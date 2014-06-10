<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/updatePasswd.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript">
		$(document).ready(function() {
			updatePasswd.init();
			$('#titleTip').html("<s:text name="RES_FIND_PASSWD_TITLE"/>");
		});

		function changeVerCode(){
			document.getElementById("verImg").src = "verCode?"+Math.random();
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
		.button1 {
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/buttom_bg2.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 30px !important;
			border: 0px solid ;
			height: 30px;
			width:63px;
		}
		.button2 {
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/buttom_bg3.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 30px !important;
			border: 0px solid ;
			height: 30px;
			width:120px;
		}
		.button3{
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/buttom_bg5.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 30px !important;
			border: 0px solid ;
			height: 30px;
			width:180px;
		}
		.black4 {
			font-size: 14px;
			color: #000;
			text-decoration: none;
		}
		.black5 {
			font-size: 14px;
			color: #787c7d;
			font-weight:bold;
			text-decoration: none;
		}
		.blue4 {
			font-size: 14px;
			color: #1B8FC5;
			text-decoration: none;
			font-weight: bold;
		}
		.blue2ex{
			font-size: 16px;
			color: rgb(27, 143, 197);
			text-decoration: none;
		}
		.test_input4vercode {
			font-size: 12px;
			line-height: 16px;
			color: #000;
			text-decoration: none;
			width:145px;
			height: 20px;
			border-top-width: 1px;
			border-right-width: 1px;
			border-bottom-width: 1px;
			border-left-width: 1px;
			border-top-style: solid;
			border-right-style: solid;
			border-bottom-style: solid;
			border-left-style: solid;
			border-top-color: #CFCFCF;
			border-right-color: #EFEFEF;
			border-bottom-color: #ffffff;
			border-left-color: #EFEFEF;
		}
	-->
	</style>
	<style type="text/css">
		<!--
		.STYLE1 {
			color: #663366;
			font-size: 36px;
		}
		-->
	</style>
</head>
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
    	<td><%@include file="headUserReg.jsp" %></td>
  	</tr>
  	<tr>
    	<td height="547" align="center" bgcolor="#E5EFF9">
    		<table width="920" border="0" cellspacing="0" cellpadding="0">
      			<tr>
        			<td><img src="images/regin5_1.gif" width="920" height="10" /></td>
      			</tr>
      			<tr>
        			<td height="435" align="center" background="images/regin6.gif">
        				<table width="800px" border="0" cellspacing="0" cellpadding="0">
        					<tr height="30">
        						<td>
        							<table>
        								<tr>
        									<td width="80px"></td>
        									<td width="550px" height="30" align="left" class="blue2ex"><s:text name="RES_FINDPWD_TITLE"/></td>
        									<td width="100px"></td>
        								</tr>
        							</table>
        						</td>
        					</tr>
        					<tr height="30"></tr>
        					<tr height="30">
        						<td>
        							<table>
        								<tr>
        									<td width="27%" height="22" align="right" class="black4"  valign="bottom"><s:text name="RES_FIND_PASSWD_ACCOUNT"/></td>
        									<td width="15%" align="left" valign="bottom" colspan="2"><input name="email" type="text" class="test_input2" id="email"  maxlength="50"/></td>
        									<td width="5%" align="left"><span id="emailTip" class="black2" ></span></td>
        									<td width="63%"></td>
        								</tr>
        								<tr>
        									<td width="27%" height="22" align="right" class="black4"  valign="bottom"><s:text name="RES_FIND_PASSWD_VERCODE"/>:</td>
        									<td width="15%"><input name="verCode" type="text" class="test_input4vercode" id="verCode"  maxlength="4"/></td>
        									<td width="6%"><img src="verCode" width="60" height="24" align="left" border="0" id="verImg" onClick="changeVerCode()" style="cursor:pointer"/></td>
        									<td width="63%"></td>
        								</tr>
        							</table>
        						</td>
        					</tr>
        					<tr height="30"></tr>
        					<tr height="30">
        						<td align="right">
        							<table>
        								<tr>
        									<td></td>
        									<td height="30"><input id="submitForm" name="submitForm" type="button" class="button2" value="<s:text name="RES_REGISTER_AGREETEXT"></s:text>" style="cursor:pointer"/></td>
        									<td width="30%"></td>
        								</tr>
        							</table>
        						</td>
        					</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td><img src="images/regin5.gif" width="920" height="10" /></td>
      			</tr>
    		</table>
    	</td>
	</tr>
   	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
</body>
</html>
