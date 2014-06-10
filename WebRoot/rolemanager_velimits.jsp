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
<script type="text/javascript">

</script>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<s:if test="type!='edit'">
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a>  > <a href="#"><s:text name="RES_ROLELIMITSCONF"/></a>
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
			<tr style="background: #eee;height: 30px;line-height: 30px;font-weight: bold;"><td align="left" style="padding-left: 10px;"><s:text name="RES_SEELIMITS" /></td></tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;border: 1px solid #ccc;">
			<tr>
				<td align="left" style="padding-left: 20px;background: #eee;height: 30px;line-height: 30px;">
					普通用户：
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;line-height: 30px;">
					<ul>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
						<s:set id="normalUser" name="normalUser" value="#request.roleLimitsMap['roleId_1']"/>
						<s:if test="#normalUser.EDITSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站 </li>
						</s:if>
						<s:if test="#normalUser.DELSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除电站 </li>
						</s:if>
						<s:if test="#normalUser.CREATENOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建普通用户 </li>
						</s:if>
						<s:if test="#normalUser.EDITNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站用户信息 </li>
						</s:if>
						<s:if test="#normalUser.DELNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除普通用户 </li>
						</s:if>
						<s:if test="#normalUser.EDITSTATIONADMINLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站管理员信息 </li>
						</s:if>
						<s:if test="#normalUser.ADDPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />添加PMU </li>
						</s:if>
						<s:if test="#normalUser.DELPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除PMU </li>
						</s:if>
						<s:if test="#normalUser.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#normalUser.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#normalUser.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#normalUser.EDITINVERTERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />逆变器改名 </li>
						</s:if>
						<s:if test="#normalUser.SETAGCSLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />设置安规参数 </li>
						</s:if>
						<s:if test="#normalUser.SENDSOFTUPDATELIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />发送升级程序 </li>
						</s:if>
					</ul>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;background: #eee;height: 30px;line-height: 30px;">
					电站管理员：
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;line-height: 30px;">
					<ul>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
						<s:set id="stationUser" name="stationUser"  value="#request.roleLimitsMap['roleId_2']"/>
						<s:if test="#stationUser.EDITSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站 </li>
						</s:if>
						<s:if test="#stationUser.DELSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除电站 </li>
						</s:if>
						<s:if test="#stationUser.CREATENOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建普通用户 </li>
						</s:if>
						<s:if test="#stationUser.EDITNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站用户信息 </li>
						</s:if>
						<s:if test="#stationUser.DELNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除普通用户 </li>
						</s:if>
						<s:if test="#stationUser.EDITSTATIONADMINLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站管理员信息 </li>
						</s:if>
						<s:if test="#stationUser.ADDPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />添加PMU </li>
						</s:if>
						<s:if test="#stationUser.DELPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除PMU </li>
						</s:if>
						<s:if test="#stationUser.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#stationUser.EDITINVERTERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />逆变器改名 </li>
						</s:if>
						<s:if test="#stationUser.SETAGCSLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />设置安规参数 </li>
						</s:if>
						<s:if test="#stationUser.SENDSOFTUPDATELIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />发送升级程序 </li>
						</s:if>
					</ul>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;background: #eee;height: 30px;line-height: 30px;">
					系统管理员：
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;line-height: 30px;">
					<ul>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
						<s:set id="sysAdmin" name="sysAdmin"  value="#request.roleLimitsMap['roleId_3']"/>
						<s:if test="#sysAdmin.EDITSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站 </li>
						</s:if>
						<s:if test="#sysAdmin.DELSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除电站 </li>
						</s:if>
						<s:if test="#sysAdmin.CREATENOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建普通用户 </li>
						</s:if>
						<s:if test="#sysAdmin.EDITNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站用户信息 </li>
						</s:if>
						<s:if test="#sysAdmin.DELNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除普通用户 </li>
						</s:if>
						<s:if test="#sysAdmin.EDITSTATIONADMINLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站管理员信息 </li>
						</s:if>
						<s:if test="#sysAdmin.ADDPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />添加PMU </li>
						</s:if>
						<s:if test="#sysAdmin.DELPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除PMU </li>
						</s:if>
						<s:if test="#sysAdmin.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#sysAdmin.EDITINVERTERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />逆变器改名 </li>
						</s:if>
						<s:if test="#sysAdmin.SETAGCSLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />设置安规参数 </li>
						</s:if>
						<s:if test="#sysAdmin.SENDSOFTUPDATELIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />发送升级程序 </li>
						</s:if>
						<s:if test="#admin.SEEALLEVENTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看所有逆变器数据 </li>
						</s:if>
						<s:if test="#admin.SEEINVCOUNTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />显示逆变器在线数目及总数 </li>
						</s:if>
					</ul>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;background: #eee;height: 30px;line-height: 30px;">
					超级管理员：
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;line-height: 30px;">
					<ul>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
						<s:set id="admin" name="admin"  value="#request.roleLimitsMap['roleId_4']"/>
						<s:if test="#admin.EDITSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站 </li>
						</s:if>
						<s:if test="#admin.DELSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除电站 </li>
						</s:if>
						<s:if test="#admin.CREATENOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建普通用户 </li>
						</s:if>
						<s:if test="#admin.EDITNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站用户信息 </li>
						</s:if>
						<s:if test="#admin.DELNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除普通用户 </li>
						</s:if>
						<s:if test="#admin.EDITSTATIONADMINLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站管理员信息 </li>
						</s:if>
						<s:if test="#admin.ADDPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />添加PMU </li>
						</s:if>
						<s:if test="#admin.DELPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除PMU </li>
						</s:if>
						<s:if test="#admin.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#admin.EDITINVERTERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />逆变器改名 </li>
						</s:if>
						<s:if test="#admin.SETAGCSLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />设置安规参数 </li>
						</s:if>
						<s:if test="#admin.SENDSOFTUPDATELIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />发送升级程序 </li>
						</s:if>
						<s:if test="#admin.SEEALLEVENTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看所有逆变器数据 </li>
						</s:if>
						<s:if test="#admin.SEEINVCOUNTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />显示逆变器在线数目及总数 </li>
						</s:if>
						<s:if test="#admin.IMPORTPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />导入PMU </li>
						</s:if>
						<s:if test="#admin.CREATESYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建系统用户</li>
						</s:if>
						<s:if test="#admin.DELSYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除系统用户</li>
						</s:if>
						<s:if test="#admin.EDITSYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑系统用户</li>
						</s:if>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</div>
