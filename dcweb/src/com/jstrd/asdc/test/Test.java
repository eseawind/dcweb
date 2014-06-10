package com.jstrd.asdc.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

public class Test {
	private static Logger logger = Logger.getLogger(Test.class.getName());

	public static void main(String[] args) {
		
	}
	
	/** 
     * 验证Email 
     * @param email
     * @return 验证成功返回true，验证失败返回false 
     */  
    public static boolean checkEmail(String email) {  
        String regex = "(\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*;*+)*";  
        return Pattern.matches(regex, email);  
    }  

	public static String getSpecifiedDayBefore(String specifiedDay) {
		Calendar calendar = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd HH:mm:ss")
					.parse(specifiedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		calendar.setTime(date);
		int day = calendar.get(Calendar.DATE);
		calendar.set(Calendar.DATE, day - 1);
		String dayBefore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(calendar.getTime());
		return dayBefore;
	}
}
