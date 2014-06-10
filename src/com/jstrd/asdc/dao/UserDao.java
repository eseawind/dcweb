package com.jstrd.asdc.dao;

import java.util.List;
import java.util.Map;

public interface UserDao {

	/**
	 *获取用户的电站关系 
	 * @param userid
	 * @return
	 */
	public List<Object> findUserStations(int userid);
	/**
	 * 根据用户ID获取用户信息
	 */
	public Object findUserById(int userid);
	/**
	 * 根据用户email获取用户信息
	 */
	public Object findUserByEmail(String email);
	
	/**
	 * 根据用户email获取用户登信息
	 */
	public String userLogin(String email, String pwd, String ipaddr, String sysinfo, String ieinfo);
	
	/***
	 * 保存用户
	 */
	public void saveUser(String Account,String pwd,String firstName,String secondName,String company,int roleId);
	
	/**
	 * 获取PMU列表
	 * @param psno
	 * @return
	 */
	public Map findPmuByPsno(String psno);
	
	
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
	public int saveStaion(String stationname,String userId,String co2xs,String gainxs,String addr,String country,String city,String timezone,String money,String psno);
	
	public int saveStation(String stationname,String phone,String email,String adminname,
			String longitude,String latitude,String hasl,String azimuth,
			String aoi,String desc,String co2xs,String gainxs,String masterid,String psno);
	/**
	 * 保存pmu ID
	 * @param stationid
	 */
	public void updatePmuStation(int stationid,String psno);
	
	/***
	 * 删除stationid
	 */
	public void delStation(int stationid);
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
			String aoi,String desc,String co2xs,String gainxs,String masterid);
	public void updateStation(int stid,String stationname,String co2xs,String gainxs,String money,String timezone,String addr,String country,String city);
	/**
	 * 获取电站信息
	 */
	public Map getStationById(int stationid);
	/***
	 * 获取电站下的所有PMU列表
	 */
	public List<Map> findStationPmu(int stationid,int pageNo,int pageSize);
	/**
	 * 获取电站下所有PMU的个数
	 */
	public int findStationPmuCount(int stationid);
	/***
	 * 分页获取某个电站的所有INV信息
	 */
	public List<Map> findStationInv(int stationid,int pageNo,int pageSize);
	/**
	 * 获取电站逆变器的所有信息
	 */
	public int findStationInvCount(int stationid);
	/**
	 * 
	 * @param isno
	 * @param byName
	 */
	public void updateInvName(String isno,String byName);
	/**
	 * 创建普通用户
	 * @param Account
	 * @param password
	 * @param firstName
	 * @param secondName
	 * @return
	 */
	public int createNormalUser(String Account,String password,String firstName,String secondName,int stationid,int createUserId);
	/**
	 * 获取电站用户
	 * @param stationid
	 * @return
	 */
	public List<Map> getUsersbyStationid(int stationid);
	
	/**
	 * 根据userId 删除用户
	 */
	public void deleteNormalUser(int userId);
	/**
	 * 删除系统用户
	 * @param userId
	 */
	public void deleteSysUser(int userId);
	/**
	 * 更新用户信息
	 */
	public void updateUserInfo(int userId,String pwd,String firstName,String secondName);
	/**
	 * 更新用户权限
	 */
	public void updateUserLimits(int userId,int editStationLimit,int addPmuLimit,int delPmuLimit, int setReportLimit);

	/**
	 * 获取各种角色的用户
	 */
	public List<Map> getUsersByRole(int roleId);
	/**
	 * 创建系统管理员
	 */
	public void createSysAdmin(String email,String password,String requestDepartment,String firstName,String secondName,String phone,String fax);
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
	public void updateSysAdmin(int userid,String password,String requestDepartment,String firstName,String secondName,String phone,String fax);
	
	
	public String[] regUser(String email,String pwd,String firstName,String secondName,String company,String question,String answer,String myurl,String country,String city,String state,String address,String postcode,String tel,String mobile);
	/**
	 * 用户账号邮件验证
	 * @param email
	 * @param listNo
	 * @return
	 */
	public String regUserVer(String email,String listNo);	
	public Map getUserRegInfo(String account);
	public String editUserRegInfo(String account,String firstname,String secondname,String company,String webaddr,String country,String province,String city,String street,String zip,String telnum,String mobile);
	public String changeUserPws(String account,String oldPws,String newPws);
	public String getCheckCode(	 String email);
	public String updateUserPasswd(	 String email, String checkCode, String newpass);
	public String activeUserAccount(int userId,String checkCode);
}
