package com.jstrd.asdc.servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.csvreader.CsvWriter;
import com.jstrd.asdc.dao.StationDao;

@SuppressWarnings("unused")
public class DataDownload extends HttpServlet {

	private static Logger logger = Logger.getLogger(DataDownload.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public DataDownload() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		this.doPost(request, response);
	}

	public void init() throws ServletException {
		
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String time="";
		String unit="";
		int type=0;
		String dataS="";
		String fileName="";
		if (request.getParameter("time")!=null)
			time=request.getParameter("time").trim();

		if (request.getParameter("unit")!=null)
			unit="("+request.getParameter("unit").trim()+")";

		if (request.getParameter("type")!=null)
			type=Integer.parseInt(request.getParameter("type").trim());

		if (request.getParameter("dataS")!=null)
			dataS=request.getParameter("dataS").trim();
		if (request.getParameter("fileName")!=null)
			fileName=request.getParameter("fileName").trim();
		
		String localLang="en_US";
		if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		String path2 = request.getContextPath();
		String realPath=request.getSession().getServletContext().getRealPath("");
		realPath=realPath+"/WEB-INF/classes/";
		String fileDir = request.getSession().getServletContext().getRealPath("");
    	fileDir=fileDir+System.getProperty("file.separator")+"upload"+System.getProperty("file.separator")+"download"+System.getProperty("file.separator");
    	String csvFilePath = fileDir+getfileName(type);   
    	if (type==1){
    		CsvWriter wr =new CsvWriter(csvFilePath,',',Charset.forName("gbk"));   
			String[] data=dataS.split(";");
			String[] til=data[0].split(",");
			String[] contents = {til[0],til[1]+"("+til[2]+")"};                       
			wr.writeRecord(contents);
			try {          
				for (int i=1;i<data.length;i++){
					String item[]=data[i].split(",");
					wr.writeRecord(item);   
				}				 
			} catch (Exception e) {   
				logger.error(e); 
			}   
			wr.close();   
    	}else if (type==2){
    		try {  
    			File file = new File(csvFilePath);  
    			if(!file.getParentFile().exists()){  
    				file.getParentFile().mkdirs();  
    			}  
    			if(!file.exists()){  
    				file.createNewFile();
    			}  
    			FileWriter fileWriter = new FileWriter(csvFilePath,false);  
    			BufferedWriter bw = new BufferedWriter(fileWriter);  
  				String[] data=dataS.split(";");
  				String[] til=data[0].split(",");
  				String contents = "\t"+til[0]+"\t"+til[1]+"("+til[2]+")\r\n";                
  				for (int i=1;i<data.length;i++){
  					String item[]=data[i].split(",");
  					contents=contents+"\t"+item[0]+"\t"+item[1]+"\r\n"; 
  				}				 
  				bw.write(contents);  
  				fileWriter.flush();  
  				bw.close();  
  				fileWriter.close();  
	       } catch (Exception e) {  
	    	   logger.error(e);
	       }  
    	}
		if (type==2)
			fileName=fileName+".txt";
		else
			fileName=fileName+".csv";
	    
		download(csvFilePath,fileName,request,response);
	}

	public void download(String path,String downloadName,HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("application/x-download");
			//downloadName = URLEncoder.encode(downloadName, "UTF-8");
			downloadName = new String(downloadName.getBytes(), "ISO8859-1");
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
    	}catch (Exception e) {
    		logger.error(e);
    	}
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

	public void writerTXT(String conent,String txtPath){  
		try {  
			File file = new File(txtPath);  
			if(!file.getParentFile().exists()){  
				file.getParentFile().mkdirs();  
			}  
			if(!file.exists()){  
				file.createNewFile();
			}  
			FileWriter fileWriter = new FileWriter(txtPath,false);  
			BufferedWriter bw = new BufferedWriter(fileWriter);  
			bw.newLine();  
			bw.write(conent);  
			fileWriter.flush();  
			bw.close();  
			fileWriter.close();  
		} catch (Exception e) {  
			logger.error(e); 
		}  
	} 
	
	public String getProperties(String res,String fileName) {
		String s="";
		Properties p;
		FileInputStream in;
		FileOutputStream out;
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
