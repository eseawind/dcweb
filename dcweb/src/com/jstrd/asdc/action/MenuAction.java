package com.jstrd.asdc.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.service.StationService;
import com.jstrd.asdc.service.UserLimitService;
import com.jstrd.asdc.service.UserService;

@SuppressWarnings({"unchecked","unused"})
public class MenuAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(MenuAction.class.getName());
	private StationService stationService;
	private InverterService inverterService;
	private UserService userService;
	private UserLimitService userLimitService;
	private List<Map> stationList;
	private List<Map> countryList;
	private int stationid;
	private String type;
	private String day;		//yyyy-MM-dd
	private String month;	//yyyy-MM
	private String year;	//yyyy
	private int pageNo=1;
	private int pageSize=20;
	private int totalCount;
	private int totalPage;
	private int countryId;
	private List<Map> stateList;
	private int state;
	private String stationName;
	private int changeUserId=0;
	private String account;	
	private int status = -1;
	private String ludt;
	
	List<Map> isnosList;
	String e_today_u="KWh";
	String e_total_u="KWh";
	String pac_u="W";
	String pacmax_u="W";
	
	public String powerlist(){
		this.getSession().setAttribute("defaultStation","0");
		String myplant="";
		this.getSession().setAttribute("myplant","");
		if(this.getSession().getAttribute("user")==null || ((Map)this.getSession().getAttribute("user")).get("userId").toString().equals("0")){
			int userid = 0;
			Map userMenu=userLimitService.getUserMenu(0, 0);
			this.getSession().setAttribute("userMenu", userMenu);
			stationList = stationService.findExcampleStationInfo();
			Map userMap=new HashMap(); 
			userMap.put("userId", "0");
			userMap.put("UserId", "0");
			userMap.put("account", "excample@zeversolar.com");
			userMap.put("roleId", "0");
			userMap.put("firstName", "guest");
			userMap.put("secondName", "");
			this.getSession().setAttribute("email", "excample@zeversolar.com");
			this.getSession().setAttribute("user", userMap);
		}else{
			Map user = (Map)this.getSession().getAttribute("user");
			int userid = Integer.parseInt(user.get("UserId").toString());
			Map userMenu=userLimitService.getUserMenu(userid, 0);
			if (changeUserId!=0)
				userid=changeUserId;
			stationList = stationService.findOverview(userid);
			for(int i=0;i<stationList.size();i++){
				myplant=myplant+","+stationList.get(i).get("stationid");
			}
			this.getSession().setAttribute("myplant",myplant);
			this.getSession().setAttribute("userMenu", userMenu);
		}
		return SUCCESS;
	}
	
	/**
	 * 管理员 -- 电站查询 -- 电站列表
	 * @see 2013-06-28
	 */
	public String powerAllList(){
		int stid=0;
		this.getSession().setAttribute("defaultStation","0");
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), stid);
		this.getSession().setAttribute("userMenu", userMenu);
		if (!userMenu.get("station").toString().equals("1"))
			return "tologin";
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		countryList=stationService.getContryList(localLang);
		if (countryId!=0)
			stateList=stationService.getStateList(countryId, localLang);
		String country=null;
		String st=null;
		if (stationName!=null && stationName.trim().equals(""))
			stationName=null;
		if (account!=null && account.trim().equals(""))
			account=null;
		if (countryId!=0)
			country=countryId+"";
		if (state!=0)
			st=state+"";
		
		totalPage= stationService.findAllStationCount(country, st, stationName, account, status, pageNo, pageSize);
		//判断,当面页大于总页数时, 当前页等于总页数
		if(pageNo > totalPage){
			pageNo = totalPage;
		}
		stationList = stationService.findAllStationInfo(country, st, stationName, account, status, pageNo, pageSize);
		return SUCCESS;
	}

	
	public String getStateInfolist(){
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		stateList=stationService.getStateList(countryId, localLang);
		return SUCCESS;
	}
	
	public String systemerr(){
		
		return SUCCESS;
	}

	public String overview(){
		Map user = null;
		if (this.getSession().getAttribute("user")!=null)
			user=(Map)this.getSession().getAttribute("user");
		if (stationid==0 && this.getSession().getAttribute("defaultStation")!=null)
			stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String myplant=this.getSession().getAttribute("myplant")==null?"":this.getSession().getAttribute("myplant").toString();
		if (user!=null){
			int userid = Integer.parseInt(user.get("UserId").toString());
			Map userMenu=userLimitService.getUserMenu(userid, stationid);
			this.getSession().setAttribute("userMenu", userMenu);
			if (userid==0 || user.get("roleId").toString().equals("4") || myplant.indexOf(stationid+"")!=-1 || userMenu.get("station").toString().equals("1")){
				if(stationid!=0){
					Map stationMap = stationService.findStationById(stationid);
					this.getSession().setAttribute("defaultStation", stationid);
					this.getSession().setAttribute("defaultStationMap",stationMap);
					this.getSession().setAttribute("ludt", stationMap.get("ludt"));
				}
			return SUCCESS;
			} else
				return "login";
		} else{
			return "login";
		}
	}
	
	public String power(){
		
		if(type==null){
			type="day";
		}
		day = SwfAction.getToday();
		Map user = (Map)this.getSession().getAttribute("user");
		if (stationid==0 && this.getSession().getAttribute("defaultStation")!=null)
			stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		int userid = Integer.parseInt(user.get("UserId").toString());
		Map userMenu=userLimitService.getUserMenu(userid, stationid);
		this.getSession().setAttribute("userMenu", userMenu);
		if(stationid!=0){
			this.getSession().setAttribute("defaultStation", stationid);
			Map stationMap = stationService.findStationById(stationid);
			ludt = stationMap.get("ludt").toString();
			this.getSession().setAttribute("defaultStationMap",stationMap);
			isnosList=inverterService.findAllIsnosByStid(stationid+"");
			if (isnosList.size()>0){
				Map inv=(Map)isnosList.get(0);
				e_today_u=inv.get("e_today_u").toString();
				e_total_u=inv.get("e_total_u").toString();
				pac_u=inv.get("pac_u").toString();
				pacmax_u=inv.get("pacmax_u").toString();
			}
		}
		return SUCCESS;
	}

	/**
	 * @see 2014-03-20新添加日统计 
	 */
	private String startDate;
	private String endDate;
	
	public String plantDayStatistics() {
		stationService.plantDayStatistics(startDate, endDate);
		return null;
	}
	
	private int flag;
	public String createNewStation(){
		flag=1;
		return SUCCESS;
	}
	
	private Map stationMap;
	private String stid;
	public String editStation(){
		stationMap = this.stationService.findStationById(Integer.parseInt(stid));
		type="editStation"; 
		flag = 1;
		return SUCCESS;
			
	}
	private List<Map> userMapList;
	public String userconf(){
		int stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		userMapList = this.userService.getUsersbyStationid(stationid);
		return SUCCESS;
	}
	
	private String psno;
	
	
	
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

	public List<Map> getStationList() {
		return stationList;
	}
	public void setStateList(List<Map> stateList) {
		this.stateList = stateList;
	}

	public List<Map> getStateList() {
		return stateList;
	}
	
	
	public List<Map> getCountryList() {
		return countryList;
	}

	public void setStationList(List<Map> stationList) {
		this.stationList = stationList;
	}
	public void setCountryList(List<Map> countryList) {
		this.countryList = countryList;
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

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public Map getStationMap() {
		return stationMap;
	}

	public void setStationMap(Map stationMap) {
		this.stationMap = stationMap;
	}

	public String getStid() {
		return stid;
	}

	public void setStid(String stid) {
		this.stid = stid;
	}

	public String getPsno() {
		return psno;
	}

	public void setPsno(String psno) {
		this.psno = psno;
	}
	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public List<Map> getUserMapList() {
		return userMapList;
	}

	public void setUserMapList(List<Map> userMapList) {
		this.userMapList = userMapList;
	}

	public UserLimitService getUserLimitService() {
		return userLimitService;
	}

	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getStationName() {
		return stationName;
	}
	public int getChangeUserId() {
		return changeUserId;
	}
	
	public void setChangeUserId(int changeUserId) {
		this.changeUserId = changeUserId;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getAccount() {
		return account;
	}
	
	public void setAccount(String account) {
		this.account = account;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getLudt() {
		return ludt;
	}
	public void setLudt(String ludt) {
		this.ludt = ludt;
	}
	public List<Map> getIsnosList() {
		return isnosList;
	}
	public void setIsnosList(List<Map> isnosList) {
		this.isnosList = isnosList;
	}
	public String getE_today_u() {
		return e_today_u;
	}
	public void setE_today_u(String eTodayU) {
		e_today_u = eTodayU;
	}
	public String getE_total_u() {
		return e_total_u;
	}
	public void setE_total_u(String eTotalU) {
		e_total_u = eTotalU;
	}
	public String getPac_u() {
		return pac_u;
	}
	public void setPac_u(String pacU) {
		pac_u = pacU;
	}
	public String getPacmax_u() {
		return pacmax_u;
	}
	public void setPacmax_u(String pacmaxU) {
		pacmax_u = pacmaxU;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}
