<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
	 			<div class="tabpowerplant_on" onclick="drawmenu.clickMenu(this)"><s:text name="RES_OVERVIEW"/></div>
	 				<ul class="menuul" style="display: block;">
	 					<li class='lion'><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="powerlist.action" ><s:text name="RES_POWERLIST"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="overview.action" ><s:text name="RES_POWERINF"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="power.action"><s:text name="RES_POWER"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="event.action"><s:text name="RES_EVENT"/></a></li>
	 				</ul>
	 			<div class="tabchart_off"  onclick="drawmenu.clickMenu(this)"><s:text name="RES_CHART"/></div>
	 				<ul class="menuul" style="display: none;">
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="dcp.action"><s:text name="RES_DCP"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="dcc.action"><s:text name="RES_DCC"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="dcv.action"><s:text name="RES_DCV"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="acp.action"><s:text name="RES_ACP"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="acf.action"><s:text name="RES_ACF"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="acc.action"><s:text name="RES_ACC"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="acv.action"><s:text name="RES_ACV"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="inve.action"><s:text name="RES_INVE"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="income.action"><s:text name="RES_INCOME"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="co2v.action"><s:text name="RES_CO2V"/></a></li>
	 				</ul>
	 			<div class="tabconf_off" onclick="drawmenu.clickMenu(this)"><s:text name="RES_CONF"/></div>
	 				<ul class="menuul" style="display: none;">
	 					<!-- 基本设置包括电站管理 逆变器管理 -->
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="showStationPmu.action"><s:text name="RES_EQUIPMENTOVERVIEW"/></a></li>
	 					<!-- 
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="showStationInv.action"><s:text name="RES_INVMANAGER"/></a></li>
	 					 -->
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="userconf.action"><s:text name="RES_USET"/></a></li>
	 					<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="reportConf.action"><s:text name="RES_CONFIG_REPORT"/></a></li>
	 					<s:if test="#session.user.ROLEID==4">
	 						<li><a href="javascript:;" onclick="drawmenu.clickli(this);return false;" linked="rolemanager.action"><s:text name="RES_ROLELIMITSCONF"/></a></li>
	 					</s:if>
	 				</ul> 
				<div class="clear"></div>