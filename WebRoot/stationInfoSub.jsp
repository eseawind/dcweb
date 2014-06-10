<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table width="860" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="82"><img src="<s:property value="#session.defaultStationMap.iconindex" />" width="82" height="82" /></td>
		<td width="154" align="center" class="black3"><span id="plantnametip"><s:property value="#session.defaultStationMap.stationname" /></span></td>
		<td width="1"><img src="images/dz_list2.gif" width="1" height="115" /></td>
		<td width="271" align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                  	<td width="50%" height="25" align="right" class="black2">E-Today：</td>
                  	<td width="50%" align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.etoday" /> <s:property value="#session.defaultStationMap.etoday_unit" /></td>
                </tr>
                <tr>
                  	<td height="25" align="right" class="black2">E-Total：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.etotal" /> <s:property value="#session.defaultStationMap.etotal_unit" /></td>
                </tr>
                <tr>
                  	<td height="25" align="right" class="black2"><s:text name="RES_ALLINCOME"/>：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.inval" /> <s:property value="#session.defaultStationMap.inval_unit" /></td>
                </tr>
                <tr>
                  	<td height="25" align="right" class="black2"><s:text name="RES_CO2V"/>：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.Co2Val" /> <s:property value="#session.defaultStationMap.co2val_unit" /></td>
                </tr>
            </table>
		</td>
		<td width="1"><img src="images/dz_list2.gif" width="1" height="115" /></td>
		<td align="center">
			<table width="95%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                  	<td width="50%" height="25" align="right" class="black2"><s:text name="RES_INVENUM"/>：</td>
                  	<td width="50%" align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.inv1num" />/<s:property value="#session.defaultStationMap.invtnum" /></td>
                </tr>
                <tr>
                  	<td height="25" align="right" class="black2"><s:text name="RES_MONITOR"/>：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.pmu1num" />/<s:property value="#session.defaultStationMap.pmutnum" /></td>
                </tr>
                <tr>
                  	<td height="25" align="right" class="black2"><s:text name="RES_EVENT"/>：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.defaultStationMap.eve0num" /></td>
                </tr>
                <tr>
                 	<td height="25" align="right" class="black2"><s:text name="RES_LASTUPDATE"/>：</td>
                  	<td align="left" class="black2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#session.ludt" /></td>
                </tr>
			</table>
		</td>
	</tr>
</table>
