<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.jstrd.asdc.util.ColorUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
	Map<String,Map> allInvMap = (Map<String,Map>)session.getAttribute("allInvMap");//所有的
	List<Map> allInvList = new ArrayList<Map>();
	Iterator it = allInvMap.entrySet().iterator();
	while (it.hasNext()){
		Map.Entry pairs = (Map.Entry)it.next();
		allInvList.add((Map) pairs.getValue());
	}
%>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<script type="text/javascript" src="js/chart.js"></script>
<script type="text/javascript">
	DCPOWER.init('<%= JSONArray.fromObject(allInvList).toString() %>',"acc",'<%= request.getAttribute("type").toString() %>','<%= request.getAttribute("sdate").toString() %>');
</script>

<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_ACC"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_ACC"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
			<div class="dot_con">
				<input id="t" type="hidden" value="acc" />
				<input id="ct" type="hidden" value='<s:property value="type" />' />
				<div class="_link" onclick="download.cvsdownload();">
					<div class="dot_csv" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle">CSV</span></div>
				</div>
				<div class="_link" onclick="download.txtdownload();">
					<div class="dot_text" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle"><s:text name="RES_TEXT" /></span></div>
				</div>
				<div class="_link"  onclick="download.printCharts();">
					<div class="dot_print" style="margin-top: 24px;"></div>
					<div style="float: left;"><span class="spantitle"><s:text name="RES_PRINT" /></span></div>
				</div>
			</div>
		</div>
		<div class="e_bluecon">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="float: left;">
				<tr>
					<td align="right" style="padding-right: 10px;width: 100px;"><s:text name="RES_CHOSSINVERTER" /> :</td>
					<td align="left" style="padding-left:10px;">
						<%  
							String editInvLimitStr = ((Map)session.getAttribute("stationLimits")).get("EDITINVERTERLIMIT").toString();
							int editInvLimit = Integer.parseInt(editInvLimitStr);
							int flag=0;
							for(int i=0;i<allInvList.size();i++){
								String channels = allInvList.get(i).get("channels")==null?"":allInvList.get(i).get("channels").toString();
								if(channels!=null && !("").equals(channels.trim())){
									flag=1;
									String[] channelsArr = channels.split("\\^");
									for(int j=0;j<channelsArr.length;j++){
						%>
									<div class="invbtncon">
										<div class="invbtn_l"></div>
										<div class="invbtn_c">
											<div class="invbtn_ctxt"><%= allInvList.get(i).get("byName")+"_"+channelsArr[j] %></div>
											<% 
												if(editInvLimit==1){
											%>
											<div class="invbtn_cclose" onclick="DCPOWER.deleteChannel('<%= allInvList.get(i).get("isno").toString() %>','<%= channelsArr[j] %>')"></div>
											<%
												}
											 %>
										</div>
										<div class="invbtn_r"></div>
									</div>
								
						<%
									}
								}
							}
							if(flag==0){  
								if(editInvLimit==1){
						%>
							<input type="text" style="cursor: pointer;" class="input_choose" readonly  onclick="DCPOWER.confShowInv();"/>
						<% 		}else{ %>
							<input type="text" style="cursor: pointer;" class="input_choose" readonly  />
						<%  	
								}
							}else{ 
								if(editInvLimit==1){
						%>
							<div style=" float:left;line-height: 23px;margin-left: 10px;cursor: pointer;font-weight: bold;text-decoration: underline;color: #1781c5;margin-top: 10px; " onclick="DCPOWER.confShowInv();"><s:text name="RES_MOD" /></div>
						<%  
								}
							} 
						%>
					</td>
				</tr>
				<tr>
					<td align="right" style="padding-right: 10px;width: 100px;"><s:text name="RES_CHOOSEDATE" />:</td>
					<td align="left" style="padding-left:10px;">
					<%
						String sdate = request.getAttribute("sdate").toString();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String backDay = sdf.format(sdf.parse(sdate).getTime()-1000*60*60*24);
						String goDay=sdf.format(sdf.parse(sdate).getTime()+1000*60*60*24);
					 %>
						<div class="backbtn" onclick="DCPOWER.refreshSwf('<%= backDay %>');"></div>
						<div style="float:left;margin-top: 8px;"><input id="sdate" style="line-height: 20px;text-indent: 0px;"  class="Wdate" type="text" style="cursor: pointer;" readonly="readonly" value='<s:property value="sdate"/>'  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',lang:'<%= lang %>',startDate:'<s:property value="sdate"/>'})" /></div>
						<div class="gobtn" onclick="DCPOWER.refreshSwf('<%= goDay %>');"></div>
					</td>
				</tr>
				<tr height="40px;">
					<td align="right" style="padding-right: 10px;width: 100px;"></td>
					<td align="left" style="padding-left:10px;">
						<div class="btn2" style="float: left;margin-left:10px;"  onclick="DCPOWER.refreshSwf();">
							<div class="btn2_l"></div>
							<div class="btn2_c" style="color:#666;"><s:text name="RES_QUERY" /></div>
							<div class="btn2_r"></div>
						</div>
					</td>
					
				</tr>
			</table>
		</div>	
		<div class="p_rtb" style="float: left;">
			<div class="p_rttab" style="left: 10px;">
					<div class="tab" linked='acc.action?type=day&sdate=<s:property value="sdate"/>'>
						<s:if test="type=='day'">
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_DAILY"/></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_DAILY"/></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
					<div class="tab" style="margin-left: 10px;" linked='acc.action?type=week&sdate=<s:property value="sdate"/>'>
						<s:if test="type=='week'" >
							<div class="tableft_on"></div>
							<div class="tabcenter_on"><s:text name="RES_WEEKLY"/></div>
							<div class="tabright_on"></div>
						</s:if>
						<s:else>
							<div class="tableft_off"></div>
							<div class="tabcenter_off"><s:text name="RES_WEEKLY"/></div>
							<div class="tabright_off"></div>
						</s:else>
					</div>
			</div>
		</div>
		<div class="e_bluecon" style="height: auto;">
			<s:if test="type=='day'" >
			<div style="width: 90%;height: 700px;margin: 0 auto;padding-top: 20px;">
				<div id="flashCont">
						 <script type="text/javascript">
							 	var flashvars = {"lang":"<%= lang %>","isno":"<s:property  value='isno'/>","baseUrl":"<%= baseUrl %>","type":"day","date":"<s:property  value='sdate'/>"}
							 	showFlashElement("swf/ACCDaily.swf",flashvars);
						 </script>
				</div>
			</div>
			</s:if>
			<s:elseif test="type=='week'">
			<div style="width: 90%;height: 700px;margin: 0 auto;padding-top: 20px;">
				<div id="flashCont">
						 <script type="text/javascript">
							 	var flashvars = {"lang":"<%= lang %>","isno":"<s:property  value='isno'/>","baseUrl":"<%= baseUrl %>","type":"day","date":"<s:property  value='sdate'/>"}
							 	showFlashElement("swf/ACCWeekly.swf",flashvars);
						 </script>
				</div>
			</div>
			</s:elseif>
			<div style="width: 90%;margin: 0 auto;">
				<table id="Searchresult" cellpadding="0" cellspacing="0" border="0"  style="border-top: 1px solid #ccc;border-left: 1px solid #ccc;border-right: 1px solid #ccc;border-bottom: 1px solid #ccc;margin-top:20px;line-height:30px;width: 100%;">
					<tr style="background: url('images/bg_tab.jpg') 0px -197px repeat-x;height: 30px;line-height: 30px;">
						<td><s:text name="RES_INVNAME" /></td><td><s:text name="RES_INVISNO" /></td><td><s:text name="RES_CHANNEL" /></td><td><s:text name="RES_MAX" /></td><td><s:text name="RES_MIN" /></td><td><s:text name="RES_AVG" /></td>
					</tr>
					<%
						//Map accDaySelInvMap = (Map)session.getAttribute("dcpDaySelInvMap");
						List infoList =  (List)session.getAttribute("infoList");
						if(infoList.size()==0){
					%>
						<td colspan="5">No data</td>
					<%	
						}
						int pageSize = 10;
						for(int i=0;i<infoList.size();i++){
							Map info  = (Map)infoList.get(i);
							StringBuffer sb  = new StringBuffer();
							sb.append(" <tr id='page_"+i+"' style='");
							if(i%2!=0){
								sb.append("background: #eee;");
							}
							if(i>=pageSize){
								sb.append("display:none;");
							}
							sb.append("'>");
							out.print(sb.toString());
					 %>
						<td ><%= allInvMap.get(info.get("isno")).get("byName") %></td>
						<td ><%= info.get("isno") %></td>
						<td ><%= info.get("channel") %></td>
						<td ><%= info.get("max") %></td>
						<td ><%= info.get("min") %></td>
						<td ><%= info.get("avg")  %></td>
					</tr>
					<%} %>
					
				</table> 
				<div style="width: 100%;margin-top: 20px;">
					<div id="Pagination" class="pagination" style="float: right;height: 50px;">
	        		</div>
        		</div>
        		<% if(pageSize<infoList.size()){ %>
				<script type="text/javascript">
				var pageSize=10;
				 $("#Pagination").pagination('<%= infoList.size()%>', {
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
    					$("#Searchresult tr").css("display","none");
    					$($("#Searchresult tr")[0]).css("display","");
    					for(var i=startid;i<=endid;i++){
    						$("#page_"+i).css("display","");
    					}
                 }
				</script>
				<%} %>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>