</s:if>
<!-- 编辑页面 -->
<s:else>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a>  > <a href="#"><s:text name="RES_ROLELIMITSCONF"/></a>
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
			<tr style="background: #eee;height: 30px;line-height: 30px;font-weight: bold;"><td align="left" style="padding-left: 10px;"><s:text name="RES_LIMITSCONF" /></td></tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;border: 1px solid #ccc;">
			<tr>
				<td align="left" style="padding-left: 20px;background: #eee;height: 30px;line-height: 30px;">
					用户类型：
					<select id="selectRole" name="roleId" onchange="rolem.changeUserType()">
						<s:if test="roleId==1">
							<option value="1" selected="selected">普通用户</option>
						</s:if>
						<s:else>
							<option value="1">普通用户</option>
						</s:else>
						<s:if test="roleId==2">
							<option value="2" selected="selected">电站管理员</option>
						</s:if>
						<s:else>
							<option value="2">电站管理员</option>
						</s:else>
						<s:if test="roleId==3">
							<option value="3" selected="selected">系统管理员</option>
						</s:if>
						<s:else>
							<option value="3">系统管理员</option>
						</s:else>
						<s:if test="roleId==4">
							<option value="4" selected="selected">超级管理员</option>
						</s:if>
						<s:else>
							<option value="4">超级管理员</option>
						</s:else>
					</select>
				</td>
			</tr>
			<tr>
				<td align="left" style="padding-left: 20px;line-height: 30px;">
					<input id="roleId" type="hidden" value="<s:property value='roleId' />" />
					<s:if test="roleId==1">
						<ul id="normalUser">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
							<s:set id="normalUser" name="normalUser"  value="#request.roleLimitsMap['roleId_1']"/>
							<s:if test="#normalUser.EDITSTATIONLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITSTATIONLIMIT" />编辑电站 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITSTATIONLIMIT" />编辑电站 </li>
							</s:else>
							<s:if test="#normalUser.ADDPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="ADDPMULIMIT" />添加PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="ADDPMULIMIT" />添加PMU </li>
							</s:else>
							<s:if test="#normalUser.DELPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="DELPMULIMIT"  />删除PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="DELPMULIMIT" />删除PMU </li>
							</s:else>
							<s:if test="#normalUser.SETREPORTLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SETREPORTLIMIT" />配置报告 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="SETREPORTLIMIT" />配置报告 </li>
							</s:else>
						</ul>
					</s:if>
					<s:elseif test="roleId==2">
						<ul>
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
							<s:set id="stationUser" name="stationUser"  value="#request.roleLimitsMap['roleId_2']"/>
							<s:if test="#stationUser.EDITSTATIONLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITSTATIONLIMIT" />编辑电站 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITSTATIONLIMIT"/>编辑电站 </li>
							</s:else>
							<s:if test="#stationUser.DELSTATIONLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="DELSTATIONLIMIT" />删除电站 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" value="DELSTATIONLIMIT" />删除电站 </li>
							</s:else>
							<s:if test="#stationUser.CREATENOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="CREATENOMARLUSERLIMIT" />创建普通用户 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="CREATENOMARLUSERLIMIT" />创建普通用户 </li>
							</s:else>
							<s:if test="#stationUser.EDITNOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" checked="checked" value="EDITNOMARLUSERLIMIT" />编辑电站用户信息 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITNOMARLUSERLIMIT" />编辑电站用户信息 </li>
							</s:else>
							<s:if test="#stationUser.DELNOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" checked="checked" value="DELNOMARLUSERLIMIT" />删除普通用户 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" value="DELNOMARLUSERLIMIT" />删除普通用户 </li>
							</s:else>
							<s:if test="#stationUser.EDITSTATIONADMINLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITSTATIONADMINLIMIT" />编辑电站管理员信息 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITSTATIONADMINLIMIT" />编辑电站管理员信息 </li>
							</s:else>
							<s:if test="#stationUser.ADDPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="ADDPMULIMIT" />添加PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="ADDPMULIMIT" />添加PMU </li>
							</s:else>
							<s:if test="#stationUser.DELPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="DELPMULIMIT" />删除PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="DELPMULIMIT" />删除PMU </li>
							</s:else>
							<s:if test="#stationUser.SETREPORTLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SETREPORTLIMIT" />配置报告 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="SETREPORTLIMIT" />配置报告 </li>
							</s:else>
							<s:if test="#stationUser.EDITINVERTERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITINVERTERLIMIT" />逆变器改名 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITINVERTERLIMIT" />逆变器改名 </li>
							</s:else>
							<s:if test="#stationUser.SETAGCSLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SETAGCSLIMIT" />设置安规参数 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="SETAGCSLIMIT" />设置安规参数 </li>
							</s:else>
							<s:if test="#stationUser.SENDSOFTUPDATELIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SENDSOFTUPDATELIMIT" />发送升级程序 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="SENDSOFTUPDATELIMIT" />发送升级程序 </li>
							</s:else>
						</ul>
					</s:elseif>
					<s:elseif test="roleId==3">
						<ul id="sysUserUl">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
							<s:set id="sysUser" name="sysUser"  value="#request.roleLimitsMap['roleId_3']"/>
							<s:if test="#sysUser.EDITSTATIONLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITSTATIONLIMIT" />编辑电站 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITSTATIONLIMIT"/>编辑电站 </li>
							</s:else>
							<s:if test="#sysUser.DELSTATIONLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="DELSTATIONLIMIT" />删除电站 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" value="DELSTATIONLIMIT" />删除电站 </li>
							</s:else>
							<s:if test="#sysUser.CREATENOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="CREATENOMARLUSERLIMIT" />创建普通用户 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="CREATENOMARLUSERLIMIT" />创建普通用户 </li>
							</s:else>
							<s:if test="#sysUser.EDITNOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" checked="checked" value="EDITNOMARLUSERLIMIT" />编辑电站用户信息 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITNOMARLUSERLIMIT" />编辑电站用户信息 </li>
							</s:else>
							<s:if test="#sysUser.DELNOMARLUSERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" checked="checked" value="DELNOMARLUSERLIMIT" />删除普通用户 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" class="sellimit" type="checkbox" value="DELNOMARLUSERLIMIT" />删除普通用户 </li>
							</s:else>
							<s:if test="#sysUser.EDITSTATIONADMINLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITSTATIONADMINLIMIT" />编辑电站管理员信息 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITSTATIONADMINLIMIT" />编辑电站管理员信息 </li>
							</s:else>
							<s:if test="#sysUser.ADDPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="ADDPMULIMIT" />添加PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="ADDPMULIMIT" />添加PMU </li>
							</s:else>
							<s:if test="#sysUser.DELPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="DELPMULIMIT" />删除PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="DELPMULIMIT" />删除PMU </li>
							</s:else>
							<s:if test="#sysUser.SETREPORTLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SETREPORTLIMIT" />配置报告 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="SETREPORTLIMIT" />配置报告 </li>
							</s:else>
							<s:if test="#sysUser.EDITINVERTERLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="EDITINVERTERLIMIT" />逆变器改名 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="EDITINVERTERLIMIT" />逆变器改名 </li>
							</s:else>
							<s:if test="#sysUser.SETAGCSLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SETAGCSLIMIT" />设置安规参数 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="SETAGCSLIMIT" />设置安规参数 </li>
							</s:else>
							<s:if test="#sysUser.SENDSOFTUPDATELIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SENDSOFTUPDATELIMIT" />发送升级程序 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="SENDSOFTUPDATELIMIT" />发送升级程序 </li>
							</s:else>
							<s:if test="#sysUser.SEEALLEVENTLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SEEALLEVENTLIMIT" />查看所有逆变器数据 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="SEEALLEVENTLIMIT" />查看所有逆变器数据 </li>
							</s:else>
							<s:if test="#sysUser.SEEINVCOUNTLIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="SEEINVCOUNTLIMIT" />显示逆变器在线数目及总数 </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox"  value="SEEINVCOUNTLIMIT" />显示逆变器在线数目及总数 </li>
							</s:else>
							<s:if test="#sysUser.IMPORTPMULIMIT==1">
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" checked="checked" value="IMPORTPMULIMIT" />导入PMU </li>
							</s:if>
							<s:else>
								<li style="width: 200px;height: 30px;float: left;"><input class="sellimit" type="checkbox" value="IMPORTPMULIMIT" />导入PMU </li>
							</s:else>
						</ul>
					</s:elseif>
					<s:elseif test="roleId==4">
						<ul id="adminUl" >
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看图表 </li>
						<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看事件 </li>
						<s:set id="admin" name="admin"  value="#request.roleLimitsMap['roleId_4']"/>
						<s:if test="#admin.EDITSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站 </li>
						</s:if>
						<s:if test="#admin.DELSTATIONLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除电站 </li>
						</s:if>
						<s:if test="#admin.CREATENOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建普通用户 </li>
						</s:if>
						<s:if test="#admin.EDITNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站用户信息 </li>
						</s:if>
						<s:if test="#admin.DELNOMARLUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除普通用户 </li>
						</s:if>
						<s:if test="#admin.EDITSTATIONADMINLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑电站管理员信息 </li>
						</s:if>
						<s:if test="#admin.ADDPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />添加PMU </li>
						</s:if>
						<s:if test="#admin.DELPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除PMU </li>
						</s:if>
						<s:if test="#admin.SETREPORTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />配置报告 </li>
						</s:if>
						<s:if test="#admin.EDITINVERTERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />逆变器改名 </li>
						</s:if>
						<s:if test="#admin.SETAGCSLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />设置安规参数 </li>
						</s:if>
						<s:if test="#admin.SENDSOFTUPDATELIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />发送升级程序 </li>
						</s:if>
						<s:if test="#admin.SEEALLEVENTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />查看所有逆变器数据 </li>
						</s:if>
						<s:if test="#admin.SEEINVCOUNTLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />显示逆变器在线数目及总数 </li>
						</s:if>
						<s:if test="#admin.IMPORTPMULIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />导入PMU </li>
						</s:if>
						<s:if test="#admin.CREATESYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />创建系统用户</li>
						</s:if>
						<s:if test="#admin.DELSYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />删除系统用户</li>
						</s:if>
						<s:if test="#admin.EDITSYSTEMUSERLIMIT==1">
							<li style="width: 200px;height: 30px;float: left;"><input type="checkbox" checked="checked" disabled />编辑系统用户</li>
						</s:if>
					</ul>
					</s:elseif>
				</td>
			</tr>
			<tr height="40px">
				<td align="left" style="padding-left: 20px;height: 30px;line-height: 30px;">
					<input class="input_btn" type="button" onclick="rolem.subLimits()" value="<s:text name='RES_OK' />"  />
				</td>
			</tr>
		</table>
	</div>
</div>
</s:else>
