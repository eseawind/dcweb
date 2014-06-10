package com.jstrd.asdc.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import com.jstrd.asdc.dao.UserDao;

@SuppressWarnings({"unchecked","unused"})
public class UserDaoImpl extends BaseDaoImpl implements UserDao{

	
	/**
	 *获取用户的电站关系 
	 * @param userid
	 * @return
	 */
	public List<Object> findUserStations(int userid){
		String sql = "select * from tb_userstation where userId=?";
		return this.jdbcTemplate.queryForList(sql,new Object[]{userid});
	}
	
	public Object findUserById(int userid) {
		String sql = "select * from tb_user tb_user where tb_user.userId=?";
		List<Object> userList = this.jdbcTemplate.queryForList(sql, new Object[]{userid});
		if(userList!=null && userList.size()>0){
			return userList.get(0);
		}else{
			return null;
		}
	}

	/**
	 * 根据用户email获取用户信息
	 */
	public Object findUserByEmail(String email){
		String sql = "select * from tb_user tb_user where lower(tb_user.Account)=?";
		List<Object> userList = this.jdbcTemplate.queryForList(sql, new Object[]{email.trim().toLowerCase()});
		if(userList!=null && userList.size()>0){
			return userList.get(0);
		}else{
			return null;
		}
	}
	
