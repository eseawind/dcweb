package com.jstrd.asdc.service;

import java.util.List;
import java.util.Map;

public interface InverterService {
	/**
	 * 获得本日的某个ID逆变器产量
	 * @param Inverterid
	 * @return
	 */
	public Map findTpInverterById(int Inverterid);
	
	/**
	 * 获取某个逆变器的
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCPInverterByDate(String Inverterid,String date);
	/**
	 * 获取某个逆变器某日的近7天的DCP值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCPInverterByWeek(String Inverterid,String date);
	/***
	 * 获取某个电站下的逆变器
	 */
	public List<Map> findStationInv(int stationid);
	/**
	 * 获取某个逆变器某日的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCVInverterByDate(String Inverterid,String date);
	
	/**
	 * 获取某个逆变器某日的近7天的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCVInverterByWeek(String Inverterid,String date);
	/**
	 * 获取某个逆变器某日的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACPInverterByDate(String Inverterid,String date);
	
	/**
	 * 获取某个逆变器某日的近7天的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACPInverterByWeek(String Inverterid,String date);
	
	/**
	 * 获取某个逆变器某日的ACF值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACFInverterByDate(String Inverterid,String date);
	
	/**
	 * 获取某个逆变器某日的近7天的ACF值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACFInverterByWeek(String Inverterid,String date);
	/**
	 * 获取某个逆变器某日的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACVInverterByDate(String Inverterid,String date);
	
	/**
	 * 获取某个逆变器某日的近7天的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACVInverterByWeek(String Inverterid,String date);
	/**
	 * 获取某个逆变器某日的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCCInverterByDate(String Inverterid,String date);
	/**
	 * 获取某个逆变器某周的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findDCCInverterByWeek(String Inverterid,String date);
	
	
	/**
	 * 获取某个逆变器某日的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACCInverterByDate(String Inverterid,String date);
	/**
	 * 获取某个逆变器某周的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findACCInverterByWeek(String Inverterid,String date);
	/**
	 * 获取某个逆变器某日的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findTempInverterByDate(String Inverterid,String date);
	/**
	 * 获取某个逆变器某月的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<Object> findTempInverterByWeek(String Inverterid,String date);
	
	/**
	 * 获取电站7天的内的发电量收益 单位每天
	 */
	public List<Map> findIncomeby7days(String stationid,String date);
	/**
	 * 获取电站12个月的发电量收益 单位每月
	 */
	public List<Map> findIncomeBy12Months(String stationid,String date);
	/**
	 * 获取电站每年的发电量收益
	 */
	public List<Map> findIncomeByyear(String stationid,String date);
	
	/**
	 * 获取电站7天的内的二氧化碳减排量 单位每天
	 */
	public List<Map> findCo2Avby7days(String stationid,String date);
	/**
	 * 获取电站12个月的二氧化碳减排量单位每月
	 */
	public List<Map> findCo2AvBy12Months(String stationid,String date);
	/**
	 * 获取电站每年的二氧化碳减排量 单位每年
	 */
	public List<Map> findCo2AvByyear(String stationid,String date);
	/**
	 * 获取用户当前选择的ISNOS
	 */
	public List<Map> findIsnosByChart(String userId,String stationid,String type);
	/**
	 * 获取某个电站的所有逆变器
	 */
	public List<Map> findAllIsnosByStid(String stationid);
	/**
	 * 获取某个电站的所有设备
	 */
	public List<Map> findAllDeviceByStid(String stationid);
	/**
	 * 更新用户选择的逆变器
	 */
	public void updateUserChartByType(String stationid,String userid,String isnos,String type,String channels);
	/**
	 * 获取电站所有的PMU及逆变器
	 */
	public List<Map> getAllPmuAndInverter(int stationid);
	public List<Map> getPmuOrInverter(int stationid,String invName,String pino,String state);
}
