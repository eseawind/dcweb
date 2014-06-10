package com.jstrd.asdc.thread;

import java.util.HashMap;
import java.util.Map;

import com.jstrd.asdc.email.MailSenderInfo;

public class Data {

	public static Map map = new HashMap();
	private static MailSenderInfo mailSenderInfo;
	
	public static synchronized MailSenderInfo getMessage(){
		if(map.size() > 0){
			mailSenderInfo = (MailSenderInfo) map.get(0);
			map.remove(0);
		}
		return mailSenderInfo;
	}
	
	public static synchronized void setMessage(MailSenderInfo mailSenderInfo){
		map.put(map.size(), mailSenderInfo);
	}
}
