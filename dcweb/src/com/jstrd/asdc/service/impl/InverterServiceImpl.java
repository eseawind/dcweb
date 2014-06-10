package com.jstrd.asdc.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.jstrd.asdc.dao.InverterDao;
import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.util.DateUtil;

public class InverterServiceImpl implements InverterService{
	
	private InverterDao inverterDao;
	

	public InverterDao getInverterDao() {
		return inverterDao;
	}

	public void setInverterDao(InverterDao inverterDao) {
		this.inverterDao = inverterDao;
	}
	/**
	 * 获得本日的某个ID逆变器产量
	 * @param Inverterid
	 * @return
	 */
	public Map findTpInverterById(int Inverterid){
		return this.inverterDao.findTpInverterById(Inverterid);
	}
	
	/**
	 * 获取某个逆变器的
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCPInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCPInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("dcp"+k, 0f);
				}
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}

	/**
	 * 获取某个逆变器某日的近7天的DCP值
	 * @param Inverterid
	 * @return
	 * @throws ParseException 
	 */
	public List<Object> findDCPInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCPInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("dcp"+k, 0f);
				}
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekDCP(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekDCP(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				for(int j=1;j<=20;j++){
					float vpvtotal = (Float)isnoList.get(i+0).get("dcp"+j)+(Float)isnoList.get(i+1).get("dcp"+j)+(Float)isnoList.get(i+2).get("dcp"+j)+(Float)isnoList.get(i+3).get("dcp"+j)+(Float)isnoList.get(i+4).get("dcp"+j)+(Float)isnoList.get(i+5).get("dcp"+j);
					float vpv = vpvtotal/6;
					map.put("dcp"+j, vpv);
				}
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	/***
	 * 获取某个电站下的逆变器
	 */
	public List<Map> findStationInv(int stationid){
		return this.inverterDao.findStationInv(stationid);
	}
	
	/**
	 * 获取某个逆变器某日的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCVInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCVInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("vpv"+k, 0);
				}
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCVInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCVInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("vpv"+k, 0f);
				}
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekDCV(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekDCV(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				for(int j=1;j<=20;j++){
					float vpvtotal = (Float)isnoList.get(i+0).get("vpv"+j)+(Float)isnoList.get(i+1).get("vpv"+j)+(Float)isnoList.get(i+2).get("vpv"+j)+(Float)isnoList.get(i+3).get("vpv"+j)+(Float)isnoList.get(i+4).get("vpv"+j)+(Float)isnoList.get(i+5).get("vpv"+j);
					float vpv = vpvtotal/6;
					map.put("vpv"+j, vpv);
				}
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	/**
	 * 获取某个逆变器某日的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACPInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACPInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				map.put("pac", 0);
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACPInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACPInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				map.put("pac", 0f);
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekACP(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekACP(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				float vpvtotal = (Float)isnoList.get(i+0).get("pac")+(Float)isnoList.get(i+1).get("pac")+(Float)isnoList.get(i+2).get("pac")+(Float)isnoList.get(i+3).get("pac")+(Float)isnoList.get(i+4).get("pac")+(Float)isnoList.get(i+5).get("pac");
				float vpv = vpvtotal/6;
				map.put("pac", vpv);
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	
	/**
	 * 获取某个逆变器某日的ACF值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACFInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACFInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				map.put("acf", 0);
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的ACF值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACFInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACFInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				map.put("acf", 0f);
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekACF(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekACF(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				float vpvtotal = (Float)isnoList.get(i+0).get("acf")+(Float)isnoList.get(i+1).get("acf")+(Float)isnoList.get(i+2).get("acf")+(Float)isnoList.get(i+3).get("acf")+(Float)isnoList.get(i+4).get("acf")+(Float)isnoList.get(i+5).get("acf");
				float vpv = vpvtotal/6;
				map.put("acf", vpv);
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	/**
	 * 获取某个逆变器某日的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACVInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACVInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				map.put("vac1", 0);
				map.put("vac2", 0);
				map.put("vac3", 0);
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACVInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACVInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				for(int k=1;k<=3;k++){
					map.put("vac"+k, 0f);
				}
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekACV(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekACV(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				for(int j=1;j<=3;j++){
					float vpvtotal = (Float)isnoList.get(i+0).get("vac"+j)+(Float)isnoList.get(i+1).get("vac"+j)+(Float)isnoList.get(i+2).get("vac"+j)+(Float)isnoList.get(i+3).get("vac"+j)+(Float)isnoList.get(i+4).get("vac"+j)+(Float)isnoList.get(i+5).get("vac"+j);
					float vpv = vpvtotal/6;
					map.put("vac"+j, vpv);
				}
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	
	/**
	 * 获取某个逆变器某日的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCCInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCCInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("ipv"+k, 0);
				}
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	/**
	 * 获取某个逆变器某日的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACCInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACCInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				map.put("iac1", 0);
				map.put("iac2", 0);
				map.put("iac3", 0);
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}

	/**
	 * 获取某个逆变器某周的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACCInverterByWeek(String Inverterid,String date) {
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findACCInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				for(int k=1;k<=3;k++){
					map.put("iac"+k, 0f);
				}
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekACC(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekACC(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				for(int j=1;j<=3;j++){
					float vpvtotal = (Float)isnoList.get(i+0).get("iac"+j)+(Float)isnoList.get(i+1).get("iac"+j)+(Float)isnoList.get(i+2).get("iac"+j)+(Float)isnoList.get(i+3).get("iac"+j)+(Float)isnoList.get(i+4).get("iac"+j)+(Float)isnoList.get(i+5).get("iac"+j);
					float vpv = vpvtotal/6;
					map.put("iac"+j, vpv);
				}
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	/**
	 * 获取某个逆变器某周的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCCInverterByWeek(String Inverterid,String date) {
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findDCCInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				for(int k=1;k<=20;k++){
					map.put("ipv"+k, 0f);
				}
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekDCC(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekDCC(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			//System.out.println(isno+","+isnoList.size());
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				for(int j=1;j<=20;j++){
					float vpvtotal = (Float)isnoList.get(i+0).get("ipv"+j)+(Float)isnoList.get(i+1).get("ipv"+j)+(Float)isnoList.get(i+2).get("ipv"+j)+(Float)isnoList.get(i+3).get("ipv"+j)+(Float)isnoList.get(i+4).get("ipv"+j)+(Float)isnoList.get(i+5).get("ipv"+j);
					float vpv = vpvtotal/6;
					map.put("ipv"+j, vpv);
				}
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	
	
	/**
	 * 获取某个逆变器某日的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findTempInverterByDate(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findTempInverterByDate(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
//		System.out.println(queryInvList);
		//构造所有查询逆变器的空节点
		for(int i=0;i<queryInvList.size();i++){
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			for(int j=0;j<144;j++){
				Map map = new HashMap();
				map.put("tempval", 0);
				map.put("fen10", j+1);
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno,backList);
		}
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			tempMap.get(isno).set(fen10-1<0?0:fen10-1, mapList.get(i));
		}
		returnList.add(0,tempMap);
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	/**
	 * 获取某个逆变器某周的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findTempInverterByWeek(String Inverterid,String date){
		List<Object> returnList = new LinkedList();
		Map<String,List<Map>> tempMap = new HashMap<String,List<Map>>();
		List<List<Map>> mapNList = this.inverterDao.findTempInverterByWeek(Inverterid, date);
		if(mapNList==null){
			return null;
		}
		List<Map> queryInvList = mapNList.get(2);//查询的逆变器列表
		List<String> dateList = new ArrayList();
		try {
			dateList = DateUtil.getLastSeventDay(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取一周的时间节点
		//构造所有查询逆变器的空节点
		for (int i = 0; i < queryInvList.size(); i++) {
			List<Map> backList = new LinkedList<Map>();
			String isno = queryInvList.get(i).get("isno").toString();
			System.out.println(isno);
			for (int j = 0; j < 144 * 7; j++) {
				Map map = new HashMap();
				map.put("tempval", 0f);
				map.put("fen10", j + 1);
				map.put("recvdate", dateList.get(j / 144));
				map.put("isno", isno);
				backList.add(map);
			}
			tempMap.put(isno, backList);
		}
		
		//查询的结果列表
		List<Map> mapList = mapNList.get(0);
		for(int i=0;i<mapList.size();i++){
			String isno = mapList.get(i).get("isno").toString();
			String recvdate = mapList.get(i).get("recvdate").toString();
			int dateindex = dateList.indexOf(recvdate);
			int fen10 = Integer.parseInt(mapList.get(i).get("fen10").toString());
			fen10 = fen10-1<0?0:fen10-1;
			int index = dateindex*144+fen10;
			tempMap.get(isno).set(index, mapList.get(i));
		}
		returnList.add(0,getAvgWeekINVE(tempMap));
		returnList.add(1,mapNList.get(1));
		return returnList;
	}
	private Map<String,List<Map>> getAvgWeekINVE(Map<String,List<Map>> tempMap ){
		Map<String,List<Map>> backMap = new LinkedHashMap<String,List<Map>>();
		Iterator it  = tempMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			String isno = (String)pairs.getKey();
			List<Map> isnoList= (List<Map>)pairs.getValue();
			//System.out.println(isno+","+isnoList.size());
			List<Map> backList = new LinkedList<Map>();
			for (int i = 0; i < isnoList.size();) {
				Map map = new HashMap();
				int fen10 = (Integer)isnoList.get(i+5).get("fen10");
				String recvdate = isnoList.get(i).get("recvdate").toString();
				float vpvtotal = (Float)isnoList.get(i+0).get("tempval")+(Float)isnoList.get(i+1).get("tempval")+(Float)isnoList.get(i+2).get("tempval")+(Float)isnoList.get(i+3).get("tempval")+(Float)isnoList.get(i+4).get("tempval")+(Float)isnoList.get(i+5).get("tempval");
				float vpv = vpvtotal/6;
				map.put("tempval", vpv);
				map.put("fen10", fen10);
				map.put("recvdate", recvdate);
				map.put("isno", isno);
				backList.add(map);
				i=i+6;
			}
			backMap.put(isno, backList);
		}
		return backMap;

	}
	
	/**
	 * 获取电站7天的内的发电量收益 单位每天
	 */
	public List<Map> findIncomeby7days(String stationid,String date){
		Map<String,Integer> dateMap = new HashMap<String,Integer>();
		List<Map> backList = new LinkedList<Map>();
		try {
			List<String> dateList = DateUtil.getLastSeventDay(date);
			for(int i=0;i<dateList.size();i++){
				Map map = new HashMap();
				map.put("income", 0);
				map.put("recvdate", dateList.get(i));
				backList.add(map);
			}
			for(int i=0;i<backList.size();i++){
				dateMap.put(backList.get(i).get("recvdate").toString(), i);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<Map> mapList = this.inverterDao.findIncomeby7days(stationid, date);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			backList.set(dateMap.get(recvdate), mapList.get(i));
		}
		//System.out.println(backList);
		return backList;
	}
	/**
	 * 获取电站12个月的发电量收益 单位每月
	 */
	public List<Map> findIncomeBy12Months(String stationid,String date){
		Map<String,Integer> dateMap = new HashMap<String,Integer>();
		List<Map> backList = new LinkedList<Map>();
			List<String> dateList = DateUtil.getLast12Months(date.split("-")[0]+"-"+date.split("-")[1]);
			for(int i=0;i<dateList.size();i++){
				Map map = new HashMap();
				map.put("income", 0);
				map.put("recvdate", dateList.get(i));
				backList.add(map);
			}
			for(int i=0;i<backList.size();i++){
				dateMap.put(backList.get(i).get("recvdate").toString(), i);
			}
		
		List<Map> mapList = this.inverterDao.findIncomeBy12Months(stationid, date);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			backList.set(dateMap.get(recvdate), mapList.get(i));
		}
		//System.out.println(backList);
		return backList;
	}
	/**
	 * 获取电站每年的发电量收益
	 */
	public List<Map> findIncomeByyear(String stationid,String date){
		
		//System.out.println(backList);
		return this.inverterDao.findIncomeByyear(stationid, date);
	}
	
	/**
	 * 获取电站7天的内的二氧化碳减排量 单位每天
	 */
	public List<Map> findCo2Avby7days(String stationid,String date){
		Map<String,Integer> dateMap = new HashMap<String,Integer>();
		List<Map> backList = new LinkedList<Map>();
		try {
			List<String> dateList = DateUtil.getLastSeventDay(date);
			for(int i=0;i<dateList.size();i++){
				Map map = new HashMap();
				map.put("co2av", 0);
				map.put("recvdate", dateList.get(i));
				backList.add(map);
			}
			for(int i=0;i<backList.size();i++){
				dateMap.put(backList.get(i).get("recvdate").toString(), i);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<Map> mapList = this.inverterDao.findCo2Avby7days(stationid, date);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			backList.set(dateMap.get(recvdate), mapList.get(i));
		}
		//System.out.println(backList);
		return backList;
	}
	/**
	 * 获取电站12个月的二氧化碳减排量单位每月
	 */
	public List<Map> findCo2AvBy12Months(String stationid,String date){
		Map<String,Integer> dateMap = new HashMap<String,Integer>();
		List<Map> backList = new LinkedList<Map>();
			List<String> dateList = DateUtil.getLast12Months(date.split("-")[0]+"-"+date.split("-")[1]);
			for(int i=0;i<dateList.size();i++){
				Map map = new HashMap();
				map.put("co2av", 0);
				map.put("recvdate", dateList.get(i));
				backList.add(map);
			}
			for(int i=0;i<backList.size();i++){
				dateMap.put(backList.get(i).get("recvdate").toString(), i);
			}
		
		List<Map> mapList = this.inverterDao.findCo2AvBy12Months(stationid, date);
		for(int i=0;i<mapList.size();i++){
			String recvdate = mapList.get(i).get("recvdate").toString();
			backList.set(dateMap.get(recvdate), mapList.get(i));
		}
		//System.out.println(backList);
		return backList;
	}
	/**
	 * 获取电站每年的二氧化碳减排量 单位每年
	 */
	public List<Map> findCo2AvByyear(String stationid,String date){
		return this.inverterDao.findCo2AvByyear(stationid, date);
	}
	/**
	 * 获取用户当前选择的ISNOS
	 */
	public List<Map> findIsnosByChart(String userId,String stationid,String type){
		return this.inverterDao.findIsnosByChart(userId, stationid, type);
	}
	/**
	 * 获取某个电站的所有逆变器
	 */
	public List<Map> findAllIsnosByStid(String stationid){
		return this.inverterDao.findAllIsnosByStid(stationid);
	}
	/**
	 * 获取某个电站的所有设备
	 */
	public List<Map> findAllDeviceByStid(String stationid){
		return this.inverterDao.findAllDeviceByStid(stationid);
	}
	/**
	 * 更新用户选择的逆变器
	 */
	public void updateUserChartByType(String stationid,String userid,String isnos,String type,String channels){
		 this.inverterDao.updateUserChartByType(stationid, userid, isnos, type,channels);
	}
	/**
	 * 获取电站所有的PMU及逆变器
	 */
	public List<Map> getAllPmuAndInverter(int stationid){
		List<List<Map>> allList = this.inverterDao.getAllPmuAndInverter(stationid);
		List<Map> pmuList = allList.get(0);
		List<Map> invList = allList.get(1);
		Map<String,Map> pmuMap = new HashMap<String,Map>();
		for(int i=0;i<pmuList.size();i++){
			pmuMap.put(pmuList.get(i).get("psno").toString(), pmuList.get(i));
		}
		List<Map> backList =new LinkedList<Map>(); 
		String c_psno=""; 
		for(int i=0;i<invList.size();i++){
			String psno = invList.get(i).get("psno").toString();
			Map pmuItem =  pmuMap.get(psno);
			if(!c_psno.equals(psno)){
				if(pmuItem!=null){
					pmuItem.put("isPmu", "1");
					backList.add(pmuItem);
					pmuMap.remove(psno);
				}else{
					pmuItem = new HashMap();
					pmuItem.put("isPmu", "1");
					backList.add(pmuItem);
					pmuMap.remove(psno);
				}
				c_psno = psno;
			}
			Map invItem = invList.get(i);
			invItem.put("isPmu", "0");
			backList.add(invItem);
		}
		Iterator it = pmuMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			Map pmuItem = (Map) pairs.getValue();
			pmuItem.put("isPmu", "1");
			backList.add(pmuItem);
		}
		return backList;
	}
	
	public List<Map> getPmuOrInverter(int stationid,String invName,String pino,String state){
		List<List<Map>> allList = this.inverterDao.getPmuOrInverter(stationid,invName,pino,state);
		List<Map> pmuList = allList.get(0);
		List<Map> invList = allList.get(1);
		Map<String,Map> pmuMap = new HashMap<String,Map>();
		for(int i=0;i<pmuList.size();i++){
			pmuMap.put(pmuList.get(i).get("psno").toString(), pmuList.get(i));
		}
		List<Map> backList =new LinkedList<Map>(); 
		String c_psno=""; 
		for(int i=0;i<invList.size();i++){
			String psno = invList.get(i).get("psno").toString();
			Map pmuItem =  pmuMap.get(psno);
			if(!c_psno.equals(psno)){
				if(pmuItem!=null){
					pmuItem.put("isPmu", "1");
					backList.add(pmuItem);
					pmuMap.remove(psno);
				}
				c_psno = psno;
			}
			Map invItem = invList.get(i);
			invItem.put("isPmu", "0");
			backList.add(invItem);
		}
		Iterator it = pmuMap.entrySet().iterator();
		while (it.hasNext()){
			Map.Entry pairs = (Map.Entry)it.next();
			Map pmuItem = (Map) pairs.getValue();
			pmuItem.put("isPmu", "1");
			backList.add(pmuItem);
		}
		return backList;
	}
}
