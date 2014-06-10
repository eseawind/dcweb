package com.jstrd.asdc.action;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jstrd.asdc.service.StationService;
import com.jstrd.asdc.service.UserLimitService;

@SuppressWarnings({"unchecked","unused"})
public class ChartShowAction extends BaseAction{

	Logger logger = Logger.getLogger(ChartShowAction.class.getName());
	private static final long serialVersionUID = 1L;
	private List<Map> invMap;
	private String stationId;
	private int tableId=13;
	private String invtList;
	private UserLimitService userLimitService;
	private String ludt;
	
	List<Map> invList;
	String e_today_u="KWh";
	String e_total_u="KWh";
	String pac_u="W";
	String pacmax_u="W";
	
	public String getInvtList() {
		return invtList;
	}


	public void setInvtList(String invtList) {
		this.invtList = invtList;
	}


	public int getTableId() {
		return tableId;
	}
	

	public void setTableId(int tableId) {
		this.tableId = tableId;
	}
	private StationService stationService;
	
	public String chartShow(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		if(stationId.equals("0")){
			return "topowerlist";
		}else{
			String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();         
			Map user = (Map)this.getSession().getAttribute("user");
			Map userMenu=userLimitService.getUserMenu(Integer.parseInt(userId), Integer.parseInt(stationId));
			this.getSession().setAttribute("userMenu", userMenu);
			Map stationMap = stationService.findStationById(Integer.parseInt(stationId));
			ludt = stationMap.get("ludt").toString();
			this.getSession().setAttribute("ludt", ludt);
			try {
				loadStationInfo(Integer.parseInt(userId),Integer.parseInt(stationId));
			} catch (Exception e) {
				logger.error(e);
			}
			this.getSession().setAttribute("tableId", tableId);
			switch(tableId)
	    	{
			//CO2
			case 10:
					return "chartco2";
			//GAin
			case 11:
					return "chartgain";
			//IDC
			case 12:
					return "chart";
			//VDC
			case 13:
					return "chart";
			//FAC
			case 14:
					return "chart";
			//IAC
			case 15:
					return "chart";
			//VAC
			case 16:
					return "chart";
			//TEMP
			case 17:
					return "chart";
			//ENERGY
			case 18:
					return "chartenergy";
			case 19:
					return "chart";
			default:  		
					return SUCCESS;
	    	}
		}
	}
	
	public String updateInvListForUser(){
		stationId = this.getSession().getAttribute("defaultStation").toString();
		String userId = ((Map)this.getSession().getAttribute("user")).get("UserId").toString();
		stationService.updateInvListForUser(Integer.parseInt(userId), Integer.parseInt(stationId), invtList);
		return SUCCESS;
	}
	
	
	public void loadStationInfo(int userId,int stationId){
		
		Map stationInfo=stationService.getStationInfoById(stationId);
		this.getSession().setAttribute("stationInfo", stationInfo);
		invList=stationService.findUserStationInv(userId, stationId);
		if (invList.size()>0){
			Map inv=(Map)invList.get(0);
			e_today_u=inv.get("etoday_u").toString();
			e_total_u=inv.get("etotal_u").toString();
			pac_u=inv.get("pac_u").toString();
			pacmax_u=inv.get("pacmax_u").toString();
		}
		this.getSession().setAttribute("userId", userId+"");
		
	}
	public List<Map> getInvMap() {
		return invMap;
	}
	public void setInvMap(List<Map> invMap) {
		this.invMap = invMap;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public StationService getStationService() {
		return stationService;
	}
	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}
	public UserLimitService getUserLimitService() {
		return userLimitService;
	}
	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}

	public String getLudt() {
		return ludt;
	}

	public void setLudt(String ludt) {
		this.ludt = ludt;
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

	public List<Map> getInvList() {
		return invList;
	}

	public void setInvList(List<Map> invList) {
		this.invList = invList;
	}
	
}
