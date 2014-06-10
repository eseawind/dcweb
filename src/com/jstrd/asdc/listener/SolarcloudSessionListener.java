package com.jstrd.asdc.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionActivationListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

/**
 * 监听Http会话
 * @author Snow
 * @version 19/12/2013
 */
public class SolarcloudSessionListener implements
		HttpSessionActivationListener, HttpSessionBindingListener,
		HttpSessionAttributeListener, HttpSessionListener,
		ServletContextListener {
	
	private static Logger logger = Logger.getLogger(SolarcloudSessionListener.class);
	ServletContext context;
	int users = 0;

	public void sessionDidActivate(HttpSessionEvent hse) {
		logger.info("sessionDidActivate("+hse.getSession().getId()+")");
	}

	public void sessionWillPassivate(HttpSessionEvent hse) {
		logger.info("sessionWillPassivate("+hse.getSession().getId()+")");
	}

	public void valueBound(HttpSessionBindingEvent hsbe) {
		logger.info("session: valueBound('"+hsbe.getSession().getId() + "', '" + hsbe.getValue() + "')");
	}

	public void valueUnbound(HttpSessionBindingEvent hsbe) {
		logger.info("session: valueUnbound('"+hsbe.getSession().getId() + "', '" + hsbe.getValue() + "')");
	}

	public void attributeAdded(HttpSessionBindingEvent hsbe) {
		logger.info("session: attributeAdded('" + hsbe.getSession().getId() + "', '" + hsbe.getName() + "', '" + hsbe.getValue() + "')");
	}

	public void attributeRemoved(HttpSessionBindingEvent hsbe) {
		logger.info("session: attributeRemoved('" + hsbe.getSession().getId() + "', '" + hsbe.getName() + "', '" + hsbe.getValue() + "')");
	}

	public void attributeReplaced(HttpSessionBindingEvent hsbe) {
		logger.info("session: attributeReplaced('" + hsbe.getSession().getId() + "', '" + hsbe.getName() + "', '" + hsbe.getValue() + "')");
	}

	public void sessionCreated(HttpSessionEvent hse) {
		users++;
		logger.info("session: sessionCreated('" + hse.getSession().getId() + "'),目前有[" + users + "]个用户");
	}

	public void sessionDestroyed(HttpSessionEvent hse) {
		users--;
		logger.warn("session: sessionDestroyed('" + hse.getSession().getId() + "'),目前有[" + users + "]个用户");
	}

	public void contextDestroyed(ServletContextEvent sce) {
		logger.fatal("session: contextDestroyed()-->ServletContext被销毁");
        this.context = null;
	}

	public void contextInitialized(ServletContextEvent sce) {
		this.context = sce.getServletContext();
	    logger.info("session: contextInitialized()-->ServletContext初始化了");
	}

}
