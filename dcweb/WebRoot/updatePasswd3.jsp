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
		height: 28px !important;
		border: 0px solid ;
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
		font-weight: bold;
		color: #0099CC;
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
        				<table width="85%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td colspan="2" align="center" height="10"></td>
            				</tr>
          					<tr>
            					<td width="52%" height="140">
            						<table width="377" border="0" cellspacing="0" cellpadding="0">
              							<tr>
                							<td><img src="images/regin21.gif" width="377" height="17" /></td>
              							</tr>
              							<tr>
                							<td height="100" valign="top" background="images/regin19.gif">
                								<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                  									<tr>
                    									<td height="100" valign="top" align="left">
                    										<p class="black4"><s:text name="RES_FIND_PASSWD_TIP1"/><font color="red"><s:property value="#session.updatepasswd" /></font></p>
                      										<p class="black4"><s:text name="RES_FIND_PASSWD_TIP2"/></p>
                      									</td>
                  									</tr>
                								</table>                  
                							</td>
              							</tr>
              							<tr>
               	 							<td><img src="images/regin20.gif" width="377" height="17" /></td>
              							</tr>
            						</table>
            					</td>
            					<td width="48%" align="left">
            						<table  border="0" cellspacing="0" cellpadding="0">
            						<tr></tr>
            						<tr>
            							<td>
	            							<table>
	            								<tr>
	            									<td height="100" valign="top" align="left">
	            										<p><img src="images/list22_1.gif" width="22" height="22" /><span class="STYLETIP"><s:text name="RES_FIND_PASSWD_TIP3"/></span></p>
														<p class="STYLETIP">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="RES_FIND_PASSWD_TIP4"/></p>
	            									</td>
	            								</tr>
	            							</table>
            							</td>
            						</tr>
            						<tr></tr>
            						</table>
              					</td>
          					</tr>
          					<tr>
					            <td height="50px"></td>
          					</tr>
          					<tr>
          						<td></td>
          						<td align="right">
          							<input id="retologin" class="button2" type="button" style="cursor:pointer" onclick="location.href='index.action'" value="<s:text name="RES_SHARE_ACTIVE_TURNLOGIN" ></s:text>"></input>
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
