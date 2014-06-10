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
public class PlantInvDownload extends HttpServlet {
	
	private static Logger logger = Logger.getLogger(PlantInvDownload.class);
	private static final long serialVersionUID = 1L;
	private StationDao stationDao;
	
	public PlantInvDownload() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
 		String lsio=null;
 		String startDT=null;
 		String endDT=null;
 		int type=1;
		if (request.getParameter("lsno")!=null)
		{
			lsio=request.getParameter("lsno");
		}
		if (request.getParameter("startdt")!=null)
		{
			startDT=request.getParameter("startdt");
		}
		if (request.getParameter("enddt")!=null)
		{
			endDT=request.getParameter("enddt");
		}
		if (request.getParameter("tp")!=null)
		{
			type=Integer.parseInt(request.getParameter("tp"));
		}
		String localLang="en_US";
		if (request.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=request.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		String realPath=request.getSession().getServletContext().getRealPath("");
		realPath=realPath+"/WEB-INF/classes/";
		String fileName=getProperties("RES_DOWNLOAD_DEV_TITLE",realPath+"messageResource_"+localLang+".properties");
		String servN="";
		try {
			List<Map> stationInvList=stationDao.getPlantInvList(lsio, startDT, endDT);
			String fileDir = request.getSession().getServletContext().getRealPath("");
	    	fileDir=fileDir+System.getProperty("file.separator")+"upload"+System.getProperty("file.separator")+"download"+System.getProperty("file.separator");
	    	String csvFilePath = fileDir+getfileName(type);   
	    	//CSV格式
	    	if (type==1) {
	    		CsvWriter wr =new CsvWriter(csvFilePath,',',Charset.forName("gbk"));   
	    		if (stationInvList!=null && stationInvList.size()>0) {
	    			Map pvnummap=(Map)stationInvList.get(0);
	    			int pvn=Integer.parseInt(pvnummap.get("pvnum").toString());
					String[] contents = new String[pvn*3+19];
					contents[0]="SN.";
					contents[1]="Time";
					int j=1;
					for (int i=1;i<=pvn;i++) {
						contents[++j]="Vpv"+i;
					}
					for (int i=1;i<=pvn;i++) {
						contents[++j]="Ipv"+i;
					}
					for (int i=1;i<=pvn;i++) {
						contents[++j]="Ppv"+i;
					}
					contents[++j]="Vac1";
					contents[++j]="Vac2";
					contents[++j]="Vac3";
					contents[++j]="Iac1";
					contents[++j]="Iac2";
					contents[++j]="Iac3";
					contents[++j]="Cos(phi)";
					contents[++j]="Under_excited";
					contents[++j]="Pac";
					contents[++j]="Sac";
					contents[++j]="Qac";
					contents[++j]="Fac";
					contents[++j]="E-Total";
					contents[++j]="H-Total";
					contents[++j]="E-Today";
					contents[++j]="Temp";                                           
					wr.writeRecord(contents);
					for (int i=1;i<stationInvList.size();i++) {
						Map inv=(Map)stationInvList.get(i);
						String ds[]=new String[contents.length];
						ds[0]=(inv.get("isno").toString());
						if (servN.equals("")) {
							servN=ds[0];							
						}
						ds[1]=(inv.get("recvdate").toString());
						j=1;
						for (int m=1;m<=pvn;m++) {
							ds[++j]=(inv.get("vpv"+m).toString());
						}
						for (int m=1;m<=pvn;m++) {
							ds[++j]=(inv.get("ipv"+m).toString());
						}
						for (int m=1;m<=pvn;m++) {
							ds[++j]=(inv.get("ppv"+m).toString());
						}
						ds[++j]=(inv.get("vac1").toString());
						ds[++j]=(inv.get("vac2").toString());
						ds[++j]=(inv.get("vac3").toString());
						ds[++j]=(inv.get("iac1").toString());
						ds[++j]=(inv.get("iac2").toString());
						ds[++j]=(inv.get("iac3").toString());
						ds[++j]=(inv.get("cos_phi").toString());
						ds[++j]=(inv.get("under_excited").toString());
						ds[++j]=(inv.get("pac").toString());
						ds[++j]=(inv.get("sac").toString());
						ds[++j]=(inv.get("qac").toString());
						ds[++j]=(inv.get("fac").toString());
						ds[++j]=(inv.get("e_total").toString());
						ds[++j]=(inv.get("h_total").toString());
						ds[++j]=(inv.get("e_today").toString());
						ds[++j]=(inv.get("tempval").toString());
						wr.writeRecord(ds);   
					}				 
	    		}
	    		wr.close();   
	    	} else if (type==2) {
	    		//TXT格式
	    		File file = new File(csvFilePath);  
	    		if(!file.getParentFile().exists()) {  
	    			file.getParentFile().mkdirs();  
 	           	}  
 	           	if(!file.exists()) {  
 	           		file.createNewFile();
 	           	}  
 	           	FileWriter fileWriter = new FileWriter(csvFilePath,false);  
 	           	BufferedWriter bw = new BufferedWriter(fileWriter);  
 	           	String ds="SN.\tTime";
	 	     	Map pvnummap=(Map)stationInvList.get(0);
				int pvn=Integer.parseInt(pvnummap.get("pvnum").toString());
				for (int i=1;i<=pvn;i++) {
					ds=ds+"\tVpv"+i;
				}
				for (int i=1;i<=pvn;i++) {
					ds=ds+"\tIpv"+i;
				}
				for (int i=1;i<=pvn;i++) {
					ds=ds+"\tPpv"+i;
				}
				ds = ds+"\tVac1\tVac2\tVac3\tIac1\tIac2\tIac3\tCos(phi)\tUnder_excited\tPac\tSac\tQac\tFac\tE-Total\tH-Total\tE-Today\tTemp\r\n";                
				if (stationInvList!=null && stationInvList.size()>0) {
					for (int i=1;i<stationInvList.size();i++) {
						Map inv = (Map)stationInvList.get(i);
						ds = ds+inv.get("isno").toString();
						if (servN.equals("")) {
							servN=fullNumString(inv.get("isno").toString());							
						}
						ds=ds+"\t"+inv.get("recvdate").toString();
						for (int j=1;j<=pvn;j++) {
							ds=ds+"\t"+fullNumString(inv.get("vpv"+j).toString());
						}
						for (int j=1;j<=pvn;j++) {
							ds=ds+"\t"+fullNumString(inv.get("ipv"+j).toString());
						}
						for (int j=1;j<=pvn;j++) {
							ds=ds+"\t"+fullNumString(inv.get("ppv"+j).toString());
						}
						ds=ds+"\t"+fullNumString(inv.get("vac1").toString());
						ds=ds+"\t"+fullNumString(inv.get("vac2").toString());
						ds=ds+"\t"+fullNumString(inv.get("vac3").toString());
						ds=ds+"\t"+fullNumString(inv.get("iac1").toString());
						ds=ds+"\t"+fullNumString(inv.get("iac2").toString());
						ds=ds+"\t"+fullNumString(inv.get("iac3").toString());
						ds=ds+"\t"+fullNumString(inv.get("cos_phi").toString());
						ds=ds+"\t"+fullNumString(inv.get("under_excited").toString());
						ds=ds+"\t"+fullNumString(inv.get("pac").toString());
						ds=ds+"\t"+fullNumString(inv.get("sac").toString());
						ds=ds+"\t"+fullNumString(inv.get("qac").toString());
						ds=ds+"\t"+fullNumString(inv.get("fac").toString());
						ds=ds+"\t"+fullNumString(inv.get("e_total").toString());
						ds=ds+"\t"+fullNumString(inv.get("h_total").toString());
						ds=ds+"\t"+fullNumString(inv.get("e_today").toString());
						ds=ds+"\t"+fullNumString(inv.get("tempval").toString())+"\r\n";
					}				 
				}
				bw.write(ds);  
				fileWriter.flush();  
				bw.close();  
				fileWriter.close();  
	    	}
	    	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String nowTime= formatter.format(new Date());
			fileName=fileName+"_"+servN+"_"+nowTime;	
			if (type==2)
				fileName=fileName+".txt";
			else
				fileName=fileName+".csv";
		    download(csvFilePath,fileName,request,response);
		} 
		catch (Exception e) {   
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
        }catch (Exception e) {
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
	
	public String fullNumString(String str){
		if (str!=null){
			if (str.substring(0,1).equals(".")){
				str="0"+str;
			}
		}
		return str;		
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
