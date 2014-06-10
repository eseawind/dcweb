package com.jstrd.asdc.service;

import java.util.List;
import java.util.Map;

public interface UserLimitService {
	
	/**
	 * 获取用户权限
	 * @param userId
	 * @param roleId
	 * @return
	 */
	public Map getRoleLimt(int roleId);

	/**
	 * 获取所有用户
	 */
	public List<Map> getAllRoleLimit();
	
	public void updateRoleLimitsById(int roleId,String limitsStr);

	public Map getUserMenu(int userId,int stationId);
}
