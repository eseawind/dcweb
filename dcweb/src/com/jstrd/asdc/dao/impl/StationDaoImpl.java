package com.jstrd.asdc.dao.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import oracle.jdbc.OracleTypes;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;

import com.jstrd.asdc.action.StationAction;
import com.jstrd.asdc.dao.StationDao;
import com.jstrd.asdc.util.DateUtil;
import org.apache.log4j.Logger;

@SuppressWarnings({"unchecked","unused"})
public class StationDaoImpl extends BaseDaoImpl implements StationDao {
	
	private static Logger logger = Logger.getLogger(StationDaoImpl.class);
	public StationDaoImpl() {
		
	}
	
	/**
	 * 获取电站的总发电量和昨日发电量
	 */
	public Map allStationInfo(){
		final String yesterDay = DateUtil.getYesterDay();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getsystempowerinfo(?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.CURSOR);
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中
				        	   tresultsMap.put("ETotal", rs.getFloat("E_Total"));
				        	   tresultsMap.put("EYesterday", rs.getFloat("E_last"));
				        	   tresultsMap.put("Co2Yesterday", rs.getFloat("Co2_last"));
				        	   tresultsMap.put("Co2Total", rs.getFloat("Co2_Total"));
				        	   tresultsMap.put("ETotal_unit", rs.getString("E_Total_u"));
				        	   tresultsMap.put("EYesterday_unit", rs.getString("E_last_u"));
				        	   tresultsMap.put("Co2Yesterday_unit", rs.getString("Co2_last_u"));
				        	   tresultsMap.put("Co2Total_unit", rs.getString("Co2_Total_u"));
				        	   tresultsMap.put("StationNumTotal", rs.getFloat("Station_Total"));
				        	   tresultsMap.put("StationNumYesterday", rs.getFloat("Station_last"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	/**
	 * 获取示例电站列表
	 */
	public Map sampleStationInfo(){
		final String yesterDay = DateUtil.getYesterDay();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getsharestationlist(?)}";// 调用的sql
				           
				           CallableStatement cs = con.prepareCall(storedProc);
				          
				           cs.registerOutParameter(1, OracleTypes.CURSOR);
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeQuery();
				           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
				           
				           while (rs.next()) {// 转换每行的返回值到Map中
				        	   tresultsMap.put("StationId", rs.getInt("StationId"));
				        	   tresultsMap.put("StationName", rs.getString("StationName"));
				        	   tresultsMap.put("IConIndex", rs.getString("IConIndex"));
				        	   tresultsMap.put("E_Today", DateUtil.getDblStr((rs.getObject("E_Today").toString())));
				        	   tresultsMap.put("E_Today_unit", rs.getString("E_Today_unit"));
				        	   tresultsMap.put("E_Total", DateUtil.getDblStr((rs.getObject("E_Total").toString())));
				        	   tresultsMap.put("E_Total_unit", rs.getString("E_Total_unit"));
				        	   tresultsMap.put("LUDT", rs.getString("LUDT"));
				        	   tresultsMap.put("Co2Val", rs.getFloat("Co2Val"));
				        	   tresultsMap.put("inval", rs.getFloat("inval"));
				        	   tresultsMap.put("iconindex", rs.getString("iconindex"));
				        	  
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	/**
	 * 获取用户所有电站的信息
	 */
	public List<Map> findOverview(final int userid){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getmystationlist(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, userid);// 设置输入参数的值
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   
			        	   if (rs.getInt("state")!=-1){
			        	   
		                   rowMap.put("stationid", rs.getString("stationid"));
		                   rowMap.put("stationname", rs.getString("stationname"));
		                   rowMap.put("invnum", rs.getString("inv1num"));
		                   rowMap.put("invtnum", rs.getString("invtnum"));
		                   rowMap.put("pmunum", rs.getString("pmu1num"));
		                   rowMap.put("pmutnum", rs.getString("pmutnum"));
		                   rowMap.put("iconindex", rs.getString("iconindex"));
		                   rowMap.put("ludt", rs.getString("ludt"));
		                   rowMap.put("iconindex", rs.getString("iconindex"));
		                   rowMap.put("ludt", rs.getString("ludt"));
		                   rowMap.put("etoday", rs.getFloat("e_today"));
		                   rowMap.put("etoday_unit", rs.getString("e_today_unit"));
		                   rowMap.put("etotal", rs.getFloat("e_total"));
		                   rowMap.put("etotal_unit", rs.getString("e_total_unit"));
		                   rowMap.put("Co2Val", rs.getFloat("co2val"));
		                   rowMap.put("co2val_unit", rs.getString("co2val_unit"));
		                   rowMap.put("inval", rs.getFloat("inval"));
		                   rowMap.put("state", rs.getInt("state"));
		                   rowMap.put("inval_unit", rs.getString("inval_unit"));
		                   rowMap.put("eve0num", rs.getString("eve0num"));
		                   rowMap.put("roleid", rs.getInt("roleid"));
		                   resultsList.add(rowMap);
			        	   }
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/**
	 * 更换背景图片
	 * @param stationid
	 * @param bgUrl
	 */
	public void updateStationBg(int stationid,String bgUrl){
		String sql = " update tb_station set bgurl=? where stationid=? ";
		this.getJdbcTemplate().update(sql,new Object[]{bgUrl,stationid});
	}
	/**
	 * 更换头像图片
	 * @param stationid
	 * @param bgUrl
	 */
	public void updateStationIc(int stationid,String bgUrl){
		String sql = " update tb_station set iconindex=? where stationid=? ";
		this.getJdbcTemplate().update(sql,new Object[]{bgUrl,stationid});
	}
	/**
	 * 根据ID获得电站信息
	 * @param stationid
	 * @return
	 */
	public Map findStationById(final int stationid){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getstationdynamic(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setBigDecimal(1, new BigDecimal(stationid));
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("etoday", rs.getFloat("e_today"));
				        	   tresultsMap.put("etoday_unit", rs.getString("e_today_unit"));
				        	   tresultsMap.put("emonth", rs.getFloat("e_month")); 
				        	   tresultsMap.put("emonth_unit", rs.getString("e_month_unit"));   
				        	   tresultsMap.put("etotal", rs.getFloat("e_total"));
				        	   tresultsMap.put("etotal_unit", rs.getString("e_total_unit"));
				        	   tresultsMap.put("Co2Val", rs.getFloat("co2val"));
				        	   tresultsMap.put("co2val_unit", rs.getString("co2val_unit"));
				        	   tresultsMap.put("inval", rs.getFloat("inval"));
				        	   tresultsMap.put("inval_unit", rs.getString("inval_unit"));
				        	   tresultsMap.put("BGURL", rs.getString("BGURL"));
				        	   tresultsMap.put("stationname", rs.getString("stationname"));
				        	   tresultsMap.put("iconindex", rs.getString("iconindex"));
				        	   tresultsMap.put("pmu1num", rs.getString("pmu1num"));
				        	   tresultsMap.put("pmutnum", rs.getString("pmutnum"));
				        	   tresultsMap.put("inv1num", rs.getString("inv1num"));
				        	   tresultsMap.put("invtnum", rs.getString("invtnum"));
				        	   tresultsMap.put("eve0num", rs.getString("eve0num"));
				        	   tresultsMap.put("evetnum", rs.getString("evetnum"));
				        	   tresultsMap.put("ludt", rs.getString("ludt"));
				        	   tresultsMap.put("admin", rs.getString("firstname")+rs.getString("secondname"));
				        	   tresultsMap.put("curdt", rs.getString("curdt"));
				        	   tresultsMap.put("account", rs.getString("account"));
			                   //break;
				           }
				           //rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	/**
	 * 获取
	 * 电站本日发电量
	 * 本月发电量
	 * 本年发电量
	 * 总收益
	 * @param stationid
	 * @return
	 */
	public Map getStationInfoById(final int stationid){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getstationdynamic(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setBigDecimal(1, new BigDecimal(stationid));
				           cs.registerOutParameter(2, OracleTypes.CURSOR);
				           return cs;
				         
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中
				        	   tresultsMap.put("etoday", rs.getFloat("e_today"));
				        	   tresultsMap.put("etoday_unit", rs.getString("e_today_unit"));
				        	   tresultsMap.put("emonth", rs.getFloat("e_month")); 
				        	   tresultsMap.put("emonth_unit", rs.getString("e_month_unit"));   
				        	   tresultsMap.put("etotal", rs.getFloat("e_total"));
				        	   tresultsMap.put("etotal_unit", rs.getString("e_total_unit"));
				        	   tresultsMap.put("Co2Val", rs.getString("co2val"));
				        	   tresultsMap.put("co2val_unit", rs.getString("co2val_unit"));
				        	   tresultsMap.put("inval", rs.getFloat("inval"));
				        	   tresultsMap.put("inval_unit", rs.getString("inval_unit"));
				        	   tresultsMap.put("BGURL", rs.getString("BGURL"));
				        	   tresultsMap.put("stationname", rs.getString("stationname"));
				        	   tresultsMap.put("iconindex", rs.getString("iconindex"));
				        	   tresultsMap.put("pmu1num", rs.getString("pmu1num"));
				        	   tresultsMap.put("pmutnum", rs.getString("pmutnum"));
				        	   tresultsMap.put("inv1num", rs.getString("inv1num"));
				        	   tresultsMap.put("invtnum", rs.getString("invtnum"));
				        	   tresultsMap.put("eve0num", rs.getString("eve0num"));
				        	   tresultsMap.put("evetnum", rs.getString("evetnum"));
				        	   tresultsMap.put("ludt", rs.getString("ludt"));
				        	   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	/**
	 * 获取今日发电明细
	 * yyyy-MM-dd
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationTpList(final int stationid,final String today){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationpowerdaily(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationid);
			           cs.setString(2, today);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                  // rowMap.put("recvdate", rs.getString("recvdate"));
		                   rowMap.put("time", rs.getString(1));
		                   rowMap.put("no", rs.getInt(2));
		                   rowMap.put("value",  rs.getFloat(3));
		                   rowMap.put("unit", rs.getString(4));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取本月发电总量明细
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationMpList(final int stationid,final String today){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_station_power_month(?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationid);
			           cs.setString(2, today);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           cs.registerOutParameter(5, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("time", rs.getString(1));
		                   rowMap.put("no", rs.getInt(2));
		                   rowMap.put("value", rs.getFloat(3));
		                   rowMap.put("unit", rs.getString(4));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取本年发电总量明细
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationYpList(final int stationid,final String year){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_station_power_year(?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationid);
			           cs.setString(2, year);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           cs.registerOutParameter(5, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("time", rs.getString(1));
		                   rowMap.put("no", rs.getInt(2));
		                   rowMap.put("value", rs.getFloat(3));
		                   rowMap.put("unit", rs.getString(4));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取所有发电量明细
	 * @param stationid
	 * @return
	 */
	public List<Map> findStationApList(final int stationid){
		final String day = DateUtil.getToday();
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_station_power_all(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationid);
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
			           int i=0;
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   i++;
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("time", rs.getString(1));
		                   rowMap.put("no", i+"");
		                   rowMap.put("value", rs.getFloat(2));
		                   rowMap.put("unit", rs.getString(3));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	
	public static void main(String[] args){
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			System.out.println(sdf1.parse("1970-01-01 00:00:00").getTime());;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long time = 143*10*60*1000+(-28800000);
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		
		System.out.println(sdf.format(time));
	}
	
	/**
	 * 获取示例电站列表
	 * @return
	 */
	public List<Map> findExcampleStationInfo(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getsharestationlist(?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("stationid", rs.getString("stationid"));
		                   rowMap.put("stationname", rs.getString("stationname"));
		                   rowMap.put("invnum", rs.getString("inv1num"));
		                   rowMap.put("invtnum", rs.getString("invtnum"));
		                   rowMap.put("pmunum", rs.getString("pmu1num"));
		                   rowMap.put("pmutnum", rs.getString("pmutnum"));
		                   rowMap.put("iconindex", rs.getString("iconindex"));
		                   rowMap.put("ludt", rs.getString("ludt"));
		                   rowMap.put("iconindex", rs.getString("iconindex"));
		                   rowMap.put("ludt", rs.getString("ludt"));
		                   rowMap.put("etoday", rs.getFloat("e_today"));
		                   rowMap.put("etoday_unit", rs.getString("e_today_unit"));
		                   rowMap.put("etotal", rs.getFloat("e_total"));
		                   rowMap.put("etotal_unit", rs.getString("e_total_unit"));
		                   rowMap.put("Co2Val", rs.getFloat("co2val"));
		                   rowMap.put("co2val_unit", rs.getString("co2_unit"));
		                   rowMap.put("inval", rs.getFloat("inval"));
		                   rowMap.put("inval_unit", rs.getString("inval_unit"));
		                   rowMap.put("eve0num", rs.getString("eve0num"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	
	/**
	 * 管理员
	 * 获取所有电站列表
	 * @return
	 */
	public List<Map> findAllStationInfo(final String country, final String state, final String stationName, final String account, final int status, final int pageNo, final int pageSize){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	 String storedProc = "{call sp_web_querystationpageexex(?,?,?,?,?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setString(1, country);
				           cs.setString(2, state);
				           cs.setString(3, stationName);
				           cs.setInt(4, pageSize);
				           cs.setString(5, account);
				           cs.setInt(6, status);
				           cs.setInt(7, pageNo);
				           cs.registerOutParameter(8, OracleTypes.VARCHAR);
				           cs.registerOutParameter(9, OracleTypes.CURSOR);
				           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(9);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("stationid", rs.getString("stationid"));
		                   rowMap.put("stationname", rs.getString("stationname"));
		                   rowMap.put("country", rs.getString("country"));
		                   rowMap.put("province", rs.getString("province"));
		                   rowMap.put("city", rs.getString("city"));
		                   rowMap.put("createdt", rs.getString("createdt"));
		                   rowMap.put("totalpower", rs.getString("totalpower"));
		                   rowMap.put("ludt", rs.getString("ludt"));
		                   rowMap.put("account", rs.getString("account"));
		                   rowMap.put("isselect", rs.getString("isselect"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/**
	 * 获取所有电站的个数
	 * @return
	 */
	public int findAllStationCount(final String country, final String state, final String stationName, final String account, final int status, final int pageNo, final int pageSize){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_querystationpageexex(?,?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, country);
			           cs.setString(2, state);
			           cs.setString(3, stationName);
			           cs.setInt(4, pageSize);
			           cs.setString(5, account);
			           cs.setInt(6, status);
			           cs.setInt(7, pageNo);
			           cs.registerOutParameter(8, OracleTypes.VARCHAR);
			           cs.registerOutParameter(9, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           cs.executeUpdate();
			           String rs = (String) cs.getObject(8);// 获取游标一行的值
			           return rs;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	
	
	/**
	 * 获取国家列表
	 */
	public List<Map> getContryList(final String lang){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getcountrylist(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, lang);// 设置输入参数的值
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("c_code", rs.getString("c_code"));
		                   rowMap.put("countryname", rs.getString("countryname"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取国家列表
	 */
	public List<Map> getStateList(final int country,final String lang){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getprovincelist(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, country);// 设置输入参数的值
			           cs.setString(2, lang);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("c_code", rs.getString("pid"));
		                   String p= rs.getString("provincename");
		                  
		                   rowMap.put("countryname", p);
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/**
	 * 获取国家列表
	 */
	public List<Map> getChartDataCo27Day(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationco2_7day(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("co2val"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 网站获得逆变器列表及当前设备状态  */
	public List<Map> findUserStationInv(final int userId,final int stationId){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getuserstationinv(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, userId);// 设置输入参数的值
			           cs.setBigDecimal(2,  new BigDecimal(stationId));// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs.getString("isno"));
		                   rowMap.put("isname", rs.getString("byname"));
		                   rowMap.put("state", rs.getString("state"));
		                   rowMap.put("etoday", DateUtil.getDblStr(rs.getString("e_today")));
		                   rowMap.put("etoday_u", rs.getString("e_today_u"));
		                   rowMap.put("etotal", DateUtil.getDblStr(rs.getString("e_total")));
		                   rowMap.put("etotal_u", rs.getString("e_total_u"));
		                   rowMap.put("pac", DateUtil.getDblStr(rs.getString("pac")));
		                   rowMap.put("pac_u", rs.getString("pac_u"));
		                   rowMap.put("pacmax", DateUtil.getDblStr(rs.getString("pacmax")));
		                   rowMap.put("pacmax_u", rs.getString("pacmax_u"));
		                   rowMap.put("et_percent", DateUtil.getDblStr(rs.getString("et_percent")));
		                   rowMap.put("eve0num", DateUtil.getDblStr(rs.getString("eve0num")));
		                   rowMap.put("isselect", rs.getString("isselect"));
		                   resultsList.add(rowMap);
			           }
			           
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/**
	 *
	 */
	public List<Map> getChartDataCo212Month(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationco2_12m(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("co2val"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 
	 */
	public List<Map> getChartDataCo2OneYear(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationco2_year(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("co2val"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 
	 */
	public List<Map> getChartDataCo2Total(final int stationId){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationco2_all(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("co2val"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	/**
	 * 
	 */
	public List<Map> getChartDataGain7Day(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationgain_7day(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("gainval"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	/**
	 * 
	 */
	public List<Map> getChartDataGain12Month(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationgain_12m(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("gainval"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 
	 */
	public List<Map> getChartDataGainOneYear(final int stationId,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationgain_year(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("gainval"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	/**
	 * 
	 */
	public List<Map> getChartDataGainTotal(final int stationId){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationgain_all(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("time", rs.getString("recvDate"));
		                   rowMap.put("data", rs.getFloat("gainval"));
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 根据逆变器编号及指定日期获取逆变器每10分钟交流频率值数据  */
	public List<Map> getChartDataFACDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_fac_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定日期某台逆变器的所选择各通道查询日期前七天的Fac曲线图  */
	public List<Map> getChartDataFAC7Day(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_fac_7dayex(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);
			           cs.setString(2, isno);	
			           cs.setString(3, date);	
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	
	
	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟交流电流值数据  */
	public List<Map> getChartDataIAC7Day(final int stationId,final String isno,final String date){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_iac_7dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期的10分钟交流电流值数据  */
	public List<Map> getChartDataIACDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_iac_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	
	
	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟交流电压值数据  */
	public List<Map> getChartDataVAC7Day(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_vac_7dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期的10分钟交流电压值数据  */
	public List<Map> getChartDataVACDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_vac_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟直流电流值数据  */
	public List<Map> getChartDataIDC7Day(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_idc_7dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期的10分钟直流电压值数据  */
	public List<Map> getChartDataIDCDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_idc_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟直流电压值数据  */
	public List<Map> getChartDataVDC7Day(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_vdc_7dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟直流电压值数据  */
	public List<Map> getChartDataVDCDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_vdc_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
			        	   rowMap.put("date", rs.getString("recvDt"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期前七天(包括指定当天)10分钟温度数据  */
	public List<Map> getChartDataTemp7Day(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_temp_7dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("date", rs.getString("recvDt"));
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站，指定逆变器列表，指定日期的10分钟温度数据  */
	public List<Map> getChartDataTempDay(final int stationId,final String isno,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_temp_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, isno);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("date", rs.getString("recvDt"));
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public String getDotStr(String ss,int num){
	  	if (ss.equals("") || (ss.indexOf(".")==-1) )
	  		return ss;
	  	String ssd=ss.substring(ss.indexOf(".")+1,ss.length());
	  	if (ssd.length()<=num)
	  		return ss;
	  	ssd=ssd.substring(0,num);
	  	ss=ss.substring(0,ss.indexOf(".")+1)+ssd;
	  	return ss;
	}
	
	/** 查询指定电站,指定逆变器，指定日期的10分钟发电量(PAC)数据  */
	public List<Map> getChartDataEnergyDay(final int stationId,final String invtList,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_energy_dayex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, invtList);// 设置输入参数的值
			           cs.setString(3, date);// 设置输入参数的值
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   int dataNum=rs.getInt("res_num");
		                  rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站,指定逆变器列表，指定月份各天的发电量情况  */
	public List<Map> getChartDataEnergyMonth(final int stationId,final String invtList,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	String storedProc = "{call sp_get_inv_energy_monthex(?,?,?,?,?,?)}";// 调用的sql
			        	CallableStatement cs = con.prepareCall(storedProc);
			        	cs.setInt(1, stationId);// 设置输入参数的值
			        	cs.setString(2, invtList);// 设置输入参数的值
			        	cs.setString(3, date);// 设置输入参数的值
			        	cs.registerOutParameter(4, OracleTypes.VARCHAR);
			        	cs.registerOutParameter(5, OracleTypes.VARCHAR);
			        	cs.registerOutParameter(6, OracleTypes.CURSOR);
			        	return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(6); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("recvdate"));
		                   rowMap.put("idd", rs.getString("idd"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("e_total_unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站,指定逆变器列表，指定年份各月的发电量情况  */
	public List<Map> getChartDataEnergyYear(final int stationId,final String invtList,final String date){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	 String storedProc = "{call sp_get_inv_energy_yearex(?,?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1, stationId);// 设置输入参数的值
				           cs.setString(2, invtList);// 设置输入参数的值
				           cs.setString(3, date);// 设置输入参数的值
				           cs.registerOutParameter(4, OracleTypes.VARCHAR);
				           cs.registerOutParameter(5, OracleTypes.VARCHAR);
				           cs.registerOutParameter(6, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(6); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("recvdate"));
		                   rowMap.put("idd", rs.getString("idd"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("e_total_unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 查询指定电站,指定逆变器列表，各年发电量情况  */
	public List<Map> getChartDataEnergyTotal(final int stationId,final String invtList){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_get_inv_energy_totalex(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationId);// 设置输入参数的值
			           cs.setString(2, invtList);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("isno", rs.getString("isno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("time", rs.getString("year"));
		                   int dataNum=rs.getInt("res_num");
		                   rowMap.put("datanum",dataNum);
		                   for (int i=1;i<=dataNum;i++){
		                	   rowMap.put("data"+i, rs.getFloat("data"+i));
		                   }
		                   rowMap.put("dataunit", rs.getString("e_total_unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	
	public void updateInvListForUser(final int userId ,final int stationId,final String invtList){
		jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_updateinvlistforuser(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, userId);
			           cs.setInt(2, stationId);
			           cs.setString(3, invtList);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.executeUpdate(); 
			          return null; 
			     } 
			  }); 
		

	}
	
	/** 指定语言，提取页面时区列表信息 */
	public List<Map> getTimezoneList(final String lang){
		List resultList = (List) jdbcTemplate.execute(
				new CallableStatementCreator() {
					public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_gettimezonelist(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, lang);// 设置输入参数的值
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
				}, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("code", rs.getString("areacode"));
		                   rowMap.put("key", rs.getString("keyval"));
		                   rowMap.put("name", rs.getString("areaname"));
		                   rowMap.put("isdst", rs.getString("isdst"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/** 指定语言,客户端时区    提取时区对应的key */
	public int getTimezoneListEx(final String lang, final String clientzonestr){
		Integer res = (Integer) jdbcTemplate.execute(
				new CallableStatementCreator() {
					public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_gettimezonelistex(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, lang);	
			           cs.setString(2, clientzonestr);
			           cs.registerOutParameter(3, OracleTypes.INTEGER);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
				}, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			        	cs.executeUpdate();
			        	Integer rs = (Integer) cs.getObject(3);
				        return rs;
			        }
			   });
		return res;
	}
	
	/** 获得当前可选择的货币符号列表  */
	public List<Map> getCurrencyList(){
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getcurrencylist(?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("currency", rs.getString("currency"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	public List<Map> getSystemGainxsList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_getsystemgainxslist(?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("gainxs", rs.getString("gainxs"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public List<Map> getSsystemCo2xsList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_getsystemco2xslist(?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("gainxs", rs.getString("gainxs"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public int createNewStation(final int userId,final String stationname,final String picurl,final String startdt,final float installcap,final String company,final String country,final String city,final String street,final String state,final String zip,final String jd,final String wd,final float height,final float insangle,final float co2rate,final float incomerate,final String currency,final int timezone,final int timezonex, final int customerflag){
		
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_create_stationex(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql 
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1,userId);
			           String s=stationname;
			           try{
			        	//   s = new String(s.getBytes( "UTF-8"));   
			           // s=new String(s.getBytes(),"UTF-8");    
			           
			          // s= new String(s.getBytes("GBK")); 
			           }catch(Exception e){
			        	   
			           }
				       	cs.setString(2,s);//电站名称
				       	cs.setString(3,picurl);//电站图片URL
				       	cs.setString(4,startdt);//并网发电日期--
				       	cs.setFloat(5,installcap);//装机容量--
					    cs.setString(6,company);//国家名称--
					    cs.setString(7,country);//国家名称--
				       	cs.setString(8,city);//城市名称--
				       	cs.setString(9,street);//所在街道--
				       	cs.setString(10,state);//省份
				       	cs.setString(11,zip);//邮编
				       	cs.setString(12,jd);//经度:(东经23度，37分，30秒，格式为:e:23-27-30,西经为:w:23-27-30)
				       	cs.setString(13,wd);//纬度:(北纬132度,30分，27秒，格式为:n:132-30-27,南纬为:s:132-30-37)
				       	cs.setFloat(14, height);//海拔单位（米）
				       	cs.setFloat(15,insangle);//安装倾向角
				       	cs.setFloat(16, co2rate);//二氧化碳减排系数
				       	cs.setFloat(17, incomerate);//电站收益系数
				       	cs.setString(18,currency);//货币单位
				       	cs.setInt(19,timezone );//电站所在时区，东正,西负
				       	cs.setInt(20,timezonex);//时间记录编号
			           cs.registerOutParameter(21, OracleTypes.NUMBER);// 注册输出参数的类型 
			           cs.setInt(22,customerflag );
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String returns=cs.getString(21);
			           return returns;// 获取输出参数的值 
			     } 
			  }); 
		return Integer.parseInt(res);
	}
	
	public void updateStationInfo(final int stationId,final String stationname,final String picurl,final String startdt,final float installcap,final String company,final String country,final String city,final String street,final String state,final String zip,final String jd,final String wd,final float height,final float insangle,final float co2rate,final float incomerate,final String currency,final Float timezone,final int timezonex, final float etotaloffset, final int customerflag){
		jdbcTemplate.execute( 
		     new CallableStatementCreator() { 
		        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
		           String storedProc = "{call sp_web_updatestationinfoex(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql 
		           CallableStatement cs = con.prepareCall(storedProc); 
		           cs.setInt(1,stationId);
			       cs.setString(2,stationname);//电站名称
			       cs.setString(3,picurl);//电站图片URL
			       cs.setString(4,startdt);//并网发电日期--
			       cs.setFloat(5, installcap);//装机容量--
				   cs.setString(6,company);//国家名称--
				   cs.setString(7,country);//国家名称--
			       cs.setString(8,city);//城市名称--
			       cs.setString(9,street);//所在街道--
			       cs.setString(10,state);//省份
			       cs.setString(11,zip);//邮编
			       cs.setString(12,jd);//经度:(东经23度，37分，30秒，格式为:e:23-27-30,西经为:w:23-27-30)
			       cs.setString(13,wd);//纬度:(北纬132度,30分，27秒，格式为:n:132-30-27,南纬为:s:132-30-37)
			       cs.setFloat(14, height);//海拔单位（米）
			       cs.setFloat(15, insangle);//安装倾向角
			       cs.setString(16, co2rate+"");
			       cs.setString(17, incomerate+"");//电站收益系数
			       cs.setString(18,currency);//货币单位 
			       cs.setFloat(19,timezone );//电站所在时区，东正,西负
			       cs.setInt(20,timezonex);//时间记录编号
			       cs.setString(21,etotaloffset+"");//etotal偏移值
			       cs.setInt(22,customerflag);//执行夏令时标志
		           return cs; 
		        } 
		     }, new CallableStatementCallback() { 
		         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
		        	cs.execute();
		        	return null;// 获取输出参数的值 
		         } 
		  }); 
	}
	
	public String checkPMuinValid(final String psno,final String id){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_checkpmuinvalid(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setString(1,psno);
				    	cs.setString(2,id);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(3); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	public String stationBindPM(final int stationId,final String psno,final String id,final String opdate){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_stationbindpmu(?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setInt(1,stationId);
				       	cs.setString(2,psno);
				    	cs.setString(3,id);
				    	cs.setString(4,opdate);
			           cs.registerOutParameter(5, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(5); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	public String stationUnBindPM(final int stationId,final String psno,final String serialno,final String opdate){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_stationunbindpmuex(?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setInt(1,stationId);
				       	cs.setString(2,psno);
				       	cs.setString(3,serialno);
				       	cs.setString(4,opdate);
			           cs.registerOutParameter(5, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(5); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	
	public List<Map> getInvTypeList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getinvtypelist(?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("type", rs.getString("devtypename"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public List<Map> getInvPinpaiList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getinvtypelist(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("model", rs.getString("penpai"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public List<Map> getInvFactoryList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getinvtypelist(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("factoryname", rs.getString("factoryname"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public List<Map> findInvList(final String stationName,final String type,final String listno,final int pagecols,final int page){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_query_inv_pageex(?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, stationName);
			           cs.setString(2, type);
			           cs.setString(3, listno);
			           cs.setBigDecimal(4, new BigDecimal( pagecols));
			           cs.setBigDecimal(5, new BigDecimal( page));
			           cs.registerOutParameter(6, OracleTypes.NUMBER);
			           cs.registerOutParameter(7,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(7);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("psno", rs.getString("isno"));
		                   rowMap.put("factoryname", rs.getString("factoryname"));
		                   rowMap.put("penpai", rs.getString("penpai"));
		                   rowMap.put("invtype", rs.getString("invtype"));
		                   rowMap.put("state", rs.getInt("state")+"");
		                   rowMap.put("stationname", rs.getString("stationname"));
			        	   rowMap.put("country", rs.getString("country"));
		                   rowMap.put("city", rs.getString("city"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public int findInvPageNum(final String stationName,final String type,final String listno,final int pagecols,final int page){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_query_inv_pageex(?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, stationName);
			           cs.setString(2, type);
			           cs.setString(3, listno);
			           cs.setBigDecimal(4, new BigDecimal( pagecols));
			           cs.setBigDecimal(5, new BigDecimal( page));
			           cs.registerOutParameter(6, OracleTypes.NUMBER);
			           cs.registerOutParameter(7,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(6);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	public List<Map> getInvAnalyTypeList(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_inv_analyex(?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.DECIMAL);
				           cs.registerOutParameter(2, OracleTypes.DECIMAL);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);
				           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("pt", rs.getString(1));
		                   rowMap.put("pn", rs.getString(2));
		                   rowMap.put("pp", rs.getFloat(3));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public List<Map> getInvAnalyCountryList(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_inv_analyex(?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.DECIMAL);
				           cs.registerOutParameter(2, OracleTypes.DECIMAL);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);
				           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("context", rs.getString(1));
		                   rowMap.put("pn", rs.getString(2));
		                   rowMap.put("pp", rs.getFloat(3));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public int getInvAnalyTotalType(){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_inv_analyex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.DECIMAL);
			           cs.registerOutParameter(2, OracleTypes.DECIMAL);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(1);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	public int getInvAnalyTotalCountry(){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_inv_analyex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.DECIMAL);
			           cs.registerOutParameter(2, OracleTypes.DECIMAL);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(2);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	
	public Map getInvInfo(final String psno){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getinvinfo(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setString(1,psno);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   //tresultsMap.put("isno", rs.getString("isno"));
				        	   //tresultsMap.put("psno", rs.getString("psno"));
				        	   tresultsMap.put("createdt", rs.getString("createdt")); 
				        	   tresultsMap.put("devname", rs.getString("devname"));   
				        	   tresultsMap.put("factoryname", rs.getString("factoryname"));
				        	   tresultsMap.put("penpai", rs.getString("penpai"));
				        	   tresultsMap.put("softver", rs.getString("softver"));
				        	   tresultsMap.put("hardver", rs.getString("hardver"));   
				        	   tresultsMap.put("e_total", rs.getString("e_total")+" "+rs.getString("e_total_u"));
				        	   tresultsMap.put("h_total", rs.getString("h_total"));
				        	   //tresultsMap.put("state", rs.getString("state"));
				        	   tresultsMap.put("devtypename", rs.getString("devtypename"));
				        	   tresultsMap.put("byname", rs.getString("byname"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	public List<Map> getStationDeviceex(final int stationId){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_getstationdeviceex(?,?)}";// 调用的sql
			        	  CallableStatement cs = con.prepareCall(storedProc);
			        	  cs.setInt(1, stationId);// 设置输入参数的值
				           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("devtyp", rs.getString("devtyp"));
		                   rowMap.put("devno", rs.getString("devno"));
			        	   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("kind", rs.getString("kind"));
			        	   rowMap.put("state", rs.getString("state"));
		                   rowMap.put("newnum", rs.getString("newnum"));
			        	   rowMap.put("totalnum", rs.getString("totalnum"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public Map getDevInfo(final String psno){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getdeviceinfoex(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setString(1,psno);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("ssno", rs.getString("ssno"));
				        	   tresultsMap.put("typename", rs.getString("typename"));
				        	   tresultsMap.put("devicename", rs.getString("devicename")); 
				        	   tresultsMap.put("softver", rs.getString("softver"));   
				        	   tresultsMap.put("hardwarever", rs.getString("hardwarever"));
				        	   tresultsMap.put("xh", rs.getString("xh"));
				        	   tresultsMap.put("factory", rs.getString("factory"));
				        	   tresultsMap.put("pp", rs.getString("pp"));
				        	   tresultsMap.put("e_total", rs.getString("e_total"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	public void setDevName(final String psno,final String byName){
		jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_setpmubyname(?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, psno);
			           cs.setString(2, byName);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.executeUpdate(); 
			          return null; 
			     } 
			  }); 
		

	}
	

	public List<Map> getPumTypeList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getpmutypelist(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("type", rs.getString("tname"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public List<Map> getPumModelList(){
		
		 List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getpmutypelist(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2); // 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("model", rs.getString("tname"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public List<Map> findPumList(final String type,final String model,final String listno,final int state,
			final String hardver,final String softver,final int autoUpdate,final int needUpdate,final int pagecols,final int page){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_query_pmu_pageex2(?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, type);
			           cs.setString(2, model);
			           cs.setString(3, listno);
			           cs.setString(4, hardver);
			           cs.setString(5, softver);
			           cs.setInt(6, autoUpdate);
			           cs.setInt(7, needUpdate);
			           cs.setInt(8, state);
			           cs.setBigDecimal(9, new BigDecimal( pagecols));
			           cs.setBigDecimal(10, new BigDecimal( page));
			           cs.registerOutParameter(11, OracleTypes.NUMBER);
			           cs.registerOutParameter(12,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(12);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("psno", rs.getString(1));
			        	   rowMap.put("idex", rs.getString(2));
		                   rowMap.put("pmutype", rs.getString(3));
		                   rowMap.put("stationname", rs.getString(4));
		                   rowMap.put("state", rs.getInt(5)+"");
			        	   rowMap.put("country", rs.getString(6));
		                   rowMap.put("city", rs.getString(7));
			        	   rowMap.put("hardver", rs.getString(8));
		                   rowMap.put("softver", rs.getString(9));
		                   rowMap.put("needup", rs.getString(10));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public int findPumPageNum(final String type,final String model,final String listno,final int state,final String hardver,final String softver,final int autoUpdate,final int needUpdate,final int pagecols,final int page){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	 String storedProc = "{call sp_web_query_pmu_pageex2(?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setString(1, type);
				           cs.setString(2, model);
				           cs.setString(3, listno);
				           cs.setString(4, hardver);
				           cs.setString(5, softver);
				           cs.setInt(6, autoUpdate);
				           cs.setInt(7, needUpdate);
				           cs.setInt(8, state);
				           cs.setBigDecimal(9, new BigDecimal( pagecols));
				           cs.setBigDecimal(10, new BigDecimal( page));
				           cs.registerOutParameter(11, OracleTypes.NUMBER);
				           cs.registerOutParameter(12,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(11);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	public List<Map> getPumAnalyTypeList(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_pmu_analyex(?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.DECIMAL);
				           cs.registerOutParameter(2, OracleTypes.DECIMAL);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);
				           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("pt", rs.getString(1));
		                   rowMap.put("pn", rs.getString(2));
		                   rowMap.put("pp", rs.getString(3));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public List<Map> getPumAnalyCountryList(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_pmu_analyex(?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.DECIMAL);
				           cs.registerOutParameter(2, OracleTypes.DECIMAL);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);
				           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("context", rs.getString(1));
		                   rowMap.put("pn", rs.getString(2));
		                   rowMap.put("pp", rs.getString(3));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public int getPumAnalyTotalType(){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_pmu_analyex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.DECIMAL);
			           cs.registerOutParameter(2, OracleTypes.DECIMAL);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(1);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	public int getPumAnalyTotalCountry(){
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_pmu_analyex(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.DECIMAL);
			           cs.registerOutParameter(2, OracleTypes.DECIMAL);
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4,  OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           
			           cs.executeUpdate();
			           String res= cs.getString(2);// 获取游标一行的值
			         
			           return res;
			        }
			   });
		return Integer.parseInt(resultList);
	}
	
	public Map getPumInfo(final String psno){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getpmuinfoex(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setString(1,psno);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中
				        	   tresultsMap.put("psno", rs.getString("psno"));
				        	   tresultsMap.put("stationname", rs.getString("stationname"));
				        	   tresultsMap.put("idex", rs.getString("idex"));
				        	   tresultsMap.put("pmutype", rs.getString("pmutype"));
				        	   tresultsMap.put("subtype", rs.getString("subtype"));
				        	   tresultsMap.put("upa", rs.getString("upa"));
				        	   tresultsMap.put("upn", rs.getString("upn"));
				        	   
				        	   tresultsMap.put("usedspace", rs.getString("usedspace"));
				        	   tresultsMap.put("totalspace", rs.getString("totalspace"));
				        	   int st=rs.getInt("state");
				        	   if (st==0)
				        	   tresultsMap.put("state","离线"); 
				        	   else if (st==1)
				        		   tresultsMap.put("state", "在线");  
				        	   tresultsMap.put("softver", rs.getString("softver"));   
				        	   tresultsMap.put("hardwver", rs.getString("hardwver"));
				        	   tresultsMap.put("llip", rs.getString("llip"));
				        	   tresultsMap.put("curgate", rs.getString("curgate"));
				        	   tresultsMap.put("lldt", rs.getString("lldt"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	/** 获取指定电站的详细情况  */
	public Map getStationInfo(final int stationId){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_getstationinfo(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("stationname", rs.getString("stationname"));
				        	   tresultsMap.put("iconindex", rs.getString("iconindex"));
				        	   tresultsMap.put("startdt", rs.getString("startdt"));  
				        	   if (rs.getString("totalpower")==null || rs.getString("totalpower").equals("0"))
				        		   tresultsMap.put("totalpower", "");  
				        	   else
				        		   tresultsMap.put("totalpower", rs.getFloat("totalpower"));
				        	   tresultsMap.put("companyname", rs.getString("companyname"));
				        	   tresultsMap.put("city", rs.getString("city"));
				        	   tresultsMap.put("province", rs.getString("province"));
				        	   tresultsMap.put("country", rs.getString("country"));
				        	   tresultsMap.put("street", rs.getString("street"));
				        	   tresultsMap.put("zip", rs.getString("zip"));
				        	   tresultsMap.put("jd", rs.getString("jd"));
				        	   tresultsMap.put("wd", rs.getString("wd"));
				        	   if (rs.getString("height")==null || rs.getString("height").equals("0"))
				        		   tresultsMap.put("height", "");  
				        	   else
				        		   tresultsMap.put("height", rs.getFloat("height"));

				        	   if (rs.getString("comangle")==null || rs.getString("comangle").equals("0"))
				        		   tresultsMap.put("comangle", "");  
				        	   else
				        		   tresultsMap.put("comangle", rs.getFloat("comangle"));
				        	   tresultsMap.put("timezone", rs.getString("tzkey"));
				        	   tresultsMap.put("co2xs", rs.getFloat("co2xs"));
				        	   tresultsMap.put("gainxs", rs.getFloat("gainxs"));
				        	   tresultsMap.put("currency", rs.getString("currency"));
				        	   tresultsMap.put("company", rs.getString("company"));
				        	   tresultsMap.put("admin", rs.getString("admininfo"));
				        	   tresultsMap.put("etotaloffset", rs.getFloat("etotaloffset"));
				        	   
				        	   tresultsMap.put("customerflag", rs.getInt("customerflag"));
				        	   tresultsMap.put("portkey", rs.getString("portkey"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	
	
	public List<Map> getSystemAdminList(){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_web_get_sys_accountlist2(?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("account", rs.getString("account"));
		                   rowMap.put("firstname", rs.getString("firstname"));
		                   rowMap.put("secondname", rs.getString("secondname"));
		                   ;
		                   rowMap.put("updatet", rs.getString("updatet")==null?"0":rs.getString("updatet"));
		                   rowMap.put("plantt", rs.getString("plantt")==null?"0":rs.getString("plantt"));
		                   rowMap.put("usert", rs.getString("usert")==null?"0":rs.getString("usert"));
		                   rowMap.put("devt", rs.getString("devt")==null?"0":rs.getString("devt"));
		                   rowMap.put("eventt", rs.getString("evet")==null?"0":rs.getString("evet"));
		                   rowMap.put("state", rs.getString("state"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public String removeSystemAdmin(final String account){
		 String resultList = (String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_sys_removeaccount2(?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, account);
			           cs.registerOutParameter(2, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(2); // 获取游标一行的值
			          return result;
			        }
			   });
		
		 return resultList;
	}
	
	public String addSystemAdmin(final String account,final int pro,final int sta,final int acc,final int dev,final int event,final int state){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_sys_appendaccount2(?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setString(1,account);
				       	cs.setInt(2,pro);
				       	cs.setInt(3,sta);
				       	cs.setInt(4,acc);
				       	cs.setInt(5,dev);
				       	cs.setInt(6,event);
				       	cs.setInt(7,state);
			           cs.registerOutParameter(8, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(8); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	
	public String updateSystemAdmin(final String account,final int pro,final int sta,final int acc,final int dev,final int event,final int state){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_sys_updateaccount2(?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setString(1,account);
				       	cs.setInt(2,pro);
				       	cs.setInt(3,sta);
				       	cs.setInt(4,acc);
				       	cs.setInt(5,dev);
				       	cs.setInt(6,event);
				       	cs.setInt(7,state);
			           cs.registerOutParameter(8, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(8); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	public Map getDayReportConfig(final int reportId,final int stationId){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_get_reportdaily(?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportId);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);				           
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(3);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("state", rs.getString("state"));
				        	   tresultsMap.put("reciverlist", rs.getString("reciverlist"));
				        	   tresultsMap.put("rep_format", rs.getString("rep_format")); 
				        	   tresultsMap.put("sendattime", rs.getString("sendattime"));   
				        	   tresultsMap.put("itemstr", rs.getString("itemstr"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	public Map getMonReportConfig(final int reportId,final int stationId){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_get_reportmonthly(?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportId);
				           cs.registerOutParameter(3, OracleTypes.CURSOR);				           
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(3);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("state", rs.getString("state"));
				        	   tresultsMap.put("reciverlist", rs.getString("reciverlist"));
				        	   tresultsMap.put("rep_format", rs.getString("rep_format")); 
				        	   tresultsMap.put("sendattime", rs.getString("sendattime"));   
				        	   tresultsMap.put("itemstr", rs.getString("itemstr"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	public Map getEventReportConfig(final int reportId,final int stationId){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_web_get_reportevent(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);				           
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map tresultsMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
				           while (rs.next()) {// 转换每行的返回值到Map中

				        	   tresultsMap.put("state", rs.getString("state"));
				        	   tresultsMap.put("reciverlist", rs.getString("reciverlist"));
				        	   tresultsMap.put("rep_format", rs.getString("rep_format")); 
				        	   tresultsMap.put("nextdelay", rs.getString("nextdelay"));   
				        	   tresultsMap.put("emptysend", rs.getString("emptysend"));
				        	   tresultsMap.put("maxeventlimit", rs.getString("maxeventlimit"));   
				        	   tresultsMap.put("itemstr", rs.getString("itemstr"));
			                   break;
				           }
				           rs.close();
				           return tresultsMap;
				        }
				   });
		return resultMap;
	}
	
	public void putDayReportConfig(final int reportId,final int stationId,final int state,final String recieverList,final int repFormat,final String sendTime,final String itemstr,final String lang){
		jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_put_reportdaily(?,?,?,?,?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, lang);
			           cs.setInt(2, stationId);
			           cs.setInt(3, reportId);
			           cs.setInt(4, state);
			           cs.setString(5, recieverList);
			           cs.setInt(6, repFormat);
			           cs.setString(7, sendTime);
			           cs.setString(8, itemstr);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.executeUpdate(); 
			          return null; 
			     } 
			  }); 
		

	}
	public void putMonReportConfig(final int reportId,final int stationId,final int state,final String recieverList,final int repFormat,final String itemstr,final String lang){
		jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_put_reportmonthly(?,?,?,?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, lang);
			           cs.setInt(2, stationId);
			           cs.setInt(3, reportId);
			           cs.setInt(4, state);
			           cs.setString(5, recieverList);
			           cs.setInt(6, repFormat);
			           cs.setString(7, itemstr);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.executeUpdate(); 
			          return null; 
			     } 
			  }); 
		

	}
	public void putEventReportConfig(final int reportId,final int stationId,final int state,final String recieverList,final int repFormat,final int nextdelay,final int emptysend,final int maxeventlimit,final String itemstr,final String lang){
		jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_put_reportevent(?,?,?,?,?,?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 

			           cs.setString(1, lang);
			           cs.setInt(2, stationId);
			           cs.setInt(3, state);
			           cs.setString(4, recieverList);
			           cs.setInt(5, repFormat);
			           cs.setInt(6, nextdelay);
			           cs.setInt(7, emptysend);
			           cs.setInt(8, maxeventlimit);
			           cs.setString(9, itemstr);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.executeUpdate(); 
			          return null; 
			     } 
			  }); 
		

	}
	
	public String removeStation(final int userId,final int stationId){
		String resultList = (String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_remove_stationex(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, stationId);
			           cs.setInt(2,userId);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			    	 public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           String result="err_nofound";
				           cs.executeUpdate();
				           result=cs.getString(3); // 获取游标一行的值
				          return result;
				        }
			  }); 
		
		return resultList;
	}

	public List<Map> getStationSharedaAcountList(final int stationId){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			        	  String storedProc = "{call sp_get_stationsharedaccount(?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1, stationId);
				           cs.registerOutParameter(2, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("userid", rs.getString("userid"));
		                   rowMap.put("rightstr", rs.getString("rightstr"));
		                   rowMap.put("state", rs.getInt("state")+"");
		                   rowMap.put("account", rs.getString("account"));
		                   rowMap.put("firstname", rs.getString("firstname"));
		                   rowMap.put("secondname", rs.getString("secondname"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	public String setStationtoAccount(final int stationId,final String account,final String rightStr){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_set_stationtoaccount(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setInt(1,stationId);
				       	cs.setString(2,account);
				       	cs.setString(3,rightStr);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(4); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	public String setStationtoAccountRight(final int stationId,final int userId,final String rightStr){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_set_accountrightonstation(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setInt(1,stationId);
				       	cs.setInt(2,userId);
				       	cs.setString(3,rightStr);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(4); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}

	public String removeAccFromStation(final int stationId,final int userId){
		
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_removeaccfromstation(?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
				       	cs.setInt(1,stationId);
				       	cs.setInt(2,userId);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(3); // 获取游标一行的值
			          return result;
			        }
			   });
		return resultList;
	}
	
	public String appendPmu(final String psno,final String idex,final String type,final String devname,final String xh,final String factory,final String penpai,final String softver,final String hardver){
		 String resultList = (String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_sys_appendpmu(?,?,?,?,?,?,?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, psno);
			           cs.setString(2, idex);
			           cs.setString(3, type);
			           cs.setString(4, devname);
			           cs.setString(5, xh);
			           cs.setString(6, factory);
			           cs.setString(7, penpai);
			           cs.setString(8, softver);
			           cs.setString(9, hardver);
			           cs.registerOutParameter(10, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(10); // 获取游标一行的值
			          return result;
			        }
			   });
		
		 return resultList;
	}
	

	public String getSharePlantCode(final int stationId,final int userId){
		 String resultList = (String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_genuserstationvcode(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, userId);
			           cs.setInt(2, stationId);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(3); // 获取游标一行的值
			          return result;
			        }
			   });
		
		 return resultList;
	}
	public String checkSharePlantCode(final int stationId,final int userId,final String code){
		 String resultList = (String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_shareaccountactive(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, stationId);
			           cs.setInt(2, userId);
			           cs.setString(3, code);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           String result="err_nofound";
			           cs.executeUpdate();
			           result=cs.getString(4); // 获取游标一行的值
			          return result;
			        }
			   });
		
		 return resultList;
	}
	public Map getReportMainInfoDay(final int stationId,final int reportType,final String itemstr){
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);
				          
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map infoMap = new HashMap();
				           cs.executeUpdate();
				          
				           ResultSet rs = (ResultSet) cs.getObject(4);// 获取游标一行的值
				           rs.next();
				           infoMap.put("e_today", fullNumString(rs.getString("e_today")));
				           infoMap.put("power_max", fullNumString(rs.getString("power_max")));
				           infoMap.put("in_today", fullNumString(rs.getString("in_today")));
				           infoMap.put("co2_today", fullNumString(rs.getString("co2_today")));
				           infoMap.put("e_total", fullNumString(rs.getString("e_total")));
				           infoMap.put("in_total", fullNumString(rs.getString("in_total")));
				           infoMap.put("co2total", fullNumString(rs.getString("co2_total")));
				           infoMap.put("startdt", rs.getString("startdt"));
				           infoMap.put("enddt", rs.getString("enddt"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	
	public List<Map> getReportListInfoDay(final int stationId,final int reportType,final String itemstr){
		
		List<Map> resultList = (List<Map>)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);				      
				           return cs;
				        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("rtime", rs.getString("rtime"));
		                   rowMap.put("fen10", rs.getString("fen10"));
		                   rowMap.put("pac", rs.getString("pac"));
		                   rowMap.put("unit", rs.getString("unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public Map getReportMainInfoMonth(final int stationId,final int reportType,final String itemstr){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);				      
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map infoMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(4);// 获取游标一行的值
				           rs.next();
				           infoMap.put("e_month", fullNumString(rs.getString("e_month")));
				           infoMap.put("power_max", fullNumString(rs.getString("pac_max")));
				           infoMap.put("in_month", fullNumString(rs.getString("in_month")));
				           infoMap.put("co2_month", fullNumString(rs.getString("co2_month")));
				           infoMap.put("e_total", fullNumString(rs.getString("e_total")));
				           infoMap.put("in_total", fullNumString(rs.getString("in_total")));
				           infoMap.put("co2total", fullNumString(rs.getString("co2_total")));
				           infoMap.put("startdt", rs.getString("startdt"));
				           infoMap.put("enddt", rs.getString("enddt"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	public List<Map> getReportListInfoMonth(final int stationId,final int reportType,final String itemstr){
		
		List<Map> resultList = (List<Map>)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);				      
				           return cs;
				        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("recvdate", rs.getString("recvdate"));
		                   rowMap.put("idd", rs.getString("idd"));
		                   rowMap.put("e_total", rs.getString("e_total"));
		                   rowMap.put("e_total_unit", rs.getString("e_total_unit"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	public Map getReportMainInfoEvent(final int stationId,final int reportType,final String itemstr){
		final String today = DateUtil.getToday();
		Map resultMap = (Map)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);				      
				           return cs;
				        }
				     }, new CallableStatementCallback() {
				        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           Map infoMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(4);// 获取游标一行的值
				           rs.next();
				           infoMap.put("startdt", rs.getString("startdt"));
				           infoMap.put("enddt", rs.getString("enddt"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	public List<Map> getReportListInfoEvent(final int stationId,final int reportType,final String itemstr){
	
		List<Map> resultList = (List<Map>)jdbcTemplate.execute(
			     new CallableStatementCreator() {
				        public CallableStatement createCallableStatement(Connection con) throws SQLException {
				           String storedProc = "{call sp_report_data_service(?,?,?,?,?)}";// 调用的sql
				           CallableStatement cs = con.prepareCall(storedProc);
				           cs.setInt(1,stationId);
				           cs.setInt(2,reportType);
				           cs.setString(3,itemstr);
				           cs.registerOutParameter(4, OracleTypes.CURSOR);		
				           cs.registerOutParameter(5, OracleTypes.CURSOR);				      
				           return cs;
				        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("did", rs.getString("did"));

			        	   rowMap.put("sn", rs.getString("ssno"));
		                   rowMap.put("msgtype", rs.getString("msgtype"));
		                   rowMap.put("occdt", rs.getString("occdt"));
		                   rowMap.put("context", rs.getString("context"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
public List<Map> accountSearchList(final String email,final String firstName,final String secondName,final String tel,final String mobile,final String country,final String state,final String city,final String company,final int pageNo,final int pageSize){
		
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_query_userlist_pageex(?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, email);
			           cs.setString(2, firstName);
			           cs.setString(3, secondName);
			           cs.setString(4, tel);
			           cs.setString(5, mobile);
			           cs.setString(6, country);
			           cs.setString(7, state);
			           cs.setString(8, city);
			           cs.setString(9, company);
			           cs.setInt(10, pageSize);
			           cs.setInt(11, pageNo);
			           cs.registerOutParameter(12, OracleTypes.NUMBER);
			           cs.registerOutParameter(13, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(13);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("userid", rs.getString("userid"));
		                   rowMap.put("account", rs.getString("account"));
		                   rowMap.put("createdt", rs.getString("createdt"));
		                   rowMap.put("firstname", rs.getString("firstname"));
		                   rowMap.put("secondname", rs.getString("secondname"));
		                   rowMap.put("country", rs.getString("country"));
		                   rowMap.put("province", rs.getString("province"));
		                   rowMap.put("tel", rs.getString("tel"));
		                   rowMap.put("mobile", rs.getString("mobile"));
		                   rowMap.put("company", rs.getString("company"));
		                   rowMap.put("city", rs.getString("city"));
		                   rowMap.put("active", rs.getString("mailactive"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

public int accountSearchCount(final String email,final String firstName,final String secondName,final String tel,final String mobile,final String country,final String state,final String city,final String company,final int pageNo,final int pageSize){
	
	String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_userlist_page(?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, email);
		           cs.setString(2, firstName);
		           cs.setString(3, secondName);
		           cs.setString(4, tel);
		           cs.setString(5, mobile);
		           cs.setString(6, country);
		           cs.setString(7, state);
		           cs.setString(8, city);
		           cs.setString(9, company);
		           cs.setInt(10, pageSize);
		           cs.setInt(11, pageNo);
		           cs.registerOutParameter(12, OracleTypes.NUMBER);
		           cs.registerOutParameter(13, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           List resultsList = new ArrayList();
		           cs.executeUpdate();
		           cs.executeUpdate();
		           String rs = cs.getObject(12).toString();// 获取游标一行的值
		          
		           return rs;
		        }
		   });
	return Integer.parseInt(resultList);
}

public List<Map> getPlantInvList(final String listno,final String startDt,final String endDt){
	List resultList = (List) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_inv_downloadex(?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, listno);
		           cs.setString(2, startDt);
		           cs.setString(3, endDt);
		           cs.registerOutParameter(4,  OracleTypes.NUMBER);
		           cs.registerOutParameter(5,  OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           List resultsList = new ArrayList();
		           cs.executeUpdate();
		           int pvnum=cs.getInt(4);
		           Map pvnumMap = new HashMap();
		           pvnumMap.put("pvnum", pvnum);

                   resultsList.add(pvnumMap);
		           ResultSet rs = (ResultSet) cs.getObject(5);// 获取游标一行的值
		           while (rs.next()) {// 转换每行的返回值到Map中
		        	   Map rowMap = new HashMap();
		        	   rowMap.put("idid", rs.getString("idid"));
	                   rowMap.put("isno", rs.getString("isno"));
	                   rowMap.put("recvdate", rs.getString("recvdate"));
	                   rowMap.put("vpv1", rs.getString("vpv1"));
	                   rowMap.put("vpv2", rs.getString("vpv2"));
	                   rowMap.put("vpv3", rs.getString("vpv3"));
	                   rowMap.put("vpv4", rs.getString("vpv4"));
	                   rowMap.put("vpv5", rs.getString("vpv5"));
	                   rowMap.put("vpv6", rs.getString("vpv6"));
	                   rowMap.put("vpv7", rs.getString("vpv7"));
	                   rowMap.put("vpv8", rs.getString("vpv8"));
	                   rowMap.put("vpv9", rs.getString("vpv9"));
	                   rowMap.put("vpv10", rs.getString("vpv10"));
	                   rowMap.put("vpv11", rs.getString("vpv11"));
	                   rowMap.put("vpv12", rs.getString("vpv12"));
	                   rowMap.put("vpv13", rs.getString("vpv13"));
	                   rowMap.put("vpv14", rs.getString("vpv14"));
	                   rowMap.put("vpv15", rs.getString("vpv15"));
	                   rowMap.put("vpv16", rs.getString("vpv16"));
	                   rowMap.put("vpv17", rs.getString("vpv17"));
	                   rowMap.put("vpv18", rs.getString("vpv18"));
	                   rowMap.put("vpv19", rs.getString("vpv19"));
	                   rowMap.put("vpv20", rs.getString("vpv20"));
	                   rowMap.put("ipv1", rs.getString("ipv1"));
	                   rowMap.put("ipv2", rs.getString("ipv2"));
	                   rowMap.put("ipv3", rs.getString("ipv3"));
	                   rowMap.put("ipv4", rs.getString("ipv4"));
	                   rowMap.put("ipv5", rs.getString("ipv5"));
	                   rowMap.put("ipv6", rs.getString("ipv6"));
	                   rowMap.put("ipv7", rs.getString("ipv7"));
	                   rowMap.put("ipv8", rs.getString("ipv8"));
	                   rowMap.put("ipv9", rs.getString("ipv9"));
	                   rowMap.put("ipv10", rs.getString("ipv10"));
	                   rowMap.put("ipv11", rs.getString("ipv11"));
	                   rowMap.put("ipv12", rs.getString("ipv12"));
	                   rowMap.put("ipv13", rs.getString("ipv13"));
	                   rowMap.put("ipv14", rs.getString("ipv14"));
	                   rowMap.put("ipv15", rs.getString("ipv15"));
	                   rowMap.put("ipv16", rs.getString("ipv16"));
	                   rowMap.put("ipv17", rs.getString("ipv17"));
	                   rowMap.put("ipv18", rs.getString("ipv18"));
	                   rowMap.put("ipv19", rs.getString("ipv19"));
	                   rowMap.put("ipv20", rs.getString("ipv20"));
	                   rowMap.put("ppv1", rs.getString("ppv1"));
	                   rowMap.put("ppv2", rs.getString("ppv2"));
	                   rowMap.put("ppv3", rs.getString("ppv3"));
	                   rowMap.put("ppv4", rs.getString("ppv4"));
	                   rowMap.put("ppv5", rs.getString("ppv5"));
	                   rowMap.put("ppv6", rs.getString("ppv6"));
	                   rowMap.put("ppv7", rs.getString("ppv7"));
	                   rowMap.put("ppv8", rs.getString("ppv8"));
	                   rowMap.put("ppv9", rs.getString("ppv9"));
	                   rowMap.put("ppv10", rs.getString("ppv10"));
	                   rowMap.put("ppv11", rs.getString("ppv11"));
	                   rowMap.put("ppv12", rs.getString("ppv12"));
	                   rowMap.put("ppv13", rs.getString("ppv13"));
	                   rowMap.put("ppv14", rs.getString("ppv14"));
	                   rowMap.put("ppv15", rs.getString("ppv15"));
	                   rowMap.put("ppv16", rs.getString("ppv16"));
	                   rowMap.put("ppv17", rs.getString("ppv17"));
	                   rowMap.put("ppv18", rs.getString("ppv18"));
	                   rowMap.put("ppv19", rs.getString("ppv19"));
	                   rowMap.put("ppv20", rs.getString("ppv20"));
	                   rowMap.put("vac1", rs.getString("vac1"));
	                   rowMap.put("vac2", rs.getString("vac2"));
	                   rowMap.put("vac3", rs.getString("vac3"));
	                   rowMap.put("iac1", rs.getString("iac1"));
	                   rowMap.put("iac2", rs.getString("iac2"));
	                   rowMap.put("iac3", rs.getString("iac3"));
	                   rowMap.put("status", rs.getString("status"));
	                   rowMap.put("cos_phi", rs.getString("cos_phi"));
	                   rowMap.put("under_excited", rs.getString("under_excited"));
	                   rowMap.put("pac", rs.getString("pac"));
		        	   rowMap.put("sac", rs.getString("sac"));
	                   rowMap.put("qac", rs.getString("qac"));
	                   rowMap.put("fac", rs.getString("fac"));
		        	   rowMap.put("e_total", rs.getString("e_total"));
	                   rowMap.put("h_total", rs.getString("h_total"));
	                   rowMap.put("e_today", rs.getString("e_today"));
		        	   rowMap.put("tempval", rs.getString("tempval"));
	                   resultsList.add(rowMap);
		           }
		           rs.close();
		           return resultsList;
		        }
		   });
	return resultList;
}


public String shareaccountactive(final int stationId,final int userId,final int state){
	
	 String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_shareaccountactiveex(?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
			       	cs.setInt(1,stationId);
			       	cs.setInt(2,userId);
			       	cs.setInt(3,state);
		           cs.registerOutParameter(4, OracleTypes.VARCHAR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           String result="err_nofound";
		           cs.executeUpdate();
		           result=cs.getString(4); // 获取游标一行的值
		          return result;
		        }
		   });
	return resultList;
}
	

	/** 2013-06-06  统计事件查询列表总页数   */
	public Map findEventList(final int msgtype, final int state, final String desc, final String ssno, final String startdt, final String enddt, final String stationname, final int country, final int devtype, final String devmodel, final String errcode, final int rowperpage, final int page){
		 Map resultList = (Map) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_event_pageexex(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setInt(1, msgtype);
		           cs.setInt(2, state);
		           cs.setString(3, desc);
		           cs.setString(4, ssno);
		           cs.setString(5, startdt);
		           cs.setString(6, enddt);
		           cs.setString(7, stationname);
		           cs.setInt(8, country);
		           cs.setInt(9, devtype);
		           cs.setString(10, devmodel);
		           cs.setInt(11, Integer.parseInt(errcode));
		           cs.setInt(12, rowperpage);
		           cs.setInt(13, page);
		           cs.registerOutParameter(14, OracleTypes.NUMBER);
		           cs.registerOutParameter(15, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		           List resultsList = new ArrayList();
		           Map resultM=new HashMap();
		           resultM.put("allPage", cs.getString(14));
		           
		           ResultSet rs = (ResultSet) cs.getObject(15); // 获取游标一行的值
		           while (rs.next()) {// 转换每行的返回值到Map中
		        	   Map rowMap = new HashMap();
		        	   rowMap.put("stationname", rs.getString("stationname"));
	                   rowMap.put("ssno", rs.getString("ssno"));
	                   rowMap.put("msgtype", rs.getString("msgtype"));
	                   rowMap.put("occdt", rs.getString("occdt"));
	                   rowMap.put("msg_desc", rs.getString("msg_desc"));
	                   rowMap.put("country", rs.getString("country"));
	                   rowMap.put("city", rs.getString("city"));
	                   rowMap.put("devt", rs.getString("devt"));
	                   resultsList.add(rowMap);
		           }
		           rs.close();
		           resultM.put("eventList", resultsList);
		           return resultM;
		        }
		   });
		return resultList;
	}
	
	/** 2013-06-06  统计事件查询列表总页数   */
	public int findEventCount(final int msgtype, final int state, final String desc, final String ssno, final String startdt, final String enddt, final String stationname, final int country, final int devtype, final String devmodel, final String errcode, final int rowperpage, final int page) {
		String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_event_pageexex(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setInt(1, msgtype);
		           cs.setInt(2, state);
		           cs.setString(3, desc);
		           cs.setString(4, ssno);
		           cs.setString(5, startdt);
		           cs.setString(6, enddt);
		           cs.setString(7, stationname);
		           cs.setInt(8, country);
		           cs.setInt(9, devtype);
		           cs.setString(10, devmodel);
		           cs.setInt(11, Integer.parseInt(errcode));
		           cs.setInt(12, rowperpage);
		           cs.setInt(13, page);
		           cs.registerOutParameter(14, OracleTypes.NUMBER);
		           cs.registerOutParameter(15, OracleTypes.CURSOR);
		           
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		           cs.executeUpdate();
		           String rs = cs.getObject(14).toString();// 获取游标一行的值
		           return rs;
		        }
		   });
		return Integer.parseInt(resultList);
	}


public int findEventListPage(final int msgtype,final int state,final String desc,final String ssno,final String startdt,final String enddt,
		final String stationname,final int country,final int devtype,final String devmodel,final int rowperpage,final int page){
	
	 String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_event_pageex(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setInt(1, msgtype);
		           cs.setInt(2, state);
		           cs.setString(3, desc);
		           cs.setString(4, ssno);
		           cs.setString(5, startdt);
		           cs.setString(6, enddt);
		           cs.setString(7, stationname);
		           cs.setInt(8, country);
		           cs.setInt(9, devtype);
		           cs.setString(10, devmodel);
		           cs.setInt(11, rowperpage);
		           cs.setInt(12, page);
		           cs.registerOutParameter(13, OracleTypes.NUMBER);
		           cs.registerOutParameter(14, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		          
		           cs.executeUpdate();
		           String res= cs.getString(13);// 获取游标一行的值
			         
		           return res;
		        }
		   });
	return Integer.parseInt(resultList);
}

public void setPmuUpdate(final int state,final String psno){
	jdbcTemplate.execute( 
		     new CallableStatementCreator() { 
		        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
		           String storedProc = "{call sp_web_pmu_do(?,?)}";
		           CallableStatement cs = con.prepareCall(storedProc); 
		           cs.setInt(1, state);
		           cs.setString(2, psno);
		           return cs; 
		        } 
		     }, new CallableStatementCallback() { 
		         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
		           cs.executeUpdate(); 
		          return null; 
		     } 
		  }); 
	

}
public int getUpdateRight(final int userId){
	String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_check_up_right(?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setInt(1, userId);
		           cs.registerOutParameter(2, OracleTypes.VARCHAR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           
		           cs.executeUpdate();
		           String res= cs.getString(2);// 获取游标一行的值
		           
		           return res;
		        }
		   });
	if (resultList.equals("yes"))
		return 1;
	else
		return 0;
}



public List<Map> findDictList(final  String subtag,final String lan,final String Val1,final String val2,final String content,final int pagecols,final int page){
	List resultList = (List) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_dict_page(?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, subtag);
		           cs.setString(2, lan);
		           cs.setString(3, Val1);
		           cs.setString(4, val2);
		           cs.setString(5, content);
		           cs.setInt(6, pagecols);
		           cs.setInt(7, page);
		           cs.registerOutParameter(8, OracleTypes.NUMBER);
		           cs.registerOutParameter(9, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           List resultsList = new ArrayList();
		           cs.executeUpdate();
		           ResultSet rs = (ResultSet) cs.getObject(9);// 获取游标一行的值
		           while (rs.next()) {// 转换每行的返回值到Map中
		        	   Map rowMap = new HashMap();
	                  // rowMap.put("recvdate", rs.getString("recvdate"));
	                   rowMap.put("subtag", rs.getString(1));
	                   rowMap.put("lang", rs.getString(2));
	                   rowMap.put("val1",  rs.getString(3));
	                   rowMap.put("val2", rs.getString(4));
	                   rowMap.put("context", rs.getString(5));
	                   resultsList.add(rowMap);
		           }
		           rs.close();
		           return resultsList;
		        }
		   });
	return resultList;
}


public int findDictListPage(final  String subtag,final String lan,final String Val1,final String val2,final String content,final int pagecols,final int page){
	String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_query_dict_page(?,?,?,?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, subtag);
		           cs.setString(2, lan);
		           cs.setString(3, Val1);
		           cs.setString(4, val2);
		           cs.setString(5, content);
		           cs.setInt(6, pagecols);
		           cs.setInt(7, page);
		           cs.registerOutParameter(8, OracleTypes.NUMBER);
		           cs.registerOutParameter(9, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		           String ss= cs.getString(8);// 获取游标一行的值
		          
		           return ss;
		        }
		   });
	return Integer.parseInt(resultList);
}

public List<Map> findDictSubTag(){
	List resultList = (List) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_dict_listinfo(?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.registerOutParameter(1, OracleTypes.CURSOR);
		           cs.registerOutParameter(2, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           List resultsList = new ArrayList();
		           cs.executeUpdate();
		           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
		           while (rs.next()) {// 转换每行的返回值到Map中
		        	   Map rowMap = new HashMap();
	                  // rowMap.put("recvdate", rs.getString("recvdate"));
	                   rowMap.put("subtag", rs.getString(1));
	                   resultsList.add(rowMap);
		           }
		           rs.close();
		           return resultsList;
		        }
		   });
	return resultList;
}

public List<Map> findDictLang(){
	List resultList = (List) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_dict_listinfo(?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.registerOutParameter(1, OracleTypes.CURSOR);
		           cs.registerOutParameter(2, OracleTypes.CURSOR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           List resultsList = new ArrayList();
		           cs.executeUpdate();
		           ResultSet rs = (ResultSet) cs.getObject(2);// 获取游标一行的值
		           while (rs.next()) {// 转换每行的返回值到Map中
		        	   Map rowMap = new HashMap();
	                  // rowMap.put("recvdate", rs.getString("recvdate"));
	                   rowMap.put("lang", rs.getString(1));
	                   resultsList.add(rowMap);
		           }
		           rs.close();
		           return resultsList;
		        }
		   });
	return resultList;
}

public String createDict(final  String subtag,final String lan,final String val1,final String val2,final String content){
	String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_dict_add(?,?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, subtag);
		           cs.setString(2, lan);
		           cs.setString(3, val1);
		           cs.setString(4, val2);
		           cs.setString(5, content);
		           cs.registerOutParameter(6, OracleTypes.VARCHAR);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		           String ss= cs.getString(6);// 获取游标一行的值
		          
		           return ss;
		        }
		   });
	return resultList;
}

public void updateDict(final  String subtag,final String lan,final String val1,final String val2,final String content){
	String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_dict_update(?,?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, subtag);
		           cs.setString(2, lan);
		           cs.setString(3, val1);
		           cs.setString(4, val2);
		           cs.setString(5, content);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		         
		         return "";
		        }
		   });
	
	}

	public void removeDict(final  String subtag,final String lan,final String val1,final String val2){
		String resultList = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_dict_remove(?,?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setString(1, subtag);
		           cs.setString(2, lan);
		           cs.setString(3, val1);
		           cs.setString(4, val2);
		           return cs;
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		         
		         return "";
		        }
		  });
	
	}
	
	/**
	 * 13-04-16修改
	 */
	public String getLocalTime(final int istationid){
		
		String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationlocaldt(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           
			           cs.setInt(1, istationid);
			           cs.registerOutParameter(2, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           cs.executeUpdate();
			           String rs = cs.getObject(2).toString();// 获取游标一行的值
			          
			           return rs;
			        }
			   });
		return resultList;
	}

	/** 修改电站的关注属性  */
	public String updateStationAttention(final String stationId, final int state) {
		 String resultList = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_setstationselectstate(?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc);
				       cs.setInt(1,Integer.parseInt(stationId));
				       cs.setInt(2,state);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           cs.executeUpdate();
			           return null;
			        }
			   });
		 return null;
	}

	/** 设备列表页面---删除逆变器   */
	public String removeInv(final int stationid, final String isno) {
		String res = (String) jdbcTemplate.execute(
		     new CallableStatementCreator() {
		        public CallableStatement createCallableStatement(Connection con) throws SQLException {
		           String storedProc = "{call sp_web_removeinvbasepmustation(?,?,?)}";// 调用的sql
		           CallableStatement cs = con.prepareCall(storedProc);
		           cs.setInt(1, stationid);	
		           cs.setString(2, isno);
		           cs.registerOutParameter(3, OracleTypes.VARCHAR);
		           return cs; 
		        }
		     }, new CallableStatementCallback() {
		        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
		           cs.executeUpdate();
		           String rs = cs.getObject(3).toString();// 获取游标一行的值
		           return rs;
		        }
		   });
		return res;
		
	}
	
	public String fullNumString(String str){
		if (str!=null){
			if (str.substring(0,1).equals(".")){
				str="0"+str;
			}
		}
		return str;		
	}

	public void plantDayStatistics(final String startDate, final String endDate) {
		jdbcTemplate.execute(new CallableStatementCreator() {
			public CallableStatement createCallableStatement(Connection conn)
					throws SQLException {
				 String storedProc = "{call mp_recalc_dailyexex(?,?)}";// 调用的sql 
				 CallableStatement cs = conn.prepareCall(storedProc); 
				 cs.setString(1, startDate);
				 cs.setString(2, endDate);
				 return cs;
			}
		}, new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.execute();
				return null;
			}
		});
	}
	
	/**
	 * @see 新加存储过程，返回电站事件数据，DC-397
	 * @return
	 */
	public List<Map> getStationEventPortInfo(final int stationid,final String occdt1,final String occdt2){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_port_getstationevent(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setInt(1, stationid);
			           cs.setString(2, occdt1);
			           cs.setString(3, occdt2);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(4);
			           while (rs.next()) {
			        	   int i=1;
			        	   Map rowMap = new HashMap();
		                   rowMap.put("did", rs.getString(i++));
		                   rowMap.put("ssno", rs.getString(i++));
		                   rowMap.put("occdt", rs.getString(i++));
		                   rowMap.put("msgtype", rs.getString(i++));
		                   rowMap.put("errcode", rs.getString(i++));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/**
	 * @see 新加存储过程，返回电站事件数据，DC-397
	 * @return
	 */
	public String getStationInfoByKey(final String key){
		String res = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_port_getstationidbykey(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, key);
			           cs.registerOutParameter(2, OracleTypes.VARCHAR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           cs.executeUpdate();
			           String reInfo = cs.getObject(2).toString();
			           return reInfo;
			        }
			   });
		return res;
	}

	public void updatePortKeyByStationid(String key, String sid) {
		String sql = "update tb_station set portkey=? where stationid=?";
		this.getJdbcTemplate().update(sql, new Object[]{key, Integer.parseInt(sid)});
	}

}
