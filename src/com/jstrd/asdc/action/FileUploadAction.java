package com.jstrd.asdc.action;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jxl.*;
import jxl.write.*;
import jxl.write.*;
import jxl.format.*;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

import com.jstrd.asdc.service.StationService;
public class FileUploadAction extends BaseAction{
private List<File> file;
private List<String> fileName;
private List<String> fileContentType;
private StationService stationService;
private String optFlag="0";

public String pmuImport(){
	String returns="";
	try{
		
		InputStream in=new FileInputStream(file.get(0));
		jxl.Workbook wb = Workbook.getWorkbook(in);       
		jxl.Sheet st = wb.getSheet(0);
		String title="";
		Cell cell=st.getCell(0,0);
		title=cell.getContents().trim();
		if (!title.equals("序列号")){
			returns="-1";
			this.getSession().setAttribute("res", returns);
			return SUCCESS;
		}
		System.out.print(title);
		int row=1;
		boolean flag=true;
		String psno;//序列号
		String idex;//注册码
		String type;//类型
		String devname;//名称
		String xh;//型号
		String factory;//厂家制造商
		String penpai;//品牌
		String softver;//软件版本号
		String hardver;//软件版本号
		while(row<st.getRows()){
			
			psno=st.getCell(0,row).getContents().trim();
			idex=st.getCell(1,row).getContents().trim();
			type=st.getCell(2,row).getContents().trim();
			devname=st.getCell(3,row).getContents().trim();
			xh=st.getCell(4,row).getContents().trim();
			factory=st.getCell(5,row).getContents().trim();
			penpai=st.getCell(6,row).getContents().trim();
			softver=st.getCell(7,row).getContents().trim();
			hardver=st.getCell(8,row).getContents().trim();
			row++;
			boolean ck=true;
			if (psno.length()>20 || psno.length()<5){
				returns=returns+";"+row+",-1";
				ck=false;
			}
			if (idex.length()>24 || idex.length()<10){
				returns=returns+";"+row+",-2";
				ck=false;
			}
			if (type.length()>50 || type.length()<3){
				returns=returns+";"+row+",-3";
				ck=false;
			}
			if (devname.length()>50 || devname.length()<3){
				returns=returns+";"+row+",-4";
				ck=false;
			}
			if (xh.length()>50 || xh.length()<3){
				returns=returns+";"+row+",-5";
				ck=false;
			}
			if (factory.length()>50 || factory.length()<3){
				returns=returns+";"+row+",-6";
				ck=false;
			}
			if (penpai.length()>50 || penpai.length()<5){
				returns=returns+";"+row+",-7";
				ck=false;
			}
			if (softver.length()>16 || softver.length()<3){
				returns=returns+";"+row+",-8";
				ck=false;
			}
			if (hardver.length()>16 || hardver.length()<3){
				returns=returns+";"+row+",-9";
				ck=false;
			}
			if (ck==false)
				continue;
			String res=stationService.appendPmu(psno, idex, type, devname, xh, factory, penpai, softver, hardver);
			if (res.equals("ok")){
				optFlag="1";
				returns=returns+";"+row+",1";
				}
			else{
				returns=returns+";"+row+",0";
			}
			
		}
		if (in!=null)
			in.close();
		
	}catch(Exception e){
		
		e.printStackTrace();
		optFlag="0";
	}
	this.getSession().setAttribute("res", returns);
	return SUCCESS;
}


public List<File> getFile() {
	return file;
}
public void setFile(List<File> file) {
	this.file = file;
}
public List<String> getFileName() {
	return fileName;
}
public void setFileName(List<String> fileName) {
	this.fileName = fileName;
}
public List<String> getFileContentType() {
	return fileContentType;
}
public void setFileContentType(List<String> fileContentType) {
	this.fileContentType = fileContentType;
}


public StationService getStationService() {
	return stationService;
}


public void setStationService(StationService stationService) {
	this.stationService = stationService;
}


public String getOptFlag() {
	return optFlag;
}


public void setOptFlag(String optFlag) {
	this.optFlag = optFlag;
}




}
