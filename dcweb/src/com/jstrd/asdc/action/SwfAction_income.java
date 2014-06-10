package com.jstrd.asdc.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.jdom.xpath.XPath;
import org.omg.CORBA.Object;



import com.jstrd.asdc.dao.StationDao;
import com.jstrd.asdc.service.EventService;
import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.service.StationService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class SwfAction_income extends BaseAction{
	
	Logger log = Logger.getLogger(SwfAction_income.class);
	
	private static final long serialVersionUID = 6176031897143558747L;
	private InverterService inverterService;
	private int stationid; 
	private String type="day";
	private String day;
	private String month;
	private String year;
	private String date;
	
    /**
     * Income
     * @return
     * @throws Exception 
     */
    public String swfincome() throws Exception{
    	if("day".equals(type)){
	    	String xmlStr = getDayIncomeXml();
			this.printXml(xmlStr);
    	}else if("month".equals(type)){
    		String xmlStr = getMonthIncomeXml();
    		this.printXml(xmlStr);
    	}else if("year".equals(type)){
    		String xmlStr = getYearIncomeXml();
    		this.printXml(xmlStr);
    	}
    	return null;
    }
    
    private String getDayIncomeXml() throws Exception{
    	Document doc=createDoc();
		doc.getRootElement().setAttribute("unit","$");
		List<Map> mapList = inverterService.findIncomeby7days(stationid+"", date);
		Element itemElement = new Element("item");
		itemElement.setAttribute("Channel","Income");
		itemElement.setAttribute("color","#ff6600");
		doc.getRootElement().addContent(itemElement);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			Element dataElement = new Element("data");
			dataElement.setAttribute("day",recvdate);
			dataElement.setAttribute("value",mapList.get(i).get("income").toString());
			itemElement.addContent(dataElement);
		}
		return doc2String(doc);
    }
    private String getMonthIncomeXml() throws Exception{
    	Document doc=createDoc();
		doc.getRootElement().setAttribute("unit","$");
		List<Map> mapList = inverterService.findIncomeBy12Months(stationid+"", date);
		Element itemElement = new Element("item");
		itemElement.setAttribute("Channel","Income");
		itemElement.setAttribute("color","#ff6600");
		doc.getRootElement().addContent(itemElement);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			Element dataElement = new Element("data");
			dataElement.setAttribute("month",recvdate);
			dataElement.setAttribute("value",mapList.get(i).get("income").toString());
			itemElement.addContent(dataElement);
		}
		return doc2String(doc);
    }
    private String getYearIncomeXml() throws Exception{
    	Document doc=createDoc();
		doc.getRootElement().setAttribute("unit","$");
		List<Map> mapList = inverterService.findIncomeByyear(stationid+"", date);
		Element itemElement = new Element("item");
		itemElement.setAttribute("Channel","Income");
		itemElement.setAttribute("color","#ff6600");
		doc.getRootElement().addContent(itemElement);
		for(int i=0;i<mapList.size();i++){
			String year = mapList.get(i).get("year").toString();
			Element dataElement = new Element("data");
			dataElement.setAttribute("year",year);
			dataElement.setAttribute("value",mapList.get(i).get("income").toString());
			itemElement.addContent(dataElement);
		}
		return doc2String(doc);
    }

	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}

	public int getStationid() {
		return stationid;
	}

	public void setStationid(int stationid) {
		this.stationid = stationid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
	
}
