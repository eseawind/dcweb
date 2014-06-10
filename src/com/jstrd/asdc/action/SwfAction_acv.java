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
import java.util.Iterator;
import java.util.LinkedList;
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
import com.jstrd.asdc.util.ColorUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class SwfAction_acv extends BaseAction{
	
	Logger log = Logger.getLogger(SwfAction_acv.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 6176031897143558747L;
	private InverterService inverterService;
	private String type="day";
	private String day;
	private String month;
	private String year;
	private String isno;
	private String date;
    /**
     * Chart acv
     * @return
     * @throws Exception
     */
    public String swfacv() throws Exception{
    	if("day".equals(type)){
	    	String xmlStr = getDayacvXml();
			this.printXml(xmlStr);
    	}else if("week".equals(type)){
    		String xmlStr = getWeekacvXml();
    		this.printXml(xmlStr);
    	}
    	return null;
    }
    private String getWeekacvXml() throws Exception{
    	Document doc=createDoc();
		doc.getRootElement().setAttribute("unit","V");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().length()>0){
				selInvList.add((Map) pairs.getValue());
			}
		}
		int color=0;
		for(int j=0;j<selInvList.size();j++) {    
			String isno = selInvList.get(j).get("isno").toString();
			String byName= selInvList.get(j).get("byName").toString();//修改成逆变器名称
			String channels = selInvList.get(j).get("channels").toString();
			String[] channelsArr =channels.split("\\^");
			for(int i=0;i<channelsArr.length;i++){
				Element itemElement = new Element("item");
				itemElement.setAttribute("isno",isno+"_"+(channelsArr[i]));
				itemElement.setAttribute("Channel",byName+"_"+(channelsArr[i]));
				itemElement.setAttribute("color",ColorUtil.color[color]);
				color++;
				doc.getRootElement().addContent(itemElement);
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
		if(RESMap.size()==0){return doc2String(doc);}
		Iterator it = RESMap.entrySet().iterator();   
		List<Map> mapList = new LinkedList<Map>();
		while (it.hasNext()) {    
			Map.Entry entry = (Map.Entry) it.next();    
			mapList.addAll((List<Map>)entry.getValue());
		}
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();    
			String byName= ((Map)allInvMap.get(isno)).get("byName").toString();//修改成逆变器名称
			String fen10 = getFormattime1(Integer.parseInt(mapList.get(i).get("fen10").toString()));
			String showChannelStr = ((Map)allInvMap.get(isno)).get("channels").toString();
			String[] showChannelArr = showChannelStr.split("\\^");
			for(int j=0;j<showChannelArr.length;j++){
				String value = mapList.get(i).get("vac"+(j+1)).toString();	
				XPath xpath = XPath.newInstance("/dataSet/item[@isno='"+isno+"_"+showChannelArr[j]+"']");
				Element itemElement = (Element) xpath.selectSingleNode(doc);
				Element dataElement = new Element("data");
				dataElement.setAttribute("day",mapList.get(i).get("recvdate").toString());
				dataElement.setAttribute("time",fen10);
				dataElement.setAttribute("value",value);
				itemElement.addContent(dataElement);
			}
		}
		return doc2String(doc);
    }
    private String getDayacvXml() throws Exception{
    	Document doc=createDoc();
		doc.getRootElement().setAttribute("unit","V");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().length()>0){
				selInvList.add((Map) pairs.getValue());
			}
		}
		int color=0;
		for(int j=0;j<selInvList.size();j++) {    
			String isno = selInvList.get(j).get("isno").toString();
			String byName= selInvList.get(j).get("byName").toString();//修改成逆变器名称
			String channels = selInvList.get(j).get("channels").toString();
			String[] channelsArr =channels.split("\\^");
			for(int i=0;i<channelsArr.length;i++){
				Element itemElement = new Element("item");
				itemElement.setAttribute("isno",isno+"_"+(channelsArr[i]));
				itemElement.setAttribute("Channel",byName+"_"+(channelsArr[i]));
				itemElement.setAttribute("color",ColorUtil.color[color]);
				color++;
				doc.getRootElement().addContent(itemElement);
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
		if(RESMap.size()==0){return doc2String(doc);}
		Iterator it = RESMap.entrySet().iterator();   
		List<Map> mapList = new LinkedList<Map>();
		while (it.hasNext()) {    
			Map.Entry entry = (Map.Entry) it.next();    
			mapList.addAll((List<Map>)entry.getValue());
		}
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();    
			String byName= ((Map)allInvMap.get(isno)).get("byName").toString();//修改成逆变器名称
			String fen10 = getFormattime1(Integer.parseInt(mapList.get(i).get("fen10").toString()));
			String showChannelStr = ((Map)allInvMap.get(isno)).get("channels").toString();
			String[] showChannelArr = showChannelStr.split("\\^");
			for(int j=0;j<showChannelArr.length;j++){
				String value = mapList.get(i).get("vac"+(j+1)).toString();	
				XPath xpath = XPath.newInstance("/dataSet/item[@isno='"+isno+"_"+showChannelArr[j]+"']");
				Element itemElement = (Element) xpath.selectSingleNode(doc);
				Element dataElement = new Element("data");
				dataElement.setAttribute("time",fen10);
				dataElement.setAttribute("value",value);
				itemElement.addContent(dataElement);
			}
		}
		return doc2String(doc);
    }
	public InverterService getInverterService() {
		return inverterService;
	}
	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
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
	public String getIsno() {
		return isno;
	}
	public void setIsno(String isno) {
		this.isno = isno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
    
	
}
