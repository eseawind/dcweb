package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

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

@SuppressWarnings({"unused","unchecked"})
public class ChartData  extends HttpServlet {

	private static Logger logger = Logger.getLogger(ChartData.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public ChartData() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		Document doc = DocumentHelper.createDocument();
		Element root = null;
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
		
		
 		int sid=0;
 		String date="";
 		int tabId=0;
 		/** 13-05-20向雪平修改 将jdom换成dom4j **/
	    root = doc.addElement("dataSet");
		if (request.getParameter("sid")!=null){
			sid=Integer.parseInt(request.getParameter("sid"));

			root.addAttribute("sid", sid+"");
		}else{
			root.addAttribute("sid", "0");
		}
		
		if (request.getParameter("tableid")!=null){
			tabId=Integer.parseInt(request.getParameter("tableid"));
			root.addAttribute("tableid", tabId+"");
		}else{
			root.addAttribute("tableid", "0");
		}
		
		if (request.getParameter("date")!=null){
			date=request.getParameter("date");
			root.addAttribute("date", date);
		}else{
			root.addAttribute("date", "");
		}
		try {
			List<Map> dataList;
	    	switch(tabId)
	    	{
	    	case 1001:
	    		dataList=stationDao.getChartDataCo27Day(sid, date);
	    		break;
	    	case 1002:
	    		dataList=stationDao.getChartDataCo212Month(sid, date);
	    		break;
	    	case 1003: 
	    		dataList=stationDao.getChartDataCo2OneYear(sid, date);
	    		break;
	    	case 1004: 
	    		dataList=stationDao.getChartDataCo2Total(sid);
	    		break;
	    	case 1101: 
	    		dataList=stationDao.getChartDataGain7Day(sid, date);
	    		break;
	    	case 1102: 
	    		dataList=stationDao.getChartDataGain12Month(sid, date);
	    		break;
	    	case 1103: 
	    		dataList=stationDao.getChartDataGainOneYear(sid, date);
	    		break;
	    	case 1104: 
	    		dataList=stationDao.getChartDataGainTotal(sid);
	    		break;
	    	default:  		
	    		dataList=null;
	    	}
		    if (dataList!=null && dataList.size()>0){
		    	String unit=(String)dataList.get(0).get("dataunit");
		    	root.addAttribute("unit", unit);
				for(int i=0;i<dataList.size();i++){	
					
					Element respEle1 =  new BaseElement("data");
					respEle1.addAttribute("title", (String)dataList.get(i).get("time"));
					respEle1.addAttribute("value", dataList.get(i).get("data").toString());
					root.add(respEle1);
				}		    	
		    }else{
		    	
		    	Element respEle2 =  new BaseElement("error");
				respEle2.addAttribute("status", "error");
				respEle2.addAttribute("sid", sid+"");
				respEle2.addAttribute("error", "未找到电站信息");
				root.add(respEle2);
		    }
			    
		} catch (Exception e) {
			Element respEle2 =  new BaseElement("error");
			respEle2.addAttribute("status", "error");
			respEle2.addAttribute("sid", sid+"");
			respEle2.addAttribute("error", "未找到电站信息");
			root.add(respEle2);
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
	//以上传时间戳作为上传文件名
	private synchronized String getNewPhotoName(String userid,String FiledataFileName){
		//System.out.println("开始获取新名"+FiledataFileName);
		int temp = (int)(Math.random()*10000);
		String tempStr= temp+"";
		long now = System.currentTimeMillis();
		String newFileName = "";
		int index = FiledataFileName.lastIndexOf(".");
		//String photoTitle = FiledataFileName.substring(0,index);
		if (index != -1) {
			newFileName = now +tempStr+ FiledataFileName.substring(index);
		} else {
			newFileName = Long.toString(now)+tempStr;
		}
		return userid+"_"+newFileName;
	}
	
	private synchronized String getNewPhotoName(String userid){
		int temp = (int)(Math.random()*10000);
		String tempStr= temp+"";
		long now = System.currentTimeMillis();
		String newFileName = "";		
		newFileName = Long.toString(now)+tempStr;
		return userid+"_"+newFileName;
	}
	
	public static void main(String[] args){
		System.out.println((int)(Math.random()*10000));
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
	
	//拷贝文件
	private void copyFile(File srcFile,File destFile)throws Exception{
		FileInputStream fis = new FileInputStream(srcFile);
		FileOutputStream fos = new FileOutputStream(destFile);
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0){
			fos.write(buffer , 0 , len);
		}
		fos.flush();
		fis.close();
		fos.close();
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
		FileOutputStream out;
		File file = new File(fileName);
		try {
			in = new FileInputStream(file);
			 p = new Properties();
			 p.load(in);
			 s=p.getProperty(res);
			 in.close();
		 } catch(Exception e) {
			 logger.error(e);
		 }
		 return s;
	}
}
