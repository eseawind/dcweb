package com.jstrd.asdc.thread;

import org.apache.log4j.Logger;

public class ReportMailThread extends Thread { 
	
	private static Logger logger = Logger.getLogger(ReportMailThread.class);
	DoReportMail domail;
	
	public void run() { 
		try {
			while (!this.isInterrupted()) {
				if (null == domail) {
					domail = new DoReportMail();
				}
				domail.reportMail();
				Thread.sleep(300000);
			}
		} catch (Exception e) {
			logger.error(e);
		}
    }  
}
