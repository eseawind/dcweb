<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
    <script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/createStation.js"></script>
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
  		changeTimezone();
  		$("#titleSpan").html("<s:text name="RES_CREATESTATION"/>");
			createStation.init();
		});
  	</script>
	<script type="text/javascript">
 		function changeCountry(cid){
			if(cid==0){
				
			}else{
			hiddenFrame.location.href="stateList.action?countryId="+cid;
			}
		}
		
		function changeCurrency(val){
			$('#incomerateu').html(val);
		}
	</script>
	
	<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		-->
	</style>
	<style type="text/css">
		<!--
		.STYLE1 {
			color: #FFFFFF;
			font-weight: bold;
			font-size: 18px
		}
		.STYLE3 {color: #CCCCCC; font-weight: bold; font-size: 16px}
		-->
	</style>
	<style>
		#flashCont {
		  	position: absolute;
		   	width:600px;
		  	height:400px;
		  	left:40%;
		  	top:25%;
		  	margin-left:-50px;
		 	margin-top:-25px;
		  	Z-INDEX: 9999;
		}
		#frame1 {
		  	position: absolute;
		  	width:580px;
		  	height:360px;
		  	left:40%;
		  	top:27%;
		  	margin-left:-50px;
		  	margin-top:-25px;
		  	Z-INDEX: 6000;
		}
		.button2 {
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/buttom_bg1.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			height: 28px;
			width:63px;
		}
		.Wdate1 {
		    border: 1px solid rgb(153, 153, 153);
		    height: 20px;
		    width: 85px;
		    background: url("/datepicker/skin/datePicker.gif") no-repeat scroll right center rgb(255, 255, 255);
		    line-height: 20px;
		    text-indent: 5px;
		}
	</style>
