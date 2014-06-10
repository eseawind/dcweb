package com.jstrd.asdc.action;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport{
	
	private static final long serialVersionUID = 8966072702839059453L;

	public String getRemortIP(HttpServletRequest request) {
		  if (request.getHeader("x-forwarded-for") == null) {
		   return request.getRemoteAddr();
		  }
		  return request.getHeader("x-forwarded-for");
	}
	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}
	
	public HttpServletResponse getResponse(){
		return ServletActionContext.getResponse();
	}
	
	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}
	
	public String getBaseUrl(){
		String path = this.getRequest().getContextPath();
    	String basePath = this.getRequest().getScheme()+"://"+this.getRequest().getServerName()+":"+this.getRequest().getServerPort()+path+"/";
		return basePath;
	}
	
	public void print(String str){
		 try {
			this.getResponse().setCharacterEncoding("UTF-8");
			this.getResponse().getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void printXml(String str){
		 try {
			this.getResponse().setCharacterEncoding("UTF-8");
			this.getResponse().setContentType("text/xml;charset=utf-8");    
			this.getResponse().setHeader("Cache-Control", "no-cache");   
			this.getResponse().getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	 
	/**  
     * Document转换为字符串  
     *   
     * @param xmlFilePath XML文件路径  
     * @return xmlStr 字符串  
     * @throws Exception  
     */  
    public static String doc2String(Document doc) throws Exception {   
        Format format = Format.getPrettyFormat();   
        format.setEncoding("UTF-8");// 设置xml文件的字符为UTF-8，解决中文问题   
        XMLOutputter xmlout = new XMLOutputter(format);   
        ByteArrayOutputStream bo = new ByteArrayOutputStream();
        xmlout.output(doc, new PrintWriter(bo));   
        return bo.toString();   
    }   
    /**
     * 格式化fen10
     * @param timeparty
     * @return
     */
	public String getFormattime1(int timeparty){
			long time = timeparty*10*60*1000+(-28800000);
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
			return "00:00".equals(sdf.format(time))?"24:00":sdf.format(time);
	}
	/***
	 * 获取今天的日期 yyyy-MM-dd
	 */ 
	public static String getToday(){
		return new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}
	/**
	 * 格式化时间
	 * @param date
	 * @return
	 */
	public static String formateDay(Date date){
		SimpleDateFormat format = new SimpleDateFormat("dd");
		return format.format(date);
	}
	/***
	 * 创建XML对象
	 * @return
	 */
	public static Document createDoc(){
		Element rootElement = new Element("dataSet");
		Document doc=new Document(rootElement);
		return doc;
	}
}
