package com.jstrd.asdc.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

import com.jstrd.asdc.service.EventService;
import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.service.UserLimitService;

@SuppressWarnings({"unchecked","unused"})
public class EventAction extends BaseAction {

	private static Logger logger = Logger.getLogger(EventAction.class);
	private static final long serialVersionUID = 1L;
	private EventService eventService;
	private InverterService inverterService;
	private UserLimitService userLimitService;
	private String occdt1;
	private String occdt2;
	private int approved=3;
	private List<Map> InvMap;
	private List<Map> eventMap;
	private int pageSize=20;
	private int totalPage;
	private int totalCount;
	private int pageNo=1;
	private String e_level="0";
	private String isno="-1";
	private int edid;
	private int reportType;
	
	/**
	 * 电站事件查询
	 */
	public String event(){
		String ss=this.getRequest().getParameter("approved");
		String localLang="en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")!=null)
			localLang=this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		//初始化参数
		int stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		String clientdate = (String) this.getSession().getAttribute("clientdate");
		if(stationid == 0){
			return "topowerlist";
		}else{
			Map user = (Map)this.getSession().getAttribute("user");
			int userid = Integer.parseInt(user.get("UserId").toString());
			Map userMenu=userLimitService.getUserMenu(userid, stationid);
			this.getSession().setAttribute("userMenu", userMenu);
			int userId=0;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime= formatter.format(new Date());
			formatter = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay= formatter.format(new Date());
			if(this.getSession().getAttribute("user")!=null)
				userId=Integer.parseInt(((Map)this.getSession().getAttribute("user")).get("userId").toString());
			logger.info("client date is: " + clientdate);
			logger.info("occdt1 is: " + occdt1);
			logger.info("occdt2 is: " + occdt2);
			if(null != clientdate){
				if(occdt1==null)
					occdt1=clientdate;
				if(occdt2==null)
					occdt2=clientdate;
				if(occdt1.trim().equals(""))
					occdt1=null;
				if(occdt2.trim().equals(""))
					occdt2=null; 
			}
			Float approved_f=null;
			String isno_f=isno;
			if(isno.equals("-1"))
				isno_f=null;
			String e_level_n=null;
			if(!e_level.equals("0"))
				e_level_n=e_level;
			InvMap = inverterService.findAllDeviceByStid(stationid+"");
			totalPage = eventService.getEventCountBySid(stationid, occdt1,occdt2, approved_f, isno_f, e_level_n,userId,localLang,pageSize,pageNo);
			//判断,当面页大于总页数时, 当前页等于总页数
			if(pageNo > totalPage){
				pageNo = totalPage;
			}
			eventMap = eventService.getEventByStationid(stationid, occdt1,occdt2, approved_f, isno_f, e_level_n,userId,localLang,pageSize,pageNo);
			Map inv = new HashMap();
			for(int i=0;i<InvMap.size();i++){
				String isno = InvMap.get(i).get("isno").toString();
				if (InvMap.get(i).get("byName")!=null)
					inv.put(isno, InvMap.get(i).get("byName").toString());
				else
					inv.put(isno, isno);
			}
			for(int i=0;i<eventMap.size();i++){
				String isno ="";
				if (eventMap.get(i).get("isno")!=null)
					isno=eventMap.get(i).get("isno").toString();
				Object approved = eventMap.get(i).get("approved");
				if(inv.get(isno)==null){
					eventMap.get(i).put("byName", isno);
				}else{
					eventMap.get(i).put("byName", inv.get(isno).toString());
				}
				if(approved==null){
					eventMap.get(i).put("approved", 0);
				}
			}
			return SUCCESS;
		}
	}
	
	public String delEvent(){
		JSONObject jsonObject = new JSONObject();
		try{
			int stationid = Integer.parseInt(this.getSession().getAttribute("defaultStation").toString());
		}catch(Exception e){
			jsonObject.put("status", "error");
			this.print(jsonObject.toString());
			logger.error(e);
		}
		eventService.delEventById(edid);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	public String reportConf(){
		return SUCCESS;
	}
	
	public String editReportConf(){
		return SUCCESS;
	}

	public int getApproved() {
		return approved;
	}

	public void setApproved(int approved) {
		this.approved = approved;
	}

	public List<Map> getInvMap() {
		return InvMap;
	}

	public void setInvMap(List<Map> invMap) {
		InvMap = invMap;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}	

	public List<Map> getEventMap() {
		return eventMap;
	}

	public void setEventMap(List<Map> eventMap) {
		this.eventMap = eventMap;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public EventService getEventService() {
		return eventService;
	}

	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}

	public String getE_level() {
		return e_level;
	}

	public void setE_level(String e_level) {
		this.e_level = e_level;
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

	public int getEdid() {
		return edid;
	}

	public void setEdid(int edid) {
		this.edid = edid;
	}

	public int getReportType() {
		return reportType;
	}

	public void setReportType(int reportType) {
		this.reportType = reportType;
	}

	public String getOccdt1() {
		return occdt1;
	}

	public void setOccdt1(String occdt1) {
		this.occdt1 = occdt1;
	}

	public String getOccdt2() {
		return occdt2;
	}

	public void setOccdt2(String occdt2) {
		this.occdt2 = occdt2;
	}

	public UserLimitService getUserLimitService() {
		return userLimitService;
	}

	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}
}
