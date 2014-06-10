package com.jstrd.asdc.service.impl;

import java.util.List;
import java.util.Map;

import com.jstrd.asdc.dao.UserLimitDao;
import com.jstrd.asdc.service.UserLimitService;

public class UserLimitServiceImpl implements UserLimitService {
	
	private UserLimitDao userLimitDao;

	public UserLimitDao getUserLimitDao() {
		return userLimitDao;
	}

	public void setUserLimitDao(UserLimitDao userLimitDao) {
		this.userLimitDao = userLimitDao;
	}
	public Map getRoleLimt(int roleId){
		return userLimitDao.getRoleLimt(roleId);
	}

	/**
	 * 获取所有用户
	 */
	public List<Map> getAllRoleLimit(){
		return userLimitDao.getAllRoleLimit();
	}
	
	public void updateRoleLimitsById(int roleId,String limitsStr){
		 userLimitDao.updateRoleLimitsById( roleId, limitsStr);
	}

	public Map getUserMenu(int userId,int stationId){
		return this.userLimitDao.getUserMenu(userId, stationId);
		
	}
}
