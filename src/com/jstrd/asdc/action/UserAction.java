package com.jstrd.asdc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.jstrd.asdc.email.MainSend;
import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.service.StationService;
import com.jstrd.asdc.service.UserLimitService;
import com.jstrd.asdc.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.LocalizedTextUtil;

@SuppressWarnings({"unchecked","unused"})
public class UserAction extends BaseAction {

	private static Logger logger = Logger.getLogger(UserAction.class);
	private static final long serialVersionUID = 1L;
	private String email;
	private String pwd;
	private String firstName;
	private String secondName;
	private String company;
	private String question;
	private String answer;
	private String myurl;
	private String country;
	private String state;
	private String city;
	private String address;
	private String postcode;
	private String tel1;
	private String tel2;
	private String tel3;
	private String tel4;
	private String mobile;
	private String mobile2;

	private String oldpwd;
	private UserService userService;
	private UserLimitService userLimitService;
	private InverterService inverterService;
	private List<Map> stateList;
	private List<Map> countryList;
	private Map userInfo;
	private int countryId;
	private StationService stationService;
	private String checkcode;
	private String yourId;
	private String verCode;
	private String userLocal;
	
	public String doRegister() {
		if (email == null || ("").equals(email)) {
			return INPUT;
		}
		userService.saveUser(email, pwd, firstName, secondName, company, 2);
		Object result = userService.findUserByEmail(email);
		Map limitMap = userLimitService.getRoleLimt(2);
		
		this.getSession().setAttribute("email", email);
		this.getSession().setAttribute("password", pwd);
		this.getSession().setAttribute("user", result);
		this.getSession().setAttribute("roleLimits", limitMap);
		return SUCCESS;
	}

	public String doRegister1() {
		return SUCCESS;
	}

	public String doRegister2() {
		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		countryList = stationService.getContryList(localLang);
		return SUCCESS;
	}

	public String getUserRegInfo() {
		email = (String) this.getSession().getAttribute("email");
		userInfo = userService.getUserRegInfo(email.trim());
		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		if (null==userInfo.get("tel") || userInfo.get("tel").toString().equals("---")) {
			userInfo.put("tel1", "");
			userInfo.put("tel2", "");
			userInfo.put("tel3", "");
			userInfo.put("tel4", "");
		} else {
			String tl = (String) userInfo.get("tel");
			String tls[] = tl.split("-");
			userInfo.put("tel1", tls[0]);
			userInfo.put("tel2", tls[1]);
			userInfo.put("tel3", tls[2]);
			if (tls.length == 4)
				userInfo.put("tel4", tls[3]);
		}
		if (null==userInfo.get("mobile") || userInfo.get("mobile").toString().equals("-")) {
			userInfo.put("mobile1", "");
			userInfo.put("mobile", "");
		} else {
			String mbl = (String) userInfo.get("mobile");
			if (null != mbl) {
				String mbs[] = mbl.split("-");
				if (mbs.length > 1) {
					userInfo.put("mobile1", mbs[0]);
					userInfo.put("mobile", mbs[1]);
				}
			}
		}
		if (null != userInfo.get("provincap"))
			state = userInfo.get("provincap").toString().trim();
		countryList = stationService.getContryList(localLang);
		stateList = stationService.getStateList(Integer.parseInt(userInfo.get("country").toString()), localLang);
		return SUCCESS;
	}
	
	public String viewCurInfo(){
		
		return null;
	}

