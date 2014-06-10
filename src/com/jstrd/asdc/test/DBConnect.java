package com.jstrd.asdc.test;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {


	public static void main(String[] args) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");// 加载驱动类
		String url = "jdbc:oracle:thin:@58.210.73.86:1591:orcl";// 数据库为school
		String user = "dcweb";// 用户名system
		String password = "dcwebtest";// 登录密码
		Connection con = DriverManager.getConnection(url, user, password);
		System.out.println(con);
	}
}
