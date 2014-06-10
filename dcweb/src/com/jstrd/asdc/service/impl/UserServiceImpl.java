package com.jstrd.asdc.service.impl;

import java.util.List;
import java.util.Map;

import com.jstrd.asdc.dao.UserDao;
import com.jstrd.asdc.service.UserService;

public class UserServiceImpl implements UserService{

	public UserDao userDao;
	
	/**
	 *获取用户的电站关系 
	 * @param userid
	 * @return
	 */
	public List<Object> findUserStations(int userid){
		return this.userDao.findUserStations(userid);
	}
	/**
	 * 根据用户ID获取用户信息
	 */
	public Object findUserById(int userid){
		
		return userDao.findUserById(userid);
	}
	/**
	 * 根据用户email获取用户信息
	 */
	public Object findUserByEmail(String email){
		return userDao.findUserByEmail(email);
	}
	
	/** 根据用户email获取用户登信息   */
	public String userLogin(String email, String pwd, String ipaddr, String sysinfo, String ieinfo){
		return userDao.userLogin(email, pwd, ipaddr, sysinfo, ieinfo);
	}
	
	public UserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	/***
	 * 保存用户
	 */
	public void saveUser(String Account,String pwd,String firstName,String secondName,String company,int roleId){
		this.userDao.saveUser(Account, pwd, firstName, secondName, company,roleId);
	}
	
	/**
	 * 获取PMU列表
	 * @param psno
	 * @return
	 */
	public Map findPmuByPsno(String psno){
		return this.userDao.findPmuByPsno(psno);
	}
	/**
	 * 保存电站信息
	 * @param stationname
	 * @param userId
	 * @param co2xs
	 * @param gainxs
	 * @param addr
	 * @param country
	 * @param city
	 * @return
	 */
	public int saveStaion( String stationname, String userId, String co2xs, String gainxs, String addr, String country, String city,String timezone,String money,String psno){
		return this.userDao.saveStaion(stationname, userId, co2xs, gainxs, addr, country, city,timezone,money,psno);
	}
	public int saveStation(String stationname,String phone,String email,String adminname,
			String longitude,String latitude,String hasl,String azimuth,
			String aoi,String desc,String co2xs,String gainxs,String masterid,String psno){
		return this.userDao.saveStation(stationname, phone, email, adminname, longitude, latitude, hasl, azimuth, aoi, desc, co2xs, gainxs, masterid, psno);
	}
	/**
	 * 保存pmu ID
	 * @param stationid
	 */
	public void updatePmuStation(int stationid,String psno ){
		this.userDao.updatePmuStation(stationid, psno);
	}
	/***
	 * 删除stationid
	 */
	public void delStation(int stationid){
		this.userDao.delStation(stationid);
	}
	/**
	 * 更新电站信息
	 * @param stationname
	 * @param phone
	 * @param email
	 * @param adminname
	 * @param longitude
	 * @param latitude
	 * @param hasl
	 * @param azimuth
	 * @param aoi
	 * @param desc
	 * @param co2xs
	 * @param gainxs
	 * @param masterid
	 * @return
	 */
	public void updateStation(int stationid,String stationname,String phone,String email,String adminname,
			String longitude,String latitude,String hasl,String azimuth,
			String aoi,String desc,String co2xs,String gainxs,String masterid){
		this.userDao.updateStation(stationid, stationname, phone, email, adminname, longitude, latitude, hasl, azimuth, aoi, desc, co2xs, gainxs, masterid);
	}
	public void updateStation(int stid,String stationname,String co2xs,String gainxs,String money,String timezone,String addr,String country,String city){
		this.userDao.updateStation(stid, stationname, co2xs, gainxs, money, timezone, addr, country, city);
	}
	/**
	 * 获取电站信息
	 */
	public Map getStationById(int stationid){
		return this.userDao.getStationById(stationid);
	}
	
