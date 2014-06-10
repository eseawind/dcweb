package com.jstrd.asdc.dao.impl;

import org.springframework.jdbc.core.JdbcTemplate;

public class BaseDaoImpl {
	
	public JdbcTemplate jdbcTemplate ;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	

}
