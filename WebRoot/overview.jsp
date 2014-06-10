<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_POWERINF"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_POWERINF"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
	<div  class="rightcon" style="text-align: center;" >
		<div style="width:90%;margin: 0 auto;height: 600px; overflow: hidden;">
			<div id="flashCont">
		 			<script type="text/javascript">
		 				var flashvars = {"lang":"<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>","stationid":"<s:property value='#session.defaultStation' />","baseUrl":"<%= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" %>"}
		 				showFlashElement("swf/OverView.swf",flashvars);
		 			</script>
		 	</div>
	 	</div>
	 	<div class="clear"></div>
	</div>
</div>