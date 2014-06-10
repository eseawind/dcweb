<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="js/rolem.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<!-- 创建管理员 -->
<s:if test='type!="edit"'>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a  href="javascript:;" onclick="return false;"><s:text name="RES_ROLELIMITSCONF"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_ROLELIMITSCONF"/></div>
		</div>
		<table cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr>
				<td>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('editLimits.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_LIMITSCONF" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('viewLimits.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_SEELIMITS" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('createSysuser.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_CREATESYSUSER" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('rolemanager.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_INDEX" /></div>
							<div class="btn2_r"></div>
					</div>
				</td>
			</tr>
		</table>
		
		<table class="showsysuser" cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr style="background: #eee;height: 30px;line-height: 30px;font-weight: bold;"><td align="left" style="padding-left: 10px;"><s:text name="RES_CREATESYSUSER" /></td></tr>
		</table>
		
		<table class="showsysuser" id="sysadmintab" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;border: 1px solid #ccc;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
			<form id="createSysuserForm" >
			<s:token></s:token>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_EMAIL"/>：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="email" name="email" /></td>
				<td align="left" id="emailTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_PASSWORD" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="password" class="input_txt" id="pwd" name="pwd" /></td>
				<td align="left" id="pwdlTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_REPASSWORD" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="password" class="input_txt" id="repwd" name="repwd" /></td>
				<td align="left" id="repwdTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_RDEPARTMENT" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="reqdepartment" name="requestDepartment" /></td>
				<td align="left" id="departTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_FRISTNAME" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="firstName" name="firstName" /></td>
				<td align="left" id="fnameTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_SECONDNAME" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="secondName" name="secondName" /></td>
				<td align="left" id="lnameTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"> <s:text name="RES_PHONE" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="tel" name="phone" /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"> <s:text name="RES_FAX" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="fax" name="fax" /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"></td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input id="createSysuserBtn"  class="input_btn" type="button" value="<s:text name="RES_OK"/>"  /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			</form>
		</table>
		<script type="text/javascript">
			rolem.cinit();
		</script>
	</div>
</div>
</s:if>
<!-- 编辑管理员 -->
<s:else>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a  href="javascript:;" onclick="return false;"><s:text name="RES_ROLELIMITSCONF"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_ROLELIMITSCONF"/></div>
		</div>
		<table cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr>
				<td>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('editLimits.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_LIMITSCONF" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('viewLimits.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_SEELIMITS" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('createSysuser.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_CREATESYSUSER" /></div>
							<div class="btn2_r"></div>
					</div>
					<div class="btn2" style="float: right;margin-left:10px;" onclick="drawmenu.getBody('rolemanager.action');">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_INDEX" /></div>
							<div class="btn2_r"></div>
					</div>
				</td>
			</tr>
		</table>
		
		<table class="showsysuser" cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr style="background: #eee;height: 30px;line-height: 30px;font-weight: bold;"><td align="left" style="padding-left: 10px;"><s:text name="RES_EDITSYSUSER" /></td></tr>
		</table>
		
		<table class="showsysuser" id="sysadmintab" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;border: 1px solid #ccc;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
			<form id="editSysuserForm" >
			<s:token></s:token>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_EMAIL"/>：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="hidden" name="userId" value="<s:property value='userMap.userId'/>" /><input type="text" class="input_txt" id="email" name="email" readonly="readonly" value="<s:property value='userMap.Account'/>"  /></td>
				<td align="left" id="emailTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_PASSWORD" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="password" class="input_txt" id="pwd" name="pwd" value="<s:property value='userMap.pwd'/>" /></td>
				<td align="left" id="pwdlTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_REPASSWORD" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="password" class="input_txt" id="repwd" name="repwd" value="<s:property value='userMap.pwd'/>" /></td>
				<td align="left" id="repwdTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_RDEPARTMENT" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="reqdepartment" name="requestDepartment"  value="<s:property value='userMap.reqestDepartment'/>" /></td>
				<td align="left" id="departTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_FRISTNAME" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="firstName" name="firstName"  value="<s:property value='userMap.firstName'/>"/></td>
				<td align="left" id="fnameTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;">* <s:text name="RES_SECONDNAME" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="secondName" name="secondName" value="<s:property value='userMap.secondName'/>" /></td>
				<td align="left" id="lnameTip">&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"> <s:text name="RES_PHONE" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="tel" name="phone" value="<s:property value='userMap.tel'/>" /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"> <s:text name="RES_FAX" />：</td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input type="text" class="input_txt" id="fax" name="fax" value="<s:property value='userMap.fax'/>" /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			<tr height="40px">
				<td align="right" style="width: 200px;height: 30px;line-height: 30px;"></td>
				<td align="left" style="width: 200px;height: 30px;line-height: 30px;"><input id="editSysuserBtn"  class="input_btn" type="button" value="<s:text name="RES_OK"/>"  /></td>
				<td align="left" >&nbsp;</td>
			</tr>
			</form>
		</table>
		<script type="text/javascript">
			rolem.einit();
		</script>
	</div>
</div>
</s:else>