package com.jstrd.asdc.action;

import java.io.IOException;
import java.net.InetAddress;
import java.util.Map;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

import com.jstrd.asdc.service.UserLimitService;
import com.jstrd.asdc.service.UserService;

/**
 * 用户登录
 */
@SuppressWarnings("unchecked")
public class LoginAction extends BaseAction {

	private static Logger logger = Logger.getLogger(LoginAction.class.getName());
	private static final long serialVersionUID = 1L;
	private UserService userService;
	private UserLimitService userLimitService;
	private String email;
	private String password;
	private String vercode;
	private String ipaddr;
	private String sysinfo;
	private String ieinfo;
	private String datetime;

	/**
	 * 登录
	 */
	public String ajaxlogin() throws Exception {
		JSONObject jsonObj = new JSONObject();
		if (null!=this.getSession().getAttribute("rand") && vercode.trim().equals((String) this.getSession().getAttribute("rand"))) {
			ipaddr = this.getIpAddr();
			String res = "";
			try {
				res = userService.userLogin(email, password, ipaddr, sysinfo, ieinfo);
			} catch(Exception e) {
				logger.error("**********login fail********:"+email+ password+ ipaddr+ sysinfo+ ieinfo,e);
			}
			if (res.equals("ok")) {
				jsonObj.put("status", "ok");
				jsonObj.put("errorcode", "0");
				Map resultMap = (Map) userService.findUserByEmail(email);
				this.getSession().setAttribute("email", email);
				this.getSession().setAttribute("password", password);
				this.getSession().setAttribute("user", resultMap);
			} 
			else if (res.equals("err_pwd")) {
				jsonObj.put("status", "error");
				jsonObj.put("errorcode", "2");
			} 
			else if (res.equals("err_retrylimited")) {
				jsonObj.put("status", "error");
				jsonObj.put("errorcode", "3");
			} 
			else if (res.equals("err_account")) {
				jsonObj.put("status", "error");
				jsonObj.put("errorcode", "1");
				
			}
		} 
		else {
			jsonObj.put("status", "error");
			jsonObj.put("errorcode", "4");
		}
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			this.getResponse().getWriter().print(jsonObj.toString());
			this.getResponse().getWriter().flush();
		} catch (IOException e) {
			logger.error(e);
		}
		return null;
	}

	/**
	 * 退出登录
	 * @return
	 */
	public String logout() {
		this.getSession().removeAttribute("email");
		this.getSession().removeAttribute("password");
		this.getSession().removeAttribute("user");
		return SUCCESS;
	}
	
	/**
	 * 获取用户登录IP地址
	 * @return
	 */
	public String getIpAddr(){
		String ipAddress = null;
		//ipAddress = this.getRequest().getRemoteAddr();
		ipAddress = this.getRequest().getHeader("x-forwarded-for");
		
		if(ipAddress==null || ipAddress.length()==0 || "unknown".equalsIgnoreCase(ipAddress)){
			ipAddress = this.getRequest().getHeader("Proxy-Client-IP");
		}
		
		if(ipAddress==null || ipAddress.length()==0 || "unknown".equalsIgnoreCase(ipAddress)){
			ipAddress = this.getRequest().getHeader("WL-Proxy-Client-IP");
		}
		
		if(ipAddress==null || ipAddress.length()==0 || "unknown".equalsIgnoreCase(ipAddress)){
			ipAddress = this.getRequest().getRemoteAddr();
			if(ipAddress.equals("127.0.0.1")){
				//根据网卡获取本机配置的IP
				InetAddress inet = null;
				try {
					inet = InetAddress.getLocalHost();
				} catch (Exception e) {
					e.printStackTrace();
				}
				ipAddress = inet.getHostAddress();
			}
		}
		
		//对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
		if(ipAddress!=null && ipAddress.length()>15){	//"***.***.***.***".length() = 15
			if(ipAddress.indexOf(",")>0){
				ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
			}
		}
		
		return ipAddress;
	}

	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public UserLimitService getUserLimitService() {
		return userLimitService;
	}

	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getVercode() {
		return vercode;
	}

	public void setVercode(String vercode) {
		this.vercode = vercode;
	}

	public String getIpaddr() {
		return ipaddr;
	}

	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}

	public String getSysinfo() {
		return sysinfo;
	}

	public void setSysinfo(String sysinfo) {
		this.sysinfo = sysinfo;
	}

	public String getIeinfo() {
		return ieinfo;
	}

	public void setIeinfo(String ieinfo) {
		this.ieinfo = ieinfo;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
}
