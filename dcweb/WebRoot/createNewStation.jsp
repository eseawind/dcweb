<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<s:if test="type=='editStation'">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/createStation.js"></script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_POWERLIST"/></a> > <a href="javascript:;" onclick="return false;"><s:text name="RES_EDITSTATION"/></a>
</div>
<s:if test="flag==1">
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_EDITSTATION"/> </div>
	<div  class="rightcon">
		<form id="editStation">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="left" style="margin: 0 auto;" >
				<tr height="40px;">
					<td align="right">
					</td>
					<td align="left" style="padding-left: 20px;color: #666;">
					    ( <font color="red">*</font> <s:text name="RES_MUSTFILL" />)
					</td>
					<td align="left" width="300px;" style="padding-left: 20px;">
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_STATIONNAME" />:
					</td>
					<td align="left" width="250px" style="padding-left: 20px;">
						<input class="input_txt" type="text" id="stationname" name="stationname" value="<s:property value='stationMap.stationname '/>"> <font color="red">*</font>
					</td>
					<td align="left"  width="300px;" id="stationname_tip" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_MONEY" />：
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<select id="money" name="money">
 								<option value="0" selected="selected">--<s:text name="RES_CHOOSEMONEY" />--</option>
 								<s:if test='"$"==stationMap.money'>
 									<option value="$" selected="selected">$</option>
 								</s:if>
 								<s:else>
 									<option value="$">$</option>
 								</s:else>
 								<s:if test='"€"==stationMap.money'>
 									<option value="€" selected="selected">€</option>
 								</s:if>
 								<s:else>
 									<option value="€">€</option>
 								</s:else>
 								<s:if test='"￥"==stationMap.money'>
 									<option value="￥" selected="selected">￥</option>
 								</s:if>
 								<s:else>
 									<option value="￥">￥</option>
 								</s:else>
 								
	 					</select>
					</td>
					<td align="left" id="money_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_TIMEZONE" />：
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<select id="timezone" name="timezone">
							<option value="" selected="selected">--<s:text name="RES_TIMEZONE" />--</option>
							<s:if test="stationMap.timezone==13">
								<option value="+13" selected="selected">GMT +13</option>
							</s:if>
							<s:else>
								<option value="+13">GMT +13</option>
							</s:else>
							<s:if test="stationMap.timezone==12">
								<option value="+12" selected="selected">GMT +12</option>
							</s:if>
							<s:else>
								<option value="+12">GMT +12</option>
							</s:else>
							<s:if test="stationMap.timezone==11.5">
								<option value="+11.5" selected="selected">GMT +11.5</option>
							</s:if>
							<s:else>
								<option value="+11.5">GMT +11.5</option>
							</s:else>
							<s:if test="stationMap.timezone==11">
								<option value="+11" selected="selected">GMT +11</option>
							</s:if>
							<s:else>
								<option value="+11">GMT +11</option>
							</s:else>
							<s:if test="stationMap.timezone==10">
								<option value="+10" selected="selected">GMT +10</option>
							</s:if>
							<s:else>
								<option value="+10">GMT +10</option>
							</s:else>
							<s:if test="stationMap.timezone==9.5">
								<option value="+9.5" selected="selected">GMT +9.5</option>
							</s:if>
							<s:else>
								<option value="+9.5">GMT +9.5</option>
							</s:else>
							<s:if test="stationMap.timezone==9">
								<option value="+9" selected="selected">GMT +9</option>
							</s:if>
							<s:else>
								<option value="+9">GMT +9</option>
							</s:else>
							<s:if test="stationMap.timezone==8">
								<option value="+8" selected="selected">GMT +8</option>
							</s:if>
							<s:else>
								<option value="+8">GMT +8</option>
							</s:else>
							<s:if test="stationMap.timezone==7">
								<option value="+7" selected="selected">GMT +7</option>
							</s:if>
							<s:else>
								<option value="+7">GMT +7</option>
							</s:else>
							<s:if test="stationMap.timezone==6.5">
								<option value="+6.5" selected="selected">GMT +6.5</option>
							</s:if>
							<s:else>
								<option value="+6.5">GMT +6.5</option>
							</s:else>
							<s:if test="stationMap.timezone==6">
								<option value="+6" selected="selected">GMT +6</option>
							</s:if>
							<s:else>
								<option value="+6">GMT +6</option>
							</s:else>
							<s:if test="stationMap.timezone==5.75">
								<option value="+5.75" selected="selected">GMT +5.75</option>
							</s:if>
							<s:else>
								<option value="+5.75">GMT +5.75</option>
							</s:else>
							<s:if test="stationMap.timezone==5.5">
								<option value="+5.5" selected="selected">GMT +5.5</option>
							</s:if>
							<s:else>
								<option value="+5.5">GMT +5.5</option>
							</s:else>
							<s:if test="stationMap.timezone==5">
								<option value="+5" selected="selected">GMT +5</option>
							</s:if>
							<s:else>
								<option value="+5">GMT +5</option>
							</s:else>
							<s:if test="stationMap.timezone==4.5">
								<option value="+4.5" selected="selected">GMT +4.5</option>
							</s:if>
							<s:else>
								<option value="+4.5">GMT +4.5</option>
							</s:else>
							<s:if test="stationMap.timezone==4">
								<option value="+4" selected="selected">GMT +4</option>
							</s:if>
							<s:else>
								<option value="+4">GMT +4</option>
							</s:else>
							<s:if test="stationMap.timezone==3.5">
								<option value="+3.5" selected="selected">GMT +3.5</option>
							</s:if>
							<s:else>
								<option value="+3.5">GMT +3.5</option>
							</s:else>
							<s:if test="stationMap.timezone==3">
								<option value="+3" selected="selected">GMT +3</option>
							</s:if>
							<s:else>
								<option value="+3">GMT +3</option>
							</s:else>
							<s:if test="stationMap.timezone==2">
								<option value="+2" selected="selected">GMT +2</option>
							</s:if>
							<s:else>
								<option value="+2">GMT +2</option>
							</s:else>
							<s:if test="stationMap.timezone==1">
								<option value="+1" selected="selected">GMT +1</option>
							</s:if>
							<s:else>
								<option value="+1">GMT +1</option>
							</s:else>
							<s:if test="stationMap.timezone==0">
								<option value="+0" selected="selected">GMT +0</option>
							</s:if>
							<s:else>
								<option value="+0">GMT +0</option>
							</s:else>
							<s:if test="stationMap.timezone==-1">
								<option value="-1" selected="selected">GMT -1</option>
							</s:if>
							<s:else>
								<option value="-1">GMT -1</option>
							</s:else>
							<s:if test="stationMap.timezone==-3">
								<option value="-3" selected="selected">GMT -3</option>
							</s:if>
							<s:else>
								<option value="-3">GMT -3</option>
							</s:else>
							<s:if test="stationMap.timezone==-4">
								<option value="-4" selected="selected">GMT -4</option>
							</s:if>
							<s:else>
								<option value="-4">GMT -4</option>
							</s:else>
							<s:if test="stationMap.timezone==-5">
								<option value="-5" selected="selected">GMT -5</option>
							</s:if>
							<s:else>
								<option value="-5">GMT -5</option>
							</s:else>
							<s:if test="stationMap.timezone==-6">
								<option value="-6" selected="selected">GMT -6</option>
							</s:if>
							<s:else>
								<option value="-6">GMT -6</option>
							</s:else>
							<s:if test="stationMap.timezone==-7">
								<option value="-7" selected="selected">GMT -7</option>
							</s:if>
							<s:else>
								<option value="-7">GMT -7</option>
							</s:else>
							<s:if test="stationMap.timezone==-8">
								<option value="-8" selected="selected">GMT -8</option>
							</s:if>
							<s:else>
								<option value="-8">GMT -8</option>
							</s:else>
							<s:if test="stationMap.timezone==-10">
								<option value="-10" selected="selected">GMT -10</option>
							</s:if>
							<s:else>
								<option value="-10">GMT -10</option>
							</s:else>
							<s:if test="stationMap.timezone==-11">
								<option value="-11" selected="selected">GMT -11</option>
							</s:if>
							<s:else>
								<option value="-11">GMT -11</option>
							</s:else>
	 					</select>
					</td>
					<td align="left" id="timezone_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_CO2XS" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="co2xs" type="text" name="co2xs" value="<s:property value='stationMap.CO2xs' />" onkeyup="value=value.replace(/[^\d\.]/g,'')" > <font color="red">*</font>
					</td>
					<td align="left" id="co2xs_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_GAINXS" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="gainxs" type="text" name="gainxs" value="<s:property value='stationMap.gainxs' />" onkeyup="value=value.replace(/[^\d\.]/g,'')" > <font color="red">*</font>
					</td>
					<td align="left" id="gainxs_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_ADDR" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="addr" type="text" name="addr" value="<s:property value='stationMap.addr'/>" > 
					</td>
					<td align="left" id="addr_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_COUNTRY" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="country" type="text" name="country" value="<s:property value='stationMap.country'/>" > 
					</td>
					<td align="left" id="country_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_CITY" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="city" type="text" name="city" value="<s:property value='stationMap.city'/>" > 
					</td>
					<td align="left" id="city_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
					
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input type="hidden" id='stid' name="stid" value="<s:property value='stid' />"/>
						<input style="border: 1px solid #ccc;padding: 2px 9px;" id="epsSubbtn" type="button" name='<s:text name="RES_OK" />' value="OK">
					</td>
					<td align="left" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
			</table>
		</form>
	</div>	
