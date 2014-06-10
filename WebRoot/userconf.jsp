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
<s:set id="stid"  name="stid" value="'St_'+#session.defaultStation"/>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_USET"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_USET"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
		</div>
		<s:if test="#session.stationLimitsMap[#stid].CREATENOMARLUSERLIMIT==1">
		<table cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr>
				<td></td>
				<td></td>
				<td align="right">
					<div class="btn2" style="float: right;margin-left:10px;"  onclick="userconf.showCNormalUser()">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_ADDUSER"/><input id="usercount" type="hidden" value="<s:property value='userMapList.size()'/>" /></div>
							<div class="btn2_r"></div>
					</div>
					<!-- 
					<div class="btn2" style="float: right;" onclick="drawmenu.getBody('createNewStation.action')">
							<div class="btn2_l"></div>
							<div class="btn2_c">Change Password</div>
							<div class="btn2_r"></div>
					</div>
					 -->
				</td>
			</tr>
		</table>
		</s:if>
		<table border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;border-top: 1px solid #ccc;border-left: 1px solid #ccc;border-right: 1px solid #ccc; font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr style="background: url('images/bg_tab.jpg') 0px -197px repeat-x;">
					<td height="30px" style="border-bottom: 1px solid #ccc;" ><s:text name="RES_EMAIL"/></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_ETYPE"/></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_FRISTNAME"/></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_SECONDNAME"/></td>
					<s:if test="#session.stationLimitsMap[#stid].CREATENOMARLUSERLIMIT==1||#session.stationLimitsMap[#stid].DELNOMARLUSERLIMIT==1">
					<td height="30px" colspan="2" style="border-bottom: 1px solid #ccc;"><s:text name="RES_CONFIRM"/></td>
					</s:if>
				</tr>
				<s:iterator id="user" value="userMapList" status="umst">
				<s:if test="#umst.odd">
				<tr>
				</s:if>
				<s:else>
				<tr style="background: #eee;">
				</s:else>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:property value="#user.Account" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;">
						<s:if test="#user.roleId==1">
							普通用户
						</s:if>
						<s:elseif test="#user.roleId==2">
							管理员用户
						</s:elseif>
					</td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:property value="#user.firstName" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:property value="#user.secondName" /></td>
					<s:if test="#session.stationLimitsMap[#stid].CREATENOMARLUSERLIMIT==1">
					<td height="30px" width="40px" style="border-bottom: 1px solid #ccc;"><a href="javascript:;" onclick="userconf.editNormalUser(<s:property value="#user.userId" />);return false;"><img src="images/icon/edit.png" /></a></td>
					<s:if test="#session.stationLimitsMap[#stid].DELNOMARLUSERLIMIT==1&&#user.roleId==1">
					<td height="30px" width="40px" style="border-bottom: 1px solid #ccc;"><a href="javascript:;" onclick="userconf.delNormalUser(<s:property value="#user.userId" />);return false;" ><img src="images/icon/delete.png" /></a></td>
					</s:if>
					<s:else>
					<td height="30px" width="40px" style="border-bottom: 1px solid #ccc;">&nbsp;</td>
					</s:else>
					</s:if>
					<s:else>
					
					</s:else>
				</tr>
				</s:iterator>
		</table>
		<table id="addUsertab" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;display: none;">
			<form id="addUserForm">
				<s:token></s:token>
				<tr height="40px">
					<td colspan="3" align="left" height="30px" style="font-weight: bold;font-size: 16px;"><s:text name="RES_ADDUSER"/></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="100px"><s:text name="RES_EMAIL" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input id="email" class="input_txt" type="text" name="email" onfocus="userconf.focusEmail();" onblur="userconf.checkEmail();" /></td>
					<td align="left" width="300px" id="emailTip"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="100px"><s:text name="RES_PASSWORD" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt"  id="pwd" name="pwd" type="password" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="100px"><s:text name="RES_REPASSWORD" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" id="repwd" name="repwd" type="password" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="100px"><s:text name="RES_FRISTNAME" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" id="firstName" name="firstName" type="text" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right" width="100px"><s:text name="RES_SECONDNAME" />:</td>
					<td align="left" width="240px">&nbsp;&nbsp;<input class="input_txt" id="secondName" name="secondName" type="text" /></td>
					<td align="left" width="300px"></td>
					<td></td>
				</tr>
				<tr height="40px">
					<td width="100px"></td>
					<td align="right"></td>
					<td align="left">&nbsp;&nbsp;<input id="submitForm" class="input_btn" type="button" value="<s:text name="RES_OK"/>" /></td>
				</tr>
			</form>
		</table>
	</div>
</div>