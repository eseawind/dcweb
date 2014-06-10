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

public class SwfAction extends BaseAction{
	
	Logger log = Logger.getLogger(SwfAction.class);
	
	private static final long serialVersionUID = 6176031897143558747L;
	private StationService stationService;
	private InverterService inverterService;
	private int stationid; 
	private String type="day";
	private String day;
	private String month;
	private String year;
	private String contentType;
	private String sdate;
	private String t;
	private String ct;
	//application/csv
	//text/plain
	public InputStream getInputStream() throws Exception {
		if(("power").equals(t)){
			return getPowerInputStream();
		}else if("event".equals(t)){
			return getEventInputStream();
		}else if("dcp".equals(t)){
			return getDcpInputStream();
		}else if("dcv".equals(t)){
			return getDcvInputStream();
		}else if("dcc".equals(t)){
			return getDccInputStream();
		}else if("acp".equals(t)){
			return getAcpInputStream();
		}else if("acf".equals(t)){
			return getAcfInputStream();
		}else if("acv".equals(t)){
			return getAcvInputStream();
		}else if("acc".equals(t)){
			return getAccInputStream();
		}else if("inve".equals(t)){
			return getInveInputStream();
		}else if("income".equals(t)){
			return getIncomeInputStream();
		}else if("co2v".equals(t)){
			return getCo2vInputStream();
		}
        return new ByteArrayInputStream("下载示例".getBytes());    
    }    
	private EventService eventService;
//	private String occdt;
//	private int approved=-1;
//	private String e_level;
//	private String isno="-1";
	private InputStream getEventInputStream(){
		int stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
////		int  totalCount = eventService.getEventCountBySid(stationid, null, -1, null, null);
////		List<Map> eventList = eventService.getEventByStationid(stationid, totalCount, 1, null, -1, null, null);
		StringBuilder sb = new StringBuilder();
//		sb.append("电站名称,事件编号,逆变器名称,时间,状态,事件等级");
		sb.append("\n");
//		for(int i=0;i<eventList.size();i++){
//			sb.append(stationname+","+eventList.get(i).get("edid")+","+eventList.get(i).get("isno")+","+eventList.get(i).get("occdt")+","+eventList.get(i).get("approved")+","+eventList.get(i).get("e_level"));
//			sb.append("\n");
//		}
		return new ByteArrayInputStream(sb.toString().getBytes()); 
	}
	
