package com.jstrd.asdc.servlet;
import java.awt.image.BufferedImage;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

@SuppressWarnings({"unchecked","unused"})
public class ChartDataSelected  extends HttpServlet {

	private static Logger logger = Logger.getLogger(ChartDataSelected.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public ChartDataSelected() {
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
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
 		int sid=0;
 		String date="";
 		int tabId=0;
		int userId=0;
 		String isnos="";
 		String dataUnit="";
 		if (request.getParameter("userid")!=null) {
 			userId=Integer.parseInt(request.getParameter("userid").trim());
 		} else {
 			Map user = (Map)request.getSession().getAttribute("user");
 			if (user!=null)
 				userId=Integer.parseInt(user.get("userId").toString());
 		}
		if (request.getParameter("sid")!=null) {
			sid=Integer.parseInt(request.getParameter("sid"));
			doc.getRootElement().setAttribute("sid",sid+"");
		} else {
			doc.getRootElement().setAttribute("sid","0");
		}
		if (request.getParameter("tableid")!=null) {
			tabId=Integer.parseInt(request.getParameter("tableid"));
			doc.getRootElement().setAttribute("tableid",tabId+"");
		} else {
			doc.getRootElement().setAttribute("tableid","0");
		}
		if (request.getParameter("date")!=null) {
			date=request.getParameter("date");
			doc.getRootElement().setAttribute("date",date);
		} else {
			doc.getRootElement().setAttribute("date","");
		}
		if (request.getParameter("isnos")!=null) {
			isnos=request.getParameter("isnos");
		}
		try {
			String dateList=",";
			String nowDate="";
			Element itemEDate = new Element("date");
			if (!isnos.trim().equals("")) {
				String isno=isnos;
				List<Map> dataList;
				int dataNum=1;
		    	switch(tabId) {
			    	case 1201:
			    		dataList=stationDao.getChartDataIDCDay(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1202:
			    		dataList=stationDao.getChartDataIDC7Day(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1301: 
			    		dataList=stationDao.getChartDataVDCDay(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1302: 
			    		dataList=stationDao.getChartDataVDC7Day(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1401: 
			    		dataList=stationDao.getChartDataFACDay(sid,isno, date);
			    		break;
			    	case 1402: 
			    		dataList=stationDao.getChartDataFAC7Day(sid,isno, date);
			    		break;
			    	case 1501: 
			    		dataList=stationDao.getChartDataIACDay(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1502: 
			    		dataList=stationDao.getChartDataIAC7Day(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1601: 
			    		dataList=stationDao.getChartDataVACDay(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1602: 
			    		dataList=stationDao.getChartDataVAC7Day(sid,isno, date);
			    		dataNum=3;
			    		break;
			    	case 1701: 
			    		dataList=stationDao.getChartDataTempDay(sid,isno, date);
			    		break;
			    	case 1702: 
			    		dataList=stationDao.getChartDataTemp7Day(sid,isno, date);
			    		break;
			    	case 1801:
			    		dataList=stationDao.getChartDataEnergyDay(sid,isno, date);
			    		break;
			    	case 1802:
			    		dataList=stationDao.getChartDataEnergyMonth(sid,isno, date);
			    		break;
			    	case 1803: 
			    		dataList=stationDao.getChartDataEnergyYear(sid,isno, date);
			    		break;
			    	case 1804: 
		    		dataList=stationDao.getChartDataEnergyTotal(sid,isno);
		    		break;
			    	default:  		
			    		dataList=null;
		    	}
		    	Map InvInfo=stationDao.getInvInfo(isno);
		    	String per = "";
		    	Element itemE = null;
		    	for(int i=0; i<dataList.size(); i++){
		    		String isnocur = (String) dataList.get(i).get("isno");
		    		String byname = (String) dataList.get(i).get("byname");
		    		dataNum=Integer.parseInt(dataList.get(0).get("datanum").toString());
		    		if(!per.equals(isnocur)){
		    			itemE = new Element("i");
		    	    	itemE.setAttribute("b", byname);
		    	    	itemE.setAttribute("i", isnocur);
		    	    	itemE.setAttribute("n", dataNum+"");
		    	    	per = isnocur;
		    	    	doc.getRootElement().addContent(itemE);
		    		}
		    		Element itemElement = new Element("d");
		    		itemElement.setAttribute("t", (String)dataList.get(i).get("time"));
		    		if (dataNum==1) {
			    		itemElement.setAttribute("v", dataList.get(i).get("data1").toString());
			    	} else {
			    		for (int m=1;m<=dataNum;m++)
				    		itemElement.setAttribute("v"+m, dataList.get(i).get("data"+m).toString());			    		    		
			    	}
		    		if (dataList.get(i).get("date")!=null && !nowDate.equals(dataList.get(i).get("date").toString())) {
		    			nowDate=dataList.get(i).get("date").toString();
		    			if (dateList.indexOf(","+nowDate+",")==-1) {
			    			Element itemEDate2 = new Element("d");
			    			itemEDate2.setAttribute("d",nowDate);
			    			itemEDate.addContent(itemEDate2);
			    			dateList=dateList+nowDate+",";
		    			}
			    	}
			    	if (dataUnit.equals("")) {
			    		dataUnit=dataList.get(i).get("dataunit").toString();
			    		doc.getRootElement().setAttribute("unit",dataUnit);
			    	}
			    	itemE.addContent(itemElement);
		    	}
			}
			doc.getRootElement().addContent(itemEDate);
		}  catch (Exception e) {
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
        format.setEncoding("UTF-8");// 设置xml文件的字符为UTF-8，解决中文问题   
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
		while ((len = fis.read(buffer)) > 0) {
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
		} catch (Exception e) {
			logger.error(e);
		}
		return s;
	}
}
