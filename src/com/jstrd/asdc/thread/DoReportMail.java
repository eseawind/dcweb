package com.jstrd.asdc.thread;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Pattern;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.jstrd.asdc.email.mailServerInfo;
import com.jstrd.asdc.email.MainSend;
import com.jstrd.asdc.util.DateUtil;

@SuppressWarnings({"unchecked","unused"})
public class DoReportMail extends JdbcDaoSupport{
	
	private static Logger logger = Logger.getLogger(DoReportMail.class);
	private static ApplicationContext ctx=null;
	public static int issent = 1; //邮件发送异常标志，如有异常则不更新邮件任务列表的是否发送成功标志
	
	public int getIssent() {
		return issent;
	}

	
	public static void setIssent(int issent) {
		DoReportMail.issent = issent;
	}

	/**
	 * 发送邮件
	 */
	public void reportMail(){
		if (null == ctx)
			ctx = new ClassPathXmlApplicationContext("applicationContext-base.xml");
		DoReportMail jdbcDao = (DoReportMail) ctx.getBean("reportDao");
		if (mailServerInfo.serverHost==null) {
			Map serverMap=(Map)jdbcDao.getMailServerInfo();
			mailServerInfo.serverHost=serverMap.get("smtp").toString();
			mailServerInfo.serverPort=Integer.parseInt(serverMap.get("port").toString());
			mailServerInfo.mailAcc=serverMap.get("account").toString();
			mailServerInfo.emailPwd=serverMap.get("password").toString();
			mailServerInfo.sendEmail=serverMap.get("email").toString();
		}
		String realPath=this.getClass().getResource("/").getPath().toString();
		realPath=realPath.replaceAll("%20"," ");
		String basePath ="http://solarcloud.zeversolar.com/";
		//String basePath = "http://voicet.oicp.net:8000";
		//String basePath ="http://127.0.0.1/";
		List<Map> taskList = null;
		try {
			taskList=jdbcDao.mailTask();
		} catch (Exception e) {
			logger.error(e);
		}
		int tasks=0;
		if (taskList!=null)
			tasks=taskList.size();
		logger.warn("find mail reports : "+tasks);
		if (taskList!=null && tasks>0)
			for (int i=0; i<tasks; i++) {
				Map taskInfo=(Map)taskList.get(i);
				int type=Integer.parseInt(taskInfo.get("reportid").toString());
				int stationId=Integer.parseInt(taskInfo.get("stationid").toString());
				//String localtime = taskInfo.get("localtime").toString();
				String taskid = taskInfo.get("taskid").toString();
				String itemstr=taskInfo.get("itemstr").toString();
				String lang=taskInfo.get("lang").toString();
				String reciverList=taskInfo.get("reciverlist").toString();
				if(checkEmail(reciverList) && null!=reciverList){
					logger.info("邮件验证成功, 接收邮件地址列表：" + reciverList);
					if (type==1) {
						Map reportInfo=jdbcDao.getReportMainInfoDay(stationId, 1, itemstr);
						List<Map> reportInfoList=jdbcDao.getReportListInfoDay(stationId, 1, itemstr);
						String userName = reportInfo.get("firstname").toString()+reportInfo.get("secondname").toString();
						String reportimg="";
						String stationName=reportInfo.get("stationname").toString();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String nowTime= formatter.format(new Date());
						formatter = new SimpleDateFormat("yyyy-MM-dd");
						//String nowDay= formatter.format(new Date());
						//获取邮件报告图表标题时间
						String nowDay = (String)reportInfo.get("startdt");
						long now = System.currentTimeMillis();
						String newFileName = "";		
						newFileName =realPath+"/../../upload/report/"+ Long.toString(now)+".jpg";
						ReportImage img=new ReportImage();
						try {
							img.areaImage(reportInfoList,nowDay,newFileName);
						} catch (IOException e) {
							logger.error(e);
						}
						MainSend mainSendms=new MainSend();
						mainSendms.setStationId(stationId);
						//mainSendms.setLocaltime(localtime);
						mainSendms.doSendDayReport(reciverList, userName, stationName, reportInfo, itemstr, lang, realPath, basePath,basePath+"/upload/report/"+ Long.toString(now)+".jpg");
					}
					else if (type==2) {
						Map reportInfo=jdbcDao.getReportMainInfoMonth(stationId, 2, itemstr);
						List<Map> reportInfoList=jdbcDao.getReportListInfoMonth(stationId, 2, itemstr);
						String userName = reportInfo.get("firstname").toString()+reportInfo.get("secondname").toString();
						String reportimg="";
						String stationName=reportInfo.get("stationname").toString();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String nowTime= formatter.format(new Date());
						formatter = new SimpleDateFormat("yyyy-MM");
						String nowDay= formatter.format(new Date());
						long now = System.currentTimeMillis();
						String newFileName = "";		
						newFileName =realPath+"/../../upload/report/"+ Long.toString(now)+".jpg";
						ReportImage img=new ReportImage();
						try {
							img.barImage(reportInfoList,nowDay,newFileName);
						} catch (IOException e) {
							logger.error(e);
						}
						MainSend mainSendms=new MainSend();
						mainSendms.setStationId(stationId);
						//mainSendms.setLocaltime(localtime);
						mainSendms.doSendMonthReport(reciverList, userName, stationName, reportInfo, itemstr, lang, realPath, basePath,basePath+"/upload/report/"+ Long.toString(now)+".jpg");
					}
					else if (type==3) {
						Map reportInfo=jdbcDao.getReportMainInfoEvent(stationId, 3, itemstr);
						List<Map> reportInfoList=jdbcDao.getReportListInfoEvent(stationId, 3, itemstr);
						String userName = reportInfo.get("firstname").toString()+reportInfo.get("secondname").toString();
						String reportimg="";
						String stationName="";
						if (reportInfo.get("stationname")!=null)
							stationName=reportInfo.get("stationname").toString();
						String tab="<table border='1' cellspacing='0' cellpadding='0'>";
						tab=tab+"<tr>";
						tab=tab+"    <td width='61' valign='top'><p>"+getProperties("RES_REPORT_EVENT_ITEM",realPath+"messageResource_"+lang+".properties")+" </p></td>";
						tab=tab+"    <td width='156' valign='top'><p align='center'>"+getProperties("RES_ETIME",realPath+"messageResource_"+lang+".properties")+" </p></td>";
						tab=tab+"    <td width='81' valign='top'><p align='center'>"+getProperties("RES_REPORT_EVENT_TYPE",realPath+"messageResource_"+lang+".properties")+" </p></td>";
						tab=tab+"    <td width='260' valign='top'><p align='center'>"+getProperties("RES_REPORT_EVENT_CONTENT",realPath+"messageResource_"+lang+".properties")+" </p></td>";
						tab=tab+"  </tr>";
						if (reportInfoList!=null && reportInfoList.size()>0) {
							for (int ii=0;ii<reportInfoList.size();ii++) {
								Map rinfo=(Map)reportInfoList.get(ii);
								tab=tab+"<tr>";
								tab=tab+"<td width='61' valign='top'>"+(ii+1)+"</td>";
								tab=tab+"<td width='156' valign='top'>"+rinfo.get("occdt").toString()+" </td>";
								tab=tab+"<td width='81' valign='top'>"+(rinfo.get("msgtype")==null?"":rinfo.get("msgtype").toString())+" </td>";
								tab=tab+"<td width='260' valign='top'>"+(rinfo.get("context")==null?"":rinfo.get("context").toString())+" </td>";
								tab=tab+"</tr>";
							}
						}
						tab=tab+"</table>";
						//if((reportInfoList!=null && reportInfoList.size()>0) || itemstr.substring(0,1).equals("0")) {
						if((reportInfoList!=null && reportInfoList.size()>0)) {
							MainSend mainSendms=new MainSend();
							mainSendms.setStationId(stationId);
							//mainSendms.setLocaltime(localtime);
							mainSendms.doSendEventReport(reciverList, userName, stationName, reportInfo, itemstr, lang, realPath, basePath,tab,reportInfo.get("startdt").toString(),reportInfo.get("enddt").toString());
						}
					}
					//没有异常，发送成功，更新成功标志issent
					if(0 == getIssent()){
						setIssent(1);
					}else{
						jdbcDao.updateMailSent(taskid);
					}
				}else{
					logger.warn("邮件验证失败, 接收邮件地址列表：[" + reciverList + "], 邮件地址列表为空或邮件地址格式不正确 !");
				}
			}
		System.gc();
	}
	
