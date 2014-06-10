package com.jstrd.asdc.datasource;

import org.apache.log4j.Logger;

public class DbContextHolder {
	
	static Logger log = Logger.getLogger(DbContextHolder.class);
	private static final ThreadLocal contextHolder = new ThreadLocal();
	
	public static void setDbType(String dbType){
		contextHolder.set(dbType);
	}
	
	public static String getDbType(){
		return (String)contextHolder.get();
	}
	
	public static void clearDbType(){
		contextHolder.remove();
	}

}

