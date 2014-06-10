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
			function changeCountry(cid){
			if (cid==0){
			}else{
				hiddenFrame.location.href="stateList.action?countryId="+cid;
			}
		}
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
	-->
</style>
<body>
<input type="hidden" id="email"  value="<s:property value="userInfo.account"/>"/>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table border="0" cellspacing="18" cellpadding="0">
      			<tr>
        			<td width="690" align="center">
        				<table width="896" border="0" cellspacing="0" cellpadding="0">
			          		<tr>
			            		<td><img src="images/list5_1.gif" width="896" height="6" /></td>
			            	</tr>
			          		<tr>
            					<td align="center" background="images/list6.gif">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td width="20%" height="33" align="right"><span class="black2">*  <s:text name="RES_FRISTNAME" ></s:text>：</span></td>
                  							<td width="28%" height="33"><input name="firstName" type="text" class="test_input2"  maxlength="15" id="firstName" value="<s:property value="userInfo.firstname"/>" readonly="true"/></td>
                  							<td width="42%" height="33" id="fnameTip" align="left" class="black2">&nbsp;</td>
                						</tr>
                						<tr>
						                  	<td height="33">&nbsp;</td>
						                  	<td height="33" align="right"><span class="black2">*&nbsp; <s:text name="RES_SECONDNAME" ></s:text>：</span></td>
						                  	<td height="33"><input name="secondName" type="text" class="test_input2"  maxlength="15" id="secondName" readonly="true" value="<s:property value="userInfo.secondname"/>"/></td>
						                  	<td height="33" id="lnameTip" align="left" class="black2">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">&nbsp;&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCMP" ></s:text>：</span></td>
                  							<td height="33"><input name="company" type="text" class="test_input2" id="company"  maxlength="50" readonly="true" value="<s:property value="userInfo.company"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONURL" ></s:text>：</span></td>
                  							<td height="33"><input name="myurl" type="text" class="test_input2" id="myurl"   maxlength="50" readonly="true" value="<s:property value="userInfo.webaddr"/>" /></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                 	 						<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">*&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCOUNTRY" ></s:text>：</span></td>
                  							<td height="33">
                  								<select name="country" class="test_input2" id="country" onchange="changeCountry(this.value)" readonly="true">
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
                  							<td height="33" id="countryTip"  align="left" class="black2">&nbsp;</td>
                						</tr>
                						<tr>
	                  						<td height="33">&nbsp;</td>
	                  						<td height="33"  align="right"><span class="black2">*&nbsp;<s:text name="RES_STATE" ></s:text>：</span></td>
	                  						<td height="33">
	                  							<select name="state" class="test_input2" id="state" readonly="true">
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
	                  						<td height="33" id="stateTip" align="left" class="black2">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">&nbsp;<s:text name="RES_REGISTER_CREATEPERSONCITY" ></s:text>：</span></td>
                  							<td height="33"><input name="city" type="text" class="test_input2" id="city"  maxlength="30" readonly="true" value="<s:property value="userInfo.city"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">&nbsp;<s:text name="RES_REGISTER_CREATEADDRESS" ></s:text>：</span></td>
                  							<td height="33"><input name="address" type="text" class="test_input2" id="address"  readonly="true" maxlength="50" value="<s:property value="userInfo.street"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONPOSTCODE" ></s:text>：</span></td>
                  							<td height="33"><input name="postcode" type="text" class="test_input2" id="postcode"  readonly="true" maxlength="10" value="<s:property value="userInfo.zip"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONTEL" ></s:text>：</span></td>
                  							<td height="33" align="left">
                  								<input name="tel1" type="text" class="test_input3" id="tel1" size="6"  maxlength="6" value="<s:property value="userInfo.tel1"/>"/>
                  								<input name="tel2" type="text" class="test_input3" id="tel2" size="4"  maxlength="6" value="<s:property value="userInfo.tel2"/>"/>
                  								<input name="tel3" type="text" class="test_input4" id="tel3" size="6"  maxlength="10" value="<s:property value="userInfo.tel3"/>"/>
                  								<input name="tel4" type="text" class="test_input3" id="tel4" size="8"  maxlength="8" value="<s:property value="userInfo.tel4"/>"/>
                  							</td>
                  							<td rowspan="2" class="black2"></td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2"><s:text name="RES_REGISTER_CREATEPERSONMOBIL" />：</span></td>
                  							<td height="33" align="left">
                  								<input name="mobile1" type="text" class="test_input3" id="mobile1" size="6"  maxlength="6"  value="<s:property value="userInfo.mobile1"/>"/>
                  								<input name="mobile" type="text" class="test_input4" id="mobile"  maxlength="15" value="<s:property value="userInfo.mobile"/>"/>
                  							</td>
                  						</tr>
                  						<tr>
                  							<td height="33" colspan="4" align="center">----------------最后一次登录信息--------------------</td>
                  						</tr>
                  						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">IP地址：</span></td>
                  							<td height="33"><input id="ipaddr" name="ipaddr" type="text" class="test_input2" readonly="true" maxlength="10" value="<s:property value="userInfo.ipaddr"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<script type="text/javascript">
											var curIp = $("#ipaddr").val();
											var curCountry = "";
											var curProvince = "";
											var curCity = "";
											$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip='+curIp,function(){ 
												curCountry = remote_ip_info.country;
												curProvince = remote_ip_info.province;
												curCity = remote_ip_info.city;
												if(curIp==""){
													$("#curCountry").val('');
													$("#curProvince").val('');
													$("#curCity").val('');
												}else{
													$("#curCountry").val(curCountry);
													$("#curProvince").val(curProvince);
													$("#curCity").val(curCity);
												}
											});
										</script>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">操作系统：</span></td>
                  							<td height="33"><input id="opsys" name="opsys" type="text" class="test_input2" readonly="true" value="<s:property value="userInfo.op_sys"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">浏览器：</span></td>
                  							<td height="33"><input id="ieinfo" name="ieinfo" type="text" class="test_input2" readonly="true" value="<s:property value="userInfo.ie_info"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">最后一次登录时间：</span></td>
                  							<td height="33"><input id="lastlogindt" name="lastlogindt" type="text" class="test_input2" readonly="true" value="<s:property value="userInfo.lastlogindt"/>"/></td>
                  							<td height="33">&nbsp;</td>
                						</tr>
                						<tr>
                  							<td height="33">&nbsp;</td>
                  							<td height="33" align="right"><span class="black2">位置信息：</span></td>
                  							<td height="33">
                  								<input id="curCountry" name="curCountry" type="text" size="5" readonly="true" />
                  								<input id="curProvince" name="curProvince" type="text" size="5" readonly="true" />
                  								<input id="curCity" name="curCity" type="text" size="5" readonly="true" />
                  							</td>
                  							<td height="33">&nbsp;</td>
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
</table>
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
