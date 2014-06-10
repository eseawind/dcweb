package com.jstrd.asdc.interceptor;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.interceptor.I18nInterceptor;

/**
 * 为struts2配置语言环境
 * 
 */
@SuppressWarnings("serial")
public class DefaultLanguageInterceptor extends AbstractInterceptor {

	
	@SuppressWarnings("unchecked")
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Locale locale = null;
		// 获取request的参数列表
		Map<String, Object> params = ServletActionContext.getRequest()
				.getParameterMap();
		// 获取session
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		// 获取request中request_locale参数值
		Object requested_locale = findLocaleParameter(params,
				I18nInterceptor.DEFAULT_PARAMETER);
		
		// 如果request中request_locale参数值为null，则获取request_only_locale参数值
		if (requested_locale == null) {
			
			requested_locale = findLocaleParameter(params,
					I18nInterceptor.DEFAULT_PARAMETER);
			// 如果request中request_only_locale参数值为null，则从session中获取WW_TRANS_I18N_LOCALE值，该值是struts2
			// 框架中的i18n拦截器根据request的request_locale参数值设置的语言环境
			if (requested_locale == null) {
			
				requested_locale = session
						.get(I18nInterceptor.DEFAULT_SESSION_ATTRIBUTE);
				// 如果session中不存在WW_TRANS_I18N_LOCALE值，则获取ActionContext的语言环境
				if (requested_locale == null) {
				
					requested_locale = invocation.getInvocationContext()
							.getLocale();
				}
			}
		}
		
		
		invocation.getInvocationContext().setLocale(locale);
		return invocation.invoke();
	}

	/**
	 * 从Map集合中获取指定元素的值
	 * 
	 * @param params
	 * @param parameterName
	 * @return
	 */
	private Object findLocaleParameter(Map<String, Object> params,
			String parameterName) {
		Object requested_locale = params.get(parameterName);
		if (requested_locale != null && requested_locale.getClass().isArray()
				&& ((Object[]) requested_locale).length == 1) {
			requested_locale = ((Object[]) requested_locale)[0];
		}
		return requested_locale;
	}
}