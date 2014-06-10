package com.jstrd.asdc.thread;

import com.jstrd.asdc.email.SimpleMailSender;

public class RegMailSetThread extends Thread{
	
	@Override
	public void run() {
		SimpleMailSender simpleMailSender = new SimpleMailSender();
		try{
			while(true){
				if(Data.map.size() > 0){
					simpleMailSender.mailInfo = Data.getMessage();
					simpleMailSender.run();
				}
				Thread.sleep(500);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
