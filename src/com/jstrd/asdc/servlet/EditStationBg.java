package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

public class EditStationBg extends HttpServlet {

	private static Logger logger = Logger.getLogger(EditStationBg.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public EditStationBg() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		Document doc = createDoc();
		Element itemElement = new Element("item");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
		int sid=0;
		if (request.getParameter("sid")!=null)
		sid=Integer.parseInt(request.getParameter("sid"));
		try {
			currentDay = this.getCurrentDay();
			String path = request.getContextPath();
	    	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		    String subUrl="upload/station/defultBg.jpg";
	    	String bgurl=basePath+subUrl;
		    stationDao.updateStationBg(sid, subUrl);
		    itemElement.setAttribute("status", "ok");
		    itemElement.setAttribute("sid", sid+"");
		    itemElement.setAttribute("imageurl",bgurl);
		} catch (Exception e) {
			itemElement.setAttribute("status", "error");
		    itemElement.setAttribute("sid", sid+"");
			itemElement.setAttribute("error", "未找到电站信息");
			logger.error(e);
		}
		doc.getRootElement().addContent(itemElement);
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
		if (!(dirFile.exists()) && !(dirFile.isDirectory()))  {
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
