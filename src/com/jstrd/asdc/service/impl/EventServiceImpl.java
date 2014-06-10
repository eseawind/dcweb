package com.jstrd.asdc.service.impl;

import java.util.List;
import java.util.Map;

import com.jstrd.asdc.dao.EventDao;
import com.jstrd.asdc.service.EventService;

public class EventServiceImpl implements EventService{

	private EventDao eventDao;
	/***
	 * 获取电站的个数
	 * @param stationid
	 * @return
	 */
	public int getEventCountBySid(int stationid,String occdt1,String occdt2,Float approved,String isno,String e_level, int userId, String lang, int pageRows, int page){
		return eventDao.getEventCountBySid(stationid, occdt1, occdt2, approved, isno, e_level,userId,lang,pageRows,page);
	}
	/**
	 * 获取电站的event
	 * @param stationid
	 * @return
	 */
	public List<Map> getEventByStationid(int stationid,String occdt1,String occdt2,Float approved,String isno,String e_level, int userId, String lang, int pageRows, int page){
		return eventDao.getEventByStationid(stationid,  occdt1,occdt2, approved, isno, e_level,userId,lang,pageRows,page);
	}
	
	/***
	 * 根据ID删除event
	 */
	public void delEventById(int edid){
		 eventDao.delEventById(edid);
	}
	
	public EventDao getEventDao() {
		return eventDao;
	}
	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}
}
