package com.jstrd.asdc.datasource;

import java.sql.Connection;   
import java.sql.SQLException;   
   
import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;   
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;   
import org.springframework.web.context.WebApplicationContext;   
import org.springframework.web.context.support.WebApplicationContextUtils;   

public class DynamicDataSource extends AbstractRoutingDataSource{

	static Logger log=Logger.getLogger("DynamicDataSource");
	/* 
	 * @see org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource#determineCurrentLookupKey()
	 */
	protected Object determineCurrentLookupKey() {
		return DbContextHolder.getDbType();
	}
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		return false;
	}
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return null;
	}
	
}