	/***
	 * 获取电站下的所有PMU列表
	 */
	public List<Map> findStationPmu(int stationid,int pageNo,int pageSize){
		return this.userDao.findStationPmu(stationid,pageNo,pageSize);
	}
	/**
	 * 获取电站下所有PMU的个数
	 */
	public int findStationPmuCount(int stationid){
		return this.userDao.findStationPmuCount(stationid);
	}
	/***
	 * 分页获取某个电站的所有INV信息
	 */
	public List<Map> findStationInv(int stationid,int pageNo,int pageSize){
		return this.userDao.findStationInv(stationid, pageNo, pageSize);
	}
	/**
	 * 获取电站逆变器的所有信息
	 */
	public int findStationInvCount(int stationid){
		return this.userDao.findStationInvCount(stationid);
	}
	/**
	 * @param isno
	 * @param byName
	 */
	public void updateInvName(String isno,String byName){
		this.userDao.updateInvName(isno, byName);
	}
	/**
	 * 创建普通用户
	 * @param Account
	 * @param password
	 * @param firstName
	 * @param secondName
	 * @return
	 */
	public int createNormalUser(String Account,String password,String firstName,String secondName,int stationid,int createUserId) {
		return this.userDao.createNormalUser(Account, password, firstName, secondName, stationid,createUserId);
	}
	/**
	 * 获取电站用户
	 * @param stationid
	 * @return
	 */
	public List<Map> getUsersbyStationid(int stationid){
		return this.userDao.getUsersbyStationid(stationid);
	}
	/**
	 * 根据userId 删除用户
	 */
	public void deleteNormalUser(int userId){
		this.userDao.deleteNormalUser(userId);
	}
	/**
	 * 删除系统用户
	 * @param userId
	 */
	public void deleteSysUser(int userId){
		this.userDao.deleteSysUser(userId);
	}
	/**
	 * 更新用户信息
	 */
	public void updateUserInfo(int userId,String pwd,String firstName,String secondName){
		this.userDao.updateUserInfo(userId, pwd, firstName, secondName);
	}
	/**
	 * 更新用户权限
	 */
	public void updateUserLimits(int userId,int editStationLimit,int addPmuLimit,int delPmuLimit, int setReportLimit){
		this.userDao.updateUserLimits(userId, editStationLimit, addPmuLimit, delPmuLimit, setReportLimit);
	}
	/**
	 * 获取各种角色的用户
	 */
	public List<Map> getUsersByRole(int roleId){
		return this.userDao.getUsersByRole(roleId);
	}
	/**
	 * 创建系统管理员
	 */
	public void createSysAdmin(String email,String password,String requestDepartment,String firstName,String secondName,String phone,String fax){
		this.userDao.createSysAdmin( email, password, requestDepartment, firstName, secondName, phone, fax);
	}
	
	/**
	 * 更新系统管理员信息
	 * @param userid
	 * @param email
	 * @param password
	 * @param requestDepartment
	 * @param firstName
	 * @param secondName
	 * @param phone
	 * @param fax
	 */
	public void updateSysAdmin(int userid,String password,String requestDepartment,String firstName,String secondName,String phone,String fax){
		this.userDao.updateSysAdmin(userid, password, requestDepartment, firstName, secondName, phone, fax);
	}

	public String[] regUser(	final String email,final String pwd,final String firstName,final String secondName,final String company,final String question,final String answer,final String myurl,final String country,String city,final String state,final String address,final String postcode,final String tel,final String mobile){
		return this.userDao.regUser(email, pwd, firstName, secondName, company, question, answer, myurl, country,city, state, address, postcode, tel, mobile);
		
	}
	/**
	 * 用户账号邮件验证
	 * @param email
	 * @param listNo
	 * @return
	 */
	public String regUserVer(	final String email,final String listNo){
		return this.userDao.regUserVer(email, listNo);
		
		
	}

	public Map getUserRegInfo(String account){
		return this.userDao.getUserRegInfo(account);
	}
	public String editUserRegInfo(String account,String firstname,String secondname,String company,String webaddr,String country,String province,String city,String street,String zip,String telnum,String mobile){
		return this.userDao.editUserRegInfo(account, firstname, secondname, company, webaddr, country, province,city, street, zip, telnum, mobile);
		
	}
	public String changeUserPws(String account,String oldPws,String newPws){
		return this.userDao.changeUserPws(account, oldPws, newPws);
	}
	public String getCheckCode(	 String email){
		return this.userDao.getCheckCode(email);
	}
	public String updateUserPasswd(	 String email, String checkCode, String newpass){
		return this.userDao.updateUserPasswd(email, checkCode, newpass);
	}

	public String activeUserAccount(int userId,String checkCode){
		return this.userDao.activeUserAccount(userId, checkCode);
	}
}
