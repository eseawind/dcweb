package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jstrd.asdc.dao.StationDao;

@SuppressWarnings("unchecked")
public class StationAmountInfo extends HttpServlet {

	private static Logger logger = Logger.getLogger(StationAmountInfo.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public StationAmountInfo() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Document doc = createDoc();
		try{
			request.setCharacterEncoding("UTF-8");
		}catch(UnsupportedEncodingException e) {
			logger.error(e);
		}
		int sid=0;
		int d_type=0;
		String s_date="";
		String unit="KWh";
		if (request.getParameter("sid")!=null)
			sid=Integer.parseInt(request.getParameter("sid"));
		if (request.getParameter("type")!=null)
			d_type=Integer.parseInt(request.getParameter("type"));
		if (request.getParameter("date")!=null)
			s_date=request.getParameter("date");
		try {
			List<Map> stationPowerList=null;
			if (d_type==1){
				stationPowerList=stationDao.findStationTpList(sid, s_date);
			} 
			else if (d_type==2)
				stationPowerList=stationDao.findStationMpList(sid, s_date);    
			else if (d_type==3)
				stationPowerList=stationDao.findStationYpList(sid, s_date);	    
			else if (d_type==4)
				stationPowerList=stationDao.findStationApList(sid);	    
			if (stationPowerList!=null && stationPowerList.size()>0)
			    	
			    unit=(String)stationPowerList.get(0).get("unit");
			    doc.getRootElement().setAttribute("type",d_type+"");
			    doc.getRootElement().setAttribute("time",s_date+"");
			    doc.getRootElement().setAttribute("unit",unit);
			    if (stationPowerList!=null && stationPowerList.size()>0){
			    	for(int i=0;i<stationPowerList.size();i++){
				    	Element itemElement = new Element("data");
				    	unit=(String)stationPowerList.get(i).get("unit");
				    	itemElement.setAttribute("title", (String)stationPowerList.get(i).get("time"));
				    	itemElement.setAttribute("no", stationPowerList.get(i).get("no").toString());
				    	itemElement.setAttribute("value", stationPowerList.get(i).get("value").toString());
				    	doc.getRootElement().addContent(itemElement);
			    	}
			    }
		} catch (Exception e) {
			Element itemElement =new Element("error");
			itemElement.setAttribute("status", "error");
			itemElement.setAttribute("sid", sid+"");
			itemElement.setAttribute("error", "未找到电站发电信息");
			doc.getRootElement().addContent(itemElement);
			logger.error(e);
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml;charset=utf-8");    
		response.setHeader("Cache-Control", "no-cache");   
		try {
			response.getWriter().print(doc2String(doc));
			response.getWriter().close();
		} catch (Exception e) {
			logger.error(e);
		}
	}
	
    public static String doc2String(Document doc) throws Exception {   
        Format format = Format.getPrettyFormat();   
        format.setEncoding("UTF-8");// 设置xml文件的字符为UTF-8，解决中文问题   
        XMLOutputter xmlout = new XMLOutputter(format);   
        ByteArrayOutputStream bo = new ByteArrayOutputStream();
       
        xmlout.output(doc, new PrintWriter(bo));   
        return bo.toString();   
    }
    
    /***
	 * 创建XML对象
	 * @return
	 */
	public static Document createDoc(){
		Element rootElement = new Element("dataSet");
		Document doc=new Document(rootElement);
		return doc;
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
  
}
