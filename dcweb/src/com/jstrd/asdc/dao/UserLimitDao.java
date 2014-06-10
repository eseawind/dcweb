package com.jstrd.asdc.dao;

import java.util.List;
import java.util.Map;

/**
 * 获取用户权限
 * @author D.D.W by zbiti.com
 *
 * @date Feb 7, 2012
 */
public interface UserLimitDao {

	/**
	 * 获取用户权限
	 * @param userId
	 */
	public Map getRoleLimt(int roleId);

	/**
	 * 获取所有用户
	 */
	public List<Map> getAllRoleLimit();

	public void updateRoleLimitsById(int roleId,String limitsStr);
	public Map getUserMenu(int userId,int stationId);
}
