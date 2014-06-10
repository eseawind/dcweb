package com.jstrd.asdc.service.impl;

import java.util.List;
import java.util.Map;

import com.jstrd.asdc.dao.StationDao;
import com.jstrd.asdc.service.StationService;

@SuppressWarnings("unchecked")
public class StationServiceImpl implements StationService {

	public StationDao stationDao;
	
	/**
	 * 获取电站的总发电量和昨日发电量
	 */
	public Map allStationInfo(){
		return stationDao.allStationInfo();
	}
	
	public Map sampleStationInfo(){
		return stationDao.sampleStationInfo();
	}
	public List<Map> findOverview(int userid){
		return stationDao.findOverview(userid);
	}


	/**
	 * 根据ID获得电站信息
	 * @param stationid
	 * @return
	 */
	public Map findStationById(int stationid){
		return stationDao.findStationById(stationid);
	}
	/**
	 * 获取
	 * 电站本日发电量
	 * 本月发电量
	 * 本年发电量
	 * 总收益
	 * @param stationid
	 * @return
	 */
	public Map getStationInfoById(int stationid){
		return stationDao.getStationInfoById(stationid);
	}
	/**
	 * 获取今日发电明细
	 * yyyy-MM-dd
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationTpList(int stationid,String today){
		return stationDao.findStationTpList(stationid, today);
	}
	/**
	 * 获取本月发电总量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationMpList(int stationid,String today){
		return stationDao.findStationMpList(stationid, today);
	}
	/**
	 * 获取本年发电总量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationYpList(int stationid,String year){
		return stationDao.findStationYpList(stationid, year);
	}
	/**
	 * 获取所有发电量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationApList(int stationid){
		return stationDao.findStationApList(stationid);
	}
	/**
	 * 获取示例电站列表
	 * @return
	 */
	public List<Map> findExcampleStationInfo(){
		return stationDao.findExcampleStationInfo();
	}
	/**
	 * 管理员
	 * 获取所有电站列表
	 * @return
	 */
	public List<Map> findAllStationInfo(String country, String state, String stationName, String account, int status, int pageNo, int pageSize)
	{
		return this.stationDao.findAllStationInfo(country, state, stationName, account, status, pageNo, pageSize);
	}
	/**
	 * 获取所有电站的个数
	 * @return
	 */
	public int findAllStationCount(String country, String state, String stationName, String account, int status, int pageNo, int pageSize){
		return this.stationDao.findAllStationCount(country, state, stationName, account, status, pageNo, pageSize);
	}
	public StationDao getStationDao() {
		return stationDao;
	}

	public void setStationDao(StationDao stationDao) {
		this.stationDao = stationDao;
	}
	/**
	 * 获取国家列表
	 * @return
	 */
	public List<Map> getContryList(String lang){
		return this.stationDao.getContryList(lang);
	}
	/**
	 * 获取省/州列表
	 * @return
	 */
	public List<Map> getStateList(int country,String lang){
		return this.stationDao.getStateList(country,lang);
	}
	
	public List<Map> findUserStationInv(int userId,int stationId){
		return this.stationDao.findUserStationInv(userId, stationId);
		
	}
	/**
	 * 保存图表默认逆变器接口
	 * @return
	 */
	public void updateInvListForUser(int userId ,int stationId,String invtList){
		this.stationDao.updateInvListForUser(userId ,stationId,invtList);
		
	}
	
	/** 指定语言，提取页面时区列表信息 */
	public List<Map> getTimezoneList(String lang){
		return this.stationDao.getTimezoneList(lang);
	}
	
	/** 指定语言,客户端时区    提取时区对应的key */
	public int getTimezoneListEx(String lang, String clientzonestr){
		return this.stationDao.getTimezoneListEx(lang, clientzonestr);
	}
	
	/** 获得当前可选择的货币符号列表  */
	public List<Map> getCurrencyList(){
		return this.stationDao.getCurrencyList();
	}
	
