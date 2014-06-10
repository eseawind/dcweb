package com.jstrd.asdc.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
public interface StationService {
	
	public String getLocalTime(int stationid);
	
	/**
	 * 获取电站的总发电量和昨日发电量
	 */
	public Map allStationInfo();
	/**
	 * 获取示例电站列表
	 */
	public Map sampleStationInfo();
	
	/**
	 * 获得某个用户下的所有电站的发电总量
	 * @param userid
	 * @return
	 */
	public List<Map> findOverview(int userid);
	/**
	 * 根据ID获得电站信息
	 * @param stationid
	 * @return
	 */
	public Map findStationById(int stationid);
	/**
	 * 获取
	 * 电站本日发电量
	 * 本月发电量
	 * 本年发电量
	 * 总收益
	 * @param stationid
	 * @return
	 */
	public Map getStationInfoById(int stationid);
	/**
	 * 获取今日发电明细
	 * yyyy-MM-dd
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationTpList(int stationid,String today);
	/**
	 * 获取本月发电总量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationMpList(int stationid,String today);
	/**
	 * 获取本年发电总量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationYpList(int stationid,String year);
	/**
	 * 获取所有发电量
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationApList(int stationid);
	/**
	 * 获取示例电站列表
	 * @return
	 */
	public List<Map> findExcampleStationInfo();
	
	/**
	 * 管理员
	 * 获取所有电站列表
	 * @return
	 */
	public List<Map> findAllStationInfo(String country, String state, String stationName, String account, int status, int pageNo, int pageSize);
	
	/**
	 * 获取所有电站的个数
	 * @return
	 */
	public int findAllStationCount(String country, String state, String stationName, String account, int status, int pageNo, int pageSize);
	
	/**
	 * 获取国家列表
	 * @return
	 */
	public List<Map> getContryList(String lang);
	/**
	 * 获取省/州列表
	 * @return
	 */
	public List<Map> getStateList(int country,String lang);
	
	public List<Map> findUserStationInv(int userId,int stationId);
	/**
	 * 保存图表默认逆变器接口
	 * @return
	 */
	public void updateInvListForUser(int userId ,int stationId,String invtList);

	/**
	 * 指定语言，提取页面时区列表信息
	 * @param lang	语言
	 * @return
	 */
	public List<Map> getTimezoneList(String lang);
	
	/**
	 * 指定语言,客户端时区    提取时区对应的key
	 * @param lang			语言
	 * @param clientzonestr	客户端时区
	 * @see 2013-06-08
	 * @return
	 */
	public int getTimezoneListEx(String lang, String clientzonestr);
	
	/**
	 * 获得当前可选择的货币符号列表
	 * @see 2013-06-13
	 * @return
	 */
	public List<Map> getCurrencyList();
	
	
	public List<Map> getSystemGainxsList();
	
	
	public List<Map> getSsystemCo2xsList();
	public int createNewStation(int userId, String stationname, String picurl, String startdt, float installcap, String company,String country, String city, String street, String state, String zip, String jd, String wd, float height, float insangle, float co2rate, float incomerate, String currency, int timezone, int timezonex, int customerflag);
	public void updateStationInfo(int stationId, String stationname, String picurl, String startdt, float installcap,String company, String country, String city, String street, String state, String zip, String jd, String wd, float height, float insangle, float co2rate, float incomerate, String currency, Float timezone, int timezonex, float etotaloffset, int customerflag);
	public String checkPMuinValid(String psno,String id);
	public String stationBindPM(int stationId,String psno,String id, String opdate);
	public String stationUnBindPM(int stationId,String psno,String serialno, String opdate);

	public List<Map> getPumTypeList();
	public List<Map> getPumModelList();
	public List<Map> findPumList(String type,String model,String listno,int state,String hardver,String softver,int autoUpdate,int needUpdate,int pagecols,int page);
	public int findPumPageNum(String type,String model,String listno,int state,String hardver,String softver,int autoUpdate,int needUpdate,int pagecols,int page);
	public List<Map> getPumAnalyTypeList();
	public List<Map> getPumAnalyCountryList();
	public int getPumAnalyTotalType();
	public int getPumAnalyTotalCountry();
	public Map getPumInfo(String psno);
	public List<Map> getStationDeviceex(int stationId);

	public Map getDevInfo(String psno);
	public void setDevName(String psno,String byName);
	
	public List<Map> getInvTypeList();
	public List<Map> getInvPinpaiList();
	public List<Map> getInvFactoryList();
	public List<Map> findInvList(String stationName,String type,String listno,int pagecols,int page);
	public int findInvPageNum(String stationName,String type,String listno,int pagecols,int page);
	public List<Map> getInvAnalyTypeList();
	public List<Map> getInvAnalyCountryList();
	public int getInvAnalyTotalType();
	public int getInvAnalyTotalCountry();
	public Map getInvInfo(String psno);
	
