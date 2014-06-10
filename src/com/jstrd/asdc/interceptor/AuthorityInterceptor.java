package com.jstrd.asdc.interceptor;


import java.util.Locale;
import java.util.Map;
import javax.servlet.http.*;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
public class AuthorityInterceptor extends AbstractInterceptor {
	/**
	 * 
	 */
	
	private static final long serialVersionUID = -5093785975261187593L;

	//拦截Action处理的拦截方法   
    public String intercept(ActionInvocation invocation) throws Exception {   
        // 取得请求相关的ActionContext实例   
        ActionContext ctx=invocation.getInvocationContext();   
        HttpServletRequest request = (HttpServletRequest) ctx.get(StrutsStatics.HTTP_REQUEST); 
        Map session=ctx.getSession();   
        /*if (session.get("WW_TRANS_I18N_LOCALE")!=null && !session.get("WW_TRANS_I18N_LOCALE").toString().equals("")){
			 String locals=session.get("WW_TRANS_I18N_LOCALE").toString().trim();
			 if (locals.equals("en_US")){
				 ctx.setLocale(Locale.US);
				 session.put("WW_TRANS_I18N_LOCALE","en_US");
			 }
			 else if (locals.equals("zh_CN")){
				 ctx.setLocale(Locale.SIMPLIFIED_CHINESE);

				 session.put("WW_TRANS_I18N_LOCALE","zh_CN");
			 }
			 else{
				 ctx.setLocale(Locale.SIMPLIFIED_CHINESE);
				 session.put("WW_TRANS_I18N_LOCALE","zh_CN");
			 }
		 }
		 else{
			 ctx.setLocale(request.getLocale());
			 session.put("WW_TRANS_I18N_LOCALE",request.getLocale());
		 }
        ctx.setSession(session);*/
        String stationId ="0";
        if (session.get("defaultStation")!=null)
        	stationId=session.get("defaultStation").toString();
        //取出名为user的session属性   
        Object email=(Object)session.get("email");
       
        String s=ctx.getName();
        //如果没有登陆
        if(email!=null || s.equals("sharePlantCheck") || s.equals("userRegCheck") || s.equals("gotoindex") || s.equals("tologin") || s.equals("powerlist") || s.equals("updatePasswdShow")|| s.equals("updatePasswd")|| s.equals("updatePasswdMail") || s.equals("updatePasswdType")){   
        	
        	return invocation.invoke();   
        }   
         
        return "tologin";           
    }

	
}
