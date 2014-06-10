<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="js/powerlist.js"></script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_POWERLIST"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_POWERLIST"/></div>
	<div  class="rightcon">
		<s:if test="#session.roleLimits.createStationLimit==1">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center" style="margin: 0 auto;">
				<tr height="40px;">
					<s:if test="#session.user.roleId>3">
					<td align="left">
						<span style="color:#666;">当前在线逆变器数目:6 总计:10 </span>
					</td>
					</s:if>
					<td align="right">
						<div class="btn2" style="float: right;" onclick="drawmenu.getBody('createNewStation.action')">
							<div class="btn2_l"></div>
							<div class="btn2_c"><s:text name="RES_CREATESTATION" /></div>
							<div class="btn2_r"></div>
						</div>
					</td>
				</tr>
			</table>
		</s:if>
		<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center" style="margin: 0 auto;">
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;background: url('images/bgtable.jpg') repeat-x; ">
						<tr height="20px" style="overflow: hidden;">
							<td width="50%" align="left"><span class="spantitle">Plant</span></td>
							<td width="50%" align="right"><span class="spantitle">System Power</span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td width="50%" align="left"></td>
							<td width="50%" align="right"><span class="spantitle">[kwp]</span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-left: 0px;background: url('images/bgtable.jpg') repeat-x;">
						<tr height="20px" style="overflow: hidden;">
							<td colspan="4"><span class="spangraytitle">Information</span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td colspan="4"><span class="spangraytitle"></span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td width="25%"><span class="spantitle">PMU Count</span></td>
							<td width="25%"><span class="spantitle">Inverter Count</span></td>
						</tr>
					</table>
				
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-left: 0px;background: url('images/bgtable.jpg') repeat-x;">
						<tr height="20px" style="overflow: hidden;">
							<td><span class="spangraytitle"></span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td><span class="spangraytitle">Manage</span></td>
						</tr>
						<tr height="20px" style="overflow: hidden;">
							<td><span class="spangraytitle"></span></td>
						</tr>
					</table>
				</td>
				 
			</tr>
			<s:iterator id="station" status="ss" value="stationList">
			<s:set id="stid"  name="stid" value="'St_'+#station.stationid"/>
			<s:if test="#ss.odd==true">
			<tr>
			</s:if>
			<s:else>
			<tr style="background: #eee;">
			</s:else>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-top:0px; ">
						<tr height="30px" style="overflow: hidden;">
							<td width="50%"><a href="javascript:;" style="color:#666;text-decoration: underline;" onclick="drawmenu.getBody('overview.action?stationid=<s:property value="#station.stationid" />');return false;" ><s:property value="#station.stationname" /></a></td>
							<td width="50%"><s:property value="#station.e_total" /></td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-left: 0px;border-top:0px;">
						<tr height="30px" style="overflow: hidden;">
							<td width="25%"><s:property value="#station.pmunum" /></td>
							<td width="25%"><s:property value="#station.invnum" /></td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-left: 0px;border-top:0px;">
						<tr height="30px" style="overflow: hidden;">
							<td>
								<a title="the power station details" href="javascript:;" onclick="drawmenu.getBody('detailStation.action?stid=<s:property value="#station.stationid" />');return false;">
									<img  src="images/icon/detail.png"/>
								</a>
							</td>
							<s:if test="#session.stationLimitsMap[#stid].editStationLimit==1">
							<td>
								<a title="rename the power station" href="javascript:;" onclick="drawmenu.getBody('editStation.action?stid=<s:property value="#station.stationid" />');return false;">
									<img src="images/icon/edit.png"/>
								</a>
							</td>
							</s:if>				
							<s:if test="#session.stationLimitsMap[#stid].delStationLimit==1">
							<td>
								<a title="delete this station" href="javascript:;" onclick="powerlist.delStation('<s:property value="#station.stationid" />');return false;">
									<img src="images/icon/delete.png"/>
								</a>
							</td>
							</s:if>
						</tr>
					</table>
				</td>
				
			</tr>
			</s:iterator>
		</table>

	</div>
</div>