<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>

<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_POWERLIST"/></a> > <a href="javascript:;" onclick="return false;"><s:text name="RES_STATIONDETAIL"/></a>
</div>
<s:if test="stationMap==null">
	<div class="rightcon_title"><s:text name="RES_POWERLIST"/></div>
	<div  class="rightcon">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center" style="margin: 0 auto;">
				<tr height="40px;">
					<td align="right">
						Sorry,this station is not exist.
					</td>
				</tr>
			</table>
	</div>	
</s:if>
<s:else>
<div class="rightcon">
	<div class="rightcon">
		<div class="rightcon_title"><s:text name="RES_STATIONDETAIL"/> </div>
		<div  class="rightcon">
				<table border="0" cellpadding="0" cellspacing="0" width="90%" align="left" style="margin: 0 auto;" >
					<tr>
						<td width="460px">
							<s:if test="stationMap.bgurl==null||stationMap.bgurl==''">
								<img src="theme/icon/bg_gl.jpg" height="300px" width="400px"/>
							</s:if>
							<s:else>
								<img src="<s:property value='stationMap.bgurl'/>" height="300px" width="400px"/>
							</s:else>
						</td>
						<td valign="top">
							<table border="0" cellpadding="0" cellspacing="0"  align="left">
								<tr height="30px">
									<td align="left">
										<span class="spantitle"><s:property value="stationMap.stationname"/></span>
										<s:if test="#session.userLimits.editStationLimit==1">
											<a title="rename the power station" href="javascript:;" onclick="drawmenu.getBody('editStation.action?stid=<s:property value="stationMap.stationid" />');return false;">
												<img src="images/icon/edit.png"/>
											</a>
										</s:if>
									</td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_ADDR"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.addr"/>,<s:property value="stationMap.city"/>,<s:property value="stationMap.country"/></td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_CANAME"/>:</span>&nbsp;&nbsp;<s:property value="#session.user.firstName"/><s:property value="#session.user.secondName"/></td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_LONGITUDE"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.x"/>°</td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_LATITUDE"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.y"/>°</td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_HASL"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.h"/>M</td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_AZIMUTH"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.comangle"/>°</td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_AOI"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.cominsangle"/>°</td>
								</tr height="30px">
								<tr>
									<td align="left"><span class="spangraytitle"><s:text name="RES_CO2XS"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.CO2xs"/></td>
								</tr>
								<tr height="30px">
									<td align="left"><span class="spangraytitle"><s:text name="RES_GAINXS"/>:</span>&nbsp;&nbsp;<s:property value="stationMap.gainxs"/></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</div>	
	<div>
</div>
</s:else>