package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.net.URLDecoder;
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

public class MfileUpload extends HttpServlet {

	private static Logger logger = Logger.getLogger(MfileUpload.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public MfileUpload() {
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
		String sid="";
		String uid="";
		String tp="";
		String imgdata="";
		try {
			request.setCharacterEncoding("UTF-8");
			InputStream is = request.getInputStream();
			int i = 0;
			StringBuilder values = new StringBuilder();
			while((i=is.read())!=-1){
				values.append((char)i);
			}
			String val=values.toString();
			String v[]=val.split("&");
			for (i=0;i<v.length;i++){
				if (v[i].indexOf("sid=")!=-1){
					sid=v[i].substring(4,v[i].length());
				}else if (v[i].indexOf("type=")!=-1){
					tp=v[i].substring(5,v[i].length());
				}else if (v[i].indexOf("uid=")!=-1){
					uid=v[i].substring(4,v[i].length());
				}else if (v[i].indexOf("imgdata=")!=-1){
					imgdata=v[i].substring(8,v[i].length());
					imgdata=URLDecoder.decode(imgdata,"UTF-8");
				}
			}
			
		} catch (Exception e) {
			logger.error(e);
		}
		try {
			currentDay = this.getCurrentDay();
			String newPhotoName="";
    		newPhotoName = this.getNewPhotoName(sid);
    		byte[]   result   =new   sun.misc.BASE64Decoder().decodeBuffer(imgdata); 
    		RandomAccessFile   inOut   =   new   RandomAccessFile( "/opt/data_center/res/user/"+newPhotoName+".jpg", "rw");
    		inOut.write(result); 
    		inOut.close(); 
		    String bgurl="/res/user/"+newPhotoName+".jpg";
		    int tps=Integer.parseInt(tp); 
		    if (tps==1) {
		    	stationDao.updateStationIc(Integer.parseInt(sid), bgurl);
		    } else if (tps==2) {
		    	stationDao.updateStationBg(Integer.parseInt(sid), bgurl);
		    }
		    itemElement.setAttribute("status", "ok");
		    itemElement.setAttribute("uid", uid);
		    itemElement.setAttribute("sid", sid);
		    itemElement.setAttribute("imageurl", "/res/user/"+newPhotoName+".jpg");
			    
		} catch (Exception e) {
			itemElement.setAttribute("status", "error");
			if (uid!=null)
		    itemElement.setAttribute("uid", uid);
			if (sid!=null)
		    itemElement.setAttribute("sid", sid);
			itemElement.setAttribute("error", "上传文件异常");
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
