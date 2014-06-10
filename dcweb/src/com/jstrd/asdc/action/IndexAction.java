package com.jstrd.asdc.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.apache.log4j.Logger;

import com.jstrd.asdc.service.StationService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.LocalizedTextUtil;

@SuppressWarnings("unchecked")
public class IndexAction extends BaseAction {

	private static Logger logger = Logger.getLogger(IndexAction.class);
	private static final long serialVersionUID = 1L;
	private String ludt;
	private String e_total;
	private String e_ytotal;
	private String co2_total;
	private String co2_ytotal;
	private String income_total;
	private String income_ytotal;
	private String e_total_unit;
	private String e_ytotal_unit;
	private String co2_total_unit;
	private String co2_ytotal_unit;
	private String income_total_unit;
	private String income_ytota_unitl;
	private String stationnum;
	private String ystationnum;
	private StationService stationService;

	// 示例电站信息
	private String stationId;
	private String stationName;
	private String iConIndex;
	private String e_Total;
	private String e_Today;
	private String e_Total_unit;
	private String e_Today_unit;

	private String clientdate;
	private String servertime;
	
	/**
	 * 首页面
	 */
	public String index() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		servertime = formatter.format(new Date());
		//初始化页面语言参数
		String locals = "en_US";
		//Locale loc = this.getRequest().getLocale();
		//locals = loc.toString();
		int hasLocalsSession = 0;
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
		{
			locals = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString().trim();
			hasLocalsSession = 1;
		}
		//从cookie中取出上次选择的语种
		int hasLocalsCookie = 0;
		if(hasLocalsSession == 0){
			Cookie[] cookies = this.getRequest().getCookies();
			try {
				if(null != cookies){
					logger.info("Cookie不为空, Cookies = "+cookies);
					for(Cookie cookie : cookies){
					    if("locals".equals(cookie.getName())){
					    	if(cookie.getValue() != null && cookie.getValue().length() > 1){
					    		locals = cookie.getValue();
					    		hasLocalsCookie = 1;
					    	}
				    	}
					}
				}else{
					logger.info("Cookies为空, Cookies = " + cookies);
				}
			} catch (Exception e) {
				logger.error(e);
			}
		}
		if (locals != null && hasLocalsCookie == 0 ) {
			Cookie cookie = new Cookie("locals",locals);
			cookie.setMaxAge(1512000);
			//设置路径，这个路径即该工程下都可以访问该cookie 如果不设置路径，那么只有设置该cookie路径及其子路径可以访问
			cookie.setPath("/");
			this.getResponse().addCookie(cookie);
		}
		if (locals != null) {
			if (locals.equals("en_US")) {
				ActionContext.getContext().setLocale(Locale.US);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("en_US", null));
			} else if (locals.equals("zh_CN")) {
				ActionContext.getContext().setLocale(Locale.SIMPLIFIED_CHINESE); 
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("zh_CN", null));
			} else if (locals.equals("de_DE")) {
				ActionContext.getContext().setLocale(Locale.GERMANY);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("de_DE", null));
			} else if (locals.equals("da_DK")) {
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("da_DK", null));
			} else {
				ActionContext.getContext().setLocale(Locale.US);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("en_US", null));
			}
		}
		Map tmap = stationService.allStationInfo();
		e_total = String.format("%.2f", (Float) tmap.get("ETotal"));
		co2_total = String.format("%.2f", (Float) tmap.get("Co2Total"));
		stationnum = Math.round((Float) tmap.get("StationNumTotal")) + "";
		ystationnum = Math.round((Float) tmap.get("StationNumYesterday")) + "";
		e_ytotal = String.format("%.2f", (Float) tmap.get("EYesterday"));
		co2_ytotal = String.format("%.2f", (Float) tmap.get("Co2Yesterday"));
		e_total_unit = (String) tmap.get("ETotal_unit");
		co2_total_unit = (String) tmap.get("Co2Total_unit");
		e_ytotal_unit = (String) tmap.get("EYesterday_unit");
		co2_ytotal_unit = (String) tmap.get("Co2Yesterday_unit");
		
		Map tamp = stationService.sampleStationInfo();
		stationId = tamp.get("StationId") + "";
		stationName = (String) tamp.get("StationName");
		iConIndex = (String) tamp.get("iconindex");
		e_Total = (String) tamp.get("E_Total");
		e_Today = (String) tamp.get("E_Today");
		e_Today_unit = (String) tamp.get("E_Today_unit");
		e_Total_unit = (String) tamp.get("E_Total_unit");
		ludt = (String) tamp.get("LUDT");
		// 登录状态访问首页时自动跳转到电站列表页面
		if (this.getSession().getAttribute("user") != null ) {
			if("0".equals(((Map)this.getSession().getAttribute("user")).get("userId")))
				return SUCCESS;
			return "tomain";
		} else {
			return SUCCESS;
		}
	}
	
	/** 获取客户端日期, 作为默认查询条件  */
	public String getClientDate(){
		this.getSession().setAttribute("clientdate", clientdate);
		return null;
	}

	public String getLudt() {
		return ludt;
	}

	public void setLudt(String ludt) {
		this.ludt = ludt;
	}

	public String getE_Today() {
		return e_Today;
	}

	public void setE_Today(String e_Today) {
		this.e_Today = e_Today;
	}

	public String getE_Total() {
		return e_Total;
	}

	public void setE_Total(String e_Total) {
		this.e_Total = e_Total;
	}

	public String getIConIndex() {
		return iConIndex;
	}

	public void setIConIndex(String iConIndex) {
		this.iConIndex = iConIndex;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getStationId() {
		return stationId;
	}

	public void setstationId(String stationId) {
		this.stationId = stationId;
	}

	public String getE_total() {
		return e_total;
	}

	public void setE_total(String e_total) {
		this.e_total = e_total;
	}

	public String getE_ytotal() {
		return e_ytotal;
	}

	public void setE_ytotal(String e_ytotal) {
		this.e_ytotal = e_ytotal;
	}

	public String getIncome_total() {
		return income_total;
	}

	public void setIncome_total(String income_total) {
		this.income_total = income_total;
	}

	public String getIncome_ytotal() {
		return income_ytotal;
	}

	public void setIncome_ytotal(String income_ytotal) {
		this.income_ytotal = income_ytotal;
	}

	public StationService getStationService() {
		return stationService;
	}

	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}

	public String getCo2_total() {
		return co2_total;
	}

	public void setCo2_total(String co2_total) {
		this.co2_total = co2_total;
	}

	public String getCo2_ytotal() {
		return co2_ytotal;
	}

	public void setCo2_ytotal(String co2_ytotal) {
		this.co2_ytotal = co2_ytotal;
	}

	public String getStationnum() {
		return stationnum;
	}

	public void setStationnum(String stationnum) {
		this.stationnum = stationnum;
	}

	public String getYstationnum() {
		return ystationnum;
	}

	public void setYstationnum(String ystationnum) {
		this.ystationnum = ystationnum;
	}
	
	public String getE_total_unit() {
		return e_total_unit;
	}

	public void setE_total_unit(String e_total_unit) {
		this.e_total_unit = e_total_unit;
	}

	public String getE_ytotal_unit() {
		return e_ytotal_unit;
	}

	public void setE_ytotal_unit(String e_ytotal_unit) {
		this.e_ytotal_unit = e_ytotal_unit;
	}

	public String getCo2_total_unit() {
		return co2_total_unit;
	}

	public void setCo2_total_unit(String co2_total_unit) {
		this.co2_total_unit = co2_total_unit;
	}

	public String getCo2_ytotal_unit() {
		return co2_ytotal_unit;
	}

	public void setCo2_ytotal_unit(String co2_ytotal_unit) {
		this.co2_ytotal_unit = co2_ytotal_unit;
	}

	public String getIncome_total_unit() {
		return income_total_unit;
	}

	public void setIncome_total_unit(String income_total_unit) {
		this.income_total_unit = income_total_unit;
	}

	public String getIncome_ytota_unitl() {
		return income_ytota_unitl;
	}

	public void setIncome_ytota_unitl(String income_ytota_unitl) {
		this.income_ytota_unitl = income_ytota_unitl;
	}

	public String getE_Total_unit() {
		return e_Total_unit;
	}

	public void setE_Total_unit(String e_Total_unit) {
		this.e_Total_unit = e_Total_unit;
	}

	public String getE_Today_unit() {
		return e_Today_unit;
	}

	public void setE_Today_unit(String e_Today_unit) {
		this.e_Today_unit = e_Today_unit;
	}

	public String getClientdate() {
		return clientdate;
	}

	public void setClientdate(String clientdate) {
		this.clientdate = clientdate;
	}

	public String getServertime() {
		return servertime;
	}

	public void setServertime(String servertime) {
		this.servertime = servertime;
	}


}