	private InputStream getPowerInputStream(){
		if(("day").equals(ct)){
			return getPowerDayInputStream();
		}else if (("month").equals(ct)){
			return getPowerMonthInputStream();
		}else if(("year").equals(ct)){
			return getPowerYearInputStream();
		}else if(("allyear").equals(ct)){
			return getPowerAllYearInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	private InputStream getDccInputStream(){
		if(("day").equals(ct)){
			return getDccDayInputStream();
		}else if("week".equals(ct)){
			return getDccWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getDccDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流电流");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("ipv"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getDccWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流电流");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("ipv"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getDcpInputStream(){
		if(("day").equals(ct)){
			return getDcpDayInputStream();
		}else if("week".equals(ct)){
			return getDcpWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getDcvInputStream(){
		if(("day").equals(ct)){
			return getDcvDayInputStream();
		}else if("week".equals(ct)){
			return getDcvWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getAcpInputStream(){
		if(("day").equals(ct)){
			return getAcpDayInputStream();
		}else if("week".equals(ct)){
			return getAcpWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getAcpDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,交流功率");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
			String value = mapList.get(i).get("pac").toString();	
			sb.append(isno+","+byName+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAcpWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,交流功率");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
			String value = mapList.get(i).get("pac").toString();	
			sb.append(isno+","+byName+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	
	private InputStream getAcfInputStream(){
		if(("day").equals(ct)){
			return getAcfDayInputStream();
		}else if("week".equals(ct)){
			return getAcfWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	private InputStream getAcfDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,交流频率");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
		
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
			String value = mapList.get(i).get("acf").toString();	
			sb.append(isno+","+byName+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAcfWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,交流频率");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
			String value = mapList.get(i).get("acf").toString();	
			sb.append(isno+","+byName+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAcvInputStream(){
		if(("day").equals(ct)){
			return getAcvDayInputStream();
		}else if("week".equals(ct)){
			return getAcvWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	private InputStream getAcvDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,交流电压");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				sb.append(isno+","+byName+","+(j+1)+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAcvWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,交流电压");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				sb.append(isno+","+byName+","+(j+1)+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAccInputStream(){
		if(("day").equals(ct)){
			return getAccDayInputStream();
		}else if("week".equals(ct)){
			return getAccWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getAccDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,交流电流");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("iac"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getAccWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,交流电流");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("iac"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	
	private InputStream getInveInputStream(){
		if(("day").equals(ct)){
			return getInveDayInputStream();
		}else if("week".equals(ct)){
			return getInveWeekInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	private InputStream getInveDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,逆变器温度");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
		
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
			String value = mapList.get(i).get("tempval").toString();	
			sb.append(isno+","+byName+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getInveWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,时间,逆变器温度");
		sb.append("\n");
		Map allInvMap =(Map)this.getSession().getAttribute("allInvMap");
		List<Map> selInvList = new ArrayList<Map>();
		Iterator iterator = allInvMap.entrySet().iterator();
		while (iterator.hasNext()){
			Map.Entry pairs = (Map.Entry)iterator.next();
			Map tempMap = (Map) pairs.getValue();
			if(tempMap.get("channels").toString().equals("0")){
				selInvList.add((Map) pairs.getValue());
			}
		}
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
			String value = mapList.get(i).get("tempval").toString();	
			sb.append(isno+","+byName+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getIncomeInputStream(){
		if(("day").equals(ct)){
			return getIncomeDayInputStream();
		}else if("month".equals(ct)){
			return getIncomeMonthInputStream();
		}else if("year".equals(ct)){
			return getIncomeYearInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	
	private InputStream getIncomeDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,收益");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findIncomeby7days(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("recvdate")+","+mapList.get(i).get("income"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getIncomeMonthInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,收益");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findIncomeBy12Months(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("recvdate")+","+mapList.get(i).get("income"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getIncomeYearInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,收益");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findIncomeByyear(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("year")+","+mapList.get(i).get("income"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());        
	}
	private InputStream getCo2vInputStream(){
		if(("day").equals(ct)){
			return getCo2vDayInputStream();
		}else if("month".equals(ct)){
			return getCo2vMonthInputStream();
		}else if("year".equals(ct)){
			return getCo2vYearInputStream();
		}
		return new ByteArrayInputStream("参数错误".getBytes());   
	}
	private InputStream getCo2vDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,二氧化碳减排量");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findCo2Avby7days(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("recvdate")+","+mapList.get(i).get("co2av"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getCo2vMonthInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,二氧化碳减排量");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findCo2AvBy12Months(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("recvdate")+","+mapList.get(i).get("co2av"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getCo2vYearInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("电站名称,日期,二氧化碳减排量");
		sb.append("\n");
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String day = this.getToday();
		List<Map> mapList = inverterService.findCo2AvByyear(stationid+"", day);
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		for(int i=0;i<mapList.size();i++){
			sb.append(stationname+","+mapList.get(i).get("year")+","+mapList.get(i).get("co2av"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());        
	}
	private InputStream getDcvDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流电压");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("vpv"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getDcvWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流功率");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("vpv"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	
	private InputStream getDcpDayInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流功率");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("dcp"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getDcpWeekInputStream(){
		StringBuilder sb = new StringBuilder();
		sb.append("逆变器序列号,逆变器名称,通道,时间,直流功率");
		sb.append("\n");
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
		Map RESMap = (Map)this.getSession().getAttribute("dayMap");
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
				String value = mapList.get(i).get("dcp"+(j+1)).toString();	
				sb.append(isno+","+byName+","+(j+1)+","+mapList.get(i).get("recvdate")+" "+fen10+","+String.format("%.3f", Float.parseFloat(value)));
				sb.append("\n");
			}
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getPowerDayInputStream(){
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		day = sdate;
		List<Map> powerList = stationService.findStationTpList(stationid,day);
		StringBuilder sb = new StringBuilder();
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		sb.append("电站名称,日期,时间,发电量（KW）");
		sb.append("\n");
		for(int i=0;i<powerList.size();i++){
			sb.append(stationname+","+sdate+","+getFormattime1(Integer.parseInt(powerList.get(i).get("fen10").toString()))+","+powerList.get(i).get("e_fen10"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());   
	}
	private InputStream getPowerMonthInputStream(){
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		day = sdate+"-01";
		List<Map> powerList = stationService.findStationMpList(stationid, day);
		StringBuilder sb = new StringBuilder();
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		sb.append("电站名称,日期,发电量（KW）");
		sb.append("\n");
		for(int i=0;i<powerList.size();i++){
			sb.append(stationname+","+powerList.get(i).get("recvdate")+","+powerList.get(i).get("e_total"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());  
	}

	private InputStream getPowerYearInputStream(){
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		year = sdate+"-01-01";
		List<Map> powerList = stationService.findStationYpList(stationid, year);
		StringBuilder sb = new StringBuilder();
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		sb.append("电站名称,月份,发电量（KW）");
		sb.append("\n");
		for(int i=0;i<powerList.size();i++){
			sb.append(stationname+","+powerList.get(i).get("recvdate")+","+powerList.get(i).get("e_total"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());     
	}
	
	private InputStream getPowerAllYearInputStream(){
		stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		List<Map> powerList = stationService.findStationApList(stationid);
		StringBuilder sb = new StringBuilder();
		String stationname = ((Map)this.getSession().getAttribute("defaultStationMap")).get("stationname").toString();
		sb.append("电站名称,年份,发电量（KW）");
		sb.append("\n");
		for(int i=0;i<powerList.size();i++){
			sb.append(stationname+","+powerList.get(i).get("year")+","+powerList.get(i).get("e_total"));
			sb.append("\n");
		}
		return new ByteArrayInputStream(sb.toString().getBytes());     
	}
	
	public String csvDownload(){
		 contentType = "application/csv"; 
		 //fileName = "兆伏艾索_20120202.csv";
		 return SUCCESS;    
	}

	
	public String txtDownload(){
		 contentType = "text/plain"; 
		 //fileName = "兆伏艾索_20120202.txt";
		 return SUCCESS;    
	}
	
	/** 提供转换编码后的供下载用的文件名 */    
	  
    public String getDownloadFileName() { 
    	int stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
    	Map stationMap = stationService.findStationById(stationid);
		String stationName = stationMap.get("stationname")==null?"":stationMap.get("stationname").toString();
		String bakName = "";
		String downFileName="";
		if(("text/plain").equals(contentType)){
			bakName=".txt";
		}else if(("application/csv").equals(contentType)){
			bakName=".csv";
		}
		if(("power").equals(t)){
			log.info("test");
			downFileName =  stationName+"_"+sdate+bakName;    
	        try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1" );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }    
		}else if("event".equals(t)){
			downFileName =  stationName+"_event"+bakName;    
	        try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }    
		}else if("dcp".equals(t)){
			downFileName =  stationName+"_dcp"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("dcv".equals(t)){
			downFileName =  stationName+"_dcv"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("dcc".equals(t)){
			downFileName =  stationName+"_dcc"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("acp".equals(t)){
			downFileName =  stationName+"_acp"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("acf".equals(t)){
			downFileName =  stationName+"_acf"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("acv".equals(t)){
			downFileName =  stationName+"_acv"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("acc".equals(t)){
			downFileName =  stationName+"_acc"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("inve".equals(t)){
			downFileName =  stationName+"_inve"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("income".equals(t)){
			downFileName =  stationName+"_income"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}else if("co2v".equals(t)){
			downFileName =  stationName+"_co2"+ct+bakName;
			try {    
	            downFileName = new String(downFileName.getBytes("GBK"),"ISO8859-1"  );    
	        } catch (UnsupportedEncodingException e) {    
	            e.printStackTrace();    
	        }
		}
        return downFileName;    
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

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getT() {
		return t;
	}

	public void setT(String t) {
		this.t = t;
	}

	public String getCt() {
		return ct;
	}

	public void setCt(String ct) {
		this.ct = ct;
	}

	public EventService getEventService() {
		return eventService;
	}

	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}

	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}    

   
	
	
}