	/**
	 * 获取指定电站的详细情况
	 * @param statopmId	电站id
	 * @return
	 */
	public Map getStationInfo(int statopmId);
	public List<Map> getSystemAdminList();
	public String removeSystemAdmin(String account);
	public String addSystemAdmin(String account,int pro,int sta,int acc,int dev,int event,int state);
	public String updateSystemAdmin(String account,int pmut,int onvt,int usert,int devt,int event,int state);
	
	public Map getDayReportConfig(int reportId,int stationId);
	public Map getMonReportConfig(int reportId,int stationId);
	public Map getEventReportConfig(int reportId,int stationId);
	
	public void putDayReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,String sendTime,String itemstr,String lang);
	public void putMonReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,String itemstr,String lang);
	public void putEventReportConfig(int reportId,int stationId,int state,String recieverList,int repFormat,int nextdelay,int emptysend,int maxeventlimit,String itemstr,String lang);
	public String removeStation(int userId,int stationId);
	public List<Map> getStationSharedaAcountList(int stationId);
	public String setStationtoAccount(int stationId,String account,String rightStr);
	public String setStationtoAccountRight(int stationId,int userId,String rightStr);
	public String removeAccFromStation(int stationId,int userId);
	public String appendPmu(String psno,String idex,String type,String devname,String xh,String factory,String penpai,String softver,String hardver);
	public String getSharePlantCode(int stationId,int userId);
	public String checkSharePlantCode(int stationId,int userId,String code);
	public Map getReportMainInfoDay(int stationId,int reportType,String itemstr);
	public List<Map> getReportListInfoDay(int stationId,int reportType,String itemstr);
	public Map getReportMainInfoMonth(int stationId,int reportType,String itemstr);
	public List<Map> getReportListInfoMonth(int stationId,int reportType,String itemstr);
	public Map getReportMainInfoEvent(int stationId,int reportType,String itemstr);
	public List<Map> getReportListInfoEvent(int stationId,int reportType,String itemstr);
	public int accountSearchCount(String email,String firstName,String secondName,String tel,String mobile,String country,String state,String city,String company,int pageNo,int pageSize);
	public List<Map> accountSearchList(String email,String firstName,String secondName,String tel,String mobile,String country,String state,String city,String company,int pageNo,int pageSize);
	public List<Map> getPlantInvList(String listno,String startDt,String endDt);
	public String shareaccountactive(int stationId,int userId,int state);
	
	/**
	 * 2013-06-06  统计事件查询列表 
	 * @param msgtype	1:全部,1:信息,2:警告,3:错误
	 * @param state		1:全部,0:未读，1:已经读
	 * @param desc		null:全部
	 * @param ssno		null:全部
	 * @param startdt	默认为当日减去7天
	 * @param enddt		默认当天
	 * @param stationname	null:全部
	 * @param country		1:全部
	 * @param devtype		1:全部,1:监控器,2:逆变器
	 * @param devmodel		设备型号,null:全部,
	 * @param rowperpage	每页行数
	 * @param page			返回总页数
	 * @return
	 */
	public Map findEventList(int msgtype,int state,String desc,String ssno,String startdt,String enddt,String stationname,int country,int devtype,String devmodel, String errcode, int rowperpage,int page);

	/**
	 * 2013-06-06  统计事件查询列表总页数 
	 * @param msgtype	1:全部,1:信息,2:警告,3:错误
	 * @param state		1:全部,0:未读，1:已经读
	 * @param desc		null:全部
	 * @param ssno		null:全部
	 * @param startdt	默认为当日减去7天
	 * @param enddt		默认当天
	 * @param stationname	null:全部
	 * @param country		1:全部
	 * @param devtype		1:全部,1:监控器,2:逆变器
	 * @param devmodel		设备型号,null:全部,
	 * @param rowperpage	每页行数
	 * @param page			返回总页数
	 * @return
	 */
	public int findEventCount(int msgtype,int state,String desc,String ssno,String startdt,String enddt,String stationname,int country,int devtype,String devmodel, String errcode, int rowperpage, int page);
	
	
	public int findEventListPage(int msgtype,int state,String desc,String ssno,String startdt,String enddt,String stationname,int country,int devtype,String devmodel,int rowperpage,int page);
	public void setPmuUpdate(int state,String psno);

	public int getUpdateRight(int userId);
	public List<Map> findDictList(String subtag,String lan,String Val1,String val2,String content,int pagecols,int page);
	public int findDictListPage(String subtag,String lan,String Val1,String val2,String content,int pagecols,int page);
	public List<Map> findDictSubTag();
	public List<Map> findDictLang();
	public String createDict(String subtag,String lan,String val1,String val2,String content);
	public void updateDict(String subtag,String lan,String val1,String val2,String content);
	public void removeDict(String subtag,String lan,String val1,String val2);
	
	/**
	 * 修改电站的关注属性
	 * @param stationId	电站编号
	 * @param state		电站状态0:取消关注, 1:关注
	 * @see 2013-06-28
	 */
	public String updateStationAttention(String stationId, int state);
	
	
	/** 设备列表页面---删除逆变器   */
	public String removeInv(int stationid, String isno);

	public void plantDayStatistics(String startDate, String endDate);

	public void updatePortKeyByStationid(String key, String sid);
	
}
