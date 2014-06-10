<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/register.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
			bindStation.init();
		});
  	</script>
  </head>
  <body>
  	<div class="outhead">
  		<div class="inhead">
	  		<div class="lang_select">
		 		   <div class="lang_text" onclick="langSel.open('lang_popsel')">
	 				<%
	 		  			if(session.getAttribute("WW_TRANS_I18N_LOCALE")==null||("en_US").equals(session.getAttribute("WW_TRANS_I18N_LOCALE").toString())){
	 		  	 	%>
			      		<s:text name="RES_ENGLISH"/>
			     	<% }else{ %>
			      		<s:text name="RES_CHINESE"/>
			     	<% } %>
	 			
			 		</div>
			 		<div id="lang_popsel" class="lang_popsel">
	 				<table width="100%" cellpadding="0" cellspacing="0" border="0" >
	 					<tr>
	 						<td><div vtitle="zh_CN" class="lang_tp"  onclick="langSel.click(this)"><img src="images/china_tp.gif" /></div></td>
	 						<td><div vtitle="en_US" class="lang_tp"  onclick="langSel.click(this)"><img src="images/usa_tp.gif" /></div></td>
	 					</tr>
	 					<tr>
	 						<td><div vtitle="en_US" class="lang_tp"  onclick="langSel.click(this)"><img src="images/uk_tp.gif" /></div></td>
	 						<td></td>
	 					</tr>
	 				</table>
	 				</div>
	 		</div>
			<form action='<s:url includeParams="get" encode="true"/>' id="langform" method="post">
				 		  <input type="hidden" name="request_locale" id="langlocale" />
			</form>
		</div>
  	</div>
  	<div class="reg_con">
 		<table width="850px" cellpadding="0" cellspacing="0" border="0" class="reg_topt">
 				<tr>
	 				<td height="40px" width="803px" align="left" class="td1"><s:text name="RES_ZSREG"/></td>
	 				<td height="40px" width="200px" class="td2" onclick="window.location.href='index.action'"><s:text name="RES_POWERLIST"/></td>
 				</tr>
 		</table>
 		<div class="reg_in">
 			<div class="reg_inbox">
 				<div class="reg_stepdiv">
 					<table cellpadding="0" cellspacing="0" border="0" class="reg_step">
 						<tr>
 							<td width="20px" height="20px" class="reg_stepspan2">1</td>
 							<td height="20px" class="reg_stepspan2t"><s:text name="RES_ZSREGSTEP1"/></td>
 							<td width="20px" height="20px" class="reg_jiantou"></td>
 							<td width="20px" height="20px" class="reg_stepspan1">2</td>
 							<td height="20px" class="reg_stepspan1t"><s:text name="RES_CREATESTATION"/></td>
 						</tr>
 					</table>
 				</div>
 				<form id="bindForm" action="dobindStation.action" method="post">
	 				<s:token />
	 				<table cellpadding="0" cellspacing="0" border="0" style="margin: 10px auto;" width="512px">
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_SERIALNUMBER" />：</td>
	 						<td align="left" width="130px"><input id="psno" class="reg_input" type="text" name="psno" /></td>
	 						<td id="psno_tip" class="btn1_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_STATIONNAME" />：</td>
	 						<td align="left" width="130px"><input id="stationname" class="reg_input" type="text" name="stationname" /></td>
	 						<td id="stationname_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_MONEY" />：</td>
	 						<td align="left" width="130px">
	 							<select id="money" name="money" style="width:100px;">
	 								<option value="0" selected="selected">--<s:text name="RES_CHOOSEMONEY" />--</option>
	 								<option value="$">$</option>
	 								<option value="€">€</option>
	 								<option value="￥">￥</option>
	 							</select>
	 						</td>
	 						<td id="money_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_TIMEZONE" />：</td>
	 						<td align="left" width="130px">
	 							<select id="timezone" name="timezone">
	 								<option value="" selected="selected">--<s:text name="RES_TIMEZONE" />--</option>
	 								<option value="+13">GMT +13</option>
	 								<option value="+12">GMT +12</option>
	 								<option value="+11.5">GMT +11.5</option>
	 								<option value="+11">GMT +11</option>
	 								<option value="+10">GMT +10</option>
	 								<option value="+9.5">GMT +9.5</option>
	 								<option value="+9">GMT +9</option>
	 								<option value="+8">GMT +8</option>
	 								<option value="+7">GMT +7</option>
	 								<option value="+6.5">GMT +6.5</option>
	 								<option value="+6">GMT +6</option>
	 								<option value="+5.75">GMT +5.75</option>
	 								<option value="+5.5">GMT +5.5</option>
	 								<option value="+5">GMT +5</option>
	 								<option value="+4.5">GMT +4.5</option>
	 								<option value="+4">GMT +4</option>
	 								<option value="+3.5">GMT +3.5</option>
	 								<option value="+3">GMT +3</option>
	 								<option value="+2">GMT +2</option>
	 								<option value="+1">GMT +1</option>
	 								<option value="+0">GMT +0</option>
	 								<option value="-1">GMT -1</option>
	 								<option value="-3">GMT -3</option>
	 								<option value="-4">GMT -4</option>
	 								<option value="-5">GMT -5</option>
	 								<option value="-6">GMT -6</option>
	 								<option value="-7">GMT -7</option>
	 								<option value="-8">GMT -8</option>
	 								<option value="-10">GMT -10</option>
	 								<option value="-11">GMT -11</option>
	 							</select>
	 						
	 						</td>
	 						<td id="timezone_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_CO2XS" />：</td>
	 						<td align="left" width="130px"><input id="co2xs" class="reg_input" type="text" name="co2xs" onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
	 						<td id="co2xs_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_GAINXS" />：</td>
	 						<td align="left" width="130px"><input id="gainxs" class="reg_input" type="text" name="gainxs" onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
	 						<td id="gainxs_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1"><s:text name="RES_ADDR" />：</td>
	 						<td align="left" width="130px"><input id="addr" class="reg_input" type="text" name="addr" /></td>
	 						<td id="addr_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1"><s:text name="RES_COUNTRY" />：</td>
	 						<td align="left" width="130px"><input id="country" class="reg_input" type="text" name="country" /></td>
	 						<td id="country_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td align="right" width="130px" class="reg_lefttd1"><s:text name="RES_CITY" />：</td>
	 						<td align="left" width="130px"><input id="city" class="reg_input" type="text" name="city" /></td>
	 						<td id="city_tip" align="left"></td>
	 					</tr>
	 					<tr height="45px">
	 						<td></td>
	 						<td align="left" colspan="2" >
	 							<div id="bindBtn" class="btn2">
	 								<div class="btn2_l"></div>
	 								<div class="btn2_c"><s:text name="RES_OK" /></div>
	 								<div class="btn2_r"></div>
	 							</div>
	 						</td>
	 					</tr>
	 				</table>
	 			</form>
 			<div class="reg_stepdiv"></div>
 			</div>
 			<div class="clear"></div>
 		</div>
 	</div>
 	<div class="footer"><s:text name="RES_COPYRIGHT"/></div>
  </body>
</html>
