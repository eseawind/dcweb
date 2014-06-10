package com.jstrd.asdc.thread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;


public class StartThread implements ServletContextListener {
	
	private static Logger logger = Logger.getLogger(StartThread.class);
	private ReportMailThread myThread;

	public void contextDestroyed(ServletContextEvent e) {
		if (myThread != null && myThread.isInterrupted()) {
			myThread.interrupt();
		}
	}

	public void contextInitialized(ServletContextEvent sce) {
		String str = null;
		if (str == null && myThread == null) {
			try {
				myThread = new ReportMailThread();
				myThread.start(); // servlet 上下文初始化时启动 socket
			} catch (Exception e) {
				logger.error(e);
			}
			
		}
	}
}
