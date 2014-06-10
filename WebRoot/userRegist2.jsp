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
  	<script type="text/javascript">
 		function changeCountry(cid){
			if (cid==0){
			}else{
				window.frames["hiddenFrame"].location.href="stateList.action?countryId="+cid;
			}
		}
		function submitF(form){
			return false;
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
		background-image: url("images/buttom_bg1.gif");
		background-repeat: repeat-x;
		background-position: 0 50%;
		outline: 0px solid #D3E0E7;
		height: 28px !important;
		border: 0px solid ;
		height: 28px;
		width:62px;
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
</head>
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td><%@include file="headUserReg.jsp" %></td>
  	</tr>
  	<form id="dorigisterForm" name="dorigisterForm" action="registerCreate.action" method="post" >
  	<tr>
    	<td height="910" align="center" bgcolor="#E5EFF9">
    		<table width="920" border="0" cellspacing="0" cellpadding="0">
      			<tr>
        			<td height="78" valign="bottom" background="images/regin4.gif">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
					            <td width="23%" height="40" align="center" class="blue4"><s:text name="RES_REGISTER_STEP1" ></s:text></td>
					            <td width="59%" align="center" class="blue4"><s:text name="RES_REGISTER_STEP2" ></s:text></td>
					            <td width="18%" align="center" class="black5"><s:text name="RES_REGISTER_STEP3" ></s:text></td>
          					</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td height="780" align="center" valign="top" background="images/regin6.gif">
        				<table width="794" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="163">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
              							<tr>
                							<td width="65%" align="right">
                								<table width="100%" border="0" cellspacing="0" cellpadding="0">
                  									<tr>
                    									<td height="30" colspan="3" align="left" class="blue2"><span class="blue3"><s:text name="RES_REGISTER_CREATETITLE" ></s:text></span></td>
                    								</tr>
                  									<tr>
									                    <td width="25%" height="33" align="right" class="black2">* <s:text name="RES_EMAIL" ></s:text>：</td>
									                    <td width="33%" align="left"><input name="email" type="text" class="test_input17" id="email"  maxlength="50"/></td>
									                    <td width="42%" align="left" class="red" id="emailTip"></td>
                  									</tr>
                  									<tr>
									                    <td height="33" align="right" class="black2">* <s:text name="RES_PASSWORD" ></s:text>：</td>
									                    <td align="left"><input name="pwd" type="password" class="test_input17" id="pwd"  maxlength="18"/></td>
									                    <td align="left" class="red" id="pwdlTip">&nbsp;</td>
                  									</tr>
								                  	<tr>
									                    <td height="33" align="right" class="black2">* <s:text name="RES_REPASSWORD" ></s:text>：</td>
									                    <td align="left"><input name="repwd" type="password" class="test_input17" id="repwd"  maxlength="18"/></td>
									                    <td align="left" class="red"  id="repwdTip">&nbsp;</td>
								                  	</tr>
                								</table>
                							</td>
                							<td width="35%">
                								<!-- 去掉固定提示，由JS动态提示
                								<table width="100%" border="0" cellspacing="0" cellpadding="0">
					                  				<tr>
									                    <td width="16%" height="60" align="center" valign="top"><img src="images/regin7.gif" width="22" height="22" /></td>
									                    <td width="84%" align="left" valign="top" class="black2"><s:text name="RES_REGISTER_CREATEEMAILVAL" ></s:text></td>
					                  				</tr>
                  									<tr>
									                    <td height="60" align="center" valign="top"><img src="images/regin7.gif" width="22" height="22" /></td>
									                    <td align="left" valign="top" class="black2"><s:text name="RES_REGISTER_CREATEPWDVAL" ></s:text></td>
                  									</tr>
                								</table>
                 								-->
                							</td>
              							</tr>
            						</table>
            					</td>
          					</tr>
          					<!-- 2013-06-06修改   注册时去掉密保问题 -->
          					<tr>
          						<td height="20"></td>
          					</tr>
          					<tr>
            					<td height="1" bgcolor="#92BCD4"></td>
          					</tr>
          					<tr>
          						<td height="20"></td>
          					</tr>
          					<tr>
            					<td height="440" align="right">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
              							<tr>
                							<td height="30" colspan="4" align="left" class="blue3"><s:text name="RES_REGISTER_CREATEPERSONINFO" ></s:text></td>
             	 						</tr>
							            <tr>
							                <td width="16%" height="33" align="right" class="black2">* <s:text name="RES_FRISTNAME" ></s:text>：</td>
							                <td width="30%" align="left"><input name="firstName" type="text" class="test_input2" id="firstName"  maxlength="15"/></td>
							                <td width="54%" align="left" class="red" id="fnameTip" colspan="2">&nbsp;</td>
							            </tr>
							            <tr>
							                <td height="33" align="right" class="black2">* <s:text name="RES_SECONDNAME" ></s:text>：</td>
							                <td align="left"><input name="secondName" type="text" class="test_input2" id="secondName"  maxlength="15"/></td>
							                <td align="left" class="red" id="lnameTip" colspan="2">&nbsp;</td>
							            </tr>
							            <tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCMP" ></s:text>：</td>
							                <td align="left"><input name="company" type="text" class="test_input2" id="company"  maxlength="30"/></td>
							                <td align="left" colspan="2">&nbsp;</td>
							            </tr>
							            <tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONURL" ></s:text>：</td>
							                <td align="left"><input name="myurl" type="text" class="test_input2" id="myurl" value="http://"  maxlength="50"/></td>
							                <td align="left" colspan="2"></td>
							            </tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;*&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCOUNTRY" ></s:text>：</td>
							                <td align="left"><select name="country" class="test_input2ex" id="country" >
                								<option value="0"><s:text name="RED_REGISTER_SELECT"/></option>
                 								<s:iterator id="country" status="ss" value="countryList">
	         									<option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
     											</s:iterator>
                								</select></td>
                							<td></td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;*&nbsp;<s:text name="RES_STATE" ></s:text>：</td>
							                <td align="left"><select name="state" class="test_input2ex" id="state">
							                <option value="0"><s:text name="RED_REGISTER_SELECT"/></option>
							                </select></td>
							                <td></td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_CITY" ></s:text>：</td>
							                <td align="left"><input name="city" type="text" class="test_input2" id="city"  maxlength="20"/></td>
							                <td align="left" colspan="2">&nbsp;</td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEADDRESS" ></s:text>：</td>
							                <td align="left"><input name="address" type="text" class="test_input2" id="address"  maxlength="50"/></td>
							                <td align="left" colspan="2">&nbsp;</td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONPOSTCODE" ></s:text>：</td>
							                <td align="left"><input name="postcode" type="text" class="test_input2" id="postcode"  maxlength="10"/></td>
							                <td align="left" colspan="2">&nbsp;</td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONTEL" ></s:text>：</td>
							                <td align="left"><input name="tel1" type="text" class="test_input3" id="tel1" size="6"  maxlength="6"/>
							                  	<input name="tel2" type="text" class="test_input3" id="tel2" size="4"  maxlength="6"/>
							                  	<input name="tel3" type="text" class="test_input4" id="tel3" size="6"  maxlength="10"/>
							                  	<input name="tel4" type="text" class="test_input3ex" id="tel4" size="6"  maxlength="8"/></td>
							                <td align="left">&nbsp;</td>
							                <td align="left"></td>
              							</tr>
              							<tr>
							                <td height="33" align="right" class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONMOBIL" ></s:text>：</td>
							                <td align="left"><input name="mobile2" type="text" class="test_input3" id="mobile2" size="8"  maxlength="6"/>
							                  	<input name="mobile" type="text" class="test_input13" id="mobile"  maxlength="15"/></td>
							                <td align="left">&nbsp;</td>
							                <td align="left"></td>
              							</tr>
              							<tr>
							                <td height="33" colspan="2" align="left" class="blue1">&nbsp;&nbsp;<s:text name="RES_MUSTFILL" ></s:text></td>
							                <td align="left">&nbsp;</td>
							                <td align="left">&nbsp;</td>
              							</tr>
            						</table>
            					</td>
          					</tr>
          					<tr>
          						<td height="20"></td>
          					</tr>
          					<tr>
            					<td height="1" bgcolor="#92BCD4"></td>
					        </tr>
					        <tr>
          						<td height="20"></td>
          					</tr>
					        <tr>
					            <td height="60" align="center">
					            	<table width="90%" border="0" cellspacing="0" cellpadding="0">
					              		<tr>
					                		<td align="left"><input type="button" class="button2" value="<s:text name="RES_REGISTER_CREATELASTSTEP"></s:text>" onclick="location.href='register.action'" style="cursor:pointer"/></td>
					                		<td align="right"><input id="submitFormB" name="submitFormB" type="button" class="button2" value="<s:text name="RES_REGISTER_AGREETEXT"></s:text>" style="cursor:pointer"/></td>
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
  	</form>
</table>
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
