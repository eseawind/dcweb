package com.jstrd.asdc.action;

import org.apache.log4j.Logger;
public class MainAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger(MainAction.class);
	
	public String mainPage(){
		if (this.getSession().getAttribute("user")!=null)		
			return "mainPage";
		else	
            return "tologin";
	}
	
}