</head>
<body onload="$('#flashCont')[0].style.display='none';$('#incomerateu').html($('#currency').val());">
<IFRAME id="frame1" width="300px" height="300px" style="position:absolute;z-index:1; background-color:Blue; display:none;" mce_style="position:absolute;z-index:1; background-color:Blue; display:none;" frameborder="0"></IFRAME>  
<%
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<div id='flashCont' width='600' height='400' ></div>
<script type="text/javascript">
	<%
	String lang="en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null)
	lang= session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	%>
	var flashvars = {"lang":"<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>","sid":"<s:property value="#session.defaultStation" />","baseUrl":"<%=baseUrl%>"}
	showFlashElement("swf/face.swf", flashvars);
</script>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
    	<td ><%@include file="HeadMenu.jsp" %></td>
  	</tr>
  	<tr>
    	<td height="813" align="center" bgcolor="#E5EFF9">
    	<s:form name="createStationForm" id="createStationForm" action="createNewStationQuery.action" method="post">
   			<input type="hidden" id="picurl" name="picurl" value=""/>
   			<input type="hidden" name="opdate" id="opdate" value=""/>
    		<table width="920" border="0" cellspacing="0" cellpadding="0"/>
      			<tr>
        			<td><img src="images/add1.gif" width="920" height="10" /></td>
      			</tr>
      			<tr>
        			<td height="668" align="center" background="images/regin6.gif">
        				<table width="85%" border="0" cellspacing="0" cellpadding="0">
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" colspan="4" align="left" ><span class="blue3"><s:text name="RES_DEV_INFO"/></span></td>
                			</tr>
              				<tr>
              					<td rowspan="2" align="right" class="blue1">
              					<%
              						if (lang.equals("zh_CN")){
              					%>
              					<img src="images/add2.gif" width="82" height="82"  id="stface" onclick="changFac()"/>
              					<%}else{
              					%>
              					<img src="images/add2_1.gif" width="82" height="82"  id="stface" onclick="changFac()"/>
              					<%
              					}
              					%>
              					</td>
                				<td height="33" align="right" class="blue1"><span class="black2">*&nbsp;<s:text name="RES_SERIALNUMBER"/>：</span></td>
                				<td height="33" align="left" class="blue1" width="60%"> 
                					<input name="psno" type="text" class="test_input5" id="psno"  maxlength="14"/>
                  					<input type="hidden" id="psnoflag"/>
                  				</td>
                				<td rowspan="9" align="left" valign="top">
                					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                  						<tr>
                    						<td width="16%" align="center" valign="top"><img src="images/regin7.gif" width="22" height="22" /></td>
                    						<td width="84%" align="left" valign="top" class="black2"><s:text name="RES_PMUNO_INFO"/></td>
                  						</tr>
                  						<tr>
                    						<td align="center" valign="top">&nbsp;</td>
                    						<td height="50" align="center" class="black2"><img src="images/add4new.gif" width="154" height="240" /></td>
                  						</tr>
                					</table>
                				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"><span class="black2">*&nbsp;<s:text name="RES_PMULCODE"/>：</span></td>
                				<td height="33" colspan="2" align="left" class="blue1">
                 					<input name="registno" type="text" class="test_input5" id="registno"  maxlength="16"/>                  
                 				</td>
                			</tr> 
                			<tr>
                				<td height="33" align="right" class="blue1"></td>
                				<td height="33" align="left" class="blue1" colspan="4">&nbsp;<span id="psno_tip"></span></td>
                			</tr>
							<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" colspan="4" align="left" class="blue3"><s:text name="RES_POWERINF"/></td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td width="25%" height="33" align="right" class="black2">* <s:text name="RES_STATIONNAME"/>：</td>
				                <td width="38%" align="left" colspan="3"><input id="stationname" name="stationname" type="text" class="test_input5"  maxlength="30"/></td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_INSTALLCAP"/>：</td>
				                <td align="left" colspan="3" class="blue1">
				                	<input name="installcap" id="installcap" type="text" class="test_input7"  maxlength="10"/>&nbsp;&nbsp;KW<span id="installcap_tip">&nbsp;
				                </td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_STARTDT"/>：</td>
				                <td align="left" class="blue1" colspan="3">
				                	<input name="startdt" id="startdt" type="text" size="13" class="Wdate1" type="text" value="<s:property value='startdt'/>" onFocus="WdatePicker({maxDate:'#F{\'2050-01-01\'}',lang:'<%= lang %>'})"/><span id="startdt_tip"></span>
				                </td>
              				</tr>              
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_COMPANY"/>：</td>
				                <td align="left" colspan="3" class="blue1">
				                	<input name="company" id="company" type="text" class="test_input5" maxlength="50"/>&nbsp;&nbsp;
				                </td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_COUNTRY"/>：</td>
                				<td align="left" colspan="3" class="blue1">
                					<select name="country" id="country" class="test_input7ex" >
                						<option value="0"><s:text name="RED_REGISTER_SELECT"/></option>
                  						<s:set name="cn" value="country" />
                 						<s:iterator id="country" status="ss" value="countryList">
                 						<s:if test="#cn==#country.c_code">
		         						<option value="<s:property value="#country.c_code" />"  selected="selected"><s:property value="countryname" /></option>
	     								</s:if>
 										<s:else>
 										<option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
	     								</s:else>
	     								</s:iterator>
                  					</select>
                  					<span id="country_tip"></span>
                  				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_STATE"/>：</td>
                				<td align="left" colspan="3" class="blue1">
                					<select name="state" id="state" class="test_input7ex" >
                						<option value="0"><s:text name="RED_REGISTER_SELECT"/></option>
                						<s:set name="st" value="state" />
                 						<s:iterator id="state" status="ss" value="stateList">
                  						<s:if test="#st==#state.c_code">
		         						<option value="<s:property value="#state.c_code"  />" selected="selected"><s:property value="countryname" /></option>
		         						</s:if>
 										<s:else>
 										<option value="<s:property value="#state.c_code" />"><s:property value="countryname" /></option>
 										</s:else>
	     								</s:iterator>
                					</select>
                					<span id="state_tip"></span>
                				</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_CITY"/>：</td>
				                <td align="left" class="blue1">
				                	<input name="city" id="city" type="text" class="test_input7"  maxlength="15"/>
				                	<span id="city_tip"></span>
				                </td>
				                <td align="left">&nbsp;</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_ADDRESS_NUM"/>：</td>
				                <td align="left">
				                	<input name="street" id="street" type="text" class="test_input5" maxlength="50"/>
				                </td>
				                <td align="left" id="street_tip" class="blue1">&nbsp;</td>
				                <td align="left">&nbsp;</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_ZIP"/>：</td>
				                <td align="left">
				                	<input name="zip" id="zip" type="text" class="test_input7" maxlength="10"/>
				                </td>
				                <td align="left">&nbsp;</td>
				                <td align="left">&nbsp;</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_LONGITUDE"/>：</td>
				                <td align="left" colspan="3" class="blue1">
				                	<select name="jd" id="jd" class="test_input7ex" id="select7">
					                  	<option value='e'><s:text name="RES_LONGITUDE_E"/></option>
					                  	<option value="w"><s:text name="RES_LONGITUDE_W"/></option>
                					</select>
                  					<input name="jd1" id="jd1" type="text" class="test_input6" id="textfield4" size="4" />
                  					<span class="blue1">°</span>
									<input name="jd2" id="jd2" type="text" class="test_input6" id="textfield5" size="4" />
									<span class="blue1">′</span>
									<input name="jd3" id="jd3" type="text" class="test_input6" id="textfield11" size="4" />
									<span class="blue1">″</span>
									<span id="jd_tip"></span>
								</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_LATITUDE"/>：</td>
				                <td align="left" colspan="3" class="blue1">
				                	<select name="wd" id="wd" class="test_input7ex" id="select8">
					                  	<option value='n'><s:text name="RES_LATITUDE_N"/></option>
					                  	<option value='s'><s:text name="RES_LATITUDE_S"/></option>
                					</select>
                  					<input name="wd1" id="wd1" type="text" class="test_input6" size="4" />
				                  	<span class="blue1">°</span>
				                  	<input name="wd2" id="wd2" type="text" class="test_input6"  size="4" />
				                  	<span class="blue1">′</span>
				                  	<input name="wd3" id="wd3" type="text" class="test_input6" size="4" />
				                  	<span class="blue1">″</span>
				                  	<span id="wd_tip"></span>
				                 </td>
							</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="blue1">
				                	<span class="black2">&nbsp;&nbsp;<s:text name="RES_HASL"/>：</span>
				                </td>
				                <td height="33" align="left" class="blue1" colspan="3">
				                	<input name="height" id="height" type="text" class="test_input7" maxlength="10"/>&nbsp;&nbsp;m
				                	<span id="height_tip"></span>
				                </td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" align="right" class="blue1">
                					<span class="black2">&nbsp;&nbsp;<s:text name="RES_AOI"/>：</span>
                				</td>
                				<td height="33" align="left" class="blue1" colspan="3">
                					<input name="insangle" id="insangle" type="text" class="test_input7" maxlength="10"/>&nbsp;&nbsp;°
                					<span id="insangle_tip"></span>
                				</td>
              				</tr>
              				<tr>
              					<td height="33" colspan="2" align="right" class="blue1">
              						<span class="black2">&nbsp;*&nbsp;<s:text name="RES_CO2XS"/>：</span>
              					</td>
                				<td height="33" align="left" class="blue1" colspan="3">
                					<input name="co2rate" id="co2rate" type="text" class="test_input7" value="0.8" maxlength="10"/>&nbsp;&nbsp;Kg/KWh&nbsp;&nbsp;
                					<span id="co2rate_tip"></span>
                				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" align="right" class="blue1">
                					<span class="black2">&nbsp;*&nbsp;<s:text name="RES_MONEY"/>：</span>
                				</td>
                				<td align="left" colspan="3" class="blue1">
                					<select name="currency" id="currency" onchange="changeCurrency(this.value)">
				                		<s:iterator id="currency" status="ss" value="currencyList">
						         		<option value="<s:property value="#currency.currency" />"><s:property value="#currency.currency" /></option>
					     				</s:iterator>
                					</select>
                					<span id="currency_tip"></span>
                				</td>
                				<td align="left">&nbsp;</td>
                				<td align="left">&nbsp;</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<td height="33" align="right" class="blue1">
                					<span class="black2">&nbsp;*&nbsp;<s:text name="RES_GAINXS"/>：</span>
                				</td>
                				<td height="33" align="left" class="blue1" colspan="3">
                					<input name="incomerate" id="incomerate" type="text" class="test_input7" value="0.7" maxlength="10"/>&nbsp;&nbsp;[<span id="incomerateu"></span>]/KWh&nbsp;&nbsp;<span id="incomerate_tip"></span>
                				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="blue1"></td>
                				<!-- 2013-06-07 时区 -->
                				<td height="33" align="right" class="blue1"><span class="black2">*&nbsp;<s:text name="RES_TIMEZONE"/>：</span></td>
                				<td height="33" align="left" class="blue1" colspan="3">
	                				<select name="timezone"  id="timezone" onchange="changeTimezone();">
	                					<s:set name="tim" value="timezonex" />
	                 					<s:iterator id="timezone" value="timezoneList" status="ss">
		                 				<s:if test="timezoneid==#timezone.key">
				         				<option value="<s:property value="#timezone.code" />_<s:property value="#timezone.key" />" data="<s:property value="#timezone.isdst" />" selected="selected" ><s:property value="#timezone.name" /></option>
			     						</s:if>
			     						<s:else>
			     						<option value="<s:property value="#timezone.code" />_<s:property value="#timezone.key" />" data="<s:property value="#timezone.isdst" />" ><s:property value="#timezone.name" /></option>
			     						</s:else> 
		     							</s:iterator>
	                				</select>
	                				<span id="timezone_tip"></span>
	                				<input type="hidden" name="timezonex" />                
                				</td>
              				</tr>
              				<tr id="dst">
              					<td>
              					</td>
              					<td>
              					</td>
              					<td>

              						<s:checkbox id="customerflag" name="customerflag" value="true"></s:checkbox>
              						<!--
              						<input type="checkbox" id="customerflag" onchange="changeCustomerflag();" name="customerflag" checked="checked" value="1"/>

              						-->
              						<span class="black2"><s:text name="RES_TIMEZONE_DST"/></span>
              					</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" colspan="3" align="left" class="blue1">&nbsp;&nbsp;<s:text name="RES_MUSTFILL"/></td>
				                <td align="left">&nbsp;</td>
                			</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="left" class="blue1">&nbsp;</td>
				                <td height="33" align="right" class="blue1" colspan="3">
				                	<input id="submitImg" name="submitImg" type="button" class="button2" value="<s:text name="RES_OK"></s:text>" style="cursor:pointer"/>
				                </td>
				                <td align="left">&nbsp;</td>
                			</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td><img src="images/regin5.gif" width="920" height="10" /></td>
      			</tr>
    		</table>
      	</s:form>
    	</td>
  	</tr>
  	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
