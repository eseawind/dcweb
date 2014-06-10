package com.jstrd.asdc.util;

import java.util.TimeZone;

public class Calenda {
	
	public static synchronized Calenda getInstance(TimeZone zone){
		
		Calenda cal = Calenda.getInstance(TimeZone.getDefault());
		
		return cal;
	}
	
	@SuppressWarnings("static-access")
	public static void main(String[] args) {
		Calenda cal = new Calenda();
		Calenda s = cal.getInstance(TimeZone.getDefault());
		System.out.println(s);
	}
	
}
