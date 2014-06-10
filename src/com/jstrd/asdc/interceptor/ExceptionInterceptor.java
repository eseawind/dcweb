package com.jstrd.asdc.interceptor;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

@SuppressWarnings("unused")
public class ExceptionInterceptor extends AbstractInterceptor {

	private static final Logger logger = Logger.getLogger(ExceptionInterceptor.class);
	private static final long serialVersionUID = 7136889317639982659L;

	@Override
	public String intercept(ActionInvocation invocation) {
		String result = null;
		String actionName = invocation.getInvocationContext().getName();
		try {
			result = invocation.invoke();
		} catch (Exception e) {
			logger.error("异常拦截器拦截到异常信息: [" + e.toString() + "], action名称为：" + actionName + ".action", e);
		}
		return "exceptionPage";
	}
	
}
