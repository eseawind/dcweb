package com.jstrd.asdc.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

import com.jstrd.asdc.service.StationService;
import com.jstrd.asdc.util.Base64Bean;

@SuppressWarnings({"unchecked","unused"})
public class StationAction extends BaseAction{
	private static Logger logger = Logger.getLogger(StationAction.class);
	private static final long serialVersionUID = 1L;
	private String stationname;//电站名称
	private String picurl;//电站图片URL
	private String startdt;//并网发电日期--
	private String installcap;//装机容量--
	private String country="0";//国家名称--
	private String city;//城市名称--
	private String street;//所在街道--
	private String state="0";//省份
	private String zip;//邮编
	private String jd;//经度:(东经23度，37分，30秒，格式为:e:23-27-30,西经为:w:23-27-30)
	private String wd;//纬度:(北纬132度,30分，27秒，格式为:n:132-30-27,南纬为:s:132-30-37)
	private String jd1;
	private String jd2;
	private String jd3;
	private String wd1;
	private String wd2;
	private String wd3;
	private String height;//海拔单位（米）
	private String insangle;//安装倾向角
	private String co2rate;//二氧化碳减排系数
	private String incomerate;//电站收益系数
	private String currency;//货币单位
	private String timezone ;//电站所在时区，东正,西负
	private String timezonex="0";//时间记录编号
	private String psno;
	private String registno;
	private Map stationMap;
	private List<Map> stateList;
	private String stationId;
	private String idex;//注册码
	private String type;//类型
	private String devname;//名称
	private String xh;//型号
	private String factory;//厂家制造商
	private String penpai;//品牌
	private String softver;//软件版本号
	private String hardver;//软件版本号
	private String company;
	private String clientzonestr;	//客户端时区
	private int timezoneid;			//客户端时区对应的key
	private String etotaloffset;	//电站ETOTAL偏移值
	private String opdate;			//客户端时间
	private String customerflag;	//自动执行夏令时标志
	
	public String getCustomerflag() {
		return customerflag;
	}
	public void setCustomerflag(String customerflag) {
		this.customerflag = customerflag;
	}
	public String getOpdate() {
		return opdate;
	}
	public void setOpdate(String opdate) {
		this.opdate = opdate;
	}
	public String getEtotaloffset() {
		return etotaloffset;
	}
	public void setEtotaloffset(String etotaloffset) {
		this.etotaloffset = etotaloffset;
	}
	public int getTimezoneid() {
		return timezoneid;
	}
	public void setTimezoneid(int timezoneid) {
		this.timezoneid = timezoneid;
	}
	public String getClientzonestr() {
		return clientzonestr;
	}
	public void setClientzonestr(String clientzonestr) {
		this.clientzonestr = clientzonestr;
	}
	public String getRegistno() {
		return registno;
	}
	public void setRegistno(String registno) {
		this.registno = registno;
	}
	public String getPsno() {
		return psno;
	}
	public void setPsno(String psno) {
		this.psno = psno;
	}
	public String getTimezone() {
		return timezone;
	}
	public String getTimezonex() {
		return timezonex;
	}
	private List<Map> countryList;
	private List<Map> timezoneList;
	private List<Map> incomerateList;
	private List<Map> currencyList;
	private List<Map> co2RateList;

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public void setTimezone(String timezone) {
		this.timezone = timezone;
	}
	public void setTimezonex(String timezonex) {
		this.timezonex = timezonex;
	}
	private StationService stationService;
	
