package com.jstrd.asdc.dao.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;

import com.jstrd.asdc.dao.InverterDao;
import com.jstrd.asdc.util.DateUtil;

@SuppressWarnings({"unchecked","unused"})
public class InverterDaoImpl extends BaseDaoImpl implements InverterDao {
	
	public InverterDaoImpl() {
		
	}
	
	/**
	 * 获得本日的某个ID逆变器产量
	 * @param Inverterid
	 * @return
	 */
	public Map findTpInverterById(int Inverterid){
		return null;
	}
	
	/**
	 * 获取某个逆变器的
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCPInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCP_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCP");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("dcp"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCP"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 
	 * 获取某个逆变器某日的近7天的DCP值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCPInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCP_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCP");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("dcp"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCP"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/***
	 * 获取某个电站下的逆变器
	 */
	public List<Map> findStationInv(int stationid){
		String sql = " select * from tb_Inverter inv left join tb_pmu pmu on inv.psno = pmu.psno where pmu.stationid=?  ";
		return this.jdbcTemplate.queryForList(sql,new Object[]{stationid});
	}
	
	/**
	 * 获取某个逆变器某日的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCVInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCV_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCV");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("vpv"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCV"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的DCV值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCVInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCV_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCV");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("vpv"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCV"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某日的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACPInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACP_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   //rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("pac", rs0.getString("pac"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的ACP值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACPInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACP_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("pac", rs0.getFloat("acp"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某日的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACVInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACV_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("ACV");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("vac"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("ACV"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 获取某个逆变器某日的近7天的ACV值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACVInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACV_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("ACV");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("vac"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("ACV"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 获取某个逆变器某日的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCCInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCC_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCC");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("ipv"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCC"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某周的DCC值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findDCCInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_DCC_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("DCC");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("ipv"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("DCC"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	
	/**
	 * 获取某个逆变器某日的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACCInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACC_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("ACC");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("iac"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("ACC"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某周的ACC值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACCInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACC_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   String acc = rs0.getString("ACC");
		                   String[] accArr = acc.split("\\^");
		                   for(int i=1;i<=accArr.length;i++){
			                   rowMap.put("iac"+i, Float.parseFloat((accArr[i-1])));
		                   }
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("channel", rs1.getInt("ACC"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	

	public List<List<Map>> findACFInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACF_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   //rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("acf", rs0.getString("acf"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某周的ACF值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findACFInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_ACF_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("acf", rs0.getFloat("acf"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某日的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findTempInverterByDate(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_TEMP_DAY(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("tempval", rs0.getString("temp"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	/**
	 * 获取某个逆变器某周的温度值
	 * @param Inverterid
	 * @return
	 */
	public List<List<Map>> findTempInverterByWeek(final String Inverterid,final String date){
		if(Inverterid==null||("").equals(Inverterid)){
			return null;
		}
		List<List<Map>> result = (List<List<Map>>) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "call SP_GET_INV_TEMP_WEEK(?,?,?,?)";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setString(1, Inverterid);// 设置输入参数的值
			           cs.setString(2, date);// 设置输入参数的值
			           cs.registerOutParameter(3, OracleTypes.CURSOR);
			           cs.registerOutParameter(4, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List<List<Map>> resultList = new LinkedList<List<Map>>();
			           List resultList0 = new LinkedList();
			           List resultList1 = new LinkedList();
			           cs.execute();
			           ResultSet rs0 = (ResultSet) cs.getObject(3);// 获取游标一行的值
			           while (rs0.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs0.getString("isno"));
		                   rowMap.put("recvdate", rs0.getString("recvdate"));
		                   rowMap.put("fen10", rs0.getInt("fen10"));
		                   rowMap.put("tempval", rs0.getFloat("tempval"));
		                   resultList0.add(rowMap);
			           }
			           resultList.add(resultList0);
			           rs0.close();
			           ResultSet rs1 = (ResultSet) cs.getObject(4);// 获取游标一行的值
			           while (rs1.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("isno", rs1.getString("isno"));
		                   rowMap.put("max", rs1.getFloat("max"));
		                   rowMap.put("min", rs1.getFloat("min"));
		                   rowMap.put("avg", rs1.getFloat("avg"));
		                   resultList1.add(rowMap);
			           }
			           resultList.add(resultList1);
			           rs1.close();
			           return resultList;
			        }
			   });
		String[] Inverterids = Inverterid.split(",");
		List<Map> queryInvList= new LinkedList<Map>();
		for(int i =0;i<Inverterids.length;i++){
			 Map rowMap = new HashMap();
			 rowMap.put("isno", Inverterids[i]);
			 queryInvList.add(rowMap);
		}
		result.add(queryInvList);
		return result;
	}
	
	/**
	 * 获取电站7天的内的发电量收益 单位每天
	 */
	public List<Map> findIncomeby7days(final String stationid,final String date){
		List<String> _7DaysArr = new ArrayList<String>();
		try {
			_7DaysArr = DateUtil.getLastSeventDay(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		final String startdt=_7DaysArr.get(0);
		final String enddt=_7DaysArr.get(_7DaysArr.size()-1);
		
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_7DAYS_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, startdt);
			           cs.setString(5, enddt);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("recvdate", rs.getString("recvdate"));
		                   rowMap.put("e_total", rs.getString("e_total"));
		                   rowMap.put("income", rs.getString("inval"));
		                   rowMap.put("co2av", rs.getString("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取电站12个月的发电量收益 单位每月
	 */
	public List<Map> findIncomeBy12Months(final String stationid,final String date){
		List<String> _12MonthsArrsande = new ArrayList<String>();
		try {
			_12MonthsArrsande = DateUtil.get2daysForSql(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		final String startdt=_12MonthsArrsande.get(0);
		final String enddt=_12MonthsArrsande.get(_12MonthsArrsande.size()-1);
		
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_12MONTHS_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, startdt);
			           cs.setString(5, enddt);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("recvdate", rs.getString("yearmonth"));
		                   rowMap.put("e_total", rs.getString("e_total"));
		                   rowMap.put("income", rs.getString("inval"));
		                   rowMap.put("co2av", rs.getString("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取电站每年的发电量收益
	 */
	public List<Map> findIncomeByyear(final String stationid,final String date){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_ALLYEAR_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, DateUtil.getFirstDayOfYear(date));
			           cs.setString(5, DateUtil.getLastDayOfYear(date));
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("year", rs.getString("year"));
		                   rowMap.put("e_total", rs.getFloat("e_total"));
		                   rowMap.put("income", rs.getFloat("inval"));
		                   rowMap.put("co2av", rs.getFloat("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取电站7天的内的二氧化碳减排量 单位每天
	 */
	public List<Map> findCo2Avby7days(final String stationid,final String date){
		List<String> _7DaysArr = new ArrayList<String>();
		try {
			_7DaysArr = DateUtil.getLastSeventDay(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		final String startdt=_7DaysArr.get(0);
		final String enddt=_7DaysArr.get(_7DaysArr.size()-1);
		
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_7DAYS_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, startdt);
			           cs.setString(5, enddt);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("recvdate", rs.getString("recvdate"));
		                   rowMap.put("e_total", rs.getString("e_total"));
		                   rowMap.put("income", rs.getString("inval"));
		                   rowMap.put("co2av", rs.getString("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取电站12个月的二氧化碳减排量单位每月
	 */
	public List<Map> findCo2AvBy12Months(final String stationid,final String date){
		List<String> _12MonthsArrsande = new ArrayList<String>();
		try {
			_12MonthsArrsande = DateUtil.get2daysForSql(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		final String startdt=_12MonthsArrsande.get(0);
		final String enddt=_12MonthsArrsande.get(_12MonthsArrsande.size()-1);
		
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_12MONTHS_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, startdt);
			           cs.setString(5, enddt);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("recvdate", rs.getString("yearmonth"));
		                   rowMap.put("e_total", rs.getString("e_total"));
		                   rowMap.put("income", rs.getString("inval"));
		                   rowMap.put("co2av", rs.getString("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取电站每年的二氧化碳减排量 单位每年
	 */
	public List<Map> findCo2AvByyear(final String stationid,final String date){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{?=call FN_GETSTATIONINFO_ALLYEAR_ID(?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           cs.setInt(2, Integer.parseInt(stationid));
			           cs.setString(3, date);
			           cs.setString(4, DateUtil.getFirstDayOfYear(date));
			           cs.setString(5, DateUtil.getLastDayOfYear(date));
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("year", rs.getString("year"));
		                   rowMap.put("e_total", rs.getFloat("e_total"));
		                   rowMap.put("income", rs.getFloat("inval"));
		                   rowMap.put("co2av", rs.getFloat("co2val"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}

	/**
	 * 获取用户当前选择的ISNOS
	 */
	public List<Map> findIsnosByChart(String userId,String stationId,String type){
		Map resultMap = new HashMap();
		String sql = "select userId,type,isnos,stationId,InvChecked from tb_userchart where userId = ? and type=? and stationid=?";
		List<Map> list = this.getJdbcTemplate().queryForList(sql,new Object[]{userId,type,stationId});
		if(list==null||list.size()==0){
			String sql1 = "insert into tb_userchart  (userId, type,stationid)  values (?,?,?)";
			this.getJdbcTemplate().update(sql1,new Object[]{userId,type,stationId});
		}
		return list;
	}

	/**
	 * 获取某个电站的所有逆变器
	 */
	public List<Map> findAllIsnosByStid(final String stationid){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getinvlistwithcurinfo(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setBigDecimal(1, new BigDecimal(stationid));
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
		                   rowMap.put("isno", rs.getString("isno"));
		                   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("state", rs.getString("state"));
		                   rowMap.put("e_today", DateUtil.getDblStr(rs.getString("e_today")));
		                   rowMap.put("e_today_u", rs.getString("e_today_u"));
		                   rowMap.put("e_total", DateUtil.getDblStr(rs.getString("e_total")));
		                   rowMap.put("e_total_u", rs.getString("e_total_u"));
		                   rowMap.put("pac", DateUtil.getDblStr(rs.getString("pac")));
		                   rowMap.put("pac_u", rs.getString("pac_u"));
		                   rowMap.put("pacmax", DateUtil.getDblStr(rs.getString("pacmax")));
		                   rowMap.put("pacmax_u", rs.getString("pacmax_u"));
		                   rowMap.put("percentage", DateUtil.getDblStr(rs.getString("et_percent")));
		                   rowMap.put("eve0num", rs.getString("eve0num"));
		                   //rowMap.put("evetnum", rs.getString("evetnum"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 获取某个电站的所有设备
	 * @param stationid
	 * @return
	 */
	public List<Map> findAllDeviceByStid(final String stationid){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationdevice(?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setBigDecimal(1, new BigDecimal(stationid));
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
		                   rowMap.put("isno", rs.getString("ssno"));
		                   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("devt", rs.getString("devt"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	/**
	 * 更新用户选择的逆变器
	 */
	public void updateUserChartByType(String stationid,String userid,String isnos,String type,String channels){
		String invChecked = channels;
		String sql3="update tb_userChart set   isnos=?, InvChecked=?  where userId =? and stationId=? and type=?";
		this.jdbcTemplate.update(sql3, new Object[]{isnos,invChecked,userid,stationid,type});
	}
	
	/**
	 * 获取电站所有的PMU及逆变器
	 */
	public List<List<Map>> getAllPmuAndInverter(int stationid){
		List<List<Map>> list = new LinkedList<List<Map>>();
		String sql = "select * from tb_pmu where stationid=?";
		List<Map> pmuList= this.jdbcTemplate.queryForList(sql,new Object[]{stationid}); 
		String sql1 = "select * from tb_inverter where stationid=? order by psno";
		List<Map> invList= this.jdbcTemplate.queryForList(sql1,new Object[]{stationid});
		list.add(pmuList);
		list.add(invList);
		return list;
	}
	
	/**
	 * 获取电站所有的PMU及逆变器
	 */
	public List<List<Map>> getPmuOrInverter(int stationid,String invName,String pino,String state){
		List<List<Map>> list = new LinkedList<List<Map>>();
		if(invName==null){
			String sql = "select * from tb_pmu where stationid=?";
			if(pino!=null){
				sql = sql + " and psno='"+pino+"' ";
			}
			if(state!=null){
				sql = sql + " and state= "+state +" ";
			}
			List<Map> pmuList= this.jdbcTemplate.queryForList(sql,new Object[]{stationid}); 
			String sql1 = "select * from tb_inverter where stationid=? ";
			if(pino!=null){
				sql1 = sql1+" and isno ='"+pino+"' ";
			}
			sql1 = sql1+" order by psno ";
			List<Map> invList= this.jdbcTemplate.queryForList(sql1,new Object[]{stationid});
			list.add(pmuList);
			list.add(invList);
		}else{
			
			List<Map> pmuList= new ArrayList(); 
			String sql1 = "select * from tb_inverter where stationid=? ";
			if(invName!=null){
				sql1 = sql1+" and byName like  '%"+invName+"%' ";
			}
			if(pino!=null){
				sql1 = sql1+" and isno ='"+pino+"' ";
			}
			sql1 = sql1+" order by psno ";
			List<Map> invList= this.jdbcTemplate.queryForList(sql1,new Object[]{stationid});
			list.add(pmuList);
			list.add(invList);
		}
		return list;
	}
}


