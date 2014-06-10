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
  	<script type="text/javascript">
  		$(document).ready(function() {
			register.init();
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
 							<td width="20px" height="20px" class="reg_stepspan1">1</td>
 							<td height="20px" class="reg_stepspan1t"><s:text name="RES_ZSREGSTEP1"/></td>
 							<td width="20px" height="20px" class="reg_jiantou"></td>
 							<td width="20px" height="20px" class="reg_stepspan2">2</td>
 							<td height="20px" class="reg_stepspan2t"><s:text name="RES_CREATESTATION"/></td>
 						</tr>
 					</table>
 				</div>
 				<form id="dorigisterForm" action="doregister.action" method="post">
 				<s:token />
 				<table cellpadding="0" cellspacing="0" border="0" style="margin: 10px auto;" width="512px">
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_EMAIL" />:</td>
 						<td align="left" width="130px"><input id="email" class="reg_input" type="text" name="email" /></td>
 						<td id="emailTip" class="btn1_tip" align="left"></td>
 					</tr>
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_PASSWORD" />:</td>
 						<td align="left" width="130px"><input id="pwd" class="reg_input" type="password" name="pwd" /></td>
 						<td id="pwdlTip" align="left"></td>
 					</tr>
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_REPASSWORD" />:</td>
 						<td align="left" width="130px"><input id="repwd" class="reg_input" type="password" name="repwd" /></td>
 						<td id="repwdTip" align="left"></td>
 					</tr>
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_FRISTNAME" />:</td>
 						<td align="left" width="130px"><input id="firstName" class="reg_input" type="text" name="firstName" /></td>
 						<td id="fnameTip" align="left"></td>
 					</tr>
 					
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1">* <s:text name="RES_SECONDNAME" />:</td>
 						<td align="left" width="130px"><input id="secondName" class="reg_input" type="text" name="secondName" /></td>
 						<td id="lnameTip" align="left"></td>
 					</tr>
 					<tr height="45px">
 						<td align="right" width="130px" class="reg_lefttd1"><s:text name="RES_COMPANY" />:</td>
 						<td align="left" width="130px"><input id="company" class="reg_input" type="text" name="company" /></td>
 						<td></td>
 					</tr>
 					<tr height="45px">
 						<td></td>
 						<td align="left" colspan="2" >
 							<div id="submitForm" class="btn2">
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