	public StationService getStationService() {
		return stationService;
	}
	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}
	
	/**
	 * 获取当前系时区
	 * @return
	 */
	public String getTimeOffset(){
		this.getSession().setAttribute("clientzonestr", clientzonestr);
		return null;
	}
	
	/**
	 * 创建电站
	 * @return
	 */
	public String showCreate(){
		
		clientzonestr = (String) this.getSession().getAttribute("clientzonestr");
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		countryList=stationService.getContryList(localLang);
		stateList=stationService.getStateList(Integer.parseInt(country), localLang);
		
		timezoneList=stationService.getTimezoneList(localLang);
		timezoneid = stationService.getTimezoneListEx(localLang, clientzonestr);
		
		incomerateList=stationService.getSystemGainxsList();
		currencyList=stationService.getCurrencyList();
		co2RateList=stationService.getSsystemCo2xsList();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime= formatter.format(new Date());
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay= formatter.format(new Date());
		if(startdt==null)
			startdt=nowDay;
		return "show";
	}
	
	public String createStation(){
		String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (jd1==null || jd1.trim().equals(""))
			jd1="0";
		if (jd2==null || jd2.trim().equals(""))
			jd2="0";
		if (jd3==null || jd3.trim().equals(""))
			jd3="0";
		if (wd1==null || wd1.trim().equals(""))
			wd1="0";
		if (wd2==null || wd2.trim().equals(""))
			wd2="0";
		if (wd3==null || wd3.trim().equals(""))
			wd3="0";
		jd=jd+":"+jd1+"-"+jd2+"-"+jd3;
		wd=wd+":"+wd1+"-"+wd2+"-"+wd3;
		String s[]=timezone.split("_");
		if (startdt.trim().equals(""))
			startdt=null;
		if(installcap.equals(""))
			installcap="0";

		if(height.equals(""))
			height="0";
		if(insangle.equals(""))
			insangle="0";
		if(co2rate.equals(""))
			co2rate="0";
		if(incomerate.equals(""))
			incomerate="0";
		if(customerflag.equals("") || customerflag==null){
			customerflag="1";
		}else if(customerflag.equals("true")){
			customerflag="1";
		}else if(customerflag.equals("false")){
			customerflag="0";
		}
		
		int stationid  = stationService.createNewStation(Integer.parseInt(userId),stationname, picurl, startdt, Float.parseFloat(installcap),company, country, city, street, state, zip, jd, wd, Float.parseFloat(height), Float.parseFloat(insangle), Float.parseFloat(co2rate), Float.parseFloat(incomerate), currency, Integer.parseInt(s[0]), Integer.parseInt(s[1]), Integer.parseInt(customerflag));
		stationService.stationBindPM(stationid, psno, registno,opdate);
		return SUCCESS;
	}
	
	public String showModify(){
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			try {
				stationMap=stationService.getStationInfo(Integer.parseInt(stationId));	
			} catch (Exception e) {
				logger.error(e);
			}
			String jda=(String)stationMap.get("jd");
			if (jda!=null){
				if (jda.substring(0,1).equals("+"))
					jd="1";
				else if (jda.substring(0,1).equals("-"))
					jd="0";
				jda=jda.substring(2,jda.length());
				String[] jds=jda.split("-");
				jd1=jds[0];
				jd2=jds[1];
				jd3=jds[2];
			}else{
				jd="w";
				jd1="";
				jd2="";
				jd3="";
			}
			String wda=(String)stationMap.get("wd");
			if (wda!=null){
			if (wda.substring(0,1).equals("+"))
				wd="1";
			else if (wda.substring(0,1).equals("-"))
				wd="0";
			wda=wda.substring(2,wda.length());
			String[] wds=wda.split("-");
			wd1=wds[0];
			wd2=wds[1];
			wd3=wds[2];
			}else{
				wd="s";
				wd1="";
				wd2="";
				wd3="";
			}
			country=(String)stationMap.get("country");
			state=(String)stationMap.get("province");
			co2rate=stationMap.get("co2xs").toString();
			incomerate=stationMap.get("gainxs").toString();
			currency=(String)stationMap.get("currency");
			timezonex=(String)stationMap.get("timezone");
			stateList=stationService.getStateList(Integer.parseInt((String)stationMap.get("country")), localLang);
			countryList=stationService.getContryList(localLang);
			timezoneList=stationService.getTimezoneList(localLang);
			incomerateList=stationService.getSystemGainxsList();
			currencyList=stationService.getCurrencyList();
			co2RateList=stationService.getSsystemCo2xsList();
			etotaloffset=stationMap.get("etotaloffset").toString();
			customerflag = stationMap.get("customerflag").toString();
			return "show";
		}
	}
	
	public String modifyStation(){
		JSONObject jsonObject  = new JSONObject();

		try{
		
		String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		if (jd1==null || jd1.trim().equals(""))
			jd1="0";
		if (jd2==null || jd2.trim().equals(""))
			jd2="0";
		if (jd3==null || jd3.trim().equals(""))
			jd3="0";
		if (wd1==null || wd1.trim().equals(""))
			wd1="0";
		if (wd2==null || wd2.trim().equals(""))
			wd2="0";
		if (wd3==null || wd3.trim().equals(""))
			wd3="0";
		jd=jd+":"+jd1+"-"+jd2+"-"+jd3;
		
		wd=wd+":"+wd1+"-"+wd2+"-"+wd3;
		String s[]=timezone.split("_");
		if (startdt.trim().equals(""))
			startdt=null;
		if(installcap.equals(""))
			installcap="0";
		

		if(height.equals(""))
			height="0";
		if(insangle.equals(""))
			insangle="0";
		if(co2rate.equals(""))
			co2rate="0";
		if(incomerate.equals(""))
			incomerate="0";
		if(incomerate.equals(""))
			incomerate="0";
		if(etotaloffset==null || ("").equals(etotaloffset))
			etotaloffset="0";
		stationId = this.getSession().getAttribute("defaultStation").toString();
		try {
			stationService.updateStationInfo(Integer.parseInt(stationId),stationname, picurl, startdt, Float.parseFloat(installcap), company,country, city, street, state, zip, jd, wd, Float.parseFloat(height), Float.parseFloat(insangle), Float.parseFloat(co2rate), Float.parseFloat(incomerate), currency, Float.parseFloat(s[0]), Integer.parseInt(s[1]),Float.parseFloat(etotaloffset),Integer.parseInt(customerflag));
		} catch (Exception e) {
			logger.error(e);
		}
		//修改完电站信息后，将电站单位放入session，以便其它页面实时刷新单位 
		this.getSession().setAttribute("inval_unit", currency);
		jsonObject.put("status", "ok");
		}
		catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
		}

		this.print(jsonObject.toString());
		return null;
	}
	
	public String removeStation(){
		JSONObject jsonObject  = new JSONObject();

		try{
	
		String userId = ((Map)this.getSession().getAttribute("user")).get("userId").toString();
		String res=stationService.removeStation(Integer.parseInt(userId),Integer.parseInt(stationId));
		if (res.equals("ok")){
		jsonObject.put("status", "ok");
		}else if (res.equals("err_havepmu")){
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "1");
		}
		}
		catch(Exception e){
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");
		}

		this.print(jsonObject.toString());
		return null;
	}
	public String checkPsno(){
		JSONObject jsonObject  = new JSONObject();
		String pmuRes =stationService.checkPMuinValid(psno, registno);
		if(pmuRes!=null){
			if(pmuRes.equals("ok")){
				jsonObject.put("status", "ok");
			
			}else if (pmuRes.equals("err_used")){
				jsonObject.put("status", "error");
				//PMU已经被绑定
				jsonObject.put("errorcode", "1");
			}else if (pmuRes.equals("err_nofound")){
				jsonObject.put("status", "error");
				//PMU已经被绑定
				jsonObject.put("errorcode", "0");
			}else if (pmuRes.equals("err_idex")){
				jsonObject.put("status", "error");
				//
				jsonObject.put("errorcode", "2");
			}
		}else{
			jsonObject.put("status", "error");
			//PMU不存在
			jsonObject.put("errorcode", "0");
		}
		this.print(jsonObject.toString());
		return null;
	}
	public String inputPmuShow(){
		
		return SUCCESS;
	}
	
	public String inputPmu(){
		JSONObject jsonObject  = new JSONObject();
		if(softver.equals(""))
			softver=null;

		if(hardver.equals(""))
			hardver=null;
		String pmuRes =stationService.appendPmu(psno, idex, type, devname, xh, factory, penpai, softver, hardver);
		if(pmuRes.equals("ok")){
				jsonObject.put("status", "ok");
			
			}else if (pmuRes.equals("err_exists")){
				jsonObject.put("status", "error");
				
				jsonObject.put("errorcode", "1");
			}
		
		this.print(jsonObject.toString());
		return null;
	}
	public List<Map> getCo2RateList() {
		return co2RateList;
	}
	public void setCo2RateList(List<Map> co2RateList) {
		this.co2RateList = co2RateList;
	}
	public List<Map> getCountryList() {
		return countryList;
	}
	public void setCountryList(List<Map> countryList) {
		this.countryList = countryList;
	}
	public List<Map> getTimezoneList() {
		return timezoneList;
	}
	public void setTimezoneList(List<Map> timezoneList) {
		this.timezoneList = timezoneList;
	}
	public List<Map> getIncomerateList() {
		return incomerateList;
	}
	public void setIncomerateList(List<Map> incomerateList) {
		this.incomerateList = incomerateList;
	}
	public List<Map> getCurrencyList() {
		return currencyList;
	}
	public void setCurrencyList(List<Map> currencyList) {
		this.currencyList = currencyList;
	}
	public String getStationname() {
		return stationname;
	}
	public void setStationname(String stationname) {
		this.stationname = stationname;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getStartdt() {
		return startdt;
	}
	public void setStartdt(String startdt) {
		this.startdt = startdt;
	}
	public String getInstallcap() {
		return installcap;
	}
	public void setInstallcap(String installcap) {
		this.installcap = installcap;
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
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}

	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getJd() {
		return jd;
	}
	public void setJd(String jd) {
		this.jd = jd;
	}
	public String getWd() {
		return wd;
	}
	public void setWd(String wd) {
		this.wd = wd;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getInsangle() {
		return insangle;
	}
	public void setInsangle(String insangle) {
		this.insangle = insangle;
	}
	public String getCo2rate() {
		return co2rate;
	}
	public void setCo2rate(String co2rate) {
		this.co2rate = co2rate;
	}
	public String getIncomerate() {
		return incomerate;
	}
	public void setIncomerate(String incomerate) {
		this.incomerate = incomerate;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	

	public String getJd1() {
		return jd1;
	}
	public void setJd1(String jd1) {
		this.jd1 = jd1;
	}
	public String getJd2() {
		return jd2;
	}
	public void setJd2(String jd2) {
		this.jd2 = jd2;
	}
	public String getJd3() {
		return jd3;
	}
	public void setJd3(String jd3) {
		this.jd3 = jd3;
	}
	public String getWd1() {
		return wd1;
	}
	public void setWd1(String wd1) {
		this.wd1 = wd1;
	}
	public String getWd2() {
		return wd2;
	}
	public void setWd2(String wd2) {
		this.wd2 = wd2;
	}
	public String getWd3() {
		return wd3;
	}
	public void setWd3(String wd3) {
		this.wd3 = wd3;
	}
	public Map getStationMap() {
		return stationMap;
	}
	public void setStationMap(Map stationMap) {
		this.stationMap = stationMap;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public List<Map> getStateList() {
		return stateList;
	}
	public void setStateList(List<Map> stateList) {
		this.stateList = stateList;
	}
	public String getIdex() {
		return idex;
	}
	public void setIdex(String idex) {
		this.idex = idex;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDevname() {
		return devname;
	}
	public void setDevname(String devname) {
		this.devname = devname;
	}
	public String getXh() {
		return xh;
	}
	public void setXh(String xh) {
		this.xh = xh;
	}
	public String getFactory() {
		return factory;
	}
	public void setFactory(String factory) {
		this.factory = factory;
	}
	public String getPenpai() {
		return penpai;
	}
	public void setPenpai(String penpai) {
		this.penpai = penpai;
	}
	public String getSoftver() {
		return softver;
	}
	public void setSoftver(String softver) {
		this.softver = softver;
	}
	public String getHardver() {
		return hardver;
	}
	public void setHardver(String hardver) {
		this.hardver = hardver;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
	public String sid;
	public String sname;
	public String portkey;
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getPortkey() {
		return portkey;
	}
	public void setPortkey(String portkey) {
		this.portkey = portkey;
	}
	public String generateStationKey() throws Exception{
		String key = Base64Bean.encryptBASE64((sname+"_"+sid).getBytes());
		stationService.updatePortKeyByStationid(key.trim(), sid);
		JSONObject json  = new JSONObject();
		json.put("k", key);
		this.print(json.toString());
		return null;
	}
}
