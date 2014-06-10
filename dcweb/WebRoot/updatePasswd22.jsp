<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/updatePasswd.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
			updatePasswd3.init();
			$('#titleTip').html("<s:text name="RES_FIND_PASSWD_TITLE"/>");
		});
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
		background-image: url("images/buttom_bg1.gif");
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
		height: 27px !important;
		border: 0px solid ;
		width:120px;
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
	-->
	</style>
	<style type="text/css">
	<!--
	.STYLE1 {
		color: #1B8FC5;
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
        			<td height="10" background="images/add1.gif"></td>
      			</tr>
      			<tr>
        			<td height="435" align="center" background="images/regin6.gif">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="100"><div align="left" class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="RES_CHANGEPASSWORD"/></div></td>
          					</tr>
          					<tr>
            					<td align="center">
            						<table width="70%" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
							                <td width="31%" height="30" align="center" class="black2"><div align="right"><s:text name="RES_FIND_PASSWD_ACCOUNT"/></div></td>
							                <td width="69%" align="left"  class="black2"><s:property value="email" />
							                <input type="hidden" name="checkcode" id="checkcode" class="test_input12" value="<s:property value="checkcode" />"/>
							                <input type="hidden" name="email" id="email" class="test_input12" value="<s:property value="email" />"/><span id="email_tip"></span>
							                </td>
						              	</tr>
						              	<tr>
							                <td height="30" class="black2"><div align="right"><s:text name="RES_FIND_PASSWD_NEWPWD"/></div></td>
							                <td align="left" class="black" class="black2"><input type="password" name="password" id="password" class="test_input12"/><span id="password_tip"></span></td>
						              	</tr>
						              	<tr>
							                <td height="30" class="black2"><div align="right"><s:text name="RES_FIND_PASSWD_REPWD"/></div></td>
							                <td align="left"  class="black2"><input type="password" name="repassword" id="repassword" class="test_input12"/><span id="repassword_tip"></span></td>
						              	</tr>
						              	<tr>
						                	<td height="60" colspan="2"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="submitForm" type="button" class="button2" value="<s:text name="RES_OK"/>"  style="cursor:pointer"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  type="button" class="button2" value="<s:text name="RES_CANCEL"/>" onclick="location.href='index.action'"  style="cursor:pointer"/></div></td>
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
