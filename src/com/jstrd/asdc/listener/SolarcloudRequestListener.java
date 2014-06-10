package com.jstrd.asdc.listener;

import javax.servlet.ServletRequest;
import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;

import org.apache.log4j.Logger;

/**
 * 监听请求
 * @author Snow
 * @version 19/12/2013
 */
@SuppressWarnings("unused")
public class SolarcloudRequestListener implements ServletRequestListener,
		ServletRequestAttributeListener {

	private static Logger logger = Logger.getLogger(SolarcloudRequestListener.class);
	private ServletRequest request;
	
	public void requestDestroyed(ServletRequestEvent sre) {
		logger.info("request: request destroyed");
	}

	public void requestInitialized(ServletRequestEvent sre) {
		logger.info("request: request init");
		request = sre.getServletRequest();
	}

	public void attributeAdded(ServletRequestAttributeEvent srae) {
		logger.info("request: attributeAdded('" + srae.getName() + "', '" + srae.getValue() + "')");
	}

	public void attributeRemoved(ServletRequestAttributeEvent srae) {
		logger.info("request: attributeRemoved('" + srae.getName() + "', '" + srae.getValue() + "')");
	}

	public void attributeReplaced(ServletRequestAttributeEvent srae) {
		logger.info("request: attributeReplaced('" + srae.getName() + "', '" + srae.getValue() + "')");
	}

}
