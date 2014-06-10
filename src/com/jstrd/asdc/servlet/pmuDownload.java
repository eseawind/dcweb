package com.jstrd.asdc.servlet;

import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
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

@SuppressWarnings("unchecked")
public class pmuDownload  extends HttpServlet {

	private static Logger logger = Logger.getLogger(pmuDownload.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public pmuDownload() {
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
 		String model=null;
 		String lsno=null;
 		String leixing=null;
 		String hardver=null;
 		String softver=null;
 		int autoupdate=-1;
 		int needupdate=-1;
 		int type=1;
 		int state=100;
		if (request.getParameter("hardver")!=null){
			hardver=request.getParameter("hardver");
		}
		if (request.getParameter("softver")!=null){
			softver=request.getParameter("softver");
		}
		if (request.getParameter("model")!=null){
			model=request.getParameter("model");
		}
		if (request.getParameter("type")!=null){
			leixing=request.getParameter("type");
		}
		if (request.getParameter("lsno")!=null){
			lsno=request.getParameter("lsno");
		}
		if (request.getParameter("tp")!=null){
			type=Integer.parseInt(request.getParameter("tp"));
		}
		if (request.getParameter("searchOnline")!=null){
			state=Integer.parseInt(request.getParameter("searchOnline"));
		}
		if (request.getParameter("autoupdate")!=null){
			autoupdate=Integer.parseInt(request.getParameter("autoupdate"));
		}
		if (request.getParameter("needupdate")!=null){
			needupdate=Integer.parseInt(request.getParameter("needupdate"));
		}
		String localLang="en_US";
		if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		String realPath=request.getSession().getServletContext().getRealPath("");
		realPath=realPath+"/WEB-INF/classes/";
		String fileName=getProperties("RES_DOWNLOAD_PUM_TITLE",realPath+"messageResource_"+localLang+".properties");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime= formatter.format(new Date());
		fileName=fileName+"_"+nowTime;
		try {
			List<Map> pmuList=stationDao.findPumList(leixing,model,lsno,state,hardver,softver,autoupdate,needupdate, 100000, 1);
			String fileDir = request.getSession().getServletContext().getRealPath("");
	    	fileDir=fileDir+System.getProperty("file.separator")+"upload"+System.getProperty("file.separator")+"download"+System.getProperty("file.separator");
	    	String csvFilePath = fileDir+getfileName(type);   
	    	if (type==1){
			CsvWriter wr =new CsvWriter(csvFilePath,',',Charset.forName("gbk"));   
			String[] contents = { getProperties("RES_SERIALNUMBER",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_PMULIST_HARDVRE",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_PMULIST_SOFTVRE",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_PMULIST_AUTOUPDATE",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_CONF_STATION",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_ESTATUS",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_COUNTRY",realPath+"messageResource_"+localLang+".properties"),
					getProperties("RES_CITY",realPath+"messageResource_"+localLang+".properties")};                       
			wr.writeRecord(contents);
			if (pmuList!=null && pmuList.size()>0){
				try {          
					for (int i=0;i<pmuList.size();i++){
						Map inv=(Map)pmuList.get(i);
						String ds[]=new String[contents.length];
						ds[0]=(inv.get("psno")==null?"":inv.get("psno").toString());
						ds[1]=(inv.get("hardver")==null?"":inv.get("hardver").toString());
						ds[2]=(inv.get("softver")==null?"":inv.get("softver").toString());
						if (inv.get("needup").toString().equals("1")){
							ds[3]="自动";
						}else{
							ds[3]="关闭";
						}
						ds[4]=(inv.get("stationname")==null?"":inv.get("stationname").toString());
						ds[5]=(Integer.parseInt(inv.get("state").toString())==1?getProperties("RES_ONLINE",realPath+"messageResource_"+localLang+".properties"):getProperties("RES_OFFLINE",realPath+"messageResource_"+localLang+".properties"));
						ds[6]=(inv.get("country")==null?"":inv.get("country").toString());
						ds[7]=(inv.get("city")==null?"":inv.get("city").toString());
						wr.writeRecord(ds);   
					}				 
				} catch (IOException e) {   
					logger.error(e);
				}   
			}
			wr.close();   
	    	}else if (type==2){
	    		File file = new File(csvFilePath);  
 	           	if(!file.getParentFile().exists()){  
 	           		file.getParentFile().mkdirs();  
 	           	}  
 	           	if(!file.exists()){  
 	           		file.createNewFile();
 	           	}  
 	           FileWriter fileWriter = new FileWriter(csvFilePath,false);  
 	           BufferedWriter bw = new BufferedWriter(fileWriter);  
 	           try {          
 	        	   String ds = getProperties("RES_SERIALNUMBER",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_PMULIST_HARDVRE",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_PMULIST_SOFTVRE",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_PMULIST_AUTOUPDATE",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_CONF_STATION",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_ESTATUS",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_COUNTRY",realPath+"messageResource_"+localLang+".properties")+"\t"+
 	        	   getProperties("RES_CITY",realPath+"messageResource_"+localLang+".properties")+"\r\n";  
 	        	   bw.write(ds); 
 	        	   if (pmuList!=null && pmuList.size()>0){
 						for (int i=0;i<pmuList.size();i++){
 							Map inv=(Map)pmuList.get(i);
 							ds=inv.get("psno")==null?"":inv.get("psno").toString();
 							ds=ds+"\t"+(inv.get("hardver")==null?"":inv.get("hardver").toString());
 							ds=ds+"\t"+(inv.get("softver")==null?"":inv.get("softver").toString());
 							if (inv.get("needup").toString().equals("1")){
 								ds=ds+"\t自动";
 							}else{
 								ds=ds+"\t关闭";
 							}
 							ds=ds+"\t"+(inv.get("stationname")==null?"":inv.get("stationname").toString());
 							ds=ds+"\t"+(Integer.parseInt(inv.get("state").toString())==1?getProperties("RES_ONLINE",realPath+"messageResource_"+localLang+".properties"):getProperties("RES_OFFLINE",realPath+"messageResource_"+localLang+".properties"));
 							ds=ds+"\t"+(inv.get("country")==null?"":inv.get("country").toString());
 							ds=ds+"\t"+(inv.get("city")==null?"":inv.get("city").toString())+"\r\n";
 							bw.write(ds); 
 						}				 
 	        	   }
 	           } catch (IOException e) {   
 	        	  logger.error(e); 
 	           }  
 	           fileWriter.flush();  
	           bw.close();  
	           fileWriter.close();  
	    	}
			if (type==2)
				fileName=fileName+".txt";
			else
				fileName=fileName+".csv";
		    
			download(csvFilePath,fileName,request,response);
		} catch (IOException e) {   
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
    
    private String getfileName(int type){
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
			s=p.getProperty(res);
			in.close();
		 } catch (Exception e) {
			 logger.error(e);
		 }
		 return s;
	}
	
}
