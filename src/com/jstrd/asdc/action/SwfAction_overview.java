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

public class SwfAction_overview extends BaseAction{
	
	Logger log = Logger.getLogger(SwfAction_overview.class);
	
	private static final long serialVersionUID = 6176031897143558747L;
	private StationService stationService;
	private int stationid; 
	
	public String initOverview() throws Exception{
		
		Map stationMap = stationService.getStationInfoById(stationid);
		Document doc = createDoc();
		Element itemElement = new Element("item");
		itemElement.setAttribute("today",String.format("%.2f", (Float)stationMap.get("etoday")));
		itemElement.setAttribute("month",String.format("%.2f", (Float)stationMap.get("emonth")/1000));
		itemElement.setAttribute("year",String.format("%.2f", (Float)stationMap.get("eyear")/1000));
		itemElement.setAttribute("unit", "$");
		itemElement.setAttribute("t_income",String.format("%.2f", (Float)stationMap.get("etotal")*(Float)stationMap.get("InRate")));
		itemElement.setAttribute("co2_unit", "T");
		itemElement.setAttribute("co2_inv",String.format("%.2f", (Float)stationMap.get("etotal")*(Float)stationMap.get("Co2Rate")));
		itemElement.setAttribute("bg",stationMap.get("BGURL")==null||("").equals(stationMap.get("BGURL"))?this.getBaseUrl()+"theme/icon/bg_gl.jpg":this.getBaseUrl()+stationMap.get("BGURL"));
		doc.getRootElement().addContent(itemElement);
		this.printXml(doc2String(doc));
		return null;
	}
	
	private String formatStr(String temp,int maxlength){
		if(temp.length()<maxlength){
			for(int i=temp.length();i<maxlength;i++){
				temp ="0"+temp;
			}
		}
		return temp;
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
	
}