	/**
	 * 
	 * @return
	 */
	public List<Map> getSystemGainxsList(){
		return this.stationDao.getSystemGainxsList();
		
	}
	/**
	 * 
	 * @return
	 */
	public List<Map> getSsystemCo2xsList(){
		return this.stationDao.getSsystemCo2xsList();
		
	}
	public int createNewStation(int userId, String stationname, String picurl, String startdt, float installcap,String company, String country, String city, String street, String state, String zip, String jd, String wd, float height, float insangle, float co2rate, float incomerate, String currency, int timezone, int timezonex, int customerflag){
		
		return this.stationDao.createNewStation(userId, stationname, picurl, startdt, installcap,company, country, city, street, state, zip, jd, wd, height, insangle, co2rate, incomerate, currency, timezone, timezonex, customerflag);
	}
	public void updateStationInfo(int stationId, String stationname, String picurl, String startdt, float installcap, String company,String country, String city, String street, String state, String zip, String jd, String wd, float height, float insangle, float co2rate, float incomerate, String currency, Float timezone, int timezonex, float etotaloffset,int customerflag){
		
		 this.stationDao.updateStationInfo(stationId, stationname, picurl, startdt, installcap, company,country, city, street, state, zip, jd, wd, height, insangle, co2rate, incomerate, currency, timezone, timezonex, etotaloffset,customerflag);
	}
	
	public String checkPMuinValid(String psno,String id){
		return this.stationDao.checkPMuinValid(psno, id);
		
	}
	public String stationBindPM(int stationId,String psno,String id,String opdate){
		
		return this.stationDao.stationBindPM(stationId, psno, id ,opdate);
	}
	public String stationUnBindPM(int stationId,String psno,String serialno,String opdate){
		
		return this.stationDao.stationUnBindPM(stationId, psno,serialno ,opdate);
	}
	public List<Map> getPumTypeList(){
		
		return this.stationDao.getPumTypeList();
	}
	public List<Map> getPumModelList(){
		
		return this.stationDao.getPumModelList();
	}
	public List<Map> findPumList(String type,String model,String listno,int state,String hardver,String softver,int autoUpdate,int needUpdate,int pagecols,int page){
		return this.stationDao.findPumList(type, model, listno,state, hardver,softver,autoUpdate,needUpdate,pagecols, page);
		
	}
	public int findPumPageNum(String type,String model,String listno,int state,String hardver,String softver,int autoUpdate,int needUpdate,int pagecols,int page){
		
		return this.stationDao.findPumPageNum(type, model, listno,state,hardver,softver,autoUpdate,needUpdate, pagecols, page);
		
	}
	public List<Map> getPumAnalyTypeList(){
		return this.stationDao.getPumAnalyTypeList();
	}
	public List<Map> getPumAnalyCountryList(){
		return this.stationDao.getPumAnalyCountryList();
	}
	public int getPumAnalyTotalType(){
		return this.stationDao.getPumAnalyTotalType();
	}
	public int getPumAnalyTotalCountry(){
		return this.stationDao.getPumAnalyTotalCountry();
	}
	public Map getPumInfo(String psno){
		return this.stationDao.getPumInfo(psno);
	}
	public List<Map> getStationDeviceex(int stationId){
		
		return this.stationDao.getStationDeviceex(stationId);
	}
	public Map getDevInfo(String psno){
		return this.stationDao.getDevInfo(psno);
	}
	public void setDevName(String psno,String byName){
		 this.stationDao.setDevName(psno, byName);
	}
	
public List<Map> getInvTypeList(){
		
		return this.stationDao.getInvTypeList();
	}
public List<Map> getInvPinpaiList(){
	
	return this.stationDao.getInvPinpaiList();
}
public List<Map> getInvFactoryList(){
	
	return this.stationDao.getInvFactoryList();
}
	public List<Map> findInvList(String stationName,String type,String listno,int pagecols,int page){
		return this.stationDao.findInvList(stationName,type, listno, pagecols, page);
		
	}
	public int findInvPageNum(String stationName,String type,String listno,int pagecols,int page){
		
		return this.stationDao.findInvPageNum(stationName,type, listno, pagecols, page);
		
	}
	public List<Map> getInvAnalyTypeList(){
		return this.stationDao.getInvAnalyTypeList();
	}
	public List<Map> getInvAnalyCountryList(){
		return this.stationDao.getInvAnalyCountryList();
	}
	public int getInvAnalyTotalType(){
		return this.stationDao.getInvAnalyTotalType();
	}
	public int getInvAnalyTotalCountry(){
		return this.stationDao.getInvAnalyTotalCountry();
	}
	public Map getInvInfo(String psno){
		return this.stationDao.getInvInfo(psno);
	}
	
