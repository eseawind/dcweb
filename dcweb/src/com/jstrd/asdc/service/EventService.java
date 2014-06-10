package com.jstrd.asdc.service;

import java.util.List;
import java.util.Map;

public interface EventService {

	/***
	 * 获取电站的个数
	 * @param stationid
	 * @return
	 */
	public int getEventCountBySid(int stationid,String occdt1,String occdt2,Float approved,String isno,String e_level, int userId, String lang, int pageRows, int page);
	/**
	 * 获取电站的event
	 * @param stationid
	 * @return
	 */
	public List<Map> getEventByStationid(int stationid,String occdt1,String occdt2,Float approved,String isno,String e_level, int userId, String lang, int pageRows, int page);
	
	/***
	 * 根据ID删除event
	 */
	public void delEventById(int edid);
}