	/**
	 * 查看用户详细信息
	 * @return
	 */
	public String viewUserRegInfo() {
		
		Map user = (Map) this.getSession().getAttribute("user");
		
		userInfo = userService.getUserRegInfo(email.trim());
		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
		if (userInfo.get("tel") == null || userInfo.get("tel").toString().equals("---")) {
			userInfo.put("tel1", "");
			userInfo.put("tel2", "");
			userInfo.put("tel3", "");
			userInfo.put("tel4", "");
		} else {
			String tl = (String) userInfo.get("tel");
			String tls[] = tl.split("-");
			userInfo.put("tel1", tls[0]);
			if(tls.length>1){
				userInfo.put("tel2", tls[1]);
				userInfo.put("tel3", tls[2]);
			}
			if (tls.length == 4)
				userInfo.put("tel4", tls[3]);
		}
		if (userInfo.get("mobile") == null || userInfo.get("mobile").toString().equals("-")) {
			userInfo.put("mobile1", "");
			userInfo.put("mobile", "");
		} else {
			String mbl = (String) userInfo.get("mobile");
			if (mbl != null) {
				String mbs[] = mbl.split("-");
				if (mbs.length > 1) {
					userInfo.put("mobile1", mbs[0]);
					userInfo.put("mobile", mbs[1]);
				}
			}
		}
		if (userInfo.get("provincap") != null)
			state = userInfo.get("provincap").toString().trim();
		countryList = stationService.getContryList(localLang);
		stateList = stationService.getStateList(Integer.parseInt(userInfo.get("country").toString()), localLang);
		
		String rid = user.get("roleid").toString()+"";
		int roid = Integer.parseInt(rid);
		
		if(roid == 4){
			return SUCCESS;
		}else{
			return "tologin";
		}
		
		
	}
	

