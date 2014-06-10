<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  	<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confChangePwd.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
  		$(document).ready(function() {
			confChangePwd.init();
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
			background-image: url("images/buttom_bg4.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
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
		-->
	</style>
	<script>
 		function changeCountry(cid)
 		{
			if (cid==0)
			{
			}
			else
			{
				hiddenFrame.location.href="stateList.action?countryId="+cid;
			}
		}
	</script>
  	</head>
<body >
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
   	<tr>
    	<td  align="center" valign="bottom" background="images/top_bg.gif"><%@include file="HeadMenu.jsp" %> </td>
    	<script>
        	menuOver('userMenu',6);
        </script>
  	</tr>
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table border="0" cellspacing="18" cellpadding="0">
      			<tr>
        			<td width="896" align="center">
        				<table width="896" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td><img src="images/list5_1.gif" width="896" height="6" /></td>
            				</tr>
          					<tr>
            					<td height="400" align="center" valign="top" background="images/list6.gif">
            						<table width="98%" border="0" cellspacing="0" cellpadding="0">
              							<tr>
                							<td width="83%">
                								<table width="100%" border="0" cellspacing="0" cellpadding="0">
                									<tr>
                										<td height="30" align="left" class="blue3"><s:text name="RES_CHANGEPASSWORD"/></td>
                									</tr>
                									<tr>
                										<td height="25"></td>
                									</tr>
                									<tr>
                										<td height="25" align="left" colspan="2"><span id="resinfotip"></span></td>
                									</tr>
                									<tr>
                										<td>
                											<table width="100%" border="0" cellspacing="0" cellpadding="0">
                												<tr>
                													<td width="650px">
                														<table width="100%" border="0" cellspacing="0" cellpadding="0">
                															<tr>
                																<td height="33" width="165px" align="right" class="black2"><s:text name="RES_CONF_ADMIN_ACCOUNT"/>: </td>
                																<td width="125px" align="left" class="black2"><s:property value="email"/></td>
                																<td width="310px"></td>
                															</tr>
                															<tr>
                																<td height="33" align="right" class="black2"><s:text name="RES_CONF_USER_OLDPWD"/>：</td>
                																<td align="left" class="black2"><input name="oldpwd" type="password" class="test_input11" id="oldpwd" /></td>
                																<td></td>
                															</tr>
                															<tr>
                																<td height="33" align="right" class="black2"><s:text name="RES_NEWPASSWORD"/>：</td>
                																<td align="left" class="black2"><input name="newpwd" type="password" class="test_input11" id="newpwd" /></td>
                																<td><span id="newtip"></span></td>
                															</tr>
                															<tr>
                																<td height="33" align="right" class="black2"><s:text name="RES_REPASSWORD"/>：</td>
                																<td align="left" class="black2"><input name="renewpwd" type="password" class="test_input11" id="renewpwd" /></td>
                																<td><span id="retip"></span></td>
                															</tr>
                															
                														</table>			
                													</td>
                													<td width="240px" align="center" valign="middle" class="black2">
                														<table width="100%" border="0" cellspacing="0" cellpadding="0">
                															<tr></tr>
                															<tr>
                																<td width="20%" height="33" align="center" valign="top"><img src="images/regin7.gif" width="22" height="22" /></td>
																				<td width="80%" height="33" align="left"><s:text name="RES_CONF_USER_PWDFLAG"/></td>
                															</tr>
                															<tr></tr>
                														</table>
                													</td>
                												</tr>
                											</table>
                										</td>
                									</tr>
                								</table>
                							</td>
              							</tr>
              							<tr>
                							<td height="60" align="center"><span class="blue1"><input id="submitForm" name="submitForm" type="button" class="button2" value="<s:text name="RES_OK"></s:text>"  style="cursor:pointer"/></span></td>
              							</tr>
            						</table>
            					</td>
            				</tr>
          					<tr>
            					<td height="6"><img src="images/list5.gif" width="896" height="6" /></td>
            				</tr>
          				</table>
          			</td>
      			</tr>
    		</table>
    	</td>
  	</tr>
  	<tr >
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
</body>
</html>
