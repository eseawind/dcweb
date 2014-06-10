<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="js/pmum.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>

<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="return false;"><s:text name="RES_EQUIPMENTOVERVIEW"/></a>
</div>

<div class="rightcon">
	<div class="rightcon_tcon" style="line-height: 30px;">
		<div class="container">
			<div class="title"><s:text name="RES_EQUIPMENTOVERVIEW"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
		</div>
		<div class="e_showcon" style="border: 0px;background: #fff;margin-top: 10px;">
			<div class="e_selcon" style="margin-top: 10px;margin-left: 0px;">
				<div class="e_title"><s:text name="RES_EQUIPMENTNAME" />:</div>
				<div class="e_sel">
					<input type="text" id="invName" class="input_txt" style="width: 120px;" value="<s:property value='invName'/>" />
				</div>
			</div>
			<div class="e_selcon" style="margin-top: 10px;">
				<div class="e_title"><s:text name="RES_SERIALNUMBER" />:</div>
				<div class="e_sel">
					<input type="text" id="number" class="input_txt" style="width: 120px;" value="<s:property value='pino'/>" />
				</div>
			</div>
			<div class="e_selcon" style="margin-top: 10px;">
				<div class="e_title"><s:text name="RES_EPLANT" />:</div>
				<div class="e_sel">
					<select id="eqsel" style="width:120px;margin-top:5px;">
						<option value="-1">--<s:text name="RES_ALL" />--</option>
						<s:iterator id="item" value="pmuList">
							<s:if test="#item.isPmu==1">
								<option value="<s:property value="#item.PSNO"/>"><s:property value="#item.PSNO"/></option>
							</s:if>
							<s:else>
								<option value="<s:property value="#item.isno"/>">&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#item.byName"/></option>
							</s:else>
						</s:iterator>
					</select>
				</div>
			</div>
			<div class="e_selcon" style="margin-top: 10px;">
				<div class="e_title"><s:text name="RES_DATACOLLECTION" />:</div>
				<div class="e_sel">
					<select id="statesel" style="width:120px;margin-top:5px;">
						<option value="-1">--<s:text name="RES_ALL" />--</option>
						<s:if test="state==1">
							<option value="1" selected="selected"><s:text name="RES_ONLINE" /></option>
						</s:if>
						<s:else>
							<option value="1"><s:text name="RES_ONLINE" /></option>
						</s:else>
						<s:if test="state==1">
							<option value="0" selected="selected"><s:text name="RES_OFFLINE" /></option>
						</s:if>
						<s:else>
							<option value="0"><s:text name="RES_OFFLINE" /></option>
						</s:else>
						
					</select>
				</div>
			</div>
			<div class="clear"></div>
			<div class="e_selcon" style="background: #fff;border: 0px;height:28px;margin-top: 10px;margin-left: 0px;">
				<div onclick="pmum.update();" style="width: 120px;background: url('images/icon/btn_blue_120.gif') no-repeat ;color: #fff;text-align: center;font-weight: bold;height: 28px;line-height:28px;width: 120px;cursor: pointer;" >
					<s:text name="RES_REFRESH" />
				</div>
			</div>
			<s:set id="stid"  name="stid" value="'St_'+#session.defaultStation"/>
			<s:if test="#session.stationLimitsMap[#stid].ADDPMULIMIT==1">
			<div class="e_selcon" style="background: #fff;border: 0px;height:28px;margin-top: 10px;">
				<div onclick="pmum.bindPmu();" style="width: 120px;background: url('images/icon/btn_blue_120.gif') no-repeat ;color: #fff;text-align: center;font-weight: bold;height: 28px;line-height:28px;width: 120px;cursor: pointer;">
					<s:text name="RES_ADDPMU" />
				</div>
			</div>
			</s:if>
		</div>
		<div class="e_showcon" style="border: 0px;background: #fff;margin-top: 0px;">
			<table id="Searchresult" cellpadding="0" cellspacing="0" border="0px" width="100%" style="border: 1px solid #ccc; font-weight: normal;line-height: 24px;color:#666;">
				<tr style="background: url('images/bg_tab.jpg') 0px -198px repeat-x;">
					<td style="text-align: left;text-indent: 10px;width: 30%;"><s:text name="RES_EQUIPMENTNAME" /></td>
					<td style="text-align: left;text-indent: 10px;width: 15%;"><s:text name="RES_SERIALNUMBER" /></td>
					<td style="text-align: left;text-indent: 10px;width: 16%;"><s:text name="RES_PRODUCTCATEGORIES" /></td>
					<td style="width: 15%;"><s:text name="RES_DATACOLLECTION" /></td>
					<td style="width: 8%;"><s:text name="RES_ATTRIBUTE" /></td>
					<td style="width: 8%;"><s:text name="RES_PARAMETER" /></td>
					<td style="width: 8%;"><s:text name="RES_LOG" /></td>
				</tr>
				<s:if test="showPmuList.size()==0">
					<tr id="page_<s:property value='#eqpis.index' />" psno='<s:property value="#eqpi.psno" />'>
						<td colspan="7" style="border-top: 1px solid #ccc;width: 100%; ">No recorde</td>
					</tr>
				</s:if>
				<s:iterator id="eqpi" value="showPmuList" status="eqpis">
					<s:if test="#eqpis.index<20">
						<s:if test="#eqpi.isPmu==1">
							<tr id="page_<s:property value='#eqpis.index' />" psno='<s:property value="#eqpi.psno" />'>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 26%;">
								 	<img src="images/icon/pmu_1.png"/>&nbsp;&nbsp;<s:property value="#eqpi.psno" />
								</td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 15%; "><s:property value="#eqpi.psno" /></td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 20%; "><s:property value="#eqpi.pmutype" />&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 15%; ">
									<s:if test="#eqpi.state==1">
										<img src="images/icon/data_on.png"  />
									</s:if>
									<s:else>
										<img src="images/icon/data_off.png"  />
									</s:else>
								</td>
								<td style="border-top: 1px solid #ccc;width: 8%;"><img src="images/icon/detail.png" style="cursor: pointer;" onclick="pmum.showPmuInfo('<s:property value="#eqpi.psno" />','<s:property value="#eqpi.ip" />','<s:property value="#eqpi.mac" />','<s:property value="#eqpi.softver" />','<s:property value="#eqpi.hardwver" />','<s:property value="#eqpi.usedspace" />','<s:property value="#eqpi.totalspace" />','<s:date  name="#eqpi.lldt" format="yyyy-MM-dd HH:mm:ss" />');" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; ">&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 8%; ">&nbsp;</td>
							</tr>
						</s:if>
						<s:else>
							<tr id="page_<s:property value='#eqpis.index' />" psno='<s:property value="#eqpi.psno" />' isno='<s:property value="#eqpi.isno" />'>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 40px;width: 30%;text-decoration: underline;">
								 	<img src="images/icon/inv_1.png"/>&nbsp;&nbsp;<span id="inv_name_<s:property value="#eqpi.isno" />"><s:property value="#eqpi.byName" /></span><s:if test="#session.stationLimitsMap[#stid].delStationLimit==1"><img src="images/icon/rename.png" title="update inverter name" style="cursor: pointer;" onclick="pmum.updateInvName('<s:property value="#eqpi.isno" />')" /></s:if>
								</td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 15%; "><s:property value="#eqpi.isno" /></td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 16%; "><s:property value="#eqpi.pmutype" />&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 15%; "><img src="images/icon/data_on.png"  /></td>
								<td style="border-top: 1px solid #ccc;width: 8%;"><img src="images/icon/detail.png" style="cursor: pointer;" onclick="pmum.showInvInfo('<s:property value="#eqpi.isno" />','<s:property value="#eqpi.byName" />','<s:property value="#eqpi.factory" />','<s:property value="#eqpi.softver" />','<s:property value="#eqpi.hardwver" />','<s:date  name="#eqpi.ludt" format="yyyy-MM-dd HH:mm:ss" />');" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; "><img src="images/icon/edit.png"  style="cursor: pointer;" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; "><img src="images/icon/log.png"  style="cursor: pointer;"  onclick="pmum.showlog('<s:property value="#eqpi.isno" />')"  /></td>
							</tr>
						</s:else>
					</s:if>
					<s:else>
						<s:if test="#eqpi.isPmu==1">
							<tr style="display: none;" id="page_<s:property value='#eqpis.index' />" psno='<s:property value="#eqpi.psno" />' >
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 26%;">
								 	<img src="images/icon/pmu_1.png"/>&nbsp;&nbsp;<s:property value="#eqpi.psno" />
								</td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 15%; "><s:property value="#eqpi.psno" /></td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 20%; "><s:property value="#eqpi.pmutype" />&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 15%; ">
									<s:if test="#eqpi.state==1">
										<img src="images/icon/data_on.png"  />
									</s:if>
									<s:else>
										<img src="images/icon/data_off.png"  />
									</s:else>
								</td>
								<td style="border-top: 1px solid #ccc;width: 8%;"><img src="images/icon/detail.png" style="cursor: pointer;" onclick="pmum.showPmuInfo('<s:property value="#eqpi.psno" />','<s:property value="#eqpi.ip" />','<s:property value="#eqpi.mac" />','<s:property value="#eqpi.softver" />','<s:property value="#eqpi.hardwver" />','<s:property value="#eqpi.usedspace" />','<s:property value="#eqpi.totalspace" />','<s:property value="#eqpi.lldt" />');" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; ">&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 8%; ">&nbsp;</td>
							</tr>
						</s:if>
						<s:else>
							<tr style="display: none;" id="page_<s:property value='#eqpis.index' />" psno='<s:property value="#eqpi.psno" />' isno='<s:property value="#eqpi.isno" />'>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 40px;width: 30%;text-decoration: underline;">
								 	<img src="images/icon/inv_1.png"/>&nbsp;&nbsp;<span id="inv_name_<s:property value="#eqpi.isno" />"><s:property value="#eqpi.byName" /></span><s:if test="#session.stationLimitsMap[#stid].delStationLimit==1"><img src="images/icon/rename.png" title="update inverter name" style="cursor: pointer;" onclick="pmum.updateInvName('<s:property value="#eqpi.isno" />')"/></s:if>
								</td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 15%; "><s:property value="#eqpi.isno" /></td>
								<td style="border-top: 1px solid #ccc;text-align: left;text-indent: 10px;width: 16%; "><s:property value="#eqpi.pmutype" />&nbsp;</td>
								<td style="border-top: 1px solid #ccc;width: 15%; "><img src="images/icon/data_on.png"  /></td>
								<td style="border-top: 1px solid #ccc;width: 8%;"><img src="images/icon/detail.png" style="cursor: pointer;" onclick="pmum.showInvInfo('<s:property value="#eqpi.isno" />','<s:property value="#eqpi.byName" />','<s:property value="#eqpi.factory" />','<s:property value="#eqpi.softver" />','<s:property value="#eqpi.hardwver" />','<s:date  name="#eqpi.ludt" format="yyyy-MM-dd HH:mm:ss" />');" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; "><img src="images/icon/edit.png" style="cursor: pointer;" /></td>
								<td style="border-top: 1px solid #ccc;width: 8%; "><img src="images/icon/log.png"  style="cursor: pointer;" onclick="pmum.showlog('<s:property value="#eqpi.isno" />')" /></td>
							</tr>
						</s:else>
					</s:else>
				</s:iterator>
			</table>
		</div>
		<div class="e_showcon" style="border: 0px;background: #fff;margin-top: 0px;">
			<div id="Pagination" class="pagination" style="float: right;height: 50px;">
	        </div>
	        <s:if test="showPmuList.size()>20">
		        <script type="text/javascript">
				 var pageSize=20;
				 $("#Pagination").pagination('<s:property value="showPmuList.size()" />', {
				 		items_per_page:pageSize,
						num_edge_entries: 2,
						nnum_display_entries: 4,
						next_text:">",
						prev_text:"<",
				        callback: pageselectCallback1
				 });
				</script>
			</s:if>
		</div>
	</div>
</div>
