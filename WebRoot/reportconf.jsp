<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript" src="datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/reportconf.js"></script>
<script type="text/javascript">

</script>
<s:bean name="com.jstrd.asdc.action.BeanAction" id="utilBean"></s:bean>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="drawmenu.getBody('userconf.action');return false;"><s:text name="RES_CONFIG_REPORT"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon" style="line-height: 30px;">
		<div class="container">
			<div class="title"><s:text name="RES_CONFIG_REPORT"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) <input id="text_userId" type="hidden" value="<s:property value='userMap.userId'/>" /></div>
		</div>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px" style="background: #eee;">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><s:text name="RES_CONFIG_REPORT"/></td>
					<td align="left" width="150px">
						<select id="reportTypeSel" name="reportTypeSel" onchange="reportconf.changeReportType();" >
							<s:if test="reportType==0">
							<option value="0" selected="selected">事件报告</option>
							</s:if>
							<s:else>
							<option value="0" >事件报告</option>
							</s:else>
							<s:if test="reportType==1">
							<option value="1" selected="selected">每日报告</option>
							</s:if>
							<s:else>
							<option value="1" >每日报告</option>
							</s:else>
							<s:if test="reportType==2">
							<option value="2" selected="selected">每月报告</option>
							</s:if>
							<s:else>
							<option value="2" >每月报告</option>
							</s:else>
						</select>
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<s:if test="reportType==0">
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">激活报告</span></td>
					<td align="left" width="150px"><img src="images/icon/delete.png"/></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">收件人电子邮件地址</span></td>
					<td align="left" width="150px">23227273@qq.com</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">事件间隔</span></td>
					<td align="left" width="150px">每小时</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px" rowspan="2" align="top">
					<td width="30px" >&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">内容</span></td>
					<td align="left" width="150px">
						<table>
							<tr>
								<td width="100px"></td>
								<td width="100px">信息</td>
								<td width="100px">错误</td>
							</tr>
							<tr>
								<td width="100px">电站</td>
								<td width="100px"><img src="images/icon/right.png"/></td>
								<td width="100px"><img src="images/icon/right.png"/></td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告发送方式</span></td>
					<td align="left" width="150px">HTML</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">单个报告中的最大消息数</span></td>
					<td align="left" width="150px">100</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"></td>
					<td align="left"><img src="images/icon/delete.png"/></td>
					<td align="left">如果没有可用的新事件，还会发送报告。</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px" style="background: #eee;">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px">重新生成配置报告</td>
					<td align="left" width="150px">
						
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告日期</span></td>
					<td align="left" width="150px">
						<input class="input_txt" type="text"/>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"></td>
					<td align="left" width="150px">
						<input class="input_btn" type="button" value="生成"/>
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr>
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><input class="input_btn" type="button" value="编辑" onclick="reportconf.editReportConf()" /></td>
					<td align="left" width="150px">
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		</s:if>
		<s:elseif test="reportType==1">
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">激活报告</span></td>
					<td align="left" width="150px"><img src="images/icon/delete.png"/></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">收件人电子邮件地址</span></td>
					<td align="left" width="150px">23227273@qq.com,davild.ding@gmail.com</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">发送报告事件</span></td>
					<td align="left" width="150px">每日1点</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px" align="top">
					<td width="30px" >&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">内容</span></td>
					<td align="left" width="150px">
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告发送方式</span></td>
					<td align="left" width="150px">HTML</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">要发送日期</span></td>
					<td align="left" width="150px">2011/02/17</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px" style="background: #eee;">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px">重新生成配置报告</td>
					<td align="left" width="150px">
						
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告日期</span></td>
					<td align="left" width="150px">
						<input class="input_txt" type="text"/>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"></td>
					<td align="left" width="150px">
						<input class="input_btn" type="button" value="生成"/>
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr>
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><input class="input_btn" type="button" value="编辑" onclick="reportconf.editReportConf()"/></td>
					<td align="left" width="150px">
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		</s:elseif>
		<s:elseif test="reportType==2">
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">激活报告</span></td>
					<td align="left" width="150px"><img src="images/icon/delete.png"/></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">收件人电子邮件地址</span></td>
					<td align="left" width="150px">23227273@qq.com,davild.ding@gmail.com,atompark1997@yahoo.com.cn</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">事件间隔</span></td>
					<td align="left" width="150px">发送报告事件：每日1点</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px" align="top" rowspan="4">
					<td width="30px" >&nbsp;</td>
					<td align="left" width="150px" ><span class="spangraytitle">内容</span></td>
					<td align="left" width="150px">
						<table>
							<tr>
								<td>本月平均发电量（KWH）</td>
							</tr>
							<tr>
								<td>本月最大发电量(KW)</td>
							</tr>
							<tr>
								<td>本月收入</td>
							</tr>
							<tr>
								<td>二氧化碳减排量(MT)</td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告发送方式</span></td>
					<td align="left" width="150px">HTML</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">要发送的portal页面</span></td>
					<td align="left" width="150px">2011/02/17</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px" style="background: #eee;">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px">重新生成配置报告</td>
					<td align="left" width="150px">
						
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><span class="spangraytitle">报告日期</span></td>
					<td align="left" width="150px">
						<input class="input_txt" type="text"/>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr height="30px">
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"></td>
					<td align="left" width="150px">
						<input class="input_btn" type="button" value="生成"/>
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		<table id="" border="0" cellpadding="0" cellspacing="0" width="98%" style="float: left;font-weight: normal;line-height: 24px;color:#666;margin-top:15px;">
				<tr>
					<td width="30px">&nbsp;</td>
					<td align="left" width="150px"><input class="input_btn" type="button" value="编辑" onclick="reportconf.editReportConf()"/></td>
					<td align="left" width="150px">
					</td>
					<td>&nbsp;</td>
				</tr>
		</table>
		</s:elseif>
	</div>
</div>