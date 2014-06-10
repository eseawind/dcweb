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
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/register.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
			register.init();
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
		background-image: url("images/regin18_bg.gif");
		background-repeat: repeat-x;
		background-position: 0 50%;
		outline: 0px solid #D3E0E7;
		height: 30px !important;
		border: 0px solid ;
		height: 30px;
		width:198px;
	}
	.button2 {
		font: 14px Tahoma, Verdana;
		padding: 0 5px;
		color: #D3E0E7;
		background-image: url("images/regin16_bg.gif");
		background-repeat: repeat-x;
		background-position: 0 50%;
		outline: 0px solid #D3E0E7;
		height: 30px !important;
		border: 0px solid ;
		height: 30px;
		width:63px;
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
	.STYLETIP {
		font-size: 16px;
		font-weight: bold;
		color: #0099CC;
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
		        <td height="78" valign="bottom" background="images/regin12.gif">
		        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			          	<tr>
			            	<td width="23%" height="40" align="center" class="blue4"><s:text name="RES_REGISTER_STEP1" ></s:text></td>
			            	<td width="59%" align="center" class="blue4"><s:text name="RES_REGISTER_STEP2" ></s:text></td>
			            	<td width="18%" align="center" class="blue4"><s:text name="RES_REGISTER_STEP3" ></s:text></td>
			          	</tr>
		        	</table>
		        </td>
			</tr>
			<tr>
				<td height="435" align="center" background="images/regin6.gif">
		        	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		        		<tr>
		            		<td width="460px" valign="top">
		            			<table width="377px" height="192" border="0" cellpadding="0" cellspacing="0">
		            				<tr>
							            <td>
							                <img width="377" height="17" src="images/regin21.gif"></img>
							            </td>
							        </tr>
							        <tr>
							            <td valign="top" height="100%" width="377" background="images/regin19.gif">
							            	<table width="98%" cellspacing="0" cellpadding="0" border="0" align="center">
							            		<tr>
												    <td width="98%" valign="top"><div class="STYLETIP"><s:text name="RED_REGISTER_VIA_TIP6"></s:text></div></td>
												</tr>
							            	</table>
							            </td>
							        </tr>
							        <tr>
							            <td>
							                <img width="377" height="17" src="images/regin20.gif"></img>
							            </td>
							        </tr>
								</table>
							</td>
							<td width="40px"></td>
		            		<td width="300px">
		            			<table width="100%" border="0" cellspacing="0" cellpadding="0">
		              				<tr>
						                <td width="10%" height="30" align="center"><img src="images/regin7.gif" width="22" height="22" /></td>
						                <td width="90%" align="left" class="black"><s:text name="REG_REGISTER_VIA_TIP5"></s:text></td>
		              				</tr>
		              				<tr>
						                <td height="30">&nbsp;</td>
						                <td align="left" class="black2"><s:text name="RED_REGISTER_VIA_TIP1"></s:text></td>
		              				</tr>
		              				<tr>
						                <td height="60">&nbsp;</td>
						                <td align="left" class="black2"><s:text name="RED_REGISTER_VIA_TIP2"></s:text><a href="#" id="resend"><s:text name="RED_REGISTER_VIA_TIP3" ></s:text></a></td>
		              				</tr>
		              				<tr>
		                				<td height="30">
						                <input type="hidden" id="email" value="<s:property value="email" />" />
						                <input type="hidden" id="verCode" value="<s:property value="verCode" />"/>
						                <input type="hidden" id="firstName" value="<s:property value="firstName" />"/>
						                <input type="hidden" id="secondName" value="<s:property value="secondName" />"/>
						                <input type="hidden" id="yourId" value="<s:property value="yourId" />"/>
						                </td>
						                <!-- 
						                <td align="center"><input type="button" class="button1"  id="resend" style="cursor:pointer" value="<s:text name="RED_REGISTER_VIA_TIP3" ></s:text>"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button1"  value="<s:text name="RES_SHARE_ACTIVE_TURNLOGIN"></s:text>" onclick="location.href='index.action'"  style="cursor:pointer" /></td>
						                -->
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