	/** 获取指定电站的详细情况  */
	public Map getStationInfo(int statopmId){
		return this.stationDao.getStationInfo(statopmId);
	}
	public List<Map> getSystemAdminList(){
		return this.stationDao.getSystemAdminList();
	}
	public String removeSystemAdmin(String account){
		return this.stationDao.removeSystemAdmin(account);
	}
	public String addSystemAdmin(String account,int pro,int sta,int acc,int dev,int event,int state){
		return this.stationDao.addSystemAdmin(account,pro,sta,acc,dev,event,state);
	}
	public String updateSystemAdmin(String account,int pmut,int onvt,int usert,int devt,int event,int state){
		return this.stationDao.updateSystemAdmin(account, pmut, onvt, usert, devt,event, state);
	}
	
	public Map getDayReportConfig(int reportId,int stationId){
		return this.stationDao.getDayReportConfig(reportId, stationId);
	}
	public Map getMonReportConfig(int reportId,int stationId){
		return this.stationDao.getMonReportConfig(reportId, stationId);
	}
	public Map getEventReportConfig(int reportId,int stationId){
		return this.stationDao.getEventReportConfig(reportId, stationId);
	}
	
	public void putDayReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,String sendTime,String itemstr,String lang){
		this.stationDao.putDayReportConfig(reportId, stationId, state, recieverList, repFormat, sendTime, itemstr, lang);
	}
	public void putMonReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,String itemstr,String lang){
		this.stationDao.putMonReportConfig(reportId, stationId, state, recieverList, repFormat, itemstr, lang);
	}
	public void putEventReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,int nextdelay,int emptysend,int maxeventlimit,String itemstr,String lang){
		this.stationDao.putEventReportConfig(reportId, stationId, state, recieverList, repFormat, nextdelay, emptysend, maxeventlimit, itemstr, lang);
	}
	public String removeStation(int userId,int stationId){
		return this.stationDao.removeStation(userId,stationId);
		
	}
	public List<Map> getStationSharedaAcountList(int stationId){
		return this.stationDao.getStationSharedaAcountList(stationId);
	}
	public String setStationtoAccount(int stationId,String account,String rightStr){
		return this.stationDao.setStationtoAccount(stationId, account, rightStr);
	}
	public String setStationtoAccountRight(int stationId,int userId,String rightStr){
		return this.stationDao.setStationtoAccountRight(stationId, userId, rightStr);
	}
	public String removeAccFromStation(int stationId,int userId){
		return this.stationDao.removeAccFromStation(stationId, userId);
	}
	public String appendPmu(String psno,String idex,String type,String devname,String xh,String factory,String penpai,String softver,String hardver){
		return this.stationDao.appendPmu(psno, idex, type, devname, xh, factory, penpai, softver, hardver);
	}
	public String getSharePlantCode(int stationId,int userId){
		return this.stationDao.getSharePlantCode(stationId, userId);
	}
	public String checkSharePlantCode(int stationId,int userId,String code){
		return this.stationDao.checkSharePlantCode(stationId, userId, code);
	}
	public Map getReportMainInfoDay(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportMainInfoDay(stationId, reportType, itemstr);
	}
	public List<Map> getReportListInfoDay(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportListInfoDay(stationId, reportType, itemstr);
	}
	public Map getReportMainInfoMonth(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportMainInfoMonth(stationId, reportType, itemstr);
	}
	public List<Map> getReportListInfoMonth(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportListInfoMonth(stationId, reportType, itemstr);
	}
	public Map getReportMainInfoEvent(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportMainInfoEvent(stationId, reportType, itemstr);
	}
	public List<Map> getReportListInfoEvent(int stationId,int reportType,String itemstr){
		return this.stationDao.getReportListInfoEvent(stationId, reportType, itemstr);
	}
	public int accountSearchCount(String email,String firstName,String secondName,String tel,String mobile,String country,String state,String city,String company,int pageNo,int pageSize){
		return this.stationDao.accountSearchCount(email, firstName, secondName, tel, mobile, country, state, city, company, pageNo, pageSize);
	}
	public List<Map> accountSearchList(String email,String firstName,String secondName,String tel,String mobile,String country,String state,String city,String company,int pageNo,int pageSize){
		return this.stationDao.accountSearchList(email, firstName, secondName, tel, mobile, country, state, city, company, pageNo, pageSize);
	}
	public List<Map> getPlantInvList(String listno,String startDt,String endDt){
		return this.stationDao.getPlantInvList(listno, startDt, endDt);
	}
	public String shareaccountactive(int stationId,int userId,int state){
		return this.stationDao.shareaccountactive(stationId, userId, state);		
	}
	
	/** 2013-06-06  统计事件查询列表总页数   */
	public Map findEventList(int msgtype, int state, String desc, String ssno, String startdt, String enddt, String stationname, int country, int devtype, String devmodel, String errcode, int rowperpage, int page){
		return this.stationDao.findEventList(msgtype, state, desc, ssno, startdt, enddt, stationname, country, devtype,devmodel, errcode, rowperpage, page);
	}
	
	/** 2013-06-06  统计事件查询列表总页数   */
	public int findEventCount(int msgtype, int state, String desc, String ssno, String startdt, String enddt, String stationname, int country, int devtype, String devmodel, String errcode, int rowperpage, int page) {
		return stationDao.findEventCount(msgtype, state, desc, ssno, startdt, enddt, stationname, country, devtype, devmodel, errcode, rowperpage, page);
	}
	
	public int findEventListPage(int msgtype,int state,String desc,String ssno,String startdt,String enddt,String stationname,int country,int devtype,String devmodel,int rowperpage,int page){
		return this.stationDao.findEventListPage(msgtype, state, desc, ssno, startdt, enddt, stationname, country, devtype,devmodel, rowperpage, page);
	}
	public void setPmuUpdate(int state,String psno){
		 this.stationDao.setPmuUpdate(state, psno);		
	}

	public int getUpdateRight(int userId){
		return this.stationDao.getUpdateRight(userId);
	}
	public List<Map> findDictList(String subtag,String lan,String Val1,String val2,String content,int pagecols,int page){
		return this.stationDao.findDictList(subtag, lan, Val1, val2, content, pagecols, page);
		
	}
	public int findDictListPage(String subtag,String lan,String Val1,String val2,String content,int pagecols,int page){
		return this.stationDao.findDictListPage(subtag, lan, Val1, val2, content, pagecols, page);
	}

	public List<Map> findDictSubTag(){
		return this.stationDao.findDictSubTag();
	}
	public List<Map> findDictLang(){
		return this.stationDao.findDictLang();
	}
	public String createDict(String subtag,String lan,String val1,String val2,String content){
		return this.stationDao.createDict(subtag, lan, val1, val2, content);
	}
	public void updateDict(String subtag,String lan,String val1,String val2,String content){
		this.stationDao.updateDict(subtag, lan, val1, val2, content);
	}
	public void removeDict(String subtag,String lan,String val1,String val2){
		this.stationDao.removeDict(subtag, lan, val1, val2);
	}

	/**
	 * 向雪平
	 * 13-04-16
	 */
	public String getLocalTime(int stationid) {
		return stationDao.getLocalTime(stationid);
	}

	/** 修改电站的关注属性  */
	public String updateStationAttention(String stationId, int state) {
		return stationDao.updateStationAttention(stationId, state);
	}

	/** 设备列表页面---删除逆变器   */
	public String removeInv(int stationid, String isno) {
		return stationDao.removeInv(stationid, isno);
	}

	public void plantDayStatistics(String startDate, String endDate) {
		stationDao.plantDayStatistics(startDate, endDate);
	}

	public void updatePortKeyByStationid(String key, String sid) {
		stationDao.updatePortKeyByStationid(key, sid);
	}

	
}
