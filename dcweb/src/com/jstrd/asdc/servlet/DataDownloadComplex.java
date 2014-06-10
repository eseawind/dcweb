package com.jstrd.asdc.servlet;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.URLEncoder;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

import com.jstrd.asdc.dao.StationDao;

@SuppressWarnings({"unused","unchecked"})
public class DataDownloadComplex extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(DataDownloadComplex.class);
	private StationDao stationDao;
	
	public DataDownloadComplex() {
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
		int type=0;
		String dataS="";
		String fileName="";
		String obj="";
		String til="";
		if (request.getParameter("type")!=null)
			type=Integer.parseInt(request.getParameter("type").trim());
		
		if (request.getParameter("dataS")!=null)
			dataS=request.getParameter("dataS").trim();
	
		if (request.getParameter("obj")!=null)
			obj=request.getParameter("obj").trim();
		
		if (request.getParameter("til")!=null)
			til=request.getParameter("til").trim();
		
		String localLang="en_US";
		if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		
		String path2 = request.getContextPath();
		String realPath=request.getSession().getServletContext().getRealPath("");
		realPath=realPath+"/WEB-INF/classes/";
		String fileDir = request.getSession().getServletContext().getRealPath("");
		fileDir=fileDir+System.getProperty("file.separator")+"upload"+System.getProperty("file.separator")+"download"+System.getProperty("file.separator");
		String csvFilePath = fileDir+getfileName(type);
		StringReader read = new StringReader(dataS);
	    InputSource source = new InputSource(read);
	    SAXBuilder sb = new SAXBuilder();
	    try {  
	    	int dateType=0;
		    Document doc = sb.build(source);
            Element root = doc.getRootElement();
            String tableid=root.getAttribute("tableid").getValue();
            int tableId=Integer.parseInt(tableid);
            String date=root.getAttribute("date").getValue();
            String unit=root.getAttribute("unit").getValue();
            String object=obj+"_"+date;
            String title[]=til.split(",");
            if (type==1){
            	OutputStream out = new FileOutputStream(new File(csvFilePath));
            	WritableWorkbook workbook = Workbook.createWorkbook(out);		                
            	if (tableId>=1201){
            		List<Element> eleList = root.getChildren("i");
            		for (int i=0;i<eleList.size();i++){
            			Element ele=(Element)eleList.get(i);
	            		String psno=ele.getAttributeValue("i");
	            		WritableSheet ws = workbook.createSheet(psno, i);	//创建sheet
	            		ws.setColumnView(0, 20);
		                int rownum=0;
		                putRow(ws, rownum, title);	//压入标题	
	            		int datanum=Integer.parseInt(ele.getAttributeValue("n"));
	            		List<Element> dataList = ele.getChildren("d");
	            		for (int j=0;j<dataList.size();j++){
	            			Element dat=(Element)dataList.get(j);
	            			String time=dat.getAttributeValue("t");
	            			String datetime=dat.getAttributeValue("d");
	            			if (datetime==null)
	            				datetime="";
	            			String dataArray[]=new String[datanum+1];
            				dataArray[0]=datetime+" "+time;
	            			if (datanum==1){	
	            				if (tableId>=1801 && tableId<=1804)
	            				dataArray[1]=dat.getAttributeValue("v");
	            				else
	            					dataArray[1]=dat.getAttributeValue("v");	
	            			}else{
	            				for (int m=1;m<=datanum;m++){
	            					dataArray[m]=dat.getAttributeValue("v"+m);
	            				}			            				
	            			}
	            			putRow(ws, ++rownum, dataArray);
	            		}
			            		
            		}
            	} else {
	            	List<Element> eleList = root.getChildren("data");
	            	WritableSheet ws = workbook.createSheet("sheet 1", 0);//创建sheet
	            	ws.setColumnView(0, 20);
	            	int rownum=0;
	            	putRow(ws, rownum, title);//压入标题	
	            	for (int i=0;i<eleList.size();i++){
	            		Element ele=(Element)eleList.get(i);
            			String datetime=ele.getAttributeValue("title");
            			String dataArray[]=new String[2];
        				dataArray[0]=datetime;
            			dataArray[1]=ele.getAttributeValue("value");
            			putRow(ws, ++rownum, dataArray);
	            	}
            	}
	            workbook.write();
                workbook.close();  
            } else {
            	File file = new File(csvFilePath);  
            	if(!file.getParentFile().exists()){  
            		file.getParentFile().mkdirs();  
            	}  
            	if(!file.exists()){  
            		file.createNewFile();
            	}  
            	FileWriter fileWriter = new FileWriter(csvFilePath,false);  
            	BufferedWriter bw = new BufferedWriter(fileWriter);  
            	String contents ="SN."+"\t"+title[0];
            	if (tableId<1201)
            		contents =title[0];
            	for(int i=1;i<title.length;i++){
            		contents=contents+"\t"+title[i];
            	}
            	contents=contents+"\r\n";
            	if (tableId>=1201){
	            	List<Element> eleList = root.getChildren("i");
	            	for (int i=0;i<eleList.size();i++){
	            		Element ele=(Element)eleList.get(i);
	            		String psno=ele.getAttributeValue("i");
	            		int datanum=Integer.parseInt(ele.getAttributeValue("n"));
	            		List<Element> dataList = ele.getChildren("d");
	            		for (int j=0;j<dataList.size();j++){
	            			contents=contents+psno+"\t"; 
	            			Element dat=(Element)dataList.get(j);
	            			String time=dat.getAttributeValue("t");
	            			String datetime=dat.getAttributeValue("d");
	            			if (datetime==null)
	            				datetime="";
	            			String dataArray[]=new String[datanum+1];
	            			contents=contents+datetime+" "+time+"\t";
	            			if (datanum==1){							            				
		            				contents=contents+dat.getAttributeValue("v")+"\r\n";
	            			}else{
	            				for (int m=1;m<=datanum;m++){
	            					contents=contents+dat.getAttributeValue("v"+m)+"\t";
	            				}		
	            				contents=contents+"\r\n";
	            			}
	            		}
	            	}
            	} else if (tableId<1201) {
            		List<Element> eleList = root.getChildren("data");
	            	for (int i=0;i<eleList.size();i++){
	            		Element ele=(Element)eleList.get(i);
            			String datetime=ele.getAttributeValue("title");
            			String dataArray[]=new String[2];
            			contents=contents+datetime+"\t";
            			contents=contents+ele.getAttributeValue("value")+"\r\n";
	            	}
            	}
            	bw.write(contents); 
            	fileWriter.flush();  
            	bw.close();  
            	fileWriter.close();  
            }
            if (type==2)
            	fileName=object+".txt";
            else
            	fileName=object+".csv";
	    } catch (Exception e) {  
	    	logger.error(e);
	    }  
	    
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
		} catch (Exception e) {
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
	
	private void putRow(WritableSheet ws, int rowNum, Object[] cells) throws RowsExceededException, WriteException {
		for(int j=0; j<cells.length; j++) {//写一行
			Label cell = new Label(j, rowNum, ""+cells[j]);
			ws.addCell(cell);
		}
	}

}
