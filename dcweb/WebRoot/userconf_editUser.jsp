<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="js/userconf.js"></script>
<script type="text/javascript">

</script>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="drawmenu.getBody('userconf.action');return false;"><s:text name="RES_USET"/></a> > <a href="#"><s:text name="RES_EDITUSER"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_EDITUSER"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) <input id="text_userId" type="hidden" value="<s:property value='userMap.userId'/>" /></div>
		</div>
		<table id="editUsertab" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="40px">
					<td colspan="3" align="left" height="30px" style="font-weight: bold;font-size: 16px;"><s:text name="RES_CHANGEPASSWORD"/></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="150px"><s:text name="RES_EMAIL"/>:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input id="email" class="input_txt" type="text" name="email" value="<s:property value='userMap.Account'/>" readonly="readonly" /></td>
					<td align="left" width="300px" id="emailTip"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="150px"><s:text name="RES_NEWPASSWORD"/>:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt"  id="pwd" name="pwd" type="password" value="<s:property value='userMap.pwd'/>" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="150px"><s:text name="RES_REPASSWORD" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" id="repwd" name="repwd" type="password"  value="<s:property value='userMap.pwd'/>"/></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="150px"><s:text name="RES_FRISTNAME" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" value="<s:property value='userMap.firstName'/>" id="firstName" name="firstName" type="text" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="150px"><s:text name="RES_SECONDNAME" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" value="<s:property value='userMap.secondName'/>" id="secondName" name="secondName" type="text" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right"></td>
					<td align="left">&nbsp;&nbsp;<input id="editUserBtn" class="input_btn" type="button" value="<s:text name="RES_OK"/>" onclick="userconf.updateUser();" /></td>
				</tr>
		</table>
	</div>
</div>