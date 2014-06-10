package com.jstrd.asdc.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

/**
 * 监听Http上下文
 * @author Snow
 * @version 19/12/2013
 */
@SuppressWarnings("unused")
public class SolarcloudContextListener implements ServletContextListener, ServletContextAttributeListener {

	private Logger logger = Logger.getLogger(SolarcloudContextListener.class);
	private ServletContext context = null;
	
	/**
	 * 实现ServletContextListener接口
	 */
	public void contextDestroyed(ServletContextEvent sce) {
		logger.fatal("context: contextDestroyed()->ServletContext被销毁");
		this.context = null;
	}

	public void contextInitialized(ServletContextEvent sce) {
		this.context = sce.getServletContext();
		logger.info("context: contextInitialized->ServletContext初始化");
	}

	/**
	 * 实现ServletContextAttributeListener接口
	 */
	public void attributeAdded(ServletContextAttributeEvent scae) {
		logger.info("context: 增加了一个ServletContext属性：attributeAdded('"+scae.getName()+"', '"+scae.getValue()+"')");
	}

	public void attributeRemoved(ServletContextAttributeEvent scae) {
		logger.info("context: 删除了一个ServletContext属性：attributeRemoved('"+scae.getName()+"', '"+scae.getValue()+"')");
	}

	public void attributeReplaced(ServletContextAttributeEvent scae) {
		logger.info("context: 某个ServletContext的属性被改变：attributeReplaced('"+scae.getName()+"', '"+scae.getValue()+"')");
	}

}
