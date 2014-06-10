package com.jstrd.asdc.action;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

import com.jstrd.asdc.email.MainSend;
import com.jstrd.asdc.service.StationService;
import com.jstrd.asdc.service.UserLimitService;
import com.jstrd.asdc.service.UserService;
import com.jstrd.asdc.thread.ReportImage;

public class ConfigAction extends BaseAction{
	
	Logger logger = Logger.getLogger(ConfigAction.class.getName());
	private static final long serialVersionUID = 1L;
	private StationService stationService;
	private UserLimitService userLimitService;
	private UserService userService;
	private List<Map> typeList;
	private List<Map> modelList;
	private List<Map> factoryList;
	private String type;
	private String model;
	private String listno;
	private int pagecols=20;
	private int page=1;
	private int allPage;
	private String stationId;
	private List<Map> pmulist;
	private List<Map> dictList;
	private List<Map> pmuTypeAnalyList;
	private List<Map> pmuCountryAnalyList;
	private int analyTotalType;
	private int analyTotalCountry;
	private Map pumInfoMap;
	private Map devInfoMap;
	private String byName;
	private List<Map> stationDevList;
	private String serialno;
	private String factory;
	private String account;
	private int updatet;
	private int plantt;
	private int devt;
	private int eventt;
	private int pmut;
	private int invt;
	private int usert;
	private int state;
	private int reportId=1;
	private String recieverList;
	private int repFormat;
	private String sendTime;
	private int nextdelay;
	private int nextdelay2;
	private int emptysend;
	private int maxeventlimit;
	private String itemstr;
	private List<Map> accountList;
	private String stationName;
	private int accountId;
	private String rightStr;
	private String startDt;
	private String endDt;
	private String desc;
	private int searchOnline=100;
	private String email;
	private String firstName;
	private String secondName;
	private String company;
	private String country;
	private String city;
	private String tel;
	private String mobile;

	private List<Map> stateList;
	private List<Map> countryList;
	private int msgtype=-1;
	private int devtype=-1;
	private String devmodel=null;
	private int countryId=-1;

	private int status=-1;

	private String hardver;
	private String softver;
	private int autoupdate=-1;
	private int needupdate=-1;
	private String psnos;
	
	private String subtag;
	private String lan;
	private String Val1;
	private String val2;
	private String content;
	private List<Map> lang;
	private List<Map> subTagList;
	private List<Map> paramList;
	private String errcode = "-1";
	
	private String isno;
	
	private String reciverlist;
	List eventList;
	String nowDay;
	Map reportConMap;
	private List<Map> pmuListEx;
	private int updateRight;
	private List<Map> invListEx;
	private String opdate;
	
	
	public String pmuList(){
		this.getSession().setAttribute("defaultStation","0");
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
		updateRight=stationService.getUpdateRight(Integer.parseInt(userId));
		//this.getSession().setAttribute("updateRight",updateRight);
		this.getSession().setAttribute("userMenu", userMenu);
		
		this.getSession().setAttribute("userId", userId+"");
		typeList=stationService.getPumTypeList();
		modelList=stationService.getPumModelList();
		if (page==0)
			page=1;
		if (type!=null && type.equals(""))
			type=null;
		if (model!=null && model.equals(""))
			model=null;
		if (listno !=null && listno.equals(""))
			listno=null;
		allPage=stationService.findPumPageNum(type, model, listno,searchOnline,hardver,softver,autoupdate,needupdate, pagecols, page);
		////判断,当面页大于总页数时, 当前页等于总页数
		if(page > allPage){
			page = allPage;
		}
		pmuListEx=stationService.findPumList(type, model, listno,searchOnline,hardver,softver,autoupdate,needupdate, pagecols, page);
		//this.getSession().setAttribute("pmuslist", pmulist);
		this.getSession().setAttribute("allPage", allPage);
		return SUCCESS;
	}
	public String pmuManager(){
		this.getSession().setAttribute("defaultStation","0");
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
		this.getSession().setAttribute("userMenu", userMenu);
			
		pmuTypeAnalyList=stationService.getPumAnalyTypeList();
		
		pmuCountryAnalyList=stationService.getPumAnalyCountryList();
		analyTotalType=stationService.getPumAnalyTotalType();
		analyTotalCountry=stationService.getPumAnalyTotalCountry();
	
		for(int i=0;i<pmuTypeAnalyList.size();i++){
			Map temp=(Map)pmuTypeAnalyList.get(i);
			temp.put("color", getRandColorCode());
			pmuTypeAnalyList.set(i, temp);
		}
		for(int i=0;i<pmuCountryAnalyList.size();i++){
			Map temp=(Map)pmuCountryAnalyList.get(i);
			temp.put("color",  getRandColorCode());
			pmuCountryAnalyList.set(i, temp);
		}
		return SUCCESS;
	}