	/** 根据用户email获取用户登信息   */
	public String userLogin(final String email, final String pwd, final String ipaddr, final String sysinfo, final String ieinfo) {
		String res=(String) jdbcTemplate.execute( 
		     new CallableStatementCreator() { 
		        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
		           String storedProc = "{call sp_user_loginex(?,?,?,?,?,?,?)}";	
		           CallableStatement cs = con.prepareCall(storedProc); 
		           cs.setString(1, email);
		           cs.setString(2, pwd);
		           cs.setString(3, ipaddr);
		           cs.setString(4, sysinfo);
		           cs.setString(5, ieinfo);
		           cs.registerOutParameter(6, OracleTypes.NUMBER);	// 注册输出参数的类型 
		           cs.registerOutParameter(7, OracleTypes.VARCHAR);	// 注册输出参数的类型 
		           return cs; 
		        } 
		     }, new CallableStatementCallback() { 
		         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
		           cs.execute(); 
		           String returns=cs.getString(7);
		           return returns;// 获取输出参数的值 
		     } 
		  }); 
		return res;
	}
	
	
	
	/***
	 * 保存用户
	 */
	public void saveUser(String Account,String pwd,String firstName,String secondName,String company,int roleId){
		String sql = " insert into tb_user (userId,Account,pwd,firstName,secondName,company,roleId,createdt) values (seq_userId.nextval,?,?,?,?,?,?,sysdate)";
		this.getJdbcTemplate().update(sql,new Object[]{Account,pwd,firstName,secondName,company,2});
	}
	
	
	public Map getUserRegInfo(String account){
		//将登录时间格式化为yyyy-MM-dd hh24:mi:ss
		String sql = "select userid, account, firstname, secondname, company, webaddr, country, province as provincap, city, street, zip, tel, mobile, ipaddr, op_sys, ie_info, to_char(lastlogindt,'yyyy-mm-dd hh24:mi:ss') lastlogindt from TB_USER where account=?";
		List<Map> mapList =this.getJdbcTemplate().queryForList(sql, new Object[]{account});
		if(mapList!=null && mapList.size()>0){
			return mapList.get(0);
		}else{
			return null;
		}
	}
	
	/**
	 * 获取PMU列表
	 * @param psno
	 * @return
	 */
	public Map findPmuByPsno(String psno){
		String sql = "select * from tb_pmu where psno=?";
		List<Map> mapList =this.getJdbcTemplate().queryForList(sql, new Object[]{psno});
		if(mapList!=null && mapList.size()>0){
			return mapList.get(0);
		}else{
			return null;
		}
	}
	
	/**
	 * 保存电站信息
	 * @param stationname
	 * @param userId
	 * @param co2xs
	 * @param gainxs
	 * @param addr
	 * @param country
	 * @param city
	 * @return
	 */
	public int saveStaion(final String stationname,final String userId,final String co2xs,final String gainxs,final String addr,final String country,final String city,final String timezone,final String money,final String psno){
		KeyHolder keyHolder = new GeneratedKeyHolder();   
		jdbcTemplate.update(new PreparedStatementCreator() {   
	        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {   
	               String sql = "insert into  tb_station (stationid,stationname,createdt,masterid,CO2xs,gainxs,addr,country,city,timezone,money) values (seq_stationid.nextval,?,sysdate,?,?,?,?,?,?,?,?)";    
	               PreparedStatement ps = connection.prepareStatement(sql,new String[]{"stationid"});   
	               ps.setString(1, stationname);   
	               ps.setInt(2, Integer.parseInt(userId));   
	               ps.setFloat(3, Float.parseFloat(co2xs));   
	               ps.setFloat(4, Float.parseFloat(gainxs));   
	               ps.setString(5, addr);   
	               ps.setString(6, country); 
	               ps.setString(7, city);   
	               ps.setString(8, timezone);   
	               ps.setString(9, money);   
	               return ps;   
	        }   
	    }, keyHolder);   
	       
	    int stationId = Integer.parseInt(keyHolder.getKey().toString());  
	    String sql2 = "insert into tb_userstation (userId,stationid,Createdt,Noteinfo,createUserId,roleId) values (?,?,sysdate,'电站管理员',0,2)";
		this.jdbcTemplate.update(sql2, new Object[]{userId,stationId});
		//更新PMU信息
		updatePmuStation(stationId,psno);
		return stationId;   
	}
	public int saveStation(final String stationname,final String phone,String email,String adminname,
			final String longitude,final String latitude,final String hasl,final String azimuth,
			final String aoi,final String desc,final String co2xs,final String gainxs,final String masterid,final String psno){
		
		KeyHolder keyHolder = new GeneratedKeyHolder();   
		jdbcTemplate.update(new PreparedStatementCreator() {   
	        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {   
	               String sql = "insert into  tb_station (stationid,stationname,createdt,masterid,comangle,cominsangle,x,y,h,stationdesc,CO2xs,gainxs) values (seq_stationid.nextval,?,sysdate,?,?,?,?,?,?,?,?,?)";    
	               PreparedStatement ps = connection.prepareStatement(sql,new String[]{"stationid"});   
	               ps.setString(1, stationname);   
	               ps.setInt(2, Integer.parseInt(masterid));   
	               ps.setFloat(3, Float.parseFloat(azimuth));   
	               ps.setFloat(4, Float.parseFloat(aoi));   
	               ps.setFloat(5, Float.parseFloat(longitude));   
	               ps.setFloat(6, Float.parseFloat(latitude)); 
	               ps.setFloat(7, Float.parseFloat(hasl));   
	               ps.setString(8, desc);   
	               ps.setFloat(9,Float.parseFloat(co2xs));   
	               ps.setFloat(10,Float.parseFloat(gainxs));   
	               return ps;   
	        }   
	    }, keyHolder);   
	       
	    int stationId = keyHolder.getKey().intValue();    
	    String sql2 = "insert into tb_userstation (userId,stationid,Createdt,Noteinfo,createUserId,roleId) values (?,?,?,?,?,?)";
		this.jdbcTemplate.update(sql2, new Object[]{masterid,stationId,new Date(),"电站管理员",0,2});
		//更新PMU信息
		updatePmuStation(stationId,psno);
		return stationId;   
	}
	/**
	 * 保存pmu ID
	 * @param stationid
	 */
	public void updatePmuStation(int stationid,String psno ){
		if(stationid==0){
			String sql = "update tb_pmu set stationid=? where psno=?";
			this.jdbcTemplate.update(sql,new Object[]{null,psno});
			String sql1 = "update tb_Inverter set stationid=? where psno=?";
			this.jdbcTemplate.update(sql1,new Object[]{null,psno});
		}else{
			String sql = "update tb_pmu set stationid=? where psno=?";
			this.jdbcTemplate.update(sql,new Object[]{stationid,psno});
			String sql1 = "update tb_Inverter set stationid=? where psno=?";
			this.jdbcTemplate.update(sql1,new Object[]{stationid,psno});
		}
	}
	/***
	 * 删除stationid
	 */
	public void delStation(int stationid){
		String sql ="delete from tb_station where stationid=?";//删除电站
		this.jdbcTemplate.update(sql,new Object[]{stationid});
		String sql1 = "update tb_pmu  set stationid=null where stationid=?";//解绑PMU
		this.jdbcTemplate.update(sql1,new Object[]{stationid});
		String sql2 = "delete from tb_userstation where stationid=?";//接触用户与电站关系
		this.jdbcTemplate.update(sql2,new Object[]{stationid});
		String sql3 = "update tb_inverter  set stationid=null where stationid=?";//删除逆变器绑定关系，防止取值错误。
		this.jdbcTemplate.update(sql3,new Object[]{stationid});
//		String sql3 = "delete from tb_userlimits where stationid=?";//删除与电站相关的用户权限
//		this.jdbcTemplate.update(sql3,new Object[]{stationid});
	}
	
	/**
	 * 更新电站信息
	 * @param stationname
	 * @param phone
	 * @param email
	 * @param adminname
	 * @param longitude
	 * @param latitude
	 * @param hasl
	 * @param azimuth
	 * @param aoi
	 * @param desc
	 * @param co2xs
	 * @param gainxs
	 * @param masterid
	 * @return
	 */
	public void updateStation(int stationid,String stationname,String phone,String email,String adminname,
			String longitude,String latitude,String hasl,String azimuth,
			String aoi,String desc,String co2xs,String gainxs,String masterid){
		String sql = "update tb_station set stationname=?,comangle=?,cominsangle=?,x=?,y=?,h=?,stationdesc=?,CO2xs=?,gainxs=? where stationid=?";
		this.jdbcTemplate.update(sql,new Object[]{stationname,azimuth,aoi,longitude,latitude,hasl,desc,co2xs,gainxs,stationid});
	}
	public void updateStation(int stid,String stationname,String co2xs,String gainxs,String money,String timezone,String addr,String country,String city){
		String sql = "update tb_station set stationname=?,CO2xs=?,gainxs=?,money=?,timezone=?,addr=?,country=?,city=? where stationid=?";
		this.jdbcTemplate.update(sql,new Object[]{stationname,co2xs,gainxs,money,timezone,addr,country,city,stid});
	}
	/**
	 * 获取电站信息
	 */
	public Map getStationById(int stationid){
		String sql = "select * from tb_station where stationid=?";
		List<Map> stationMap = this.jdbcTemplate.queryForList(sql,new Object[]{stationid});
		if(stationMap!=null && stationMap.size()>0){
			return stationMap.get(0);
		}else{
			return null;
		}
	}
	/***
	 * 获取电站下的所有PMU列表
	 */
	public List<Map> findStationPmu(int stationid,int pageNo,int pageSize){
		StringBuilder sqlsb = new StringBuilder();
		sqlsb.append(" select * from( ");
		sqlsb.append(" select pmu.*,rownum RN from  ");
		sqlsb.append(" (select * from tb_pmu where stationid=?) pmu where rownum<="+pageSize*pageNo);
		sqlsb.append(" )where RN>= "+((pageNo-1)*pageSize+1));
		return this.jdbcTemplate.queryForList(sqlsb.toString(),new Object[]{stationid});
	}
	/**
	 * 获取电站下所有PMU的个数
	 */
	public int findStationPmuCount(int stationid){
		String sql = "select count(*) from tb_pmu where stationid=?";
		return this.jdbcTemplate.queryForInt(sql,new Object[]{stationid});
	}
	
	/***
	 * 分页获取某个电站的所有INV信息
	 */
	public List<Map> findStationInv(int stationid,int pageNo,int pageSize){
		StringBuilder sqlsb = new StringBuilder();
		sqlsb.append(" select * from( ");
		sqlsb.append(" select inv.*,rownum RN from  ");
		sqlsb.append(" (select * from tb_Inverter where stationid=?) inv where rownum<="+pageSize*pageNo);
		sqlsb.append(" )where RN>= "+((pageNo-1)*pageSize+1));
		return this.jdbcTemplate.queryForList(sqlsb.toString(),new Object[]{stationid});
	}
	/**
	 * 获取电站逆变器的所有信息
	 */
	public int findStationInvCount(int stationid){
		String sql = "select count(*) from tb_Inverter inv  where inv.stationid=? ";
		return this.jdbcTemplate.queryForInt(sql,new Object[]{stationid});
	}
	
	/**
	 * @param isno
	 * @param byName
	 */
	public void updateInvName(String isno,String byName){
		String sql ="update tb_Inverter set byName=? where isno=?";
		this.jdbcTemplate.update(sql,new Object[]{byName,isno});
	}
	/**
	 * 
	 * 创建普通用户
	 * @param Account
	 * @param password
	 * @param firstName
	 * @param secondName
	 * @return
	 */
	public int createNormalUser(final String Account,final String password,final String firstName,final String secondName,final int stationid,int createUserId){
		KeyHolder keyHolder = new GeneratedKeyHolder();   
		jdbcTemplate.update(new PreparedStatementCreator() {   
	        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {   
	               String createdt = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	               String sql = "insert into tb_user (userId,Account,pwd,firstName,secondName,roleId,createdt) values (seq_userId.nextval,?,?,?,?,?,sysdate)";   
	               PreparedStatement ps = connection.prepareStatement(sql,new String[]{"userId"});   
	               ps.setString(1, Account);   
	               ps.setString(2, password);   
	               ps.setString(3, firstName);   
	               ps.setString(4, secondName);   
	               ps.setString(5, "1");   
	               return ps;   
	        }   
	    }, keyHolder);   
	    int generatedId = keyHolder.getKey().intValue(); 
	   //创建普通用户及电站关系
	    String sql2 = "insert into tb_userstation (userId,stationid,Createdt,Noteinfo,createUserId,roleId) values (?,?,sysdate,'普通用户',?,1)";
		this.jdbcTemplate.update(sql2, new Object[]{generatedId,stationid,createUserId});
		return generatedId;
	}
	/**
	 * 注册账号
	 */
	public String[] regUser(	final String email,final String pwd,final String firstName,final String secondName,final String company,final String question,final String answer,final String myurl,final String country,final String city,final String state,final String address,final String postcode,final String tel,final String mobile){
		String[] res=(String[]) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_create_account(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";// 调用的sql 
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, email);
			           cs.setString(2, pwd);
			           cs.setString(3, question);
			           cs.setString(4, answer);
			           //	final String email,final String pwd,final String firstName,final String secondName,final String company,final String question,
			           //final String answer,final String myurl,final String country,final String state,final String city,final String address,
			           //final String postcode,final String tel,final String mobile
			           cs.setString(5, firstName);
			           cs.setString(6, secondName);
			           cs.setString(7, company);
			           cs.setString(8, myurl);
			           cs.setString(9, country);
			           cs.setString(10, city);
			           cs.setString(11, state);
			           cs.setString(12, address);
			           cs.setString(13, postcode);
			           cs.setString(14,tel);
			           cs.setString(15, mobile);
			           cs.registerOutParameter(16, OracleTypes.NUMBER);// 注册输出参数的类型 
			           cs.registerOutParameter(17, OracleTypes.VARCHAR);// 注册输出参数的类型 
			           cs.registerOutParameter(18, OracleTypes.VARCHAR);// 注册输出参数的类型 
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String[] returns=new String[]{cs.getInt(16)+"",cs.getString(17),cs.getString(18)};

			          // cs.close();
			           return returns;// 获取输出参数的值 
			     } 
			  }); 
		return res;

	}
	/**
	 * 用户账号邮件验证
	 * @param email
	 * @param listNo
	 * @return
	 */
	public String regUserVer(	final String email,final String listNo){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_activeuseraccount(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, email);
			           cs.setString(2, listNo);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(3);

				           //cs.close();
			          return ss; 
			     } 
			  }); 
		return res;

	}
	/**
	 * 获取电站用户
	 * @param stationid
	 * @return
	 */
	public List<Map> getUsersbyStationid(int stationid){
		String sql = "select us.userId,us.stationid,u.Account,u.pwd,u.secondName,u.firstName,u.roleId from tb_userstation us inner join tb_user u on us.userId=u.userId where us.stationid=? order by u.roleId desc";
		return this.jdbcTemplate.queryForList(sql,new Object[]{stationid});
	}
	/**
	 * 根据userId 删除用户
	 */
	public void deleteNormalUser(int userId){
		String sql = "delete from tb_user where userId=?";
		this.jdbcTemplate.update(sql,new Object[]{userId});
		String sql1 = "delete from tb_userlimits where userId=?";
		this.jdbcTemplate.update(sql1,new Object[]{userId});
		String sql2 = "delete from tb_userstation where userId=?";
		this.jdbcTemplate.update(sql2,new Object[]{userId});
	}
	/**
	 * 删除系统用户
	 * @param userId
	 */
	public void deleteSysUser(int userId){
		String sql = "delete from tb_user where userId=?";
		this.jdbcTemplate.update(sql,new Object[]{userId});
	}
	
	/**
	 * 更新用户信息
	 */
	public void updateUserInfo(int userId,String pwd,String firstName,String secondName){
		String sql = "update tb_user set pwd=?,firstName=?,secondName=?  where userId=?";
		this.jdbcTemplate.update(sql, new Object[]{pwd,firstName,secondName,userId});
	}
	public String editUserRegInfo(final String account,final String firstname,final String secondname,final String company,final String webaddr,final String country,final String province,final String city,final String street,final String zip,final String telnum,final String mobile){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_updateaccountinfo(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, account);
			           cs.setString(2, firstname);
			           cs.setString(3, secondname);
			           cs.setString(4, company);
			           cs.setString(5, webaddr);
			           cs.setString(6, country);
			           cs.setString(7, province);
			           cs.setString(8, city);
			           cs.setString(9, street);
			           cs.setString(10, zip);
			           cs.setString(11, telnum);
			           cs.setString(12, mobile);
			           cs.registerOutParameter(13, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(13);

			           //cs.close();
		          return ss; 
			     } 
			  }); 
		return res;

	}
	public String changeUserPws(final String account,final String oldPws,final String newPws){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_user_changepwd(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, Integer.parseInt(account));
			           cs.setString(2, oldPws);
			           cs.setString(3, newPws);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(4);

			           //cs.close();
		          return ss; 
			     } 
			  }); 
		return res;

	}
	/**
	 * 更新用户权限
	 */
	public void updateUserLimits(int userId,int editStationLimit,int addPmuLimit,int delPmuLimit, int setReportLimit){
		String sql = "update tb_userlimits set editStationLimit=?,addPmuLimit=?,delPmuLimit=?,setReportLimit=? where userId=?";
		this.jdbcTemplate.update(sql,new Object[]{editStationLimit,addPmuLimit,delPmuLimit,setReportLimit,userId});
		
	}
	
	/**
	 * 获取各种角色的用户
	 */
	public List<Map> getUsersByRole(int roleId){
		String sql = "select * from tb_user where roleId=?  order by createdt desc";
		return this.jdbcTemplate.queryForList(sql,new Object[]{roleId});
	}
	
	/**
	 * 创建系统管理员
	 */
	public void createSysAdmin(String email,String password,String requestDepartment,String firstName,String secondName,String phone,String fax){
		String sql = " insert into tb_user (userId,Account,pwd,firstName,secondName,reqestDepartment,tel,fax,roleId,createdt) " +
									"values (seq_userId.nextval,?,?,?,?,?,?,?,3,sysdate)";
		this.getJdbcTemplate().update(sql,new Object[]{email,password,firstName,secondName,requestDepartment,phone,fax});
	}
	/**
	 * 更新系统管理员信息
	 * @param userid
	 * @param email
	 * @param password
	 * @param requestDepartment
	 * @param firstName
	 * @param secondName
	 * @param phone
	 * @param fax
	 */
	public void updateSysAdmin(int userid,String password,String requestDepartment,String firstName,String secondName,String phone,String fax){
		String sql = "update tb_user set pwd=?,firstName=?,secondName=?,reqestDepartment=?,tel=?,fax=? where userId=?";
		this.getJdbcTemplate().update(sql,new Object[]{password,firstName,secondName,requestDepartment,phone,fax,userid});
	}

	public String getCheckCode(	final String email){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_general_verifycode(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, email);
			           cs.registerOutParameter(2, OracleTypes.VARCHAR);

			           cs.registerOutParameter(3, OracleTypes.VARCHAR);

			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(2)+"#"+cs.getString(3)+"#"+cs.getString(4);

			           //cs.close();
		          return ss; 
			     } 
			  }); 
		return res;

	}	
	public String updateUserPasswd(	final String email,final String checkCode,final String newpass){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_checkverifycode(?,?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setString(1, email);
			           cs.setString(2, checkCode);
			           cs.setString(3, newpass);
			           cs.registerOutParameter(4, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(4);

			           //cs.close();
		          return ss; 
			     } 
			  }); 
		return res;

	}	
	
	public String activeUserAccount(final int userId,final String checkCode){
		String res=(String) jdbcTemplate.execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_web_activeuseraccount(?,?,?)}";
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.setInt(1, userId);
			           cs.setString(2, checkCode);
			           cs.registerOutParameter(3, OracleTypes.VARCHAR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			           cs.execute(); 
			           String ss=cs.getString(3);

			           //cs.close();
		          return ss; 
			     } 
			  }); 
		return res;

	}

	
}
