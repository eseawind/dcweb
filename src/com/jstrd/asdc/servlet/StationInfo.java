package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.tree.BaseElement;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jstrd.asdc.dao.StationDao;

@SuppressWarnings({"unchecked", "unused"})
public class StationInfo extends HttpServlet {
	
	private static Logger logger = Logger.getLogger(StationInfo.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public StationInfo() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
		Document doc = DocumentHelper.createDocument();
 		int sid=0;
 		Element root = null;
		if (request.getParameter("sid")!=null)
		sid=Integer.parseInt(request.getParameter("sid"));
		try {
			String path = request.getContextPath();
	    	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	    	String bgurl=basePath;
	    	String localLang="en_US";
			if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			String realPath=request.getSession().getServletContext().getRealPath("");
			realPath=realPath+"/WEB-INF/classes/";
			//读数据库
		    //Map stationM = stationDao.getStationInfoById(sid);
			// 优化servlet，以提高overview加载速度
		    Map stationM = (Map) request.getSession().getAttribute("defaultStationMap");
			
		    root = doc.addElement("dataSet");
		    root.addAttribute("url", bgurl+stationM.get("BGURL"));
		    
			Element respEle1 =  new BaseElement("today");
			respEle1.addAttribute("title", getProperties("RES_OVERVIEW_E_TODAY",realPath+"messageResource_"+localLang+".properties"));
			respEle1.addAttribute("value", fullNumString(stationM.get("etoday").toString())+" "+(String)stationM.get("etoday_unit"));
			root.add(respEle1);
			
			Element respEle2 =  new BaseElement("month");
			respEle2.addAttribute("title", getProperties("RES_OVERVIEW_E_MONTH",realPath+"messageResource_"+localLang+".properties"));
			respEle2.addAttribute("value", fullNumString(stationM.get("emonth").toString())+" "+(String)stationM.get("emonth_unit"));
			root.add(respEle2);
			
			Element respEle3 =  new BaseElement("total");
			respEle3.addAttribute("title", getProperties("RES_OVERVIEW_E_TOTAL",realPath+"messageResource_"+localLang+".properties"));
			respEle3.addAttribute("value", fullNumString(stationM.get("etotal").toString())+" "+(String)stationM.get("etotal_unit"));
			root.add(respEle3);
		    
			Element respEle4 =  new BaseElement("income");
			respEle4.addAttribute("title", getProperties("RES_ALLINCOME",realPath+"messageResource_"+localLang+".properties"));
			respEle4.addAttribute("value", fullNumString(stationM.get("inval").toString())+" "+(String)stationM.get("inval_unit"));
			root.add(respEle4);
			
			Element respEle5 =  new BaseElement("co2");
			respEle5.addAttribute("title", getProperties("RES_CO2V",realPath+"messageResource_"+localLang+".properties"));
			respEle5.addAttribute("value", fullNumString(stationM.get("Co2Val").toString())+" "+(String)stationM.get("co2val_unit"));
			root.add(respEle5);
		} catch (Exception e) {
			root = doc.addElement("dataSet");
			Element respEle6 =  new BaseElement("error");
			respEle6.addAttribute("status", "error");
			respEle6.addAttribute("sid", sid+"");
			respEle6.addAttribute("error", "未找到电站信息");
			root.add(respEle6);
			logger.error(e);
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml;charset=utf-8");    
		response.setHeader("Cache-Control", "no-cache"); 
		try {
			response.getWriter().print(doc.asXML());
			response.getWriter().close();
		} catch (Exception e) {
			logger.error(e);
		}
	}
    
	public String fullNumString(String str){
		if (str!=null){
			if (str.substring(0,1).equals(".")){
				str="0"+str;
			}
		}
		return str;		
	}

	public String currentDay;
	//上传PHOTO文件
	public String[] uploadPhoto(File srcFile,String newPhotoName) throws Exception{
		try {
			String photoParentDir = ConfigurationRead.getInstance().getConfigItem("filesDiskPath")+"\\"+currentDay+"\\album";
			Thumbnail tn = new Thumbnail();
			BufferedImage bufImg = ImageIO.read(srcFile);
			File destFile  = this.getFile(photoParentDir+"\\big\\"+newPhotoName);
			tn.writeBigImg(bufImg, destFile, 600,400);
			destFile = this.getFile(photoParentDir+"\\middle\\"+newPhotoName);
			tn.writeMiddleImg(bufImg, destFile, 240, 160);
			String[] photoNameAndSize = new String[2];
			photoNameAndSize[0] = newPhotoName;
			photoNameAndSize[1] = String.valueOf(srcFile.length());
			return photoNameAndSize;
		} catch (Exception e) {
		}
		return null;
	}
	
	// 创建文件
	private File getFile(String filePath)throws Exception{
		String dir = filePath.substring(0,filePath.lastIndexOf(System.getProperty("file.separator")));
		File dirFile = new File(dir);
		if ( ! (dirFile.exists())  &&   ! (dirFile.isDirectory()))  {
			dirFile.mkdirs();
		}
		return new File(filePath);
	}
	
	public String getCurrentDay(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
	}

	public void init() throws ServletException {
		WebApplicationContext wac =   
			   WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());   
		stationDao = (StationDao) wac.getBean("stationDao"); 
	}
	
	public  String getProperties(String res,String fileName) {
		String s="";
		Properties p;
		FileInputStream in;
		File file = new File(fileName);
		try {
			in = new FileInputStream(file);
			p = new Properties();
			p.load(in);
			s = p.getProperty(res);
			in.close();
		 } catch (Exception e) {
			 logger.error(e);
		 }
		 return s;
	}
}