	public String getlocalCurrentTime(){
		return null;
	}

	public List queryListBySql(String sql){
	   return this.getJdbcTemplate().queryForList(sql);
	}
	
	public String getLocalDateTimes(final int istationid){
		String resultList = (String) this.getJdbcTemplate().execute(
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
			           cs.executeUpdate();
			           String rs = cs.getObject(2).toString();
			           return rs;
			        }
			   });
		return resultList;
	}
	
	public void updateMailSent(String taskid){
		String sql = "update tb_mail_task set issent=1 where taskid=" + taskid;
		try{
			
		int res = this.getJdbcTemplate().update(sql);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		/*
		execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           
			        	String storedProc = "{call sp_report_task_updatesent(?)}"; 
			        	CallableStatement cs = con.prepareCall(storedProc); 
			        	cs.setInt(1, taskid);
			        	return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			        	 return "ok";
			         } 
			  }); 
		*/
	}
	
	public List<Map> mailTask(){
		JdbcTemplate temp=	this.getJdbcTemplate();
		List<Map> res=(List<Map>) this.getJdbcTemplate().execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           
			        	String storedProc = "{call sp_report_task_queryex(?,?)}"; 
			        	CallableStatement cs = con.prepareCall(storedProc); 
			        	cs.registerOutParameter(1, OracleTypes.NUMBER);
			        	cs.registerOutParameter(2, OracleTypes.CURSOR);
			        	return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			        	 List resultsList = new ArrayList();
				           cs.executeUpdate();
				           int tasks = Integer.parseInt(cs.getObject(1).toString());
				           if (tasks>0){
				           ResultSet rs = (ResultSet) cs.getObject(2);
				           while (rs.next()) {
				        	   Map rowMap = new HashMap();
					        	 rowMap.put("stationid",rs.getString("stationid"));
				                 rowMap.put("reportid", rs.getString("reportid"));
				                 rowMap.put("configid", rs.getString("configid"));
				                 rowMap.put("f_html", rs.getString("f_html"));
				                 rowMap.put("reciverlist", rs.getString("reciverlist"));
				                 rowMap.put("itemstr", rs.getString("itemstr"));
				                 rowMap.put("lang", rs.getString("lan"));
				                 rowMap.put("taskid", rs.getString("taskid"));
				                 //rowMap.put("localtime", rs.getString("localtime"));
				                 resultsList.add(rowMap);
				           }
				           rs.close();
			           }
			           return resultsList;
			         } 
			  }); 
		return res;
	}
	
	public Map getReportMainInfoDay(final int stationId,final int reportType,final String itemstr){
		Map resultMap = (Map)this.getJdbcTemplate().execute(
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
				           infoMap.put("startdt", fullNumString(rs.getString("startdt")));
				           infoMap.put("enddt", fullNumString(rs.getString("enddt")));
				           infoMap.put("firstname", rs.getString("firstname"));
				           infoMap.put("secondname", rs.getString("secondname"));
				           infoMap.put("stationname", rs.getString("stationname"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	
	public String fullNumString(String str){
		if (str!=null){
			if (str.substring(0,1).equals(".")){
				str="0"+str;
			}
		}
		return str;		
	}
	
	public List<Map> getReportListInfoDay(final int stationId,final int reportType,final String itemstr){
		List<Map> resultList = (List<Map>)this.getJdbcTemplate().execute(
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
		                   rowMap.put("fen10", fullNumString(rs.getString("fen10")));
		                   rowMap.put("pac", fullNumString(rs.getString("pac")));
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
		Map resultMap = (Map)this.getJdbcTemplate().execute(
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
				           infoMap.put("firstname", rs.getString("firstname"));
				           infoMap.put("secondname", rs.getString("secondname"));
				           infoMap.put("stationname", rs.getString("stationname"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	
	public List<Map> getReportListInfoMonth(final int stationId,final int reportType,final String itemstr){
		List<Map> resultList = (List<Map>)this.getJdbcTemplate().execute(
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
			           while (rs.next()) {
			        	   Map rowMap = new HashMap();
			        	   rowMap.put("recvdate", rs.getString("recvdate"));
		                   rowMap.put("idd", rs.getString("idd"));
		                   rowMap.put("e_total", fullNumString(rs.getString("e_total")));
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
		Map resultMap = (Map)this.getJdbcTemplate().execute(
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
				           infoMap.put("firstname", rs.getString("firstname"));
				           infoMap.put("secondname", rs.getString("secondname"));
				           infoMap.put("stationname", rs.getString("stationname"));
				           rs.close();
				           return infoMap;
				        }
				   });
		return resultMap;
	}
	
	public List<Map> getReportListInfoEvent(final int stationId,final int reportType,final String itemstr){
		List<Map> resultList = (List<Map>)this.getJdbcTemplate().execute(
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
		                   rowMap.put("msgtype", rs.getString("msgtype"));
		                   rowMap.put("occdt", fullNumString(rs.getString("occdt")));
		                   rowMap.put("context", rs.getString("context"));
		                   resultsList.add(rowMap);
			           }
			           rs.close();
			           return resultsList;
			        }
			   });
		return resultList;
	}
	
	public Map getMailServerInfo(){
		Map res=(Map) this.getJdbcTemplate().execute( 
			     new CallableStatementCreator() { 
			        public CallableStatement createCallableStatement(Connection con) throws SQLException { 
			           String storedProc = "{call sp_mail_get_sender(?)}"; 
			           CallableStatement cs = con.prepareCall(storedProc); 
			           cs.registerOutParameter(1, OracleTypes.CURSOR);
			           return cs; 
			        } 
			     }, new CallableStatementCallback() { 
			         public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException { 
			        	   Map rowMap = new HashMap();
				           cs.executeUpdate();
				           ResultSet rs = (ResultSet) cs.getObject(1);
				           if (rs.next()) {
				        	   rowMap.put("smtp", rs.getString("smtp"));
			                   rowMap.put("port", rs.getString("port_a"));
			                   rowMap.put("validate", rs.getString("validate_a"));
			                   rowMap.put("account", rs.getString("account"));
			                   rowMap.put("password", rs.getString("password"));
			                   rowMap.put("email", rs.getString("mailaddr"));
				           }
				           rs.close();
				           return rowMap;
			         } 
			     }); 
		return res;
	}

	public String getProperties(String res,String fileName) {
		String s="";
		Properties p;
		FileInputStream in;
		FileOutputStream out;
		File file = new File(fileName);
		try {
			in = new FileInputStream(file);
			p = new Properties();
			p.load(in);
			s=p.getProperty(res);
			in.close();
		} catch (FileNotFoundException e) {
			logger.error("配置文件config.properties找不到！" + e);
		} catch (IOException e) {
			logger.error("读取配置文件config.properties错误！" + e);
		}
		return s;
	}
	
	/** 
     * 验证Email 
     * @param email email地址 
     * @return 验证成功返回true，验证失败返回false 
     */  
    public static boolean checkEmail(String email) {  
        String regex = "(\\s*\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\\s*;*+)*";  
        return Pattern.matches(regex, email);  
    }  
    
}
