<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<script type="text/javascript">
var Page = function(){
	function showPage(pageNo,totalPage,divid){
		$("#e_subBtn").click(function(){
			    var pageNo = 1;
				var occdt1 = $("#startdate").val();
				var occdt2 = $("#enddate").val();
				var approved = $("#approved>option:selected").val();
				var isno = $("#invsel>option:selected").val();
				var pageSize = $("#pageSize>option:selected").val();
				var e_level =$("#e_level").val();
				var param = "pageNo="+pageNo+"&r="+Math.random()+"&occdt1="+occdt1+"&occdt2="+occdt2+"&approved="+approved+"&isno="+isno+"&pageSize="+pageSize+"&e_level="+e_level;
				var url = "event.action?"+param;
				drawmenu.getBody(url);
		});
		if(totalPage<=1){
			return;
		}
		innerStr = '';
		var prePageNo = parseInt(pageNo)-1;
		var nextPageNo = parseInt(pageNo)+1;
		if(totalPage>1){
			innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+(prePageNo>0?prePageNo:1)+' class="e_page">&lt;</a></li>';
		}
		if(totalPage<10){
			for(var i=1;i<=totalPage;i++){
				if(i!=pageNo){
					innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_page">'+i+'</a></li> ';
				}else{
					innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_currentpage">'+i+'</a></li>';
				}
				
			} 
		}else{
			if(pageNo<=4){
				for(var i=1;i<=4;i++){
					if(i!=pageNo){
						innerStr = innerStr +  '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_page">'+i+'</a></li> ';
					}else{
						innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_currentpage">'+i+'</a></li>';
					}
				}
				innerStr = innerStr + '<li class="e_pageli"><a href="#" class="e_pagedot">...</a></li>';
				innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+totalPage+' class="e_page">'+totalPage+'</a></li>';
			}else if((parseInt(pageNo)+3)>=totalPage){
				innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo="1" class="e_page">1</a></li>';
				innerStr = innerStr + '<li class="e_pageli"><a href="#" class="e_pagedot">...</a></li>';
				for(var i=totalPage-3;i<=totalPage;i++){
					if(i!=pageNo){
						innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_page">'+i+'</a></li>';
					}else{
						innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_currentpage">'+i+'</a></li>';
					}
				}
			}else{
				innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo="1"  class="e_page">1</a></li>';
				innerStr = innerStr + '<li class="e_pageli"><a href="#" class="e_pagedot">...</a></li>';
				for(var i=(parseInt(pageNo)-2);i<=(parseInt(pageNo)+2);i++){
					if(i!=pageNo){
						innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_page">'+i+'</a></li>';
					}else{
						innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+i+' class="e_currentpage">'+i+'</a></li>';
					}
				}
				innerStr = innerStr + '<li class="e_pageli"><a href="#" class="e_pagedot">...</a></li>';
				innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+totalPage+' class="e_page">'+totalPage+'</a></li>';
			}
		}
		if(totalPage>1){
		innerStr = innerStr + '<li class="e_pageli"><a href="#" pageNo='+(nextPageNo<totalPage?nextPageNo:totalPage)+' class="e_page">&gt;</a></li>';
		}
		innerStr= innerStr+"</ul>";
		$("#"+divid).html(
			innerStr
		);
		$(".e_page").each(function(){
			$(this).mouseover(function(){
				$(this).css("background","#369eda");
			});
			$(this).mouseout(function(){
				$(this).css("background","#fff");
			});
			$(this).click(function(){
				var pageNo = $(this).attr("pageNo");
				var occdt1 = $("#startdate").val();
				var occdt2 = $("#enddate").val();
				var approved = $("#approved>option:selected").val();
				var isno = $("#invsel>option:selected").val();
				var pageSize = $("#pageSize>option:selected").val();
				var e_level =$("#e_level").val();
				var param = "pageNo="+pageNo+"&r="+Math.random()+"&occdt1="+occdt1+"&occdt2="+occdt2+"&approved="+approved+"&isno="+isno+"&pageSize="+pageSize+"&e_level="+e_level;
				var url = "event.action?"+param;
				drawmenu.getBody(url);
			});
		});
	}
	return{
		init:function(pageNo,totalPage,divid){showPage(pageNo,totalPage,divid);}
	}
}();
var eventpage = function(){
	function csvdownload(){
		var t =$("#t").val();
		var url = "csvdownload.action?t="+t;
		window.location.href= url;
	}
	function txtdownload(){
		var t =$("#t").val();
		var url = "txtdownload.action?t="+t;
		window.location.href= url;
	}
	return{
		csvdownload:function(){csvdownload();},
		txtdownload:function(){txtdownload();}
	}
}();
function delEvent(obj){
	var url = $(obj).attr("linked");
	$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            //data: datajson,
	            success: responseDelEvent,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	});
}
function responseDelEvent(data, textStatus, jqXHR){
	if(data.status == 'ok'){
			    var pageNo = $("#currentPage").val();
				var occdt1 = $("#startdate").val();
				var occdt2 = $("#enddate").val();
				var approved = $("#approved>option:selected").val();
				var isno = $("#invsel>option:selected").val();
				var pageSize = $("#pageSize>option:selected").val();
				var e_level =$("#e_level").val();
				var param = "pageNo="+pageNo+"&r="+Math.random()+"&occdt1="+occdt1+"&occdt2="+occdt2+"&approved="+approved+"&isno="+isno+"&pageSize="+pageSize+"&e_level="+e_level;
				var url = "event.action?"+param;
				drawmenu.getBody(url);
	}else{
		alert(RES.EVENTDELERROR);
	}
}
function changeElevel(){
	var e_level = $(".e_level:checked");
	var tstr = ""
	for(var i=0;i<e_level.length;i++){
		if(i==(e_level.length-1)){
			tstr= tstr+$(e_level[i]).val();
		}else{
			tstr= tstr+$(e_level[i]).val()+",";
		}
	}
	if(tstr==""){
		tstr="0";
	}
	$("#e_level").val(tstr);
}
</script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="#"><s:text name="RES_EVENT"/></a>
</div>
<div class="rightcon">
	<div class="rightcon_tcon">
		<div class="container">
			<div class="title"><s:text name="RES_EVENT"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
			<div class="dot_con">
				<div class="_link">
					<input id="t" type="hidden" value="event" />
					<div class="dot_csv" style="margin-top: 24px;"></div>
					<div style="float: left;" onclick="eventpage.csvdownload();"><span class="spantitle">CSV</span></div>
				</div>
				<div class="_link">
					<div class="dot_text" style="margin-top: 24px;"></div>
					<div style="float: left;" onclick="eventpage.txtdownload();"><span class="spantitle"><s:text name="RES_TEXT" /></span></div>
				</div>
				<div class="_link">
					<div class="dot_print" style="margin-top: 24px;"></div>
					<div style="float: left;" onclick="window.print();"><span class="spantitle"><s:text name="RES_PRINT" /></span></div>
				</div>
			</div>
		</div>
		<div class="e_showcon">
			<div class="e_selcon" >
				<div class="e_title"><s:text name="RES_CHOOSEDATE" />:</div>
				<div class="e_sel">
					<div style="float: left;margin-top: 3px;"><input id="startdate" class="Wdate" type="text" name="occdt1" value="<s:property value='occdt1'/>" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'enddate\')||\'2050-01-01\'}',lang:'<%= lang %>'})"/></div>
					<div style="float: left;margin-left:5px;">-</div>
					<div style="float: left;margin-top: 3px;"><input id="enddate" class="Wdate" type="text" name="occdt2" value="<s:property value='occdt2'/>" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startdate\')}',maxDate:'2050-01-01',lang:'<%= lang %>'})"/></div>
				</div>
			</div>
			<div class="e_selcon">
				<div class="e_title"><s:text name="RES_ESTATUS" />:</div>
				<div class="e_sel">
					<select id="approved" name="approved" style="margin-top:5px;">
						<option value="0">--<s:text name="RES_ECHOOSESTATUS" />--</option>
						<s:if test="approved==-1">
							<option selected="selected" value="-1">Not approved</option>
						</s:if>
						<s:else>
							<option value="-1" >Not approved</option>
						</s:else>
						<s:if test="approved==1">
							<option selected="selected" value="1">approved</option>
						</s:if>
						<s:else>
							<option value="1">approved</option>
						</s:else>
					</select>
				</div>
			</div>
			<div class="e_selcon">
				<div class="e_title"><s:text name="RES_EPLANT" />:</div>
				<div class="e_sel">
					<select id="invsel" name="invsel" style="margin-top:5px;">
						<s:if test="isno=='-1'">
							<option selected="selected" value="-1">--<s:text name="RES_ECHOOSESTATUS" />--</option>
						</s:if>
						<s:else>
							<option value="-1">--<s:text name="RES_ECHOOSESTATUS" />--</option>
						</s:else>
						<s:set id="isnoStr" name="isnoStr" value="isno"/>
						<s:iterator id="inv" value="invMap" status="invt">
								<s:if test="#isnoStr==#inv.isno">
									<option selected="selected" value='<s:property value="#inv.isno" />'><s:property value="#inv.byName" /></option>
								</s:if>
								<s:else>
									<option value='<s:property value="#inv.isno" />'><s:property value="#inv.byName" /></option>
								</s:else>
						</s:iterator>
					</select>
				</div>
			</div>
			<div class="e_selcon">
				<div class="e_title"><s:text name="RES_PAGESIZE" />:</div>
				<div  class="e_sel">
					<select id="pageSize" name="pageSize" style="margin-top:5px;width:100px;">
						<s:if test="pageSize==20">
							<option value="20" selected="selected">20</option>
						</s:if>
						<s:else>
							<option value="20">20</option>
						</s:else>
						<s:if test="pageSize==30">
							<option value="30" selected="selected">30</option>
						</s:if>
						<s:else>
							<option value="30">30</option>
						</s:else>
						<s:if test="pageSize==40">
							<option value="40" selected="selected">40</option>
						</s:if>
						<s:else>
							<option value="40">40</option>
						</s:else>
						<s:if test="pageSize==50">
							<option value="50" selected="selected">50</option>
						</s:if>
						<s:else>
							<option value="50">50</option>
						</s:else>
					</select>
				</div>
			</div>
			<div class="e_selcon">
				<div class="e_title"><s:text name="RES_ETYPE" />:</div>
				<div class="e_sel">
					<input id="e_level" type="hidden" value="<s:property value='e_level'/>" />
					<s:set id="stid"  name="stid" value="'St_'+#session.defaultStation"/>
					<s:if test="#session.user.roleId<3">
						<s:if test="e_level.indexOf('1')>=0">
							<input class="e_level" type="checkbox" checked="checked" value="1" onclick="changeElevel()">Info 
						</s:if>
						<s:else>
							<input class="e_level" type="checkbox" value="1" onclick="changeElevel()">Info
						</s:else>
						<s:if test="e_level.indexOf('3')>=0">
							<input class="e_level" type="checkbox" checked="checked" value="3" onclick="changeElevel()">Error
						</s:if>
						<s:else>
							<input class="e_level" type="checkbox" value="3" onclick="changeElevel()">Error
						</s:else>
					</s:if>
					<s:else>
						<s:if test="e_level.indexOf('1')>=0">
							<input class="e_level" type="checkbox" checked="checked" value="1" onclick="changeElevel()">Info 
						</s:if>
						<s:else>
							<input class="e_level" type="checkbox" value="1" onclick="changeElevel()">Info
						</s:else>
						<s:if test="e_level.indexOf('2')>=0">
							<input class="e_level" type="checkbox" checked="checked" value="2" onclick="changeElevel()">Warning 
						</s:if>
						<s:else>
							<input class="e_level" type="checkbox" value="2" onclick="changeElevel()">Warning 
						</s:else>
						<s:if test="e_level.indexOf('3')>=0">
							<input class="e_level" type="checkbox" checked="checked" value="3" onclick="changeElevel()">Error
						</s:if>
						<s:else>
							<input class="e_level" type="checkbox" value="3" onclick="changeElevel()">Error
						</s:else>
					</s:else>
				</div>
			</div>
			
			<div style="float: left;margin-left: 20px;margin-top: 15px;">
				<div id="e_subBtn" class="btn2" style="float: left;" >
							<div class="btn2_l"></div>
							<div class="btn2_c" style="color:#666;"><s:text name="RES_QUERY" /><input id="currentPage" type="hidden" value="<s:property value='pageNo'/>"/></div>
							<div class="btn2_r"></div>
				</div>
			</div>
		</div>
		
		<div id="showscreen" class="e_showcon" style="background: #fff;border:0px;">
		
			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #ccc;border-bottom:0px; font-weight: normal;line-height: 24px;color:#666;">
				<tr style="background: url('images/bg_tab.jpg') 0px -198px repeat-x;">
					<td height="30px"><s:text name="RES_EPLANT" /></td>
					<td height="30px"><s:text name="RES_ETIME" /></td>
					<td height="30px"><s:text name="RES_ETYPE" /></td>
					<td height="30px"><s:text name="RES_EDESC" /></td>
					<s:if test="#session.stationLimitsMap[#stid].SETREPORTLIMIT==1">
						<td height="30px"><s:text name="RES_CONFIRM" /></td>
					</s:if>
				</tr>
				<s:if test="totalPage==0">
					<tr height="24px" >
						<td colspan="5" style="border-bottom: 1px solid #ccc;"><s:text name="RES_NORECORED" /></td>
					</tr>
				</s:if>
				<s:iterator id="event" value="eventMap" status="em">
					<s:if test="#em.odd">
						<tr height="24px">
					</s:if>
					<s:else>
						<tr height="24px" style="background: #eee;">
					</s:else>
						<td height="30px" style="border-bottom: 1px solid #ccc;"><s:property value="#event.byName"/></td>
						<td height="30px" style="border-bottom: 1px solid #ccc;"><s:date name="#event.occdt" format="yyyy/MM/dd HH:mm:ss"/></td>
						<td height="30px" style="border-bottom: 1px solid #ccc;">
							<s:if test="#event.e_level==1">
								Info
							</s:if>
							<s:if test="#event.e_level==2">
								Waring
							</s:if>
							<s:if test="#event.e_level==3">
								Error
							</s:if>
						</td>
						<td height="30px" style="border-bottom: 1px solid #ccc;">
							<s:if test="#event.code==null||#event.code==0">&nbsp;</s:if>
							<s:else><s:property value="#event.context"/></s:else>
						</td>
						<s:if test="#session.stationLimitsMap[#stid].SETREPORTLIMIT==1">
						<td height="30px" style="border-bottom: 1px solid #ccc;">
							<s:if test="#event.approved==0">
								<a style="color: #444;" href="javascript:;" onclick="delEvent(this);return false;" linked="delEvent.action?edid=<s:property value="#event.edid"/>"><img title="Not approved" src='images/icon/delete.png' /></a>
							</s:if>
							<s:elseif test="#event.approved==-1">
								<a style="color: #444;" href="javascript:;" onclick="delEvent(this);return false;" linked="delEvent.action?edid=<s:property value="#event.edid"/>"><img title="Not approved" src='images/icon/delete.png' /></a>
							</s:elseif>
							<s:elseif test="#event.approved==1">
								<a style="color: #444;" href="javascript:;" onclick="delEvent(this);return false;" linked="delEvent.action?edid=<s:property value="#event.edid"/>"><img title="approved" src='images/icon/right.png' /></a>
							</s:elseif>
						</td>
						</s:if>
					</tr>
				</s:iterator>
				
				
			</table>
		</div>
		<div id="pageCon" class="e_pageCon" >
			<ul id="e_pageul" class="e_pageul">
				<script type="text/javascript">
					Page.init('<s:property value="pageNo"/>','<s:property value="totalPage"/>','e_pageul');
				</script>
			</ul>
		</div>
	</div>
</div>