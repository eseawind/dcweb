<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/power.js"></script>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_POWER"/></a>
</div>
<div class="rightcon">
		<div class="p_rt">
			<div class="p_rtb">
				<div class="p_rttitle"><s:text name="RES_POWER"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
				<div class="p_rttab">
					<div id="tab_day" class="tab" linked='power.action?type=day'>
						<s:if test="type=='day'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_DAILY" /></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_DAILY" /></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div id="tab_month"  class="tab" style="margin-left: 10px;" linked="power.action?type=month">
						<s:if test="type=='month'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_MONTHLY" /></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_MONTHLY" /></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div id="tab_year" class="tab" style="margin-left: 10px;" linked="power.action?type=year">
						<s:if test="type=='year'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_YEARLY" /></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_YEARLY" /></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div id="tab_allyear" class="tab" style="margin-left: 10px;" linked="power.action?type=allyear">
						<s:if test="type=='allyear'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_ALLYEAR" /></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_ALLYEAR" /></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
				</div>
				
				<div style="float:right; height: 24px;font-weight: bold;line-height: 24px;margin-top: 35px;">
					<input id="t" type="hidden" value="power" />
					<input id="ct" type="hidden" value='<s:property value="type" />' />
					<div style="float: left;width: 60px; cursor: pointer;">
						<div class="dot_csv"></div>
						<div style="float: left;" onclick="download.cvsdownload();"><span class="spantitle">CSV</span></div>
					</div>
					<div style="float: left;width: 60px; cursor: pointer;">
						<div class="dot_text"></div>
						<div style="float: left;" onclick="download.txtdownload();"><span class="spantitle"><s:text name="RES_TEXT" /></span></div>
					</div>
					<div style="float: left;width: 60px; cursor: pointer;">
						<div class="dot_print"></div>
						<div style="float: left;"><span class="spantitle" onclick="window.print();"><s:text name="RES_PRINT" /></span></div>
					</div>
				</div>
			</div>
			<div style="height: 20px;"></div>
			<div>
				<div class="e_showcon1">
					<s:if test="type=='day'">
						<div style="height: 30px;line-height: 30px;background: #fff;border: 1px solid #ccc;width:295px;margin: 10px auto;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="100px;" align="center"><s:text name="RES_CHOOSEDATE"></s:text>：</td>
									<td width="140px;" align="center"><input id="d11" style="line-height: 20px;" class="Wdate" type="text" style="cursor: pointer;" readonly="readonly" value='<s:property value="day"/>'  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',lang:'<%= lang %>',startDate:'<s:property value="day"/>'})" /></td>
									<td width="50px;" align="center"><input style="border:1px solid #ccc;padding: 2px 9px;" type="button" value="<s:text name='RES_OK' />" onclick="Power.daySubmit();"></td>
								</tr>
							</table>
						</div>
						<div style="width: 90%;height: 560px;margin: 0 auto;">
							<div id="flashCont">
						 			<script type="text/javascript">
						 				var flashvars = {"lang":"<%= lang %>","stationid":"<s:property value='#session.defaultStation' />","baseUrl":"<%= baseUrl %>"}
						 				showFlashElement("swf/OVDaily.swf",flashvars);
						 			</script>
						 	</div>
					 	</div>
				 	</s:if>
				 	<s:elseif test="type=='month'">
				 		<div style="height: 30px;line-height: 30px;background: #fff;border: 1px solid #ccc;width:295px;margin: 10px auto;">
				 			<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="100px;" align="center"><s:text name="RES_CHOOSEMONTH"></s:text>：</td>
									<td width="140px;" align="center"><input id="d12" style="line-height: 20px;" class="Wdate" type="text" value='<s:property value="day.substring(0,7)"/>' onClick="WdatePicker({dateFmt:'yyyy-MM',lang:'<%= lang %>'})" /></td>
									<td width="50px;" align="center"><input style="border:1px solid #ccc;padding: 2px 9px;" type="button" value="<s:text name='RES_OK' />" onclick="Power.monthSubmit();"></td>
								</tr>
							</table>
						</div>
						<div style="width: 90%;height: 560px;margin: 0 auto;">
							<div id="flashCont">
						 			<script type="text/javascript">
						 				var flashvars = {"lang":"<%= lang %>","stationid":"<s:property value='#session.defaultStation' />","baseUrl":"<%= baseUrl %>"}
						 				showFlashElement("swf/OVMonthly.swf",flashvars);
						 			</script>
						 	</div>
					 	</div>
				 	</s:elseif>
				 	<s:elseif test="type=='year'">
				 		<div style="height: 30px;line-height: 30px;background: #fff;border: 1px solid #ccc;width:295px;margin: 10px auto;">
				 			<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="100px;" align="center"><s:text name="RES_CHOOSEYEAR"></s:text>：</td>
									<td width="140px;" align="center"><input id="d13" style="line-height: 20px;" class="Wdate" type="text" value='<s:property value="day.substring(0,4)"/>' onClick="WdatePicker({dateFmt:'yyyy',lang:'<%= lang %>'})" /></td>
									<td width="50px;" align="center"><input style="border:1px solid #ccc;padding: 2px 9px;" type="button" value="<s:text name='RES_OK' />" onclick="Power.yearSubmit();"></td>
								</tr>
							</table>
						</div>
						<div style="width: 90%;height: 560px;margin: 0 auto;">
					 		<div id="flashCont">
						 			<script type="text/javascript">
						 				var flashvars = {"lang":"<%= lang %>","stationid":"<s:property value='#session.defaultStation' />","baseUrl":"<%= baseUrl %>"}
						 				showFlashElement("swf/OVYearly.swf",flashvars);
						 			</script>
						 	</div>
					 	</div>
				 	</s:elseif>
				 	<s:elseif test="type=='allyear'">
				 		<div style="height: 40px;"></div>
				 		<div style="width: 90%;height: 560px;margin: 0 auto;">
					 		<div id="flashCont">
						 			<script type="text/javascript">
						 				var flashvars = {"lang":"<%= lang %>","stationid":"<s:property value='#session.defaultStation' />","baseUrl":"<%= baseUrl %>"}
						 				showFlashElement("swf/OVAllyears.swf",flashvars);
						 			</script>
						 	</div>
					 	</div>
				 	</s:elseif>
				</div>
			</div>
			<div class="clear"></div>
	     </div>
</div>
