package com.jstrd.asdc.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.jstrd.asdc.service.InverterService;

public class ChartAction extends BaseAction{

	private InverterService inverterService;
	private List<Map> invMap;
	private String isno;
	private String sdate;
	private String type;
	public String dcp(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"dcp");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = allInvList.get(i).get("channelCount")==null?"3":allInvList.get(i).get("channelCount").toString();
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			channels = chartMap.get("InvChecked")==null?"": chartMap.get("InvChecked").toString();
			String[] isnoArr = isnos.split(",");
			String[] channelArr = channels.split(",");
			if(isnoArr.length==channelArr.length){
				for(int i=0;i<isnoArr.length;i++){
					if(isnoArr[i].trim().length()>0){
						allInvMap.get(isnoArr[i]).put("channels", channelArr[i]);
					}
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findDCPInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			 mapList = inverterService.findDCPInverterByWeek(isnos, sdate);
		}
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
				String[] channelt = channelArr[i].split("\\^");
				for(int j=0;j<channelt.length;j++){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("channel", channelt[j]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i]+"_"+channelt[j],tempMap);
				}
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString()+"_"+infoList.get(i).get("channel").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示

		return SUCCESS;
	}
	
	public String dcc(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"dcc");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = allInvList.get(i).get("channelCount")==null?"3":allInvList.get(i).get("channelCount").toString();
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			channels = chartMap.get("InvChecked")==null?"": chartMap.get("InvChecked").toString();
			String[] isnoArr = isnos.split(",");
			String[] channelArr = channels.split(",");
			if(isnoArr.length==channelArr.length){
				for(int i=0;i<isnoArr.length;i++){
					if(isnoArr[i].trim().length()>0){
						allInvMap.get(isnoArr[i]).put("channels", channelArr[i]);
					}
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findDCCInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			 mapList = inverterService.findDCCInverterByWeek(isnos, sdate);
		}
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
				String[] channelt = channelArr[i].split("\\^");
				for(int j=0;j<channelt.length;j++){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("channel", channelt[j]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i]+"_"+channelt[j],tempMap);
				}
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString()+"_"+infoList.get(i).get("channel").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
	}
	
	public String dcv(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"dcv");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = allInvList.get(i).get("channelCount")==null?"3":allInvList.get(i).get("channelCount").toString();
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			channels = chartMap.get("InvChecked")==null?"": chartMap.get("InvChecked").toString();
			String[] isnoArr = isnos.split(",");
			String[] channelArr = channels.split(",");
			if(isnoArr.length==channelArr.length){
				for(int i=0;i<isnoArr.length;i++){
					if(isnoArr[i].trim().length()>0){
						allInvMap.get(isnoArr[i]).put("channels", channelArr[i]);
					}
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findDCVInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			 mapList = inverterService.findDCVInverterByWeek(isnos, sdate);
		}
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
				String[] channelt = channelArr[i].split("\\^");
				for(int j=0;j<channelt.length;j++){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("channel", channelt[j]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i]+"_"+channelt[j],tempMap);
				}
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString()+"_"+infoList.get(i).get("channel").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
	}
	
	public String acc(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"acc");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = allInvList.get(i).get("acnum")==null?"3":allInvList.get(i).get("acnum").toString();
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			channels = chartMap.get("InvChecked")==null?"": chartMap.get("InvChecked").toString();
			String[] isnoArr = isnos.split(",");
			String[] channelArr = channels.split(",");
			if(isnoArr.length==channelArr.length){
				for(int i=0;i<isnoArr.length;i++){
					if(isnoArr[i].trim().length()>0){
						allInvMap.get(isnoArr[i]).put("channels", channelArr[i]);
					}
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findACCInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			mapList = inverterService.findACCInverterByWeek(isnos, sdate);
		}
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
				String[] channelt = channelArr[i].split("\\^");
				for(int j=0;j<channelt.length;j++){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("channel", channelt[j]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i]+"_"+channelt[j],tempMap);
				}
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString()+"_"+infoList.get(i).get("channel").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
	}
	
	public String acp(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"acp");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = "0";
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			String[] isnoArr = isnos.split(",");
			for(int i=0;i<isnoArr.length;i++){
				if(allInvMap.get(isnoArr[i])!=null){
					allInvMap.get(isnoArr[i]).put("channels", "0");
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findACPInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			mapList = inverterService.findACPInverterByWeek(isnos, sdate);
		}
		
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i],tempMap);
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
		
	}
	
	public String acv(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"acv");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = allInvList.get(i).get("acnum")==null?"3":allInvList.get(i).get("acnum").toString();
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			channels = chartMap.get("InvChecked")==null?"": chartMap.get("InvChecked").toString();
			String[] isnoArr = isnos.split(",");
			String[] channelArr = channels.split(",");
			if(isnoArr.length==channelArr.length){
				for(int i=0;i<isnoArr.length;i++){
					if(isnoArr[i].trim().length()>0){
						allInvMap.get(isnoArr[i]).put("channels", channelArr[i]);
					}
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findACVInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			mapList = inverterService.findACVInverterByWeek(isnos, sdate);
		}
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
				String[] channelt = channelArr[i].split("\\^");
				for(int j=0;j<channelt.length;j++){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("channel", channelt[j]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i]+"_"+channelt[j],tempMap);
				}
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString()+"_"+infoList.get(i).get("channel").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
	}
	
	public String inve(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"inve");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = "0";
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			String[] isnoArr = isnos.split(",");
			for(int i=0;i<isnoArr.length;i++){
				if(allInvMap.get(isnoArr[i])!=null){
					allInvMap.get(isnoArr[i]).put("channels", "0");
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findTempInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			 mapList = inverterService.findTempInverterByWeek(isnos, sdate);
		}
	
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i],tempMap);
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
	}
	
	public String acf(){
		this.getSession().setAttribute("allInvMap",null);
		this.getSession().setAttribute("dayMap",null);
		this.getSession().setAttribute("infoList",null);
		String isnos="";
		String channels="";
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		List<Map> chartList = inverterService.findIsnosByChart(userId,stationid,"acf");//获取dcp的选择记录
		List<Map> allInvList = inverterService.findAllIsnosByStid(stationid);
		Map<String,Map> allInvMap= new HashMap<String,Map>();
		for(int i=0;i<allInvList.size();i++){
			String isno = allInvList.get(i).get("isno").toString();
			String byName = allInvList.get(i).get("byName")==null?"unknown_name":allInvList.get(i).get("byName").toString();
			String channelCount = "0";
			Map<String,String> tempMap= new HashMap<String,String>();
			tempMap.put("isno", isno);
			tempMap.put("byName", byName);
			tempMap.put("channelCount", channelCount);
			tempMap.put("channels", "");
			allInvMap.put(isno,tempMap);
		}
		if(chartList!=null&&chartList.size()>0){
			Map chartMap = chartList.get(0);
			isnos = chartMap.get("isnos")==null?"":chartMap.get("isnos").toString();
			String[] isnoArr = isnos.split(",");
			for(int i=0;i<isnoArr.length;i++){
				if(allInvMap.get(isnoArr[i])!=null){
					allInvMap.get(isnoArr[i]).put("channels", "0");
				}
			}
		}
		this.getSession().setAttribute("allInvMap",allInvMap);
		List<Object> mapList = new ArrayList();//初始化一下
		if(type.equals("day")){
			mapList = inverterService.findACFInverterByDate(isnos, sdate);
		}else if(type.equals("week")){
			mapList = inverterService.findACFInverterByWeek(isnos, sdate);
		}
		
		this.getSession().setAttribute("dayMap",mapList==null?new HashMap():mapList.get(0));//逆变器FLASH显示及数据
		List<Map> infoList = mapList==null?new ArrayList<Map>():(List<Map>)mapList.get(1);
		Map<String,Map> backInfoMap = new LinkedHashMap<String,Map>();
		String[] isnoArr = isnos.split(",");
		String[] channelArr = channels.split(",");
		for(int i=0;i<isnoArr.length;i++){
			if(allInvMap.get(isnoArr[i])!=null){
					Map tempMap = new HashMap();
					tempMap.put("isno", isnoArr[i]);
					tempMap.put("max", "0");
					tempMap.put("min", "0");
					tempMap.put("avg", "0");
					backInfoMap.put(isnoArr[i],tempMap);
			}
		}
		for(int i=0;i<infoList.size();i++){
			String index = infoList.get(i).get("isno").toString();
			if(backInfoMap.get(index)!=null){
				backInfoMap.put(index, infoList.get(i));
			}
		}
		List<Map> backInfoList = new LinkedList<Map>();
		Iterator it = backInfoMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			backInfoList.add((Map) pairs.getValue());
		}
		this.getSession().setAttribute("infoList",backInfoList);//逆变器信息展示
	
		return SUCCESS;
		
	}
	
	public String income(){
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		return SUCCESS;
	}
	
	public String co2v(){
		if (sdate == null || ("").equals(sdate)) {
			sdate = this.FormatDay(new Date());
		}
		if(type==null||("").equals(type)){
			type="day";
		}
		return SUCCESS;
	}
	

	private String isnos;
	private String channels;
	public String changeShowInv(){
		String stationid = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("defaultStationMap")).get("masterId").toString();
		//String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		JSONObject json = new JSONObject();
		isnos = (isnos!=null&&isnos.length()>0)?isnos.substring(0,isnos.length()-1):isnos;
		channels = (channels!=null&&channels.length()>0)?channels.substring(0,channels.length()-1):channels;
		json.put("status", "ok");
		this.inverterService.updateUserChartByType(stationid, userId, isnos, type,channels);
		this.print(json.toString());
		return null;
	}
	
	private String FormatDay(Date date){
		SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}
	
	
	public List<Map> getInvMap() {
		return invMap;
	}
	public void setInvMap(List<Map> invMap) {
		this.invMap = invMap;
	}
	public String getIsno() {
		return isno;
	}
	public void setIsno(String isno) {
		this.isno = isno;
	}

	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIsnos() {
		return isnos;
	}

	public void setIsnos(String isnos) {
		this.isnos = isnos;
	}

	public String getChannels() {
		return channels;
	}

	public void setChannels(String channels) {
		this.channels = channels;
	}
}
