package com.jstrd.asdc.servlet;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

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

import com.csvreader.CsvWriter;
import com.jstrd.asdc.dao.StationDao;

@SuppressWarnings({"unused","unchecked"})
public class EventFindDown extends HttpServlet {

	private static Logger logger = Logger.getLogger(EventFindDown.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public EventFindDown() {
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
 		int msgtype=-1;
 		int status=-1;
 		String desc=null;
 		int countryId=-1;
 		String stationName=null;
 		int devtype=-1;
 		String devmodel=null;
 		String startDt=null;
 		String endDt=null;
 		String listno=null;
 		String errcode = "-1";
 		
 		if (request.getParameter("msgtype")!=null){
 			msgtype=Integer.parseInt(request.getParameter("msgtype"));
		}
 		if (request.getParameter("status")!=null){
 			status=Integer.parseInt(request.getParameter("status"));
		}
		if (request.getParameter("desc")!=null){
			desc=request.getParameter("desc");
		}
		if (request.getParameter("countryId")!=null){
			countryId=Integer.parseInt(request.getParameter("countryId"));
		}
		if (request.getParameter("stationName")!=null){
			stationName=request.getParameter("stationName");
		}
		if (request.getParameter("devtype")!=null){
			devtype=Integer.parseInt(request.getParameter("devtype"));
		}
		if (request.getParameter("devmodel")!=null){
			devmodel=request.getParameter("devmodel");
		}
		if (devmodel.equals("-1"))
			devmodel=null;
		if (request.getParameter("startDt")!=null){
			startDt=request.getParameter("startDt");
		}
		if (request.getParameter("endDt")!=null){
			endDt=request.getParameter("endDt");
		}
		if (request.getParameter("listno")!=null){
			listno=request.getParameter("listno");
		}
		String localLang="en_US";
		if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		String realPath=request.getSession().getServletContext().getRealPath("");
		realPath=realPath+"/WEB-INF/classes/";
		String fileName="事件下载";
		try {
			List eventList;
			Map eveM=stationDao.findEventList(msgtype, status, desc, listno, startDt, endDt, stationName, countryId, devtype,devmodel, errcode, 10, 0);
			eventList=(List<Map>)eveM.get("eventList");
			String fileDir = request.getSession().getServletContext().getRealPath("");
	    	fileDir=fileDir+System.getProperty("file.separator")+"upload"+System.getProperty("file.separator")+"download"+System.getProperty("file.separator");
	    	String csvFilePath = fileDir+getfileName(1);   
			CsvWriter wr =new CsvWriter(csvFilePath,',',Charset.forName("gbk"));   
			String[] contents = {"电站名.","SN.","类型","时间","描述","国家","城市"};                       
			wr.writeRecord(contents);
			if (eventList!=null && eventList.size()>0){
				try {          
					for (int i=0;i<eventList.size();i++){
						Map event=(Map)eventList.get(i);
						String ds[]=new String[contents.length];
						ds[0]=(event.get("stationname").toString());
						ds[1]=(event.get("ssno").toString());
						ds[2]=(event.get("msgtype").toString());
						ds[3]=(event.get("occdt").toString());
						ds[4]=(event.get("msg_desc").toString());
						ds[5]=(event.get("country").toString());
						ds[6]=(event.get("city").toString());		
						wr.writeRecord(ds);   
					}				 
					
				} catch (IOException e) {   
					logger.error(e);
				}   
			}
			wr.close();   
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String nowTime= formatter.format(new Date());
			fileName=fileName+"_"+nowTime+".csv";
		    download(csvFilePath,fileName,request,response);
		} catch (IOException e) {   
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
    
    private  String getfileName(int type){
    	String dn=".csv";
 	   	if (type==2)
 	   		dn=".txt";
 		int temp = (int)(Math.random()*10000);
 		String tempStr= temp+"";
 		long now = System.currentTimeMillis();
 		String newFileName = "";		
 		newFileName = Long.toString(now)+tempStr;
 		return newFileName+dn;
 	}
    
    public void download(String path,String downloadName,HttpServletRequest request, HttpServletResponse response) {
        try {
        	response.setContentType("application/x-download");
        	downloadName = URLEncoder.encode(downloadName, "UTF-8");
        	response.addHeader("Content-Disposition", "attachment;filename=" + downloadName);
        	OutputStream os = response.getOutputStream();
        	FileInputStream fis = new java.io.FileInputStream(path);
        	byte[] b = new byte[1024];
        	int i = 0;
        	while ((i = fis.read(b)) > 0) {
        		os.write(b, 0, i);
        	}
        	fis.close();
        	os.flush();
        	os.close();
        } catch (Exception e) {
        	logger.error(e);
        }
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
		} catch (IOException e) {
			logger.error(e);
		}
		return s;
	}
}
