<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="js/chart.js"></script>
<script type="text/javascript">
	DCPOWER.init('null',"acf",'<%= request.getAttribute("type").toString() %>','<%= request.getAttribute("sdate").toString() %>');
</script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_CO2V"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_CO2V"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
			<div class="dot_con">
				<input id="t" type="hidden" value="co2v" />
				<input id="ct" type="hidden" value='<s:property value="type" />' />
				<div class="_link" onclick="download.cvsdownload();">
					<div class="dot_csv" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle">CSV</span></div>
				</div>
				<div class="_link" onclick="download.txtdownload();">
					<div class="dot_text" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle"><s:text name="RES_TEXT" /></span></div>
				</div>
				<div class="_link"  onclick="download.printCharts();">
					<div class="dot_print" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle"><s:text name="RES_PRINT" /></span></div>
				</div>
			</div>
		</div>
		<div class="p_rtb" style="float: left;">
			<div class="p_rttab" style="left: 10px;">
					<div class="tab" linked='co2v.action?type=day'>
						<s:if test="type=='day'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_7DAYS"/></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_7DAYS"/></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div class="tab" style="margin-left: 10px;" linked='co2v.action?type=month'>
						<s:if test="type=='month'" >
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_12MONTHS"/></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_12MONTHS"/></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div class="tab" style="margin-left: 10px;" linked='co2v.action?type=year'>
						<s:if test="type=='year'" >
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_YEARS"/></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_YEARS"/></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
			</div>
		</div>	
		<div class="e_bluecon" style="height: auto;">
			<s:if test="type=='day'" >
			<div style="width: 90%;height:560px;margin: 0 auto;padding-top: 20px;">
				<div id="flashCont">
					<s:property  value='#session.defaultStation'/>
						 <script type="text/javascript">
							 	//var flashvars = {"lang":"<%= lang %>","isno":"88830000000000030000","baseUrl":"<%= baseUrl %>","type":"day","date":"2012-02-03"}
							 	var flashvars = {"lang":"<%= lang %>","stationid":"<s:property  value='#session.defaultStation'/>","baseUrl":"<%= baseUrl %>","type":"day","date":"<s:property  value='sdate'/>"}
							 	showFlashElement("swf/Co2Day.swf",flashvars);
						 </script>
				</div>
			</div>
			</s:if>
			<s:elseif test="type=='month'">
			<div style="width: 90%;height:560px;margin: 0 auto;padding-top: 20px;">
				<div id="flashCont">
						 <script type="text/javascript">
							 	//var flashvars = {"lang":"<%= lang %>","isno":"88830000000000030000","baseUrl":"<%= baseUrl %>","type":"day","date":"2012-02-03"}
							 	var flashvars = {"lang":"<%= lang %>","stationid":"<s:property  value='#session.defaultStation'/>","baseUrl":"<%= baseUrl %>","type":"day","date":"<s:property  value='sdate'/>"}
							 	showFlashElement("swf/Co2Month.swf",flashvars);
						 </script>
				</div>
			</div>
			</s:elseif>
			<s:elseif test="type=='year'">
			<div style="width: 90%;height:560px;margin: 0 auto;padding-top: 20px;">
				<div id="flashCont">
						 <script type="text/javascript">
							 	//var flashvars = {"lang":"<%= lang %>","isno":"88830000000000030000","baseUrl":"<%= baseUrl %>","type":"day","date":"2012-02-03"}
							 	var flashvars = {"lang":"<%= lang %>","stationid":"<s:property  value='#session.defaultStation'/>","baseUrl":"<%= baseUrl %>","type":"day","date":"<s:property  value='sdate'/>"}
							 	showFlashElement("swf/Co2Year.swf",flashvars);
						 </script>
				</div>
			</div>
			</s:elseif>
		</div>
		<div class="clear"></div>
	</div>
</div>