</div>
</s:if>
<s:else>
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_POWERLIST"/></div>
	<div  class="rightcon">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center" style="margin: 0 auto;">
				<tr height="40px;">
					<td align="right">
						Sorry,You don't create new station permissions.
					</td>
				</tr>
			</table>
	</div>	
</div>
</s:else>
</s:if>
<s:else>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/createStation.js"></script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_POWERLIST"/></a> > <a href="javascript:;" onclick="return false;"><s:text name="RES_CREATESTATION"/></a>
</div>
<s:if test="flag==1">
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_CREATESTATION"/> </div>
	<div  class="rightcon">
		<form id="docreateNewStationForm">
			<s:token></s:token>
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="left" style="margin: 0 auto;" >
				<tr height="40px;">
					<td align="right">
					</td>
					<td align="left" style="padding-left: 20px;color: #666;">
					    ( <font color="red">*</font> <s:text name="RES_MUSTFILL" />)
					</td>
					<td align="left" width="300px;" style="padding-left: 20px;">
					</td>
				</tr>
				<!-- 
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_EMAIL" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input id="email" class="input_txt" type="text" name="email" readonly="readonly" value="<s:property value='#session.user.Account' />"> 
					</td>
					<td align="left" id="email_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_CANAME" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input id="adminname" class="input_txt" type="text" name="Adminname" readonly="readonly" value="<s:property value='#session.user.firstName' /><s:property value='#session.user.secondName' />"> 
					</td>
					<td align="left" id="aname_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				 -->
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_SERIALNUMBER" />：
					</td>
					<td align="left" width="250px" style="padding-left: 20px;">
						<input class="input_txt" type="text" id="psno" name="psno"> <font color="red">*</font>
					</td>
					<td align="left"  width="300px;" id="psno_tip" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_STATIONNAME" />:
					</td>
					<td align="left" width="250px" style="padding-left: 20px;">
						<input class="input_txt" type="text" id="stationname" name="stationname"> <font color="red">*</font>
					</td>
					<td align="left"  width="300px;" id="stationname_tip" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_MONEY" />：
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<select id="money" name="money">
 								<option value="0" selected="selected">--<s:text name="RES_CHOOSEMONEY" />--</option>
 								<option value="$">$</option>
 								<option value="€">€</option>
 								<option value="￥">￥</option>
	 					</select>
					</td>
					<td align="left" id="money_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_TIMEZONE" />：
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<select id="timezone" name="timezone">
							<option value="" selected="selected">--<s:text name="RES_TIMEZONE" />--</option>
							<option value="+13">GMT +13</option>
							<option value="+12">GMT +12</option>
							<option value="+11.5">GMT +11.5</option>
							<option value="+11">GMT +11</option>
							<option value="+10">GMT +10</option>
							<option value="+9.5">GMT +9.5</option>
							<option value="+9">GMT +9</option>
							<option value="+8">GMT +8</option>
							<option value="+7">GMT +7</option>
							<option value="+6.5">GMT +6.5</option>
							<option value="+6">GMT +6</option>
							<option value="+5.75">GMT +5.75</option>
							<option value="+5.5">GMT +5.5</option>
							<option value="+5">GMT +5</option>
							<option value="+4.5">GMT +4.5</option>
							<option value="+4">GMT +4</option>
							<option value="+3.5">GMT +3.5</option>
							<option value="+3">GMT +3</option>
							<option value="+2">GMT +2</option>
							<option value="+1">GMT +1</option>
							<option value="+0">GMT +0</option>
							<option value="-1">GMT -1</option>
							<option value="-3">GMT -3</option>
							<option value="-4">GMT -4</option>
							<option value="-5">GMT -5</option>
							<option value="-6">GMT -6</option>
							<option value="-7">GMT -7</option>
							<option value="-8">GMT -8</option>
							<option value="-10">GMT -10</option>
							<option value="-11">GMT -11</option>
	 					</select>
					</td>
					<td align="left" id="timezone_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<!-- 
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_LONGITUDE" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<input class="input_txt" id="longitude" style="width: 40px;" type="text" name="" onkeyup="value=value.replace(/[^\d\.]/g,'')">
						 		</td>
						 		<td width="40px" valign="top"> &nbsp;&nbsp;°</td>
						 		<td width="60px">
									<select id="longitudesel" name="longitudesel" >
										<option value="E">E</option>
										<option value="W">W</option>
									</select>
								</td>
						 	</tr>
						 </table>
					</td>
					<td align="left" id="longitude_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_LATITUDE" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<input class="input_txt" id="latitude" style="width: 40px;" type="text" name="latitude" onkeyup="value=value.replace(/[^\d\.]/g,'')">
						 		</td>
						 		<td width="40px" valign="top"> &nbsp;&nbsp;°</td>
						 		<td width="60px">
									<select id="latitudesel" name="latitudesel" >
										<option value="N">N</option>
										<option value="S">S</option>
									</select>
								</td>
						 	</tr>
						 </table>
					</td>
					<td align="left" id="latitude_tip" width="300px;" style="padding-left: 20px;" >
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_HASL" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<input id="hasl" class="input_txt" style="width: 70px;" type="text" name="l_height" onkeyup="value=value.replace(/[^\d\.\-]/g,'')">
						 		</td>
						 		<td width="40px" > &nbsp;&nbsp;M</td>
						 	</tr>
						 </table>
					</td>
					<td align="left" id="hasl_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_AZIMUTH" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<input class="input_txt" id="azimuth" style="width: 40px;" type="text" name="azimuth" onkeyup="value=value.replace(/[^\d\.]/g,'')">
						 		</td>
						 		<td width="40px" valign="top"> &nbsp;&nbsp;°</td>
						 	</tr>
						 </table>
					</td>
					<td align="left" id="azimuth_tip" width="300px;" style="padding-left: 20px;" onkeyup="value=value.replace(/[^\d\.]/g,'')">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_AOI" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<input id="aoi" class="input_txt" style="width: 40px;" type="text" name="aoi">
						 		</td>
						 		<td width="40px" valign="top"> &nbsp;&nbsp;°</td>
						 	</tr>
						 </table>
					</td>
					<td align="left" id="aoi_tip" width="300px;" style="padding-left: 20px;">
						
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_EDESC" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<textarea id="desc" name="desc" style="height: 100px;width: 250px;border: 1px solid #ccc;"></textarea>
					</td>
					<td align="left" id="desc_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				 -->
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_CO2XS" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="co2xs" type="text" name="co2xs" onkeyup="value=value.replace(/[^\d\.]/g,'')" > <font color="red">*</font>
					</td>
					<td align="left" id="co2xs_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_GAINXS" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="gainxs" type="text" name="gainxs" onkeyup="value=value.replace(/[^\d\.]/g,'')" > <font color="red">*</font>
					</td>
					<td align="left" id="gainxs_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_ADDR" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="addr" type="text" name="addr" > 
					</td>
					<td align="left" id="addr_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_COUNTRY" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="country" type="text" name="country" > 
					</td>
					<td align="left" id="country_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
						<s:text name="RES_CITY" />:
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input class="input_txt" id="city" type="text" name="city" > 
					</td>
					<td align="left" id="city_tip" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
				<tr height="40px;">
					<td align="right">
					
					</td>
					<td align="left"  width="250px" style="padding-left: 20px;">
						<input style="border: 1px solid #ccc;padding: 2px 9px;" id="cnsSubbtn" type="button" name='<s:text name="RES_OK" />' value="OK">
					</td>
					<td align="left" width="300px;" style="padding-left: 20px;">
					
					</td>
				</tr>
			</table>
		</form>
	</div>	
</div>
</s:if>
<s:else>
<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_POWERLIST"/></div>
	<div  class="rightcon">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center" style="margin: 0 auto;">
				<tr height="40px;">
					<td align="right">
						Sorry,You don't create new station permissions.
					</td>
				</tr>
			</table>
	</div>	
</div>
</s:else>
</s:else>