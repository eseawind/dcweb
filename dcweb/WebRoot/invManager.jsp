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
var invM = function(){
	var lastisno="";
	
	function changeSel(){
		var pageNo=$("#pageList>option:selected").val();
		drawmenu.getBody('showStationInv.action?pageNo='+pageNo)	
	}
	function renameInv(isno){
		if(lastisno==""){
			lastisno=isno;
			$("#t_"+isno).html('<input onblur="invM.rename(this)" id="'+isno+'" class="input_txt" type="text" value="'+$("#t_"+isno).html()+'" />');
		}else{
			$("#t_"+lastisno).html($("#t_"+lastisno+">input").val());
			lastisno=isno;
			$("#t_"+isno).html('<input onblur="invM.rename(this)" id="'+isno+'" class="input_txt" type="text" value="'+$("#t_"+isno).html()+'" />');
		}
	}
	function rename(obj){
		$("#t_"+lastisno).html($("#t_"+lastisno+">input").val());
		var isno =$(obj).attr("id");
		var byName = $(obj).val();
		if(byName==""){
			return false;
		}
		var url = "reNamePmu.action";
		var datajson={"isno":isno,"byName":byName};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function(){},
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	return{
		changeSel:function(){changeSel();},
		renameInv:function(isno){renameInv(isno);},
		rename:function(obj){rename(obj);}
	}
}();



</script>
<div class="rightdh">
	<b class="dot_nav"></b><s:text name="RES_CURRENTLOCAL"/>: <a href="javascript:;" onclick="drawmenu.getBody('powerlist.action');return false;"><s:text name="RES_HOME"/></a> > <a href="javascript:;" onclick="return false;"><s:text name="RES_INVMANAGER"/></a>
</div>

<div class="rightcon">
	<div class="rightcon_title"><s:text name="RES_INVMANAGER"/> ( <s:property value="#session.defaultStationMap.stationname" /> ) </div>
	<div  class="rightcon">
		<div style="width: 100%;">
			<s:if test="totalCount>0">
				<table cellpadding="0" cellspacing="0" border="0" align="left">
					<tr>
						<td height="30px" width="30px"></td>
						<td height="30px" colspan="5" align="left"><span class="spantitle"><s:text name="RES_INVLIST" /></span></td>
					</tr>
					<tr>
						<td height="30px" width="30px"></td>
						<td height="30px" width="200px" align="center"><span class="spantitle"><s:text name="RES_INVNAME" /></span></td>
						<td height="30px" width="200px" align="center"><span class="spantitle"><s:text name="RES_INVISNO" /></span></td>
						<td height="30px" width="150px" align="center"><span class="spantitle"><s:text name="RES_INVPMU" /></span></td>
						<td height="30px" width="50px" align="center"><span class="spantitle"><s:text name="RES_INVTYPE" /></span></td>
						<s:if test="#session.userLimits.editInverterLimit==1">
						<td height="30px" width="100px" align="center"><span class="spantitle"><s:text name="RES_INVEDITNAME" /></span></td>
						</s:if>
					</tr>
					<s:iterator id="inv" value="invList" status="invt">
					<tr>
						<td height="30px" width="30px"></td>
						<td height="30px" width="200px" align="center"><span id="t_<s:property value="#inv.isno" />" class="spangraytitle"><s:property value="#inv.byName" /></span></td>
						<td height="30px" width="200px" align="center"><span class="spangraytitle"><s:property value="#inv.isno" /></span></td>
						<td height="30px" width="150px" align="center"><span class="spangraytitle"><s:property value="#inv.psno" /></span></td>
						<td height="30px" width="50px" align="center"><span class="spangraytitle"><s:property value="#inv.invType" /></span></td>
						<s:if test="#session.userLimits.editInverterLimit==1">
						<td height="30px" width="100px" align="center"><a href="javascript:;" title="<s:text name="RES_INVEDITNAME" />" onclick="invM.renameInv('<s:property value="#inv.isno" />')"><img src="images/icon/edit.png" /></a></td>
						</s:if>
					</tr>
					</s:iterator>
					
					<tr>
						<td height="30px" width="30px"></td>
						<td height="30px"  colspan="5">
							<ul id="e_pageul" class="e_pageul" >
								<li class="e_pageli"><a href="javascript:;"  class="e_currentpage"><s:text name="RES_PAGECURRENT" /><s:property value="pageNo"/>/<s:property value="totalPage"/><s:text name="RES_PAGE" /> <s:text name="RES_OVERVIEW_E_TOTAL" /><s:property value="totalPage"/><s:text name="RES_PAGE" /></a></li>
							
								<li class="e_pageli">
								<select id="pageList" onchange="invM.changeSel();">
									<s:iterator value="new int[#request.totalPage]" status="i">
										<s:if test="pageNo==#i.index+1">
											<option selected="selected"><s:property value="#i.index+1"/></option>
										</s:if>
										<s:else>
											<option><s:property value="#i.index+1"/></option>
										</s:else>
									</s:iterator>
								</select>
								</li>
								<!-- 
								<s:if test="pageNo==#i.index+1">
									<li class="e_pageli" style="height: 40px"><a href="javascript:;"  class="e_currentpage"><s:property value="#i.index+1"/></a></li>
								</s:if>
								<s:else>
									<li class="e_pageli" style="height: 40px"><a href="javascript:;"  class="e_page" onclick="drawmenu.getBody('showStationPmu.action?stid=<s:property value="stid" />&pageNo=<s:property value="#i.index+1"/>');return false;"><s:property value="#i.index+1"/></a></li>
								</s:else>
								 -->
							
							</ul> 
						</td>
					</tr>
				  
				</table>
			</s:if>
			<s:else>
				<table>
					<tr>
						<td width="30px"></td>
						<td height="30px" colspan="2" align="left"><span class="spantitle">逆变器列表</span></td>
					</tr>
					<tr>
						<td width="30px"></td>
						<td height="30px" colspan="2" align="left"><span class="spangraytitle">该电站下没有查找到激活的逆变器</span></td>
					</tr>
				</table>
			</s:else>
		</div>
	</div>	
</div>
