<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/modifyStation.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
  		$(document).ready(function() {
			modifyStation.init();
			
		});
  	</script>
  	<script type="text/javascript">
 		function changeCountry(cid){
			if (cid==0){
			}else{
				hiddenFrame.location.href="stateList.action?countryId="+cid;
			}
		}
		function changeCurrency(val){
			$('#incomerateu').html(val);
		}
		// 根据用户名和电站id生成key
		function generateKey(n,s){
			var url = "generateStationKey.action";
			var data = {"sname":n, "sid":s};
			$.ajax({
		            type: "POST",
		            url: url,
		            dataType: "json",
		            data: data,
		            success: resKey,
		            error: function () {
		                alert(RES.REQUESTWRONG);
		            }
		    });
		}
		function resKey(data, textStatus, jqXHR){
			document.getElementById("portkey").innerHTML=data.k;
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
		.button2 {
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffffff;
			background-image: url("images/buttom_bg4.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			width:63px;
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
		.STYLE3 {
			color: #CCCCCC; 
			font-weight: bold; 
			font-size: 16px
		}
		-->
	</style>
	<style>
		#flashCont {
			position: absolute;
			width:600px;
			height:400px;
			left:40%;
			top:40%;
			margin-left:-50px;
			margin-top:-25px;
			Z-INDEX: 9999;
		}
		#frame1 {
			position: absolute;
			width:580px;
			height:360px;
			left:40%;
			top:42%;
			margin-left:-50px;
			margin-top:-25px;
			Z-INDEX: 6000;
		}
		.Wdate1 {
		    border: 1px solid rgb(153, 153, 153);
		    height: 20px;
		    background: url("/datepicker/skin/datePicker.gif") no-repeat scroll right center rgb(255, 255, 255);
		    line-height: 20px;
		    text-indent: 5px;
		    width: 85px;
		}
	</style>
  	</head>
<body onload="$('#flashCont')[0].style.display='none';">
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td ><%@include file="HeadMenu.jsp" %></td>
     	<script type="text/javascript">
        	menuOver('configMenu',3);;
        </script>
  	</tr>
   	<IFRAME id="frame1" width="300px" height="300px" style="position:absolute;z-index:1; 
  		background-color:Blue; display:none;" mce_style="position:absolute;z-index:1; background-color:Blue; 
  		display:none;" frameborder="0"> 
  	</IFRAME>  
	<%
    	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
	%>
	<script type="text/javascript">
		<%
      	String lang="en_US";
      	if (session.getAttribute("WW_TRANS_I18N_LOCALE")!=null && session.getAttribute("WW_TRANS_I18N_LOCALE").toString().equals("zh_CN"))
       		lang="zh_CN";
       	%>
        var flashvars = {"lang":"<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>","sid":"<s:property value="#session.defaultStation" />","baseUrl":"<%=baseUrl%>"}
        showFlashElement("swf/face.swf", flashvars);
	</script>
  	<tr>
    	<td height="750" align="center" bgcolor="#E5EFF9">
    	<form name="createStationForm" id="createStationForm" action="createNewStationQuery.action" method="post">
    	<input type="hidden" name="staionId" id="stationId" value="<s:property value="stationId" />"/>
    		<table width="920" border="0" cellspacing="0" cellpadding="0">
      			<tr>
        			<td><img src="images/add1.gif" width="920" height="10" /></td>
      			</tr>
     			<tr>
        			<td height="668" align="center" background="images/regin6.gif">
        				<table width="85%" border="0" cellspacing="0" cellpadding="0">
							<tr>
               	 				<td height="30" colspan="3" align="left" class="blue3"><s:text name="RES_POWERINF"/></td>
              				</tr>
              				<tr>
              					<td rowspan="2" align="right" ><img id="stface" src='<s:property value="stationMap.iconindex" />' width="82" height="82" onclick="changFac()" style="cursor:pointer"/>
            						<input type="hidden" id="picurl" value='<s:property value="stationMap.iconindex" />'></td>
                				<td width="18%" height="33" align="right" class="black2">* <s:text name="RES_STATIONNAME"/>：</td>
                				<td align="left"><input id="stationname" name="stationname" type="text"  maxlength="30" class="test_input5" value="<s:property value="stationMap.stationname" />" />
                					<span id="stationname_tip" class="black2"></span>&nbsp;
                				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_INSTALLCAP"/>：</td>
                				<td align="left" class="blue1"><input name="installcap" id="installcap"  maxlength="10" type="text" class="test_input7"  value="<s:property value="stationMap.totalpower" />" />&nbsp;&nbsp;KW<span id="installcap_tip" class="black2">&nbsp;</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_STARTDT"/>：</td>
				                <td align="left"><input name="startdt" id="startdt" type="text"  size="13" class="Wdate1" type="text" value="<s:property value="stationMap.startdt" />" onFocus="WdatePicker({maxDate:'#F{\'2050-01-01\'}',lang:'<%= lang %>'})" /><span id="startdt_tip" class="black2"></span></td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" class="blue1"></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_COMPANY"/>：</td>
				                <td align="left" colspan="3" class="blue1"><input name="company" id="company" type="text" value="<s:property value="stationMap.company" />"  class="test_input5" maxlength="50"/>&nbsp;&nbsp;</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_COUNTRY"/>：</td>
				                <td align="left" ><select name="country" id="country" class="test_input7ex" >
               					<s:set name="cn" value="country" />
                				<s:iterator id="country" status="ss" value="countryList">
                				<s:if test="#cn==#country.c_code">
	         					<option value="<s:property value="#country.c_code" />"  selected="selected"><s:property value="countryname" /></option>
     							</s:if>
								<s:else>
								<option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
     							</s:else>
     							</s:iterator>
                 				</select><span id="country_tip" class="black2"></span>
                  				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" ></td>
                				<td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_STATE"/>：</td>
                				<td align="left" ><select name="state" id="state" class="test_input7ex" >
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
                				</select><span id="state_tip" class="black2"></span>
                				</td>
              				</tr>
              				<tr>
              					<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">*&nbsp;<s:text name="RES_CITY"/>：</td>
				                <td align="left"><input name="city" id="city" type="text" class="test_input7"  maxlength="20" value="<s:property value="stationMap.city" />" /><span id="city_tip" class="black2"></span></td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_ADDRESS_NUM"/>：</td>
				                <td align="left"><input name="street" id="street" type="text" class="test_input5"  maxlength="50" value="<s:property value="stationMap.street" />" /><span id="street_tip" ></span></td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_ZIP"/>：</td>
				                <td align="left"><input name="zip" id="zip" type="text" class="test_input7"  maxlength="10" value="<s:property value="stationMap.zip" />" /></td>
              				</tr>
              				<tr>
              					<td height="33" align="right" ></td>
                				<td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_LONGITUDE"/>：</td>
                				<td align="left"  class="blue1" valign="bottom"><select name="jd" id="jd" class="test_input7ex" id="select7">
			                  	<s:if test="jd==1">
			                  	<option value='e' selected="selected"><s:text name="RES_LONGITUDE_E"/></option>
			                  	<option value="w"><s:text name="RES_LONGITUDE_W"/></option>
			                  	</s:if>
			                  	<s:else>
                   				<option value='e'><s:text name="RES_LONGITUDE_E"/></option>
                   				<option value="w" selected="selected"><s:text name="RES_LONGITUDE_W"/></option>
                  				</s:else>
                				</select>
                  				<input name="jd1" id="jd1" type="text" class="test_input6" id="textfield4" size="4"   value="<s:property value="jd1" />" />
                  				<span class="blue1">°</span>
								<input name="jd2" id="jd2" type="text" class="test_input6" id="textfield5" size="4"   value="<s:property value="jd2" />" />
								<span class="blue1">′</span>
								<input name="jd3" id="jd3" type="text" class="test_input6" id="textfield11" size="4"   value="<s:property value="jd3" />" />
								<span class="blue1">″</span><span id="jd_tip" class="black2"></span>
								</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_LATITUDE"/>：</td>
				                <td align="left" class="blue1"><select name="wd" id="wd" class="test_input7ex" id="select8">
				                <s:if test="wd==1">
				                <option value='n' selected="selected"><s:text name="RES_LATITUDE_N"/></option>
				                <option value='s'><s:text name="RES_LATITUDE_S"/></option>
                   				</s:if>
                  				<s:else>
                    			<option value='n'><s:text name="RES_LATITUDE_N"/></option>
                  				<option value='s' selected="selected"><s:text name="RES_LATITUDE_S"/></option>
                  				</s:else>
                				</select>
                  				<input name="wd1" id="wd1" type="text" class="test_input6" size="4"  value="<s:property value="wd1" />" />
			                  	<span class="blue1">°</span>
			                  	<input name="wd2" id="wd2" type="text" class="test_input6"  size="4"  value="<s:property value="wd2" />" />
			                  	<span class="blue1">′</span>
			                  	<input name="wd3" id="wd3" type="text" class="test_input6" size="4"  value="<s:property value="wd3" />" />
			                  	<span class="blue1">″</span><span id="wd_tip" class="black2"></span>
			                  	</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;&nbsp;<s:text name="RES_HASL"/>：</span></td>
				                <td height="33" align="left" class="blue1" ><input name="height" id="height"  maxlength="10" type="text" class="test_input7"  value="<s:property value="stationMap.height" />" onblur="checkHasl2()"/>&nbsp;&nbsp;m<span id="height_tip" class="black2"></span></td>
			              	</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;&nbsp;<s:text name="RES_AOI"/>：</span></td>
				                <td height="33" align="left" class="blue1" ><input name="insangle" id="insangle"  maxlength="10" type="text" class="test_input7"  value="<s:property value="stationMap.comangle" />" onblur="checkInsangle2()"/>&nbsp;&nbsp;°<span id="insangle_tip" class="black2"></span></td>
              				</tr>
              				<tr>
				              	<td height="33" colspan="2" align="right" ><span class="black2">&nbsp;*&nbsp;<s:text name="RES_CO2XS"/>：</span></td>
				                <td height="33" align="left" class="blue1">
				                <input name="co2rate" id="co2rate" type="text" class="test_input7"  value="<s:property value="co2rate" />" />&nbsp;&nbsp;Kg/KWh&nbsp;&nbsp;<span id="co2rate_tip" class="black2"></span>                </td>
              				</tr>
              				<tr>
              					<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;*&nbsp;<s:text name="RES_MONEY"/>：</span></td>
				                <td height="33" align="left" class="blue1">
				                <select name="currency" id="currency" class="test_input7ex" onchange="changeCurrency(this.value)">
				                <s:set name="cur" value="currency" />
                 				<s:iterator id="currency" status="ss" value="currencyList">
                 				<s:if test="#cur==#currency.currency">
		         				<option value="<s:property value="#currency.currency" />" selected="selected"><s:property value="#currency.currency" /></option>
				 				</s:if>
					     		<s:else>	
					     		<option value="<s:property value="#currency.currency" />"><s:property value="#currency.currency" /></option>
					     		</s:else>     		
					     		</s:iterator>
				                </select>
                				</td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;*&nbsp;<s:text name="RES_GAINXS"/>：</span></td>
				                <td height="33" align="left" class="blue1">
				                <input name="incomerate" id="incomerate" type="text" class="test_input4"  maxlength="10" value="<s:property value="incomerate" />" />&nbsp;&nbsp;[<span id="incomerateu"><s:property value="currency" /></span>]/KWh&nbsp;&nbsp;<span id="incomerate_tip" class="black2"></span>                
				               	</td>
              				</tr>
              				<tr>
				                <td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;&nbsp;<s:text name="RES_ETOTAL_OFFSET"/>：</span></td>
				                <td height="33" align="left" class="blue1">
				                <input name="etotaloffset" id="etotaloffset" type="text" class="test_input4"  maxlength="10" value="<s:property value="etotaloffset" />" />&nbsp;&nbsp;KWh&nbsp;&nbsp;<span id="etotaloffset_tip" class="black2"></span>                
				                </td>
              				</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">*&nbsp;<s:text name="RES_TIMEZONE"/>：</span></td>
				                <td height="33" align="left" class="blue1" >
				               	<select name="timezone"  id="timezonex" class="test_input16" onchange="changeTimezone();">
				                <s:set name="tim" value="timezonex" />
				                <s:iterator id="timezone" status="ss" value="timezoneList">
				                <s:if test="#tim==#timezone.key">
						        <option value="<s:property value="#timezone.code" />_<s:property value="#timezone.key" />" data="<s:property value="#timezone.isdst" />" selected="selected"><s:property value="#timezone.name" /></option>
	     						</s:if>
	     						<s:else>
					     		<option value="<s:property value="#timezone.code" />_<s:property value="#timezone.key" />" data="<s:property value="#timezone.isdst" />"><s:property value="#timezone.name" /></option>
					     		</s:else> 
					     		</s:iterator>
				                </select>
				                
				                
				                
				                <input type="hidden" name="timezonex" />                
                				</td>
              				</tr>
              				<tr id="dst">
              					<td>
              					</td>
              					<td>
              					</td>
              					<td>
              						<input type="checkbox" id="customerflag" onchange="changeCustomerflag();" name="customerflag" checked="checked" value="1"/>
              						<span class="black2"><s:text name="RES_TIMEZONE_DST"/></span>
				                	<input type="hidden" name="customerflagvalue" id="customerflagvalue" value="<s:property value="customerflag" />"/>
              					</td>
              				</tr>
             				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="right" class="blue1"><span class="black2">&nbsp;&nbsp;<s:text name="RES_ST_CREATER"/>：</span></td>
				                <td height="33" align="left" class="black2" ><s:property value="stationMap.admin" /></td>
              				</tr>
              				
              				<tr>
				              	<td height="33" align="right"></td>
				                <td height="33" align="right" class="blue1">
				                <s:if test="stationMap.portkey.length()>0">
				                	<span class="black2">&nbsp;&nbsp;Key：</span>
				                </s:if>
				                <s:else>
				                	<button type="button" onclick="generateKey('<s:property value="stationMap.admin" />','<s:property value="#session.defaultStation"/>')" style="cursor:pointer; width:140px;"><s:text name="RES_GENERATEKEY"/></button>
				                </s:else>
				                </td>
				                
				                <td height="33" align="left" class="black2">
				                <s:if test="stationMap.portkey.length()>0">
				                <span id="portkey"><s:property value="stationMap.portkey"/></span>
				                </s:if>
				                <s:else>
				                <span id="portkey"></span>
				                </s:else>
				                </td>
              				</tr>
              				
              				<tr>
				              	<td height="33" align="right" width="82"></td>
				                <td height="33" colspan="2" align="left" class="blue1">&nbsp;&nbsp;<s:text name="RES_MUSTFILL"/></td>
                			</tr>
              				<tr>
				              	<td height="33" align="right" ></td>
				                <td height="33" align="left" class="blue1">&nbsp;</td>
				                <td height="33" align="left" class="blue1" ><input type="button" value="<s:text name="RES_CONF_REPORT_SAVE"/>" class="button2" id="submitImg" style="cursor:pointer"/></td>
                			</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td><img src="images/regin5.gif" width="920" height="10" /></td>
      			</tr>
    		</table>
      	</form>
    	</td>
  	</tr>
  	<tr >
    	<td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
<div id='flashCont' width='600' height='400' ></div>
</body>
</html>
