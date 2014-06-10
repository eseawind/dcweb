package com.jstrd.asdc.dao.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;

import com.jstrd.asdc.dao.EventDao;

@SuppressWarnings({"unchecked"})
public class EventDaoImpl extends BaseDaoImpl implements EventDao{

	
	Logger log = Logger.getLogger(EventDaoImpl.class);
	/**
	 * 获取电站的event
	 * @param stationid
	 * @return
	 */
	public List<Map> getEventByStationid(final int stationid,final String occdt1,final String occdt2,final Float approved,final String isno,final String e_level,final int userId,final String lang,final int pageRows,final int page){
		List resultList = (List) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationevent(?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setBigDecimal(1, new BigDecimal(userId));
			           cs.setBigDecimal(2, new BigDecimal(stationid));
			           cs.setString(3, isno);
			           if (e_level==null)
				           cs.setBigDecimal(4, null);
				           else
				        	   cs.setBigDecimal(4, new BigDecimal(e_level));
			           cs.setString(5, occdt1);
			           cs.setString(6, occdt2);
			           if (approved==null)
				           cs.setBigDecimal(7, null);
				           else
				        	   cs.setBigDecimal(7, new BigDecimal(approved));
			           cs.setString(8, lang);
			           cs.setBigDecimal(9, new BigDecimal(pageRows));
			           cs.setBigDecimal(10, new BigDecimal(page));
			           cs.registerOutParameter(11, OracleTypes.VARCHAR);
			           cs.registerOutParameter(12, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			           List resultsList = new ArrayList();
			           cs.executeUpdate();
			           ResultSet rs = (ResultSet) cs.getObject(12);// 获取游标一行的值
			           while (rs.next()) {// 转换每行的返回值到Map中
			        	   Map rowMap = new HashMap();
		                   rowMap.put("did", rs.getString("did"));
		                   rowMap.put("isno", rs.getString("ssno"));
		                   rowMap.put("byname", rs.getString("byname"));
		                   rowMap.put("msgtype", rs.getString("msgtype"));
		                   rowMap.put("err_code", rs.getString("err_code"));
		                   rowMap.put("context", rs.getString("context"));
		                   rowMap.put("haveread", rs.getString("haveread"));
		                   rowMap.put("occdt", rs.getString("occdt"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	/***
	 * 获取电站的个数
	 * @param stationid
	 * @return
	 */
	public int getEventCountBySid(final int stationid,final String occdt1,final String occdt2,final Float approved,final String isno,final String e_level,final int userId,final String lang,final int pageRows,final int page){
		String result = (String) jdbcTemplate.execute(
			     new CallableStatementCreator() {
			        public CallableStatement createCallableStatement(Connection con) throws SQLException {
			           String storedProc = "{call sp_web_getstationevent(?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql
			           CallableStatement cs = con.prepareCall(storedProc);
			           cs.setBigDecimal(1, new BigDecimal(userId));
			           cs.setBigDecimal(2, new BigDecimal(stationid));
			           cs.setString(3, isno);
			           if (e_level==null)
				           cs.setBigDecimal(4, null);
				           else
				        	   cs.setBigDecimal(4, new BigDecimal(e_level));
			           cs.setString(5, occdt1);
			           cs.setString(6, occdt2);
			           if (approved==null)
				           cs.setBigDecimal(7, null);
				           else
				        	   cs.setBigDecimal(7, new BigDecimal(approved));
			           cs.setString(8, lang);
			           cs.setBigDecimal(9, new BigDecimal(pageRows));
			           cs.setBigDecimal(10, new BigDecimal(page));
			           cs.registerOutParameter(11, OracleTypes.VARCHAR);
			           cs.registerOutParameter(12, OracleTypes.CURSOR);
			           return cs;
			        }
			     }, new CallableStatementCallback() {
			        public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
			          
			           cs.executeUpdate();
			          
			           String ress=(String)cs.getObject(11);
			           return ress;
			        }
			   });
		return Integer.parseInt(result);
	}
	/*
	public int getEventCountBySid(int stationid,String occdt1,String occdt2,int approved,String isno,String e_level){
		System.out.println(occdt1+","+occdt2);
		StringBuilder sqlsb = new StringBuilder();
		sqlsb.append(" select count(edid) from tb_Inverter_event invevent left join tb_dict_ssiis dict on invevent.e_level=dict.val1 where stationid=? and invevent.code=dict.val2 and dict.language='en_US' ");
		if(occdt1!=null&&!("").equals(occdt1)&&occdt2!=null&&!("").equals(occdt2)){
			sqlsb.append(" and invevent.occdt between to_date('"+occdt1+"','yyyy-MM-dd') and to_date('"+occdt2+"','yyyy-MM-dd') ");
		}else if(occdt1==null||("").equals(occdt1)){
			if(occdt2!=null&&!("").equals(occdt2)){
				sqlsb.append(" and invevent.occdt - to_date('"+occdt2+"','yyyy-MM-dd')<0 ");
			}
		}else if(occdt2==null||("").equals(occdt2)){
			if(occdt1!=null&&!("").equals(occdt1)){
				sqlsb.append(" and invevent.occdt - to_date('"+occdt1+"','yyyy-MM-dd')>0 ");
			}
		}
		if(approved!=0){
			if(approved==-1){
				sqlsb.append(" and invevent.approved is null ");
			}else{
				sqlsb.append(" and invevent.approved= "+approved);
			}
		}
		if(isno!=null&&!("").equals(isno)&&!("-1").equals(isno)){
			sqlsb.append(" and invevent.isno= '"+isno+"' ");
		}
		if(e_level!=null&&!("").equals(e_level)){
			sqlsb.append(" and invevent.e_level in ("+e_level+") ");
		}
		return this.jdbcTemplate.queryForInt(sqlsb.toString(),new Object[]{stationid});
	}*/
	/***
	 * 根据ID删除event
	 */
	public void delEventById(int edid){
		String sql = "update tb_inverter_event set approved=1 where edid=?";
		this.jdbcTemplate.update(sql,new Object[]{edid});
	}
	
}
