package com.jstrd.asdc.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import oracle.jdbc.OracleTypes;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;

import com.jstrd.asdc.dao.UserLimitDao;

@SuppressWarnings({"unchecked","unused"})
public class UserLimitDaoImpl extends BaseDaoImpl implements UserLimitDao {

	public Map getRoleLimt(int roleId) {
		//String sql = "select * from tb_rolelimits where id=?";
		//List<Map> roleList = this.getJdbcTemplate().queryForList(sql,new Object[]{roleId});
		//if(roleList!=null&&roleList.size()>0){
		//	return roleList.get(0);
		//}else{
			return null;
		//}
	}
	
	/**
	 * 获取所有用户
	 */
	public List<Map> getAllRoleLimit(){
		//String sql = "select * from tb_rolelimits";
		//return this.getJdbcTemplate().queryForList(sql);
		return null;
	}
	public Map getUserMenu(final int userId,final int stationId){
		
		Map resultList = (Map) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_getrightstring2ex(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, userId);
			           cs.setInt(2,stationId);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			    	 public Object doInCallableStatement(CallableStatement cs) throws SQLException,DataAccessException {
				           
				           cs.executeUpdate();				         
				           Map userMenu=new HashMap();
				           String resultList=cs.getString(3);
				           String s[]=resultList.split(",");
					   		userMenu.put("station", s[0]);
					   		userMenu.put("pmu", s[1]);
					   		userMenu.put("inv", s[2]);
					   		userMenu.put("user", s[3]);
					   		userMenu.put("admin", s[4]);
					   		userMenu.put("event", s[5]);
					   		userMenu.put("dev", s[6]);
					   		userMenu.put("report", s[7]);
					   		userMenu.put("plant", s[8]);
					   		userMenu.put("share", s[9]);
					   		
					   		
					   		
					   		if (s[0].equals("1") || s[1].equals("1") || s[2].equals("1") || s[3].equals("1") || s[4].equals("1") || s[5].equals("1"))
					   			userMenu.put("manager", 1);
					   		else
					   			userMenu.put("manager", 0);
					   		if (s[6].equals("1") || s[7].equals("1") || s[8].equals("1") || s[9].equals("1"))
					   			userMenu.put("config", 1);
					   		else
					   			userMenu.put("config", 0);
				           
				          return userMenu;
				        }
			  }); 
		
		
		return resultList;
	}
	public void updateRoleLimitsById(int roleId,String limitsStr){
		/*String[] LimitStr = limitsStr.split(",");
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<LimitStr.length;i++){
			String[] temp =  LimitStr[i].split("_");
			if(i==LimitStr.length-1){
				sb.append(" "+temp[0]+"=" +temp[1]+" ");
			}else{
				sb.append(" "+temp[0]+"=" +temp[1]+", ");
			}
		}
		String sql = "update tb_rolelimits set "+sb.toString()+"where id=?";
		this.getJdbcTemplate().update(sql,new Object[]{roleId});
		*/
	}
}
