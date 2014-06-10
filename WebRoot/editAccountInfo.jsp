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
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confUser.js"></script>
	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			confUser.init();
		});
	</script>
</head>
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
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
    	<td align="center" valign="bottom" background="images/top_bg.gif">
    		<%@include file="HeadMenu.jsp" %> 
    	</td>
     	<script>
        	menuOver('userMenu',5);
        </script>
  	</tr>
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table border="0" cellspacing="18" cellpadding="0">
    			<input type="hidden" id="email"  value="<s:property value="userInfo.account"/>">
      			<tr>
        			<td width="896" align="center">
        				<table width="896" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td><img src="images/list5_1.gif" width="896" height="6" /></td>
            				</tr>
         	 				<tr>
            					<td align="center" background="images/list6.gif">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                						<tr>
                  							<td width="10%" height="33">&nbsp;</td>
                  							<td height="33" colspan="3" align="left"><span class="blue3"><s:text name="RES_REGISTER_CREATEPERSONINFO" ></s:text></span></td>
                  						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
											<td width="20%" height="33" align="right"><span class="black2"><s:text name="RES_EMAIL" ></s:text>：</span></td>
							                <td width="28%" height="33"  align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="email"/></td>
							                <td width="42%" height="33" ></td>
                						</tr>
                						<tr>
					                  		<td height="33">&nbsp;</td>
					                  		<td width="20%" height="33" align="right"><span class="black2">*  <s:text name="RES_FRISTNAME" ></s:text>：</span></td>
					                  		<td width="28%" height="33"><input name="firstName" type="text" class="test_input2"  maxlength="15" id="firstName" value="<s:property value="userInfo.firstname"/>"/></td>
					                  		<td width="42%" height="33" id="fnameTip" align="left" class="black2ex">&nbsp;</td>
					                	</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
						                  	<td height="33"  align="right"><span class="black2">*&nbsp; <s:text name="RES_SECONDNAME" ></s:text>：</span></td>
						                  	<td height="33"><input name="secondName" type="text" class="test_input2"  maxlength="15" id="secondName"  value="<s:property value="userInfo.secondname"/>"/></td>
						                  	<td height="33" id="lnameTip" align="left" class="black2ex">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33"  align="right"><span class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCMP" ></s:text>：</span></td>
                  							<td height="33"><input name="company" type="text" class="test_input2" id="company"  maxlength="50" value="<s:property value="userInfo.company"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33"  align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONURL" ></s:text>：</span></td>
                  							<td height="33"><input name="myurl" type="text" class="test_input2" id="myurl"   maxlength="50" value="<s:property value="userInfo.webaddr"/>" /></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
						                  	<td height="33">&nbsp;</td>
						                  	<td height="33"  align="right"><span class="black2">*&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCOUNTRY" ></s:text>：</span></td>
						                  	<td height="33">
						                  		<select name="country" class="test_input2ex" id="country" onchange="changeCountry(this.value)">
                 								<s:iterator id="country" status="ss" value="countryList">
                  									<s:if test='userInfo.country==#country.c_code'>
			         								<option value="<s:property value="#country.c_code" />" selected="selected"><s:property value="countryname" /></option>
			         								</s:if>
			          								<s:else>
			         								<option value="<s:property value="#country.c_code" />" ><s:property value="countryname" /></option>
			         								</s:else>
		     									</s:iterator>
                								</select>
                							</td>
                  							<td></td>
                						</tr>
                						<tr>
                 	 						<td height="33">&nbsp;</td>
                  							<td height="33"  align="right"><span class="black2">*&nbsp;<s:text name="RES_STATE" ></s:text>：</span></td>
                  							<td height="33">
                  								<select name="state" class="test_input2ex" id="state">
                  								<option value="0"><s:text name="RED_REGISTER_SELECT"/></option>
             									<s:iterator id="state" status="ss" value="stateList">
              									<s:if test='state==#state.c_code'>
	         									<option value="<s:property value="#state.c_code" />" selected="selected"><s:property value="#state.countryname" /></option>
	          									</s:if>
	          									<s:else>
	         									<option value="<s:property value="#state.c_code" />"><s:property value="#state.countryname" /></option>
	         									</s:else>
     											</s:iterator>
                								</select>
                							</td>
                  							<td></td>
                						</tr>
                						<tr>
						                  	<td height="33">&nbsp;</td>
						                  	<td height="33" align="right"><span class="black2">&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCITY" ></s:text>：</span></td>
						                  	<td height="33"><input name="city" type="text" class="test_input2" id="city"  maxlength="20" value="<s:property value="userInfo.city"/>"/></td>
						                  	<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
						                  	<td height="33">&nbsp;</td>
						                  	<td height="33" align="right"><span class="black2">&nbsp;<s:text name="RES_REGISTER_CREATEADDRESS" ></s:text>：</span></td>
						                  	<td height="33"><input name="address" type="text" class="test_input2" id="address"  maxlength="50" value="<s:property value="userInfo.street"/>"/></td>
						                  	<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
					                  		<td height="33">&nbsp;</td>
					                  		<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONPOSTCODE" ></s:text>：</span></td>
					                  		<td height="33"><input name="postcode" type="text" class="test_input2" id="postcode"  maxlength="10" value="<s:property value="userInfo.zip"/>"/></td>
					                  		<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                 	 						<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONTEL" ></s:text>：</span></td>
                  							<td height="33" align="left"><input name="tel1" type="text" class="test_input3" id="tel1" size="6"  maxlength="6" value="<s:property value="userInfo.tel1"/>"/>
                  								<input name="tel2" type="text" class="test_input3" id="tel2" size="4"  maxlength="6" value="<s:property value="userInfo.tel2"/>"/>
                  								<input name="tel3" type="text" class="test_input4" id="tel3" size="6"  maxlength="10" value="<s:property value="userInfo.tel3"/>"/>
                  								<input name="tel4" type="text" class="test_input3" id="tel4" size="8"  maxlength="8" value="<s:property value="userInfo.tel4"/>"/></td>
                  							<td height="33" class="black2"></td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
						                  	<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONMOBIL" />：</span></td>
						                  	<td height="33" align="left"><input name="mobile1" type="text" class="test_input3" id="mobile1" size="6"  maxlength="6"  value="<s:property value="userInfo.mobile1"/>"/>
						                 		<input name="mobile" type="text" class="test_input4ex" id="mobile"  maxlength="15" value="<s:property value="userInfo.mobile"/>"/>
						                 	</td>
						                 	<td height="33" class="black2"></td>
                  						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" colspan="3" align="left"><span class="blue1"><s:text name="RES_MUSTFILL" ></s:text></span></td>
                  						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" colspan="3"><div align="center"><span class="blue1"><input id="submitForm" name="submitForm" type="button" class="button2" value="<s:text name="RED_CHART_SAVE"></s:text>"  style="cursor:pointer"/></span></div></td>
                  						</tr>
              						</table>              
              					<p>&nbsp;</p>
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
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