	public String editUserRegInfo() {
		JSONObject jsonObject = new JSONObject();

		if (tel1.equals("---") || tel1.equals(""))
			tel1 = null;
		if (mobile.equals("-"))
			mobile = null;
		String user = userService.editUserRegInfo(email, firstName, secondName,
				company, myurl, country, state, city, address, postcode, tel1,
				mobile);
		if (user.equals("ok")) {
			jsonObject.put("status", "ok");
			Map userInfo = (Map) this.getSession().getAttribute("user");
			userInfo.put("firstName", firstName);
			userInfo.put("secondName", secondName);
			this.getSession().setAttribute("user", userInfo);
		} else {
			jsonObject.put("status", "error");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public String changeUserPwsShow() {
		email = (String) this.getSession().getAttribute("email");
		return SUCCESS;
	}

	public String changeUserPws() {
		JSONObject jsonObject = new JSONObject();

		String userId = ((Map) this.getSession().getAttribute("user")).get(
				"UserId").toString();

		String stationId = "0";
		if (this.getSession().getAttribute("defaultStation") != null)
			stationId = this.getSession().getAttribute("defaultStation")
					.toString();
		Map userMenu = userLimitService.getUserMenu(Integer.parseInt(userId),
				Integer.parseInt(stationId));
		this.getSession().setAttribute("userMenu", userMenu);

		String user = userService.changeUserPws(userId, oldpwd, pwd);
		if (user.equals("ok")) {
			jsonObject.put("status", "ok");
		} else if (user.equals("err_oldpwd")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "1");
		} else if (user.equals("err_account")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "2");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public String checkEmail() {
		JSONObject jsonObject = new JSONObject();
		Object user = userService.findUserByEmail(email);
		if (user != null) {
			jsonObject.put("status", "error");
		} else {
			jsonObject.put("status", "ok");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public String checkEmailAndVerCode() {
		JSONObject jsonObject = new JSONObject();
		if (this.getSession().getAttribute("rand") == null
				|| !verCode.trim().equals(
						(String) this.getSession().getAttribute("rand")))
			jsonObject.put("status", "errCode");
		else {
			Object user = userService.findUserByEmail(email);
			if (user != null) {
				jsonObject.put("status", "ok");
				this.getSession().setAttribute("updatepasswd", email);
			} else {
				jsonObject.put("status", "noAcc");
			}
		}
		this.print(jsonObject.toString());
		return null;
	}

	private String psno;
	private String stationname;
	private String co2xs;
	private String gainxs;
	private String addr;
	private String money;
	private String timezone;

	public String bindStation() {
		String userId = ((Map) this.getSession().getAttribute("user")).get(
				"userId").toString();
		int stationid = userService.saveStaion(stationname, userId, co2xs,
				gainxs, addr, country, city, timezone, money, psno);
		// userService.updatePmuStation(Integer.parseInt(userId),stationid,
		// psno);
		return SUCCESS;
	}

	public String checkPsno() {
		JSONObject jsonObject = new JSONObject();
		Map pmuMap = userService.findPmuByPsno(psno);
		if (pmuMap != null) {
			if (pmuMap.get("stationid") == null) {
				jsonObject.put("status", "ok");
			} else if (("").equals(pmuMap.get("stationid").toString().trim())) {
				jsonObject.put("status", "ok");
			} else {
				jsonObject.put("status", "error");
				// PMU已经被绑定
				jsonObject.put("errorcode", "1");
			}
		} else {
			jsonObject.put("status", "error");
			// PMU不存在
			jsonObject.put("errorcode", "0");
		}
		this.print(jsonObject.toString());
		return null;
	}

	private String phone;
	private String adminname;
	private String longitude;
	private String latitude;
	private String hasl;
	private String azimuth;
	private String aoi;
	private String desc;

	public String createNewStation() {
		JSONObject jsonObject = new JSONObject();
		String userId = ((Map) this.getSession().getAttribute("user")).get(
				"userId").toString();
		int stationid = userService.saveStaion(stationname, userId, co2xs,
				gainxs, addr, country, city, timezone, money, psno);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	private String stid;
	private Map stationMap;

	public String delStation() {
		JSONObject jsonObject = new JSONObject();
		try {
			userService.delStation(Integer.parseInt(stid));
			jsonObject.put("status", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("status", "error");
		} finally {
			this.print(jsonObject.toString());
		}
		return null;
	}

	public String detailStation() {
		stationMap = userService.getStationById(Integer.parseInt(stid));
		return SUCCESS;
	}

	public String updateStation() {
		JSONObject jsonObject = new JSONObject();
		try {
			userService.updateStation(Integer.parseInt(stid), stationname,
					co2xs, gainxs, money, timezone, addr, country, city);
			jsonObject.put("status", "ok");
			jsonObject.put("stid", stid);
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("status", "error");
		} finally {
			this.print(jsonObject.toString());
		}

		return null;
	}

	private List<Map> pmuList;
	private List<Map> showPmuList;
	private String invName;
	private String pino;
	private int pageSize = 15;

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getMyurl() {
		return myurl;
	}

	public void setMyurl(String myurl) {
		this.myurl = myurl;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getTel4() {
		return tel4;
	}

	public void setTel4(String tel4) {
		this.tel4 = tel4;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	private int totalPage;
	private int totalCount;
	private int pageNo = 1;

	public String showStationPmu() {
		String stid = this.getSession().getAttribute("defaultStation")
				.toString();
		// totalCount = userService.findStationPmuCount(Integer.parseInt(stid));
		// totalPage = (totalCount+pageSize-1)/pageSize;
		// if(pageNo>totalPage&&totalPage>0){
		// pageNo=totalPage;
		// }
		pmuList = inverterService.getAllPmuAndInverter(Integer.parseInt(stid));
		if (state == null && invName == null && pino == null) {
			showPmuList = pmuList;
		} else {
			System.out.println(invName);
			showPmuList = inverterService.getPmuOrInverter(Integer
					.parseInt(stid), invName, pino, state);
		}
		return SUCCESS;
	}

	private String idex;

	public String bindPmu() {
		JSONObject jsonObject = new JSONObject();
		try {
			Map pmu = userService.findPmuByPsno(psno);
			if (pmu == null) {
				jsonObject.put("status", "error");
				jsonObject.put("errorcode", "2");// 不存在
			} else {
				Object pmuStationid = pmu.get("stationId");
				if (pmuStationid == null) {
					String stationid = this.getSession().getAttribute(
							"defaultStation").toString();
					userService.updatePmuStation(Integer.parseInt(stationid),
							psno);
					jsonObject.put("status", "ok");
				} else {
					jsonObject.put("status", "error");
					jsonObject.put("errorcode", "1");// 已绑定
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");// 未知错误
		} finally {
			this.print(jsonObject.toString());
		}
		return null;
	}

	private List<Map> invList;

	public String showStationInv() {
		String stationid = this.getSession().getAttribute("defaultStation")
				.toString();
		totalCount = userService.findStationInvCount(Integer
				.parseInt(stationid));
		totalPage = (totalCount + pageSize - 1) / pageSize;
		if (pageNo > totalPage && totalPage > 0) {
			pageNo = totalPage;
		}
		invList = userService.findStationInv(Integer.parseInt(stationid),
				pageNo, pageSize);
		return SUCCESS;
	}

	private String isno;
	private String byName;

	public String reNamePmu() {
		JSONObject jsonObject = new JSONObject();
		try {
			userService.updateInvName(isno, byName);
			jsonObject.put("status", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");// 未知错误
		} finally {
			this.print(jsonObject.toString());
		}
		return null;
	}

	private int editStationLimit;
	private int addPmuLimit;
	private int delPmuLimit;
	private int setReportLimit;

	public String createNormalUser() {
		JSONObject jsonObject = new JSONObject();
		int stationid = Integer.parseInt(this.getSession().getAttribute(
				"defaultStation").toString());
		int createUserId = Integer.parseInt(((Map) this.getSession()
				.getAttribute("user")).get("userId").toString());
		userService.createNormalUser(email, pwd, firstName, secondName,
				stationid, createUserId);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	public String regUser() {
		String tel = tel1 + "-" + tel2 + "-" + tel3 + "-" + tel4;
		if (tel.equals("---"))
			tel = null;
		mobile = mobile2 + "-" + mobile;
		if (mobile.equals("-"))
			mobile = null;

		String[] res = userService.regUser(email, pwd, firstName, secondName, company, question, answer, myurl, country, city, state, address, postcode, tel, mobile);
		if (!res[2].equals("ok")) {
			String localLang = "en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
				localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			countryList = stationService.getContryList(localLang);
			//return "error";
			return SUCCESS;
		} else {
			MainSend mainSendms = new MainSend();
			String checkUrl = "";
			String webUrl = "";
			String localLang = "en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
				localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString();
			
			String path = this.getRequest().getContextPath();
			String realPath = this.getRequest().getSession()
					.getServletContext().getRealPath("");
			realPath = realPath + "/WEB-INF/classes/";
			String basePath = this.getRequest().getScheme() + "://"
					+ this.getRequest().getServerName() + ":"
					+ this.getRequest().getServerPort() + path + "/";
			checkUrl = basePath + "userRegCheck.action?userLocal=" + localLang + "&yourId=" + res[0] + "&amp;checkcode=" + res[1];
			webUrl = basePath;
			mainSendms.doSend(email, res[1], this.firstName + " " + this.secondName, checkUrl, webUrl, localLang, realPath);
			verCode = res[1];
			yourId = res[0];
			return SUCCESS;
		}
	}

	public String reSendVerCode() {
		JSONObject jsonObject = new JSONObject();
		try {
			MainSend mainSendms = new MainSend();
			String checkUrl = "";
			String webUrl = "";
			String localLang = "en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
				localLang = this.getSession().getAttribute(
						"WW_TRANS_I18N_LOCALE").toString();
			String path = this.getRequest().getContextPath();
			String realPath = this.getRequest().getSession()
					.getServletContext().getRealPath("");
			realPath = realPath + "/WEB-INF/classes/";
			String basePath = this.getRequest().getScheme() + "://"
					+ this.getRequest().getServerName() + ":"
					+ this.getRequest().getServerPort() + path + "/";
			checkUrl = basePath + "userRegCheck.action?yourId=" + yourId
					+ "&amp;checkcode=" + verCode;
			webUrl = basePath;
			mainSendms.doSend(email, verCode, this.firstName + " "
					+ this.secondName, checkUrl, webUrl, localLang, realPath);
			jsonObject.put("status", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "0");// 未知错误
		} finally {
			this.print(jsonObject.toString());
		}
		return null;
	}

	/**
	 * 账号邮件验证
	 * 
	 * @return
	 */
	private String listNo;

	public String getListNo() {
		return listNo;
	}

	public void setListNo(String listNo) {
		this.listNo = listNo;
	}

	public String regUserVer() {
		String verRes = userService.regUserVer(email, listNo);
		if (verRes.equals("err_active")) {
			// 账号已经被激活，不能重复激活

		} else if (verRes.equals("err_verifycode")) {
			// 错误的验证码

		} else if (verRes.equals("err_account")) {
			// 账号邮件不存在

		} else {
			// 验证成功

		}
		return SUCCESS;
	}

	private int userId;

	public String delNormalUser() {
		JSONObject jsonObject = new JSONObject();
		userService.deleteNormalUser(userId);

		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	private Map userMap;
	private Map userLimitsMap;

	public String editUser() {
		userMap = (Map) userService.findUserById(userId);
		// int roleId = Integer.parseInt(userMap.get("roleId").toString());
		// userLimitsMap = userLimitService.getUserRoleLimt(userId, roleId);
		return SUCCESS;
	}

	public String updateUser() {
		JSONObject jsonObject = new JSONObject();
		userService.updateUserInfo(userId, pwd, firstName, secondName);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	public String editUserLimits() {
		JSONObject jsonObject = new JSONObject();
		userService.updateUserLimits(userId, editStationLimit, addPmuLimit,
				delPmuLimit, setReportLimit);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	private List<Map> usersList;

	public String roleManager() {
		usersList = this.userService.getUsersByRole(3);
		return SUCCESS;
	}

	private String requestDepartment;
	private String fax;

	public String doCreateSysuser() {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("status", "ok");
		this.userService.createSysAdmin(email, pwd, requestDepartment,
				firstName, secondName, phone, fax);
		this.print(jsonObject.toString());
		return null;
	}

	private String type;

	public String editSysUser() {
		type = "edit";
		userMap = (Map) this.userService.findUserById(userId);
		return SUCCESS;
	}

	public String deleteSysUser() {
		JSONObject jsonObject = new JSONObject();
		this.userService.deleteSysUser(userId);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	public String doEditSysuser() {
		JSONObject jsonObject = new JSONObject();
		this.userService.updateSysAdmin(userId, pwd, requestDepartment,
				firstName, secondName, phone, fax);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	/**
	 * 
	 * @return
	 */
	private Map<String, Map> roleLimitsMap;

	public String viewLimits() {
		roleLimitsMap = new HashMap();
		List<Map> roleLimitsList = this.userLimitService.getAllRoleLimit();
		for (int i = 0; i < roleLimitsList.size(); i++) {
			roleLimitsMap.put("roleId_" + roleLimitsList.get(i).get("ID"),
					roleLimitsList.get(i));
		}
		return SUCCESS;
	}

	private int roleId;

	public String editLimits() {
		roleId = roleId == 0 ? 1 : roleId;
		type = "edit";
		roleLimitsMap = new HashMap();
		List<Map> roleLimitsList = this.userLimitService.getAllRoleLimit();
		for (int i = 0; i < roleLimitsList.size(); i++) {
			roleLimitsMap.put("roleId_" + roleLimitsList.get(i).get("ID"),
					roleLimitsList.get(i));
		}
		return SUCCESS;
	}

	private String limitsStr;

	public String updateRoleLimits() {
		JSONObject jsonObject = new JSONObject();
		this.userLimitService.updateRoleLimitsById(roleId, limitsStr);
		jsonObject.put("status", "ok");
		this.print(jsonObject.toString());
		return null;
	}

	public String getStateInfolist() {

		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")
					.toString();
		stateList = stationService.getStateList(countryId, localLang);
		this.getSession().setAttribute("stateList", stateList);
		return SUCCESS;
	}

	public String getStateInfolistAjax() {
		JSONObject jsonObject = new JSONObject();
		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")
					.toString();
		stateList = stationService.getStateList(countryId, localLang);
		String res = "";
		for (int i = 0; i < stateList.size(); i++) {
			if (res.equals("")) {
				res = stateList.get(i).get("c_code") + ","
						+ stateList.get(i).get("countryname");

			} else {
				res = res + ";" + stateList.get(i).get("c_code") + ","
						+ stateList.get(i).get("countryname");

			}
		}
		jsonObject.put("data", res);
		this.print(jsonObject.toString());
		return null;
	}

	public String updatePasswdShow() {

		return SUCCESS;
	}

	public String getCheckCode() {
		JSONObject jsonObject = new JSONObject();
		String res = this.userService.getCheckCode(email);
		String s[] = res.split("#");
		if (s[2].equals("error_account")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "1");
		} else {

			MainSend mainSendms = new MainSend();
			String checkUrl = "";
			String webUrl = "";
			String localLang = "en_US";
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
				localLang = this.getSession().getAttribute(
						"WW_TRANS_I18N_LOCALE").toString();
			String path = this.getRequest().getContextPath();
			String realPath = this.getRequest().getSession()
					.getServletContext().getRealPath("");
			realPath = realPath + "/WEB-INF/classes/";
			String basePath = this.getRequest().getScheme() + "://"
					+ this.getRequest().getServerName() + ":"
					+ this.getRequest().getServerPort() + path + "/";
			checkUrl = basePath + "";
			webUrl = basePath;
			String changeUrl = webUrl + "/updatePasswd.action?email=" + email
					+ "&checkcode=" + s[2];
			mainSendms.doSendCheckCode(email, s[2], s[0] + " " + s[1], webUrl,
					localLang, realPath, changeUrl);
			jsonObject.put("status", "ok");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public String updatePasswd() {
		String locals = null;
		String _url = getRequest().getQueryString();
		if (!_url.startsWith("email")) {
			if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
				locals = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString().trim();
			userLocal = locals;
		} else {
			userLocal = getRequest().getParameter("userLocal");
		}
		if (userLocal != null && !userLocal.trim().equals("")) {
			if (userLocal.equals("en_US")) {
				ActionContext.getContext().setLocale(Locale.US);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("en_US", null));
			} else if (userLocal.equals("zh_CN")) {
				ActionContext.getContext().setLocale(Locale.SIMPLIFIED_CHINESE);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("zh_CN", null));
			} else if (userLocal.equals("de_DE")) {
				ActionContext.getContext().setLocale(Locale.GERMANY);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("de_DE", null));
			} else if (userLocal.equals("da_DK")) {
				ActionContext.getContext().setLocale(new Locale("da", "DK"));
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("da_DK", null));
			} else {
				ActionContext.getContext().setLocale(Locale.US);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE",LocalizedTextUtil.localeFromString("en_US", null));
			}
		} else {
			ActionContext.getContext().setLocale(this.getRequest().getLocale());
			this.getSession().setAttribute("WW_TRANS_I18N_LOCALE",
					this.getRequest().getLocale());
		}
		return SUCCESS;
	}

	public String updatePasswdType() {

		return SUCCESS;
	}

	public String updatePasswd2() {

		return SUCCESS;
	}

	public String updatePasswdCode() {
		String email = (String) this.getSession().getAttribute("updatepasswd");
		// this.getSession().removeAttribute("updatepasswd");
		String res = this.userService.getCheckCode(email);
		String s[] = res.split("#");
		MainSend mainSendms = new MainSend();
		String checkUrl = "";
		String webUrl = "";
		String localLang = "en_US";
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			localLang = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE")
					.toString();
		String path = this.getRequest().getContextPath();
		String realPath = this.getRequest().getSession().getServletContext()
				.getRealPath("");
		realPath = realPath + "/WEB-INF/classes/";
		String basePath = this.getRequest().getScheme() + "://"
				+ this.getRequest().getServerName() + ":"
				+ this.getRequest().getServerPort() + path + "/";
		checkUrl = basePath + "";
		webUrl = basePath;
		// userLocal=" + localLang + "&
		String changeUrl = webUrl + "updatePasswd.action?email=" + email + "&checkcode=" + s[2] + "&userLocal=" + localLang;
		mainSendms.doSendCheckCode(email, s[2], s[0] + " " + s[1], webUrl,
				localLang, realPath, changeUrl);

		return SUCCESS;
	}

	public String doUpdatePasswd() {
		JSONObject jsonObject = new JSONObject();
		String res = this.userService.updateUserPasswd(email, checkcode, pwd);

		if (res.equals("ok")) {
			jsonObject.put("status", "ok");
		} else if (res.equals("err_code")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "1");
		} else if (res.equals("err_account")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "2");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public String userRegCheck() {
		String locals = null;
		if (this.getSession().getAttribute("WW_TRANS_I18N_LOCALE") != null)
			locals = this.getSession().getAttribute("WW_TRANS_I18N_LOCALE").toString().trim();
		userLocal = locals;
		if (userLocal != null && !userLocal.trim().equals("")) {
			if (userLocal.equals("en_US")) {
				ActionContext.getContext().setLocale(Locale.US);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("en_US", null));
			} else if (userLocal.equals("zh_CN")) {
				ActionContext.getContext().setLocale(Locale.SIMPLIFIED_CHINESE);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("zh_CN", null));
			}  else if (userLocal.equals("de_DE")) {
				ActionContext.getContext().setLocale(Locale.GERMANY);
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("de_DE", null));
			} else if(userLocal.equals("da_DK")) {
				ActionContext.getContext().setLocale(new Locale("da", "DK"));
				this.getSession().setAttribute("WW_TRANS_I18N_LOCALE", LocalizedTextUtil.localeFromString("da_DK", null));
			}
		} else {
			ActionContext.getContext().setLocale(Locale.US);
			this.getSession().setAttribute("WW_TRANS_I18N_LOCALE",LocalizedTextUtil.localeFromString("en_US", null));
		}
		if(yourId.endsWith("#")){
			yourId = yourId.substring(0, yourId.length()-1);
		}
		String res = userService.activeUserAccount(Integer.parseInt(yourId), checkcode);
		if (res.indexOf("ok&") != -1) {
			yourId = "0";
			String s[] = res.split("&");
			String userAcc = s[1] + "(" + s[2] + s[3] + ")";
			this.getRequest().getSession().setAttribute("userAcc", userAcc);
		} else if (res.equals("err_active")) {
			yourId = "1";
		} else if (res.equals("err_verifycode")) {
			yourId = "2";
		} else if (res.equals("err_account")) {
			yourId = "3";
		}
		return SUCCESS;
	}

	public String userActiveAdmin() {
		JSONObject jsonObject = new JSONObject();
		String res = userService.activeUserAccount(Integer.parseInt(yourId),
				"@admin");
		if (res.indexOf("ok&") != -1) {
			jsonObject.put("status", "ok");
		} else if (res.equals("err_code")) {
			jsonObject.put("status", "error");
			jsonObject.put("errorcode", "1");
		}
		this.print(jsonObject.toString());
		return null;
	}

	public Map getUserMap() {
		return userMap;
	}

	public void setUserMap(Map userMap) {
		this.userMap = userMap;
	}

	public Map getUserLimitsMap() {
		return userLimitsMap;
	}

	public void setUserLimitsMap(Map userLimitsMap) {
		this.userLimitsMap = userLimitsMap;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
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

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getPsno() {
		return psno;
	}

	public void setPsno(String psno) {
		this.psno = psno;
	}

	public String getStationname() {
		return stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

	public String getCo2xs() {
		return co2xs;
	}

	public void setCo2xs(String co2xs) {
		this.co2xs = co2xs;
	}

	public String getGainxs() {
		return gainxs;
	}

	public void setGainxs(String gainxs) {
		this.gainxs = gainxs;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
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

	public UserLimitService getUserLimitService() {
		return userLimitService;
	}

	public void setUserLimitService(UserLimitService userLimitService) {
		this.userLimitService = userLimitService;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAdminname() {
		return adminname;
	}

	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getHasl() {
		return hasl;
	}

	public void setHasl(String hasl) {
		this.hasl = hasl;
	}

	public String getAzimuth() {
		return azimuth;
	}

	public void setAzimuth(String azimuth) {
		this.azimuth = azimuth;
	}

	public String getAoi() {
		return aoi;
	}

	public void setAoi(String aoi) {
		this.aoi = aoi;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getStid() {
		return stid;
	}

	public void setStid(String stid) {
		this.stid = stid;
	}

	public Map getStationMap() {
		return stationMap;
	}

	public void setStationMap(Map stationMap) {
		this.stationMap = stationMap;
	}

	public List<Map> getPmuList() {
		return pmuList;
	}

	public void setPmuList(List<Map> pmuList) {
		this.pmuList = pmuList;
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

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getIdex() {
		return idex;
	}

	public void setIdex(String idex) {
		this.idex = idex;
	}

	public List<Map> getInvList() {
		return invList;
	}

	public void setInvList(List<Map> invList) {
		this.invList = invList;
	}

	public String getIsno() {
		return isno;
	}

	public void setIsno(String isno) {
		this.isno = isno;
	}

	public String getByName() {
		return byName;
	}

	public void setByName(String byName) {
		this.byName = byName;
	}

	public int getAddPmuLimit() {
		return addPmuLimit;
	}

	public void setAddPmuLimit(int addPmuLimit) {
		this.addPmuLimit = addPmuLimit;
	}

	public int getDelPmuLimit() {
		return delPmuLimit;
	}

	public void setDelPmuLimit(int delPmuLimit) {
		this.delPmuLimit = delPmuLimit;
	}

	public int getSetReportLimit() {
		return setReportLimit;
	}

	public void setSetReportLimit(int setReportLimit) {
		this.setReportLimit = setReportLimit;
	}

	public int getEditStationLimit() {
		return editStationLimit;
	}

	public void setEditStationLimit(int editStationLimit) {
		this.editStationLimit = editStationLimit;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getTimezone() {
		return timezone;
	}

	public void setTimezone(String timezone) {
		this.timezone = timezone;
	}

	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}

	public List<Map> getShowPmuList() {
		return showPmuList;
	}

	public void setShowPmuList(List<Map> showPmuList) {
		this.showPmuList = showPmuList;
	}

	public String getInvName() {
		return invName;
	}

	public void setInvName(String invName) {
		this.invName = invName;
	}

	public String getPino() {
		return pino;
	}

	public void setPino(String pino) {
		this.pino = pino;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<Map> getUsersList() {
		return usersList;
	}

	public void setUsersList(List<Map> usersList) {
		this.usersList = usersList;
	}

	public String getRequestDepartment() {
		return requestDepartment;
	}

	public void setRequestDepartment(String requestDepartment) {
		this.requestDepartment = requestDepartment;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Map<String, Map> getRoleLimitsMap() {
		return roleLimitsMap;
	}

	public void setRoleLimitsMap(Map<String, Map> roleLimitsMap) {
		this.roleLimitsMap = roleLimitsMap;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getLimitsStr() {
		return limitsStr;
	}

	public void setLimitsStr(String limitsStr) {
		this.limitsStr = limitsStr;
	}

	public List<Map> getStateList() {
		return stateList;
	}

	public List<Map> getCountryList() {
		return countryList;
	}

	public void setStateList(List<Map> stateList) {
		this.stateList = stateList;
	}

	public void setCountryList(List<Map> countryList) {
		this.countryList = countryList;
	}

	public StationService getStationService() {
		return stationService;
	}

	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public Map getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(Map userInfo) {
		this.userInfo = userInfo;
	}

	public String getOldpwd() {
		return oldpwd;
	}

	public void setOldpwd(String oldpwd) {
		this.oldpwd = oldpwd;
	}

	public String getCheckcode() {
		return checkcode;
	}

	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}

	public String getYourId() {
		return yourId;
	}

	public void setYourId(String yourId) {
		this.yourId = yourId;
	}

	public String getMobile2() {
		return mobile2;
	}

	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	public String getVerCode() {
		return verCode;
	}

	public void setVerCode(String verCode) {
		this.verCode = verCode;
	}

	public String getUserLocal() {
		return userLocal;
	}

	public void setUserLocal(String userLocal) {
		this.userLocal = userLocal;
	}

}
