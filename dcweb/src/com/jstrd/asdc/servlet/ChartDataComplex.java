package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

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

@SuppressWarnings({"unused","unchecked"})
public class ChartDataComplex  extends HttpServlet {

	private static Logger logger = Logger.getLogger(ChartDataComplex.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public ChartDataComplex() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		Document doc = createDoc();
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}

		int sid=0;
 		String date="";
 		int tabId=0;
 		int userId=0;
		if (request.getParameter("sid")!=null){
			sid=Integer.parseInt(request.getParameter("sid"));
			doc.getRootElement().setAttribute("sid",sid+"");
		}else{
			doc.getRootElement().setAttribute("sid","0");
		}
		if (request.getParameter("tableid")!=null){
			tabId=Integer.parseInt(request.getParameter("tableid"));
			doc.getRootElement().setAttribute("tableid",tabId+"");
		}else{
			doc.getRootElement().setAttribute("tableid","0");
		}
		if (request.getParameter("date")!=null){
			date=request.getParameter("date");
			doc.getRootElement().setAttribute("date",date);
		}else{
			doc.getRootElement().setAttribute("date","");
		}
		try {
			List<Map> stationInvList=stationDao.findUserStationInv(userId, sid);
			Element itemEDate = new Element("date");
			List<Map> dataList;
	    	switch(tabId) {
	    	case 1801:
	    		dataList=stationDao.getChartDataEnergyDay(sid,"", date);
	    		break;
	    	case 1802:
	    		dataList=stationDao.getChartDataEnergyMonth(sid,"", date);
	    		break;
	    	case 1803: 
	    		dataList=stationDao.getChartDataEnergyYear(sid,"", date);
	    		break;
	    	case 1804: 
	    		dataList=stationDao.getChartDataEnergyTotal(sid,"");
	    		break;
	    	default:  		
	    		dataList=null;
	    	}
	    	Element itemE = null;
	    	String dataUnit="";
	    	String isnoS="";
	    	boolean newIsno=false;
		    if (dataList!=null && dataList.size()>0){
		    	
				for(int j=0;j<dataList.size();j++){							    	
			    	
			    	if (!dataList.get(j).get("isno").toString().equals(isnoS))
			    	{	
			    		//if (itemE!=null)
				    		
			    		itemE=new Element("i");
			    		isnoS=dataList.get(j).get("isno").toString();
			    		itemE.setAttribute("i",isnoS);
			    		itemE.setAttribute("n", "1");
			    		dataUnit=dataList.get(j).get("dataunit").toString();
			    		doc.getRootElement().setAttribute("unit",dataUnit);
			    		newIsno=true;
			    		doc.getRootElement().addContent(itemE);
			    	}
			    	
			    	Element itemElement = new Element("d");
			    	    itemElement.setAttribute("t", (String)dataList.get(j).get("time"));
			    	    if (tabId==1801){
				    		itemElement.setAttribute("v1", dataList.get(j).get("data1").toString());
				    		//itemElement.setAttribute("v2", dataList.get(j).get("data2").toString());	 
				        }else if (tabId==1802){
				    		itemElement.setAttribute("v1", dataList.get(j).get("data").toString());
				    		itemElement.setAttribute("idd", dataList.get(j).get("idd").toString());	 
				        }else if (tabId==1803){
				    		itemElement.setAttribute("v1", dataList.get(j).get("data").toString());
				    		itemElement.setAttribute("idd", dataList.get(j).get("idd").toString());	 
				        }else if (tabId==1804){
				    		itemElement.setAttribute("v1", dataList.get(j).get("data").toString());	 
				        }
			    	itemE.addContent(itemElement);
			    	
				}		    	
		    }
			    
		} catch (Exception e) {
			Element itemElement =new Element("error");
			itemElement.setAttribute("status", "error");
		    itemElement.setAttribute("sid", sid+"");
			itemElement.setAttribute("error", "未找到电站信息");
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
        format.setEncoding("UTF-8");
        XMLOutputter xmlout = new XMLOutputter(format);   
        ByteArrayOutputStream bo = new ByteArrayOutputStream();
        xmlout.output(doc, new PrintWriter(bo));   
        return bo.toString();   
    }
    
	public static Document createDoc(){
		Element rootElement = new Element("dataSet");
		Document doc=new Document(rootElement);
		return doc;
	}

	public String currentDay;

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
		int temp = (int)(Math.random()*10000);
		String tempStr= temp+"";
		long now = System.currentTimeMillis();
		String newFileName = "";
		int index = FiledataFileName.lastIndexOf(".");
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
	
	public String getProperties(String res,String fileName) {
		String s="";
		Properties p;
		FileInputStream in;
		File file = new File(fileName);
		try {
			 in = new FileInputStream(file);
			 p = new Properties();
			 p.load(in);
			 s=p.getProperty(res);
			 in.close();
		 } catch (Exception e) {
			 logger.error(e);
		 }
		 return s;
	}
}