	public String pmuView(){
		pumInfoMap=stationService.getPumInfo(listno);
		JSONObject jsonObject  = new JSONObject();
		//String pmuRes =stationService.checkPMuinValid(psno, registno);
		if(pumInfoMap!=null){
			String infos="";
			if (pumInfoMap.get("stationname")==null || ((String)pumInfoMap.get("stationname")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("stationname")+";";
			
			if (pumInfoMap.get("psno")==null || ((String)pumInfoMap.get("psno")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("psno")+";";
			
			
			if (pumInfoMap.get("idex")==null || ((String)pumInfoMap.get("idex")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("idex")+";";
			
			if (pumInfoMap.get("pmutype")==null || ((String)pumInfoMap.get("pmutype")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("pmutype")+";";
			
			if (pumInfoMap.get("subtype")==null || ((String)pumInfoMap.get("subtype")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("subtype")+";";
			
			if (pumInfoMap.get("upa")==null || ((String)pumInfoMap.get("upa")).equals("null"))
				infos=infos+";";
			else
			{
				if (pumInfoMap.get("upa").toString().equals("1"))
					infos=infos+"打开;";
				else
					infos=infos+"关闭;";
				
			}
			if (pumInfoMap.get("upn")==null || ((String)pumInfoMap.get("upn")).equals("null"))
				infos=infos+";";
			else
			{
				if (pumInfoMap.get("upn").toString().equals("1"))
					infos=infos+"需要;";
				else
					infos=infos+"不需要;";
				
			}
				
			
			
			if (pumInfoMap.get("usedspace")==null || ((String)pumInfoMap.get("usedspace")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("usedspace")+";";
			
			if (pumInfoMap.get("totalspace")==null || ((String)pumInfoMap.get("totalspace")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("totalspace")+";";
			
			if (pumInfoMap.get("state")==null || ((String)pumInfoMap.get("state")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("state")+";";
			
			if (pumInfoMap.get("softver")==null || ((String)pumInfoMap.get("softver")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("softver")+";";
			
			if (pumInfoMap.get("hardwver")==null || ((String)pumInfoMap.get("hardwver")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("hardwver")+";";
			
			
			
			if (pumInfoMap.get("llip")==null || ((String)pumInfoMap.get("llip")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("llip")+";";
			
			//2013-07-31新加curgate
			if (pumInfoMap.get("curgate")==null || ((String)pumInfoMap.get("curgate")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("curgate")+";";
			
			if (pumInfoMap.get("lldt")==null || ((String)pumInfoMap.get("lldt")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("lldt")+";";
			jsonObject.put("status", "ok");
			jsonObject.put("res", infos);
		}else{
			jsonObject.put("status", "error");
			//PMU不存在
			jsonObject.put("errorcode", "0");
		}
		this.print(jsonObject.toString());
		return null;
	
	}

	public String devView(){
		devInfoMap=stationService.getDevInfo(listno);
		
		JSONObject jsonObject  = new JSONObject();
		if(devInfoMap!=null){
			
			String infos="";
			
			if (devInfoMap.get("ssno")==null || ((String)devInfoMap.get("ssno")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("ssno")+";";
			
			if (devInfoMap.get("typename")==null || ((String)devInfoMap.get("typename")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("typename")+";";
			
			if (devInfoMap.get("devicename")==null || ((String)devInfoMap.get("devicename")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("devicename")+";";
			
			if (devInfoMap.get("softver")==null || ((String)devInfoMap.get("softver")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("softver")+";";

			if (devInfoMap.get("hardwarever")==null || ((String)devInfoMap.get("hardwarever")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("hardwarever")+";";

			if (devInfoMap.get("xh")==null || ((String)devInfoMap.get("xh")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("xh")+";";
			
			//下面是我加的e_total
			if (devInfoMap.get("e_total")==null || ((String)devInfoMap.get("e_total")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("e_total")+";";

			if (devInfoMap.get("factory")==null || ((String)devInfoMap.get("factory")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("factory")+";";
			
			if (devInfoMap.get("pp")==null || ((String)devInfoMap.get("pp")).equals("null"))
				infos=infos+";";
			else
				infos=infos+devInfoMap.get("pp")+";";
			
			jsonObject.put("status", "ok");
			jsonObject.put("res", infos);
		}else{
			jsonObject.put("status", "error");
			//PMU不存在
			jsonObject.put("errorcode", "0");
		}
		this.print(jsonObject.toString());
		return null;
	
	}
	
	public String equip_view(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			try {
				Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
				Map stationInfo=stationService.getStationInfoById(Integer.parseInt(stationId));
				stationDevList=stationService.getStationDeviceex(Integer.parseInt(stationId));
				Map stationMap = stationService.findStationById(Integer.parseInt(stationId));
				this.getSession().setAttribute("defaultStationMap",stationMap);
				this.getSession().setAttribute("userMenu", userMenu);
				this.getSession().setAttribute("stationInfo", stationInfo);
				this.getSession().setAttribute("userId", userId+"");
			} catch (Exception e) {
				logger.error(e);
			}
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime= formatter.format(new Date());
			formatter = new SimpleDateFormat("yyyy-MM-dd");
			nowDay= formatter.format(new Date());
			return SUCCESS;
		}
	}
	
	/** 设备列表页面---删除逆变器   */
	public String removeInvbasepmu(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId!=null)
		{
			String res = stationService.removeInv(Integer.parseInt(stationId), isno);
			JSONObject jsonObject = new JSONObject();
			if(res.equals("ok")){
				jsonObject.put("status", "ok");
			}else{
				jsonObject.put("status", "err");
			}
		}
		else
		{
			logger.debug("电站ID为null, 请重新获取 !");
		}
		return null;
	}
	
	public String setDevName(){
		JSONObject jsonObject  = new JSONObject();
		try{
		stationService.setDevName(listno, byName);
		jsonObject.put("status", "ok");
		}catch (Exception e){
			jsonObject.put("status", "error");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String unbindPmu(){
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.stationUnBindPM(Integer.parseInt(stationId), listno,serialno,opdate);
			if (res.equals("ok"))
				jsonObject.put("status", "ok"); 
			else if (res.equals("err_psno_idex")){
				jsonObject.put("status", "error"); 

				jsonObject.put("errorcode", "2");
			}else if (res.equals("err_itemempty")){
				jsonObject.put("status", "error"); 

				jsonObject.put("errorcode", "1");
			}
			else{
				jsonObject.put("status", "error"); 
				jsonObject.put("errorcode", "0");
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error"); 
			jsonObject.put("errorcode", "1");
		}finally{
			this.print(jsonObject.toString());
		}
		return null;
	}
	public String bindPmu(){
		JSONObject jsonObject  = new JSONObject();
		try{
			String  res= stationService.stationBindPM(Integer.parseInt(stationId), listno, serialno, opdate);
			if(res.equals("ok")){
					jsonObject.put("status", "ok");
			}else if(res.equals("err_serial")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if(res.equals("err_usednow")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}else if(res.equals("err_notexists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "3");
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");//未知错误
		}finally{
			this.print(jsonObject.toString());
		}
		return null;
	}
	/*
	 * 
	 */
	public String invList(){
		this.getSession().setAttribute("defaultStation","0");
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
		this.getSession().setAttribute("userMenu", userMenu);
		//Map stationInfo=stationService.getStationInfoById(Integer.parseInt(stationId));
		//this.getSession().setAttribute("stationInfo", stationInfo);
		this.getSession().setAttribute("userId", userId+"");
		typeList=stationService.getInvTypeList();
		//modelList=stationService.getInvPinpaiList();
		//factoryList=stationService.getInvFactoryList();
		if (page==0)
			page=1;
		if (type!=null && type.equals(""))
			type=null;
		if (stationName!=null && stationName.equals(""))
			stationName=null;
		if (listno !=null && listno.equals(""))
			listno=null;
		
		//总页数
		allPage=stationService.findInvPageNum(stationName,type, listno, pagecols, page);
		////判断,当面页大于总页数时, 当前页等于总页数
		if(page > allPage){
			page = allPage;
		}
		invListEx=stationService.findInvList(stationName,type,listno, pagecols, page);
		//this.getSession().setAttribute("invlist", pmulist);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime= formatter.format(new Date());
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		nowDay= formatter.format(new Date());
		//this.getSession().setAttribute("nowDay", nowDay);
		return SUCCESS;
	}
	public String invManager(){
		this.getSession().setAttribute("defaultStation","0");
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
		this.getSession().setAttribute("userMenu", userMenu);
		
		pmuTypeAnalyList=stationService.getInvAnalyTypeList();
		
		pmuCountryAnalyList=stationService.getInvAnalyCountryList();
		analyTotalType=stationService.getInvAnalyTotalType();
		analyTotalCountry=stationService.getInvAnalyTotalCountry();
		
		
		for(int i=0;i<pmuTypeAnalyList.size();i++){
			Map temp=(Map)pmuTypeAnalyList.get(i);
			temp.put("color", getRandColorCode());
			pmuTypeAnalyList.set(i, temp);
		}
		for(int i=0;i<pmuCountryAnalyList.size();i++){
			Map temp=(Map)pmuCountryAnalyList.get(i);
			temp.put("color", getRandColorCode());
			pmuCountryAnalyList.set(i, temp);
		}
		return SUCCESS;
	}

	public String invView(){
		pumInfoMap=stationService.getInvInfo(listno);
		JSONObject jsonObject  = new JSONObject();
		//String pmuRes =stationService.checkPMuinValid(psno, registno);
		if(pumInfoMap!=null){
			String infos="";
			
			/*if (pumInfoMap.get("createdt")==null || ((String)pumInfoMap.get("createdt")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("createdt")+";";*/
			infos=infos + listno + ";";
			
			if (pumInfoMap.get("devname")==null || ((String)pumInfoMap.get("devname")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("devname")+";";
			
			if (pumInfoMap.get("factoryname")==null || ((String)pumInfoMap.get("factoryname")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("factoryname")+";";
			
			if (pumInfoMap.get("penpai")==null || ((String)pumInfoMap.get("penpai")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("penpai")+";";
			
			if (pumInfoMap.get("softver")==null || ((String)pumInfoMap.get("softver")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("softver")+";";

			if (pumInfoMap.get("hardver")==null || ((String)pumInfoMap.get("hardver")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("hardver")+";";
			
			if (pumInfoMap.get("e_total")==null || ((String)pumInfoMap.get("e_total")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("e_total")+";";

			if (pumInfoMap.get("h_total")==null || ((String)pumInfoMap.get("h_total")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("h_total")+";";
			
			if (pumInfoMap.get("devtypename")==null || ((String)pumInfoMap.get("devtypename")).equals("null"))
				infos=infos+";";
			else
				infos=infos+pumInfoMap.get("devtypename")+";";
			
			jsonObject.put("status", "ok");
			jsonObject.put("res", infos);
		}else{
			jsonObject.put("status", "error");
			//PMU不存在
			jsonObject.put("errorcode", "0");
		}
		this.print(jsonObject.toString());
		return null;
	
	}
	public String removeAdminAccount(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			stationService.removeSystemAdmin(account);
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String updateAdminAccount(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.updateSystemAdmin(account, updatet, plantt, usert,devt,eventt, state);
			if (res==null)
			jsonObject.put("status", "ok");
			else if (res.equals("err_notsysaccount")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "0");
			}else if (res.equals("err_notexists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "2");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String addAdminAccount(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.addSystemAdmin(account, updatet, plantt, usert,devt,eventt, state);
			if (res.equals("ok"))
			jsonObject.put("status", "ok");
			else if (res.equals("err_useraccount")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "0");
			}else if (res.equals("err_accountnotexists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "2");
		}
		
		this.print(jsonObject.toString());
		return null;
	
		}
	public String reportDayShow(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
			this.getSession().setAttribute("userMenu", userMenu);
			Map stationInfo=stationService.getStationInfoById(Integer.parseInt(stationId));
			this.getSession().setAttribute("stationInfo", stationInfo);
			this.getSession().setAttribute("userId", userId+"");
			reportConMap=stationService.getDayReportConfig(reportId, Integer.parseInt(stationId));
			if (reportConMap!=null && reportConMap.get("itemstr")!=null && !((String)reportConMap.get("itemstr")).equals("")){
				String itm=(String)reportConMap.get("itemstr");
				String itms[]=itm.split(",");
				reportConMap.put("itemstr1",itms[0]);
				reportConMap.put("itemstr2",itms[1]);
				reportConMap.put("itemstr3",itms[2]);
				reportConMap.put("itemstr4",itms[3]);
				reportConMap.put("itemstr5",itms[4]);
				reportConMap.put("itemstr6",itms[5]);
				reportConMap.put("itemstr7",itms[6]);
			}else{
				reportConMap.put("itemstr1","0");
				reportConMap.put("itemstr2","0");
				reportConMap.put("itemstr3","0");
				reportConMap.put("itemstr4","0");
				reportConMap.put("itemstr5","0");
				reportConMap.put("itemstr6","0");
				reportConMap.put("itemstr7","0");
			}
			reciverlist = (String)reportConMap.get("reciverlist");
			return SUCCESS;
		}
	}
	
	public String reportMonShow(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
			this.getSession().setAttribute("userMenu", userMenu);
			Map stationInfo=stationService.getStationInfoById(Integer.parseInt(stationId));
			this.getSession().setAttribute("stationInfo", stationInfo);
			this.getSession().setAttribute("userId", userId+"");
			reportConMap=stationService.getMonReportConfig(reportId, Integer.parseInt(stationId));
			if (reportConMap!=null && reportConMap.get("itemstr")!=null && !((String)reportConMap.get("itemstr")).equals("")){
				String itm=(String)reportConMap.get("itemstr");
				String itms[]=itm.split(",");
				reportConMap.put("itemstr1",itms[0]);
				reportConMap.put("itemstr2",itms[1]);
				reportConMap.put("itemstr3",itms[2]);
				reportConMap.put("itemstr4",itms[3]);
				reportConMap.put("itemstr5",itms[4]);
				reportConMap.put("itemstr6",itms[5]);
				reportConMap.put("itemstr7",itms[6]);
			}else{
				reportConMap.put("itemstr1","0");
				reportConMap.put("itemstr2","0");
				reportConMap.put("itemstr3","0");
				reportConMap.put("itemstr4","0");
				reportConMap.put("itemstr5","0");
				reportConMap.put("itemstr6","0");
				reportConMap.put("itemstr7","0");
			}
			return SUCCESS;
		}
	}
	
	public String reportEventShow(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
			this.getSession().setAttribute("userMenu", userMenu);
			Map stationInfo=stationService.getStationInfoById(Integer.parseInt(stationId));
			this.getSession().setAttribute("stationInfo", stationInfo);
			this.getSession().setAttribute("userId", userId+"");
			reportConMap=stationService.getEventReportConfig(reportId, Integer.parseInt(stationId));
			if (reportConMap!=null && reportConMap.get("itemstr")!=null && !((String)reportConMap.get("itemstr")).equals("")){
				String itm=(String)reportConMap.get("itemstr");
				String itms[]=itm.split(",");
				reportConMap.put("itemstr1",itms[0]);
				reportConMap.put("itemstr2",itms[1]);
			}else{
				reportConMap.put("itemstr1","0");
				reportConMap.put("itemstr2","0");
			}
			this.getSession().setAttribute("reportConMap", reportConMap);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime= formatter.format(new Date());
			formatter = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay= formatter.format(new Date());
			//this.getSession().setAttribute("nowDay", nowDay);
			return SUCCESS;
		}
	}
	
	public String reportDay(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			stationService.putDayReportConfig(reportId, Integer.parseInt(stationId), state, recieverList, repFormat, sendTime, itemstr,localLang);
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	}
	
	public String sendReportDay(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			Map reportInfo=stationService.getReportMainInfoDay(Integer.parseInt(stationId), 1, itemstr);
			List<Map> reportInfoList=stationService.getReportListInfoDay(Integer.parseInt(stationId), 1, itemstr);
			String localtime = stationService.getLocalTime(Integer.parseInt(stationId));
			String userName = ((Map)this.getSession().getAttribute("user")).get("FIRSTNAME").toString()+((Map)this.getSession().getAttribute("user")).get("SECONDNAME").toString();
			String reportimg="";
			MainSend mainSendms=new MainSend();
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			String path = this.getRequest().getContextPath();
			String realPath=this.getRequest().getSession().getServletContext().getRealPath("");
			realPath=realPath+"/WEB-INF/classes/";
			String basePath =this.getRequest().getScheme()+"://"+this.getRequest().getServerName()+":"+this.getRequest().getServerPort()+path+"/";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime= formatter.format(new Date());
			formatter = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay= formatter.format(new Date());
			long now = System.currentTimeMillis();
			String newFileName = "";		
			newFileName =realPath+"/../../upload/report/"+ Long.toString(now)+".jpg";
			ReportImage img=new ReportImage();
			img.areaImage(reportInfoList,nowDay,newFileName);
			mainSendms.setLocaltime(localtime);
			mainSendms.setStationId(Integer.parseInt(stationId));
			mainSendms.doSendDayReport(recieverList, userName, stationName, reportInfo, itemstr, localLang, realPath, basePath,basePath+"/upload/report/"+ Long.toString(now)+".jpg");
			String dateArray[][]=new String[144][2];
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	
	}
	public String reportMon(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			stationService.putMonReportConfig(reportId, Integer.parseInt(stationId), state, recieverList, repFormat, itemstr,localLang);
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	}
	
	public String sendReportMonth(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			Map reportInfo=stationService.getReportMainInfoMonth(Integer.parseInt(stationId), 2, itemstr);
			List<Map> reportInfoList=stationService.getReportListInfoMonth(Integer.parseInt(stationId), 2, itemstr);
			
			String localtime = stationService.getLocalTime(Integer.parseInt(stationId));
			
			String userName = ((Map)this.getSession().getAttribute("user")).get("FIRSTNAME").toString()+((Map)this.getSession().getAttribute("user")).get("SECONDNAME").toString();
			String reportimg="";
			MainSend mainSendms=new MainSend();
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			String path = this.getRequest().getContextPath();
			String realPath=this.getRequest().getSession().getServletContext().getRealPath("");
			realPath=realPath+"/WEB-INF/classes/";
			String basePath =this.getRequest().getScheme()+"://"+this.getRequest().getServerName()+":"+this.getRequest().getServerPort()+path+"/";

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String nowTime= formatter.format(new Date());
			 formatter = new SimpleDateFormat("yyyy-MM-dd");
			 String nowDay= formatter.format(new Date());
			long now = System.currentTimeMillis();
			String newFileName = "";		
			newFileName =realPath+"/../../upload/report/"+ Long.toString(now)+".jpg";
			ReportImage img=new ReportImage();
			img.barImage(reportInfoList,nowDay,newFileName);
			
			mainSendms.setLocaltime(localtime);
			mainSendms.setStationId(Integer.parseInt(stationId));
			mainSendms.doSendMonthReport(recieverList, userName, stationName, reportInfo, itemstr, localLang, realPath, basePath,basePath+"/upload/report/"+ Long.toString(now)+".jpg");
			
			
			jsonObject.put("status", "ok");
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String reportEvent(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			stationService.putEventReportConfig(reportId, Integer.parseInt(stationId), state, recieverList, repFormat, nextdelay2, emptysend, maxeventlimit, itemstr,localLang);
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	}
	
	public String sendReportEvent(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			
			String localtime = stationService.getLocalTime(Integer.parseInt(stationId));
			
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String nowTime= formatter.format(new Date());
			 formatter = new SimpleDateFormat("yyyy-MM-dd");
			 String nowDay= formatter.format(new Date());
			itemstr=itemstr+","+localLang;
			Map reportInfo=stationService.getReportMainInfoEvent(Integer.parseInt(stationId), 3, itemstr);
			List<Map> reportInfoList=stationService.getReportListInfoEvent(Integer.parseInt(stationId), 3, itemstr);
			String userName = ((Map)this.getSession().getAttribute("user")).get("FIRSTNAME").toString()+((Map)this.getSession().getAttribute("user")).get("SECONDNAME").toString();
			String reportimg="";
			MainSend mainSendms=new MainSend();
			
			String path = this.getRequest().getContextPath();
			String realPath=this.getRequest().getSession().getServletContext().getRealPath("");
			realPath=realPath+"/WEB-INF/classes/";
			String basePath =this.getRequest().getScheme()+"://"+this.getRequest().getServerName()+":"+this.getRequest().getServerPort()+path+"/";

			String tab="<table border='1' cellspacing='0' cellpadding='0'>";
			tab=tab+"<tr>";
			tab=tab+"    <td width='61' valign='top'><p>"+getProperties("RES_REPORT_EVENT_ITEM",realPath+"messageResource_"+localLang+".properties")+" </p></td>";
			tab=tab+"    <td width='156' valign='top'><p align='center'>SN.</p></td>";
			tab=tab+"    <td width='156' valign='top'><p align='center'>"+getProperties("RES_ETIME",realPath+"messageResource_"+localLang+".properties")+"</p></td>";
			tab=tab+"    <td width='81' valign='top'><p align='center'>"+getProperties("RES_REPORT_EVENT_TYPE",realPath+"messageResource_"+localLang+".properties")+" </p></td>";
			tab=tab+"    <td width='260' valign='top'><p align='center'>"+getProperties("RES_REPORT_EVENT_CONTENT",realPath+"messageResource_"+localLang+".properties")+"</p></td>";
			tab=tab+"  </tr>";
			if (reportInfoList!=null && reportInfoList.size()>0){
				for (int ii=0;ii<reportInfoList.size();ii++){
				Map rinfo=(Map)reportInfoList.get(ii);
				tab=tab+"<tr>";
				tab=tab+"<td width='61' valign='top'>"+(ii+1)+"</td>";
				tab=tab+"<td width='156' valign='top'>"+rinfo.get("sn").toString()+"</td>";
				tab=tab+"<td width='156' valign='top'>"+rinfo.get("occdt").toString()+"</td>";
				tab=tab+"<td width='81' valign='top'>"+rinfo.get("msgtype").toString()+"</td>";
				tab=tab+"<td width='260' valign='top'>"+rinfo.get("context").toString()+"</td>";
				tab=tab+"</tr>";
				}
			}
			tab=tab+"</table>";
			if ((reportInfoList!=null && reportInfoList.size()>0) || emptysend==0)
			mainSendms.setLocaltime(localtime);
			mainSendms.setStationId(Integer.parseInt(stationId));
			Date edate = null;
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			endDt = sdf.format(new Date());
			mainSendms.doSendEventReport(recieverList, userName, stationName, reportInfo, itemstr, localLang, realPath, basePath,tab,startDt,endDt);
			jsonObject.put("status", "ok");
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String shareAccountConfListShow(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
			this.getSession().setAttribute("userMenu", userMenu);
			accountList=stationService.getStationSharedaAcountList(Integer.parseInt(stationId));
			for (int i=0;i<accountList.size();i++){
				Map account=(Map)accountList.get(i);
				if (account!=null && account.get("rightstr")!=null && !((String)account.get("rightstr")).equals("")){
					String itm=(String)account.get("rightstr");
					String itms[]=itm.split(",");
					account.put("rightStr1",itms[0]);
					account.put("rightStr2",itms[1]);
					account.put("rightStr3",itms[2]);
				}else{
					account.put("rightStr1","0");
					account.put("rightStr2","0");
					account.put("rightStr3","0");				
				}
				accountList.set(i, account);
			}
			return SUCCESS;
		}
	}
	
	public String createStationShareAccount(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.setStationtoAccount(Integer.parseInt(stationId), account, rightStr);
			if (res.equals("ok")){
			jsonObject.put("status", "ok");
			}else if (res.equals("err_exists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if (res.equals("err_account")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String checkStationShareCode(){
		String res=stationService.checkSharePlantCode(plantt, accountId, serialno);
		if (res!=null && res.equals("err_account")){
			state=-1;
			
		}else if (res!=null && res.equals("err_verifycode")){
			state=-2;
			
		}else{
			state=0;
		}
		return SUCCESS;
	}
	public String createStationShareAccountRight(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.setStationtoAccountRight(Integer.parseInt(stationId), accountId, rightStr);
			if (res.equals("ok"))
			jsonObject.put("status", "ok");
			else if (res.equals("err_notexists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if (res.equals("err_account")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String setStationShareAccount(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			stationService.putEventReportConfig(reportId, Integer.parseInt(stationId), state, recieverList, repFormat, nextdelay, emptysend, maxeventlimit, itemstr,localLang);
			
			jsonObject.put("status", "ok");
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String removeAccFromStation(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.removeAccFromStation(Integer.parseInt(stationId), accountId);
			Map stationMap=(Map)this.getSession().getAttribute("defaultStationMap");
			Map userMap=(Map)userService.findUserById(accountId);
			if (state==1){
			MainSend mainSendms=new MainSend();
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			String path = this.getRequest().getContextPath();
			String realPath=this.getRequest().getSession().getServletContext().getRealPath("");
			realPath=realPath+"/WEB-INF/classes/";
			String basePath =this.getRequest().getScheme()+"://"+this.getRequest().getServerName()+":"+this.getRequest().getServerPort()+path+"/";
			mainSendms.doSendShareDel(userMap.get("account").toString(), stationMap.get("admin").toString(), stationMap.get("account").toString(), userMap.get("firstname").toString()+" "+userMap.get("secondname").toString(), stationMap.get("stationname").toString(), localLang, realPath, basePath);
			}
			if (res.equals("ok"))
			jsonObject.put("status", "ok");
			else if (res.equals("err_roleid")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if (res.equals("err_norolerec")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}

	public String accountSearchList(){
		this.getSession().setAttribute("defaultStation","0");
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
		this.getSession().setAttribute("userMenu", userMenu);
		
		this.getSession().setAttribute("userId", userId+"");
		typeList=stationService.getPumTypeList();
		modelList=stationService.getPumModelList();
		if (page==0)
			page=1;
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		countryList=stationService.getContryList(localLang);
		if (country!=null && !country.equals(""))
			stateList=stationService.getStateList(Integer.parseInt(country), localLang);
		String st=null;
		if (state!=0){
			st=state+"";
		}
		if (country!=null && country.equals("0")){
			
			country=null;
		}
		allPage=stationService.accountSearchCount(email, firstName, secondName, tel, mobile, country, st, city, company, page, pagecols);
		////判断,当面页大于总页数时, 当前页等于总页数
		if(page > allPage){
			page = allPage;
		}
		accountList=stationService.accountSearchList(email, firstName, secondName, tel, mobile, country, st, city, company, page, pagecols);
		return SUCCESS;
	}
	
	public String findEvent(){
		try {
			//页面传进来时判断
			if(this.getRequest().getParameter("errcode") == ""){
				errcode = "-1";
			}
			this.getSession().setAttribute("defaultStation","0");
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), 0);
			this.getSession().setAttribute("userMenu", userMenu);
			String clientdate = (String) this.getSession().getAttribute("clientdate");
			if (startDt==null){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				//endDt= formatter.format(new Date());
				endDt = clientdate;
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				int inputDayOfYear = cal.get(Calendar.DAY_OF_YEAR);
				cal.set(Calendar.DAY_OF_YEAR , inputDayOfYear-7 );
				startDt=endDt;
				}	
			if (devmodel!=null && devmodel.equals("-1"))
				devmodel="";
			
			Map eveM=stationService.findEventList(msgtype, status, desc, listno, startDt, endDt, stationName, countryId, devtype,devmodel, errcode, pagecols, page);
			eventList=(List<Map>)eveM.get("eventList");
			allPage=Integer.parseInt((String)eveM.get("allPage"));
			//判断,当面页大于总页数时, 当前页等于总页数
			if(page > allPage){
				page = allPage;
			}
			//this.getSession().setAttribute("eventList", eventList);
			String localLang="en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
				localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			countryList=stationService.getContryList(localLang);
			typeList=stationService.getInvTypeList();
			modelList=stationService.getPumModelList();
			//后台判断当errcode==-1时, jsp页面显示为Null
			if(errcode == "-1"){
				errcode = null;
			}
		} catch (Exception e) {
			logger.error(e);
		}
		return SUCCESS;
	
	}
	
	public String accountList(){
		this.getSession().setAttribute("defaultStation","0");
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), 0);
		this.getSession().setAttribute("userMenu", userMenu);
		accountList=stationService.getSystemAdminList();
		return SUCCESS;
	}
	public String searchDict(){		
		lang=this.stationService.findDictLang();
		subTagList=this.stationService.findDictSubTag();
		if (subtag!=null && subtag.trim().equals(""))
			subtag=null;
		if (lan!=null && lan.trim().equals(""))
			lan=null;
		if (Val1!=null && Val1.trim().equals(""))
			Val1=null;
		if (val2!=null && val2.trim().equals(""))
			val2=null;
		if (content!=null && content.trim().equals(""))
			content=null;
		
		allPage=stationService.findDictListPage(subtag, lan, Val1, val2, content, pagecols, page);
		//判断,当面页大于总页数时, 当前页等于总页数
		if(page > allPage){
			page = allPage;
		}
		paramList=this.stationService.findDictList(subtag, lan, Val1, val2, content, pagecols, page);
		return SUCCESS;
	}

	public String createDict(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			String res=stationService.createDict(subtag, lan, Val1, val2, content);
			if (res.equals("ok")){
			jsonObject.put("status", "ok");
			
			}
			else if (res.equals("error_exists")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if (res.equals("error_lan")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}

public String updateDict(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			stationService.updateDict(subtag, lan, Val1, val2, content);
			
			
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}
	public String removeDict(){
	
	JSONObject jsonObject  = new JSONObject();
	try{
		stationService.removeDict(subtag, lan, Val1, val2);
		
		
	}catch(Exception e){
		e.printStackTrace();
		jsonObject.put("status", "error");
		jsonObject.put("errorcode", "0");
	}
	
	this.print(jsonObject.toString());
	return null;

}
	
	/**
	 * 修改电站的关注属性
	 * @see 2013-06-28
	 */
	public String updateStationAttention(){
		stationService.updateStationAttention(stationId, state);
		return null;
	}
	
	
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public List<Map> getPmulist() {
		return pmulist;
	}
	public void setPmulist(List<Map> pmulist) {
		this.pmulist = pmulist;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getListno() {
		return listno;
	}
	public void setListno(String listno) {
		this.listno = listno;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getAllPage() {
		return allPage;
	}
	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}
	public List<Map> getTypeList() {
		return typeList;
	}
	public void setTypeList(List<Map> typeList) {
		this.typeList = typeList;
	}
	public List<Map> getModelList() {
		return modelList;
	}
	public void setModelList(List<Map> modelList) {
		this.modelList = modelList;
	}

	
	public StationService getStationService() {
		return stationService;
	}
	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}
	public List<Map> getPmuTypeAnalyList() {
		return pmuTypeAnalyList;
	}
	public void setPmuTypeAnalyList(List<Map> pmuTypeAnalyList) {
		this.pmuTypeAnalyList = pmuTypeAnalyList;
	}
	public List<Map> getPmuCountryAnalyList() {
		return pmuCountryAnalyList;
	}
	public void setPmuCountryAnalyList(List<Map> pmuCountryAnalyList) {
		this.pmuCountryAnalyList = pmuCountryAnalyList;
	}

	public Map getPumInfoMap() {
		return pumInfoMap;
	}
	public void setPumInfoMap(Map pumInfoMap) {
		this.pumInfoMap = pumInfoMap;
	}
	public List<Map> getStationDevList() {
		return stationDevList;
	}
	public void setStationDevList(List<Map> stationDevList) {
		this.stationDevList = stationDevList;
	}
	public String getByName() {
		return byName;
	}
	public void setByName(String byName) {
		this.byName = byName;
	}
	public String getSerialno() {
		return serialno;
	}
	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}
	public List<Map> getFactoryList() {
		return factoryList;
	}
	public void setFactoryList(List<Map> factoryList) {
		this.factoryList = factoryList;
	}
	public String getFactory() {
		return factory;
	}
	public void setFactory(String factory) {
		this.factory = factory;
	}
	public List<Map> getAccountList() {
		return accountList;
	}
	public void setAccountList(List<Map> accountList) {
		this.accountList = accountList;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getPmut() {
		return pmut;
	}
	public void setPmut(int pmut) {
		this.pmut = pmut;
	}
	public int getInvt() {
		return invt;
	}
	public void setInvt(int invt) {
		this.invt = invt;
	}
	public int getUsert() {
		return usert;
	}
	public void setUsert(int usert) {
		this.usert = usert;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public String getRecieverList() {
		return recieverList;
	}
	public void setRecieverList(String recieverList) {
		this.recieverList = recieverList;
	}
	public int getRepFormat() {
		return repFormat;
	}
	public void setRepFormat(int repFormat) {
		this.repFormat = repFormat;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public int getNextdelay() {
		return nextdelay;
	}
	public void setNextdelay(int nextdelay) {
		this.nextdelay = nextdelay;
	}
	public int getEmptysend() {
		return emptysend;
	}
	public void setEmptysend(int emptysend) {
		this.emptysend = emptysend;
	}
	public int getMaxeventlimit() {
		return maxeventlimit;
	}
	public void setMaxeventlimit(int maxeventlimit) {
		this.maxeventlimit = maxeventlimit;
	}
	public String getItemstr() {
		return itemstr;
	}
	public void setItemstr(String itemstr) {
		this.itemstr = itemstr;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public String getRightStr() {
		return rightStr;
	}
	public void setRightStr(String rightStr) {
		this.rightStr = rightStr;
	}
	public UserLimitService getUserLimitService() {
		return userLimitService;
	}
	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}
	public int getUpdatet() {
		return updatet;
	}
	public void setUpdatet(int updatet) {
		this.updatet = updatet;
	}
	public int getPlantt() {
		return plantt;
	}
	public void setPlantt(int plantt) {
		this.plantt = plantt;
	}
	public int getDevt() {
		return devt;
	}
	public void setDevt(int devt) {
		this.devt = devt;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getSecondName() {
		return secondName;
	}
	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public List<Map> getStateList() {
		return stateList;
	}
	public void setStateList(List<Map> stateList) {
		this.stateList = stateList;
	}
	public List<Map> getCountryList() {
		return countryList;
	}
	public void setCountryList(List<Map> countryList) {
		this.countryList = countryList;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
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
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return s;
	}
	
	public String getRandColorCode(){
		String r,g,b;   
		Random random = new Random();
		r = Integer.toHexString(random.nextInt(256)).toUpperCase(); 
		g = Integer.toHexString(random.nextInt(256)).toUpperCase();  
		b = Integer.toHexString(random.nextInt(256)).toUpperCase();  
		r = r.length()==1 ? "0" + r : r ; 
		g = g.length()==1 ? "0" + g : g ; 
		b = b.length()==1 ? "0" + b : b ; 
		return r+g+b;   
		}
public String shareaccountactive(){
		
		JSONObject jsonObject  = new JSONObject();
		try{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
			String res=stationService.shareaccountactive(plantt,Integer.parseInt(userId),state);
			if (res.equals("ok"))
			jsonObject.put("status", "ok");
			else if (res.equals("err_account")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "1");
			}else if (res.equals("err_state")){
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");
			}
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			
		}
		
		this.print(jsonObject.toString());
		return null;
	
	}

	public String setPmuUpdate(){
		JSONObject jsonObject  = new JSONObject();
		try{
			stationService.setPmuUpdate(status, psnos);
			jsonObject.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	}

	
	public int getSearchOnline() {
		pmulist=stationService.findDictList(subtag, lan, Val1, val2, content, pagecols, allPage);
		allPage=stationService.findDictListPage(subtag, lan, Val1, val2, content, pagecols, allPage);
		
		return searchOnline;
	}
	public void setSearchOnline(int searchOnline) {
		this.searchOnline = searchOnline;
	}
	public int getEventt() {
		return eventt;
	}
	public void setEventt(int eventt) {
		this.eventt = eventt;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getMsgtype() {
		return msgtype;
	}
	public void setMsgtype(int msgtype) {
		this.msgtype = msgtype;
	}
	public int getDevtype() {
		return devtype;
	}
	public void setDevtype(int devtype) {
		this.devtype = devtype;
	}
	public int getCountryId() {
		return countryId;
	}
	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDevmodel() {
		return devmodel;
	}
	public void setDevmodel(String devmodel) {
		this.devmodel = devmodel;
	}
	public int getAnalyTotalType() {
		return analyTotalType;
	}
	public void setAnalyTotalType(int analyTotalType) {
		this.analyTotalType = analyTotalType;
	}
	public int getAnalyTotalCountry() {
		return analyTotalCountry;
	}
	public void setAnalyTotalCountry(int analyTotalCountry) {
		this.analyTotalCountry = analyTotalCountry;
	}
	public int getNextdelay2() {
		return nextdelay2;
	}
	public void setNextdelay2(int nextdelay2) {
		this.nextdelay2 = nextdelay2;
	}
	public String getHardver() {
		return hardver;
	}
	public void setHardver(String hardver) {
		this.hardver = hardver;
	}
	public String getSoftver() {
		return softver;
	}
	public void setSoftver(String softver) {
		this.softver = softver;
	}
	public int getAutoupdate() {
		return autoupdate;
	}
	public void setAutoupdate(int autoupdate) {
		this.autoupdate = autoupdate;
	}
	public String getPsnos() {
		return psnos;
	}
	public void setPsnos(String psnos) {
		this.psnos = psnos;
	}
	public int getNeedupdate() {
		return needupdate;
	}
	public void setNeedupdate(int needupdate) {
		this.needupdate = needupdate;
	}
	public String getSubtag() {
		return subtag;
	}
	public void setSubtag(String subtag) {
		this.subtag = subtag;
	}
	public String getLan() {
		return lan;
	}
	public void setLan(String lan) {
		this.lan = lan;
	}
	public String getVal1() {
		return Val1;
	}
	public void setVal1(String val1) {
		Val1 = val1;
	}
	public String getVal2() {
		return val2;
	}
	public void setVal2(String val2) {
		this.val2 = val2;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<Map> getDictList() {
		return dictList;
	}
	public void setDictList(List<Map> dictList) {
		this.dictList = dictList;
	}
	public List<Map> getLang() {
		return lang;
	}
	public void setLang(List<Map> lang) {
		this.lang = lang;
	}
	public List<Map> getSubTagList() {
		return subTagList;
	}
	public void setSubTagList(List<Map> subTagList) {
		this.subTagList = subTagList;
	}
	public List<Map> getParamList() {
		return paramList;
	}
	public void setParamList(List<Map> paramList) {
		this.paramList = paramList;
	}
	public String getErrcode() {
		return errcode;
	}
	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}
	public String getIsno() {
		return isno;
	}
	public void setIsno(String isno) {
		this.isno = isno;
	}
	public String getReciverlist() {
		return reciverlist;
	}
	public void setReciverlist(String reciverlist) {
		this.reciverlist = reciverlist;
	}
	public List getEventList() {
		return eventList;
	}
	public void setEventList(List eventList) {
		this.eventList = eventList;
	}
	public String getNowDay() {
		return nowDay;
	}
	public void setNowDay(String nowDay) {
		this.nowDay = nowDay;
	}
	public Map getReportConMap() {
		return reportConMap;
	}
	public void setReportConMap(Map reportConMap) {
		this.reportConMap = reportConMap;
	}
	public List<Map> getPmuListEx() {
		return pmuListEx;
	}
	public void setPmuListEx(List<Map> pmuListEx) {
		this.pmuListEx = pmuListEx;
	}
	public int getUpdateRight() {
		return updateRight;
	}
	public void setUpdateRight(int updateRight) {
		this.updateRight = updateRight;
	}
	public List<Map> getInvListEx() {
		return invListEx;
	}
	public void setInvListEx(List<Map> invListEx) {
		this.invListEx = invListEx;
	}
	public String getOpdate() {
		return opdate;
	}
	public void setOpdate(String opdate) {
		this.opdate = opdate;
	}
	
	
	
}
