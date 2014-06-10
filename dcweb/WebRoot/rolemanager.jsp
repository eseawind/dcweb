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
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_ROLELIMITSCONF"/></a>
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
				</td>
			</tr>
		</table>
		
		<table class="showsysuser" cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr style="background: #eee;height: 30px;line-height: 30px;font-weight: bold;"><td align="left" style="padding-left: 10px;"><s:text name="RES_SYSUSERLIST" /></td></tr>
		</table>
		<table class="showsysuser" id="sysadmintab" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;border: 1px solid #ccc;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr style="background: url('images/bg_tab.jpg') 0px -197px repeat-x;">
					<td height="30px" style="border-bottom: 1px solid #ccc;" ><s:text name="RES_EMAIL" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_ADUITETIME" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_RDEPARTMENT" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_FRISTNAME" /></td>
					<td height="30px" style="border-bottom: 1px solid #ccc;"><s:text name="RES_SECONDNAME" /></td>
					<td height="30px" colspan="2" style="border-bottom: 1px solid #ccc;"><s:text name="RES_CONFIRM"/></td>
				</tr>
				<s:if test="usersList.size()>0">
					<s:iterator value="usersList" id="user" status="ulist">
					<s:if test="#ulist.index<20">
						<s:if test="#ulist.index%2==1">
						<tr id="page_<s:property value='#ulist.index'/>e" style="background:#eee">
						</s:if>
						<s:else>
						<tr id="page_<s:property value='#ulist.index'/>">
						</s:else>
							<td height="30px"><s:property value="#user.Account"/></td>
							<td height="30px"><s:date name="#user.createdt" format="yyyy/MM/dd HH:mm:ss" /></td>
							<td height="30px"><s:property value="#user.reqestDepartment"/></td>
							<td height="30px"><s:property value="#user.firstName"/></td>
							<td height="30px"><s:property value="#user.secondName"/></td>
							<td height="30px" style="width: 30px;"><img style="cursor: pointer;" src="images/icon/edit.png" onclick="drawmenu.getBody('editSysUser.action?userId=<s:property value="#user.userId" />')"/></td>
							<td height="30px" style="width: 30px;"><img style="cursor: pointer;" src="images/icon/delete.png" onclick="rolem.deleteSysuser('<s:property value="#user.userId" />')" /></td>
						</tr>
					</s:if>
					<s:else>
						<s:if test="#ulist.index%2==1">
						<tr id="page_<s:property value='#ulist.index'/>" style="background:#eee;display:none;">
						</s:if>
						<s:else>
						<tr id="page_<s:property value='#ulist.index'/>" style="display:none;">
						</s:else>
							<td height="30px"><s:property value="#user.Account"/></td>
							<td height="30px"><s:property value="#user.createdt"/></td>
							<td height="30px"><s:property value="#user.reqestDepartment"/></td>
							<td height="30px"><s:property value="#user.firstName"/></td>
							<td height="30px"><s:property value="#user.secondName"/></td>
							<td height="30px" style="width: 30px;"><img style="cursor: pointer;" src="images/icon/edit.png" onclick="drawmenu.getBody('editSysUser.action?userId=<s:property value="#user.userId" />')"/></td>
							<td height="30px" style="width: 30px;"><img style="cursor: pointer;" src="images/icon/delete.png" onclick="rolem.deleteSysuser('<s:property value="#user.userId" />')" /></td>
						</tr>
					</s:else>
					</s:iterator>
				</s:if>
				<s:else>
				<tr>
					<td colspan="6"  height="30px" >没有系统用户</td>
				</tr>
				</s:else>
		</table>
		<table class="showsysuser" cellpadding="0" cellspacing="0" border="0" width="98%" style="float: left;font-weight: normal;color: #666;margin-top:10px;">
			<tr>
				<td>
					<div id="Pagination" class="pagination" style="float: right;height: 50px;">
	        		</div>
					<s:if test="userList.size()>20">
					<script type="text/javascript">
					var pageSize=20;
					 $("#Pagination").pagination('<s:property value="userList.size()"/>', {
					 		items_per_page:pageSize,
							num_edge_entries: 2,
							num_display_entries: 4,
							next_text:">",
							prev_text:"<",
					        callback: pageselectCallback1
					 });
					 function pageselectCallback1(page_id, jq){
					 		var startid = page_id*pageSize;
	    					var endid = page_id*pageSize+pageSize-1;
	    					$("#sysadmintab tr").css("display","none");
	    					$($("#sysadmintab tr")[0]).css("display","");
	    					for(var i=startid;i<=endid;i++){
	    						$("#page_"+i).css("display","");
	    					}
	                 }
					</script>
					</s:if>
				</td>
			</tr>
		</table>
		
	</div>
</div>