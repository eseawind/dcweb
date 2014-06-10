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

public class SwfAction_power extends BaseAction{
	
	Logger log = Logger.getLogger(SwfAction_power.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 6176031897143558747L;
	private StationService stationService;
	private int stationid; 
	private String type="day";
	private String day;
	private String month;
	private String year;
	
	public String getPower() throws Exception{
		if(type.equals("day")){
			String xmlStr = this.getDayXmlPower();
			this.printXml(xmlStr);
		}else if (type.equals("month")){
			String xmlStr = this.getMonthXmlPower();
			this.printXml(xmlStr);
		}else if(type.equals("year")){
			String xmlStr = this.getYearXmlPower();
			this.printXml(xmlStr);
		}else if(type.equals("allyear")){
			String xmlStr = this.getAllYearXmlPower();
			this.printXml(xmlStr);
		}
		return null;
	}
	/************************每所有年份发电量展示***********************
	 * 
	 */
	private String getAllYearXmlPower() throws Exception{
		Document doc=createDoc();
		List<Map> powerList = stationService.findStationApList(stationid);
		Element itemElement = new Element("item");
		itemElement.setAttribute("isno",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		itemElement.setAttribute("InvName",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		for(int i=0;i<powerList.size();i++){
			Element dataElement = new Element("data");
			String ayear = powerList.get(i).get("year").toString();
			String etotal = powerList.get(i).get("e_total")==null?"0":powerList.get(i).get("e_total").toString();
			String pac = String.format("%.3f", Float.parseFloat(etotal)/1000);
			dataElement.setAttribute("year",ayear);
			dataElement.setAttribute("value",pac);
			itemElement.addContent(dataElement);
		}
		doc.getRootElement().addContent(itemElement);
		return doc2String(doc);
	}
	/************************每年发电量展示***********************
	 * 
	 */
	private String getYearXmlPower() throws Exception{
		if(year==null||("").equals(year)){
			day = this.getToday();
			year = day.split("-")[0];
		}else{
			day = year+"-01-01";
		}
		Document doc=createDoc();
		List<Map> powerList = stationService.findStationYpList(stationid, day);
		Element itemElement = new Element("item");
		itemElement.setAttribute("isno",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		itemElement.setAttribute("InvName",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		for(int i=0;i<powerList.size();i++){
			Element dataElement = new Element("data");
			String amonth = powerList.get(i).get("recvdate").toString().split("-")[1];
			String etotal = powerList.get(i).get("e_total")==null?"0":powerList.get(i).get("e_total").toString();
			String pac = String.format("%.3f", Float.parseFloat(etotal)/1000);
			dataElement.setAttribute("month",amonth.length()<2?"0"+amonth:amonth);
			dataElement.setAttribute("value",pac);
			itemElement.addContent(dataElement);
		}
		doc.getRootElement().addContent(itemElement);
		return doc2String(doc);
	}
	/***********************每月发电量展示***************************
	 * @throws Exception */
	private String getMonthXmlPower() throws Exception{
		if(month==null||("").equals(month)){
			day = this.getToday();
		}else{
			day=month+"-01";
		}
		Document doc=createDoc();
		List<Map> powerList = stationService.findStationMpList(stationid, day);
//		System.out.println(powerList);
		Element itemElement = new Element("item");
		itemElement.setAttribute("isno",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		itemElement.setAttribute("InvName",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		for(int i=0;i<powerList.size();i++){
			Element dataElement = new Element("data");
			String recvdate = powerList.get(i).get("recvdate").toString().split("-")[2];
			//itemElement.setAttribute("today",String.format("%.2f", (Float)stationMap.get("etoday")));
			String etotal = powerList.get(i).get("e_total")==null?"0":powerList.get(i).get("e_total").toString();
			String pac = String.format("%.3f", Float.parseFloat(etotal)/1000);
			dataElement.setAttribute("day",recvdate);
			dataElement.setAttribute("value",pac);
			itemElement.addContent(dataElement);
		}
		doc.getRootElement().addContent(itemElement);
		return doc2String(doc);
	}
	
	/***********************每日发电量展示***************************
	 * @throws Exception */
	private String getDayXmlPower() throws Exception{
		if(day==null||("").equals(day)){
			day = this.getToday();
		}
		Document doc=createDoc();
		List<Map> powerList = stationService.findStationTpList(stationid,day);
		Element itemElement = new Element("item");
		itemElement.setAttribute("isno",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		itemElement.setAttribute("InvName",((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString());
		for(int i=0;i<powerList.size();i++){
			Element dataElement = new Element("data");
			String fen10 = powerList.get(i).get("fen10")==null?getFormattime1(0):getFormattime1(Integer.parseInt(powerList.get(i).get("fen10").toString()));
			String etotal = powerList.get(i).get("e_fen10")==null?"0":powerList.get(i).get("e_fen10").toString();
			String pac = String.format("%.3f", Float.parseFloat(etotal)/1000);
			dataElement.setAttribute("time",fen10);
			dataElement.setAttribute("value",pac);
			itemElement.addContent(dataElement);
		}
		doc.getRootElement().addContent(itemElement);
		return doc2String(doc);
	}
	public StationService getStationService() {
		return stationService;
	}
	public void setStationService(StationService stationService) {
		this.stationService = stationService;
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
	
}
