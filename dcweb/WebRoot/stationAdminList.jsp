<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<link rel="stylesheet" href="./skins/blue.css" />
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/inner.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/confAdminStation.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/iphoto_flash.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/swfobject.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<script type="text/javascript" src="./js/artDialog.min.js"></script>
  	<script type="text/javascript">
	  	<s:if test="#session.userMenu.station==0">
	    	location.href="index.action";
	    </s:if>
  		$(document).ready(function() {
			confAdminStation.init();
			
		});
		document.onkeydown = function(e) {   
	    	var theEvent = e || window.event;   
	    	var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
	    	if(code == 13){   
	       		var ipg=$('#inputpage').val();
	       		if(ipg == ""){
	       			alert(RES.NEED_NUMBER)
	       			return false;
	       		}
	       		if(!isNaN(ipg)){
	       			$('#pageNo').val(ipg+'');
		       		if(parseInt(ipg)>parseInt($('#allPage').val())){
		       			alert(RES.INPUT_TOOLARGE)
		       			return false;
		       		}
	       		}else{
	       			$('#pageNo').val('1');
	       		}
	        	$("#searchForm").submit();	
	    	}   
	    	return true;
    	}
	</script>
	<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		
		-->
	</style>
	<style type="text/css">
		<!--
		.STYLE1 {
			color: #FFFFFF;
			font-weight: bold;
			font-size: 18px
		}
		.STYLE3 {
			color: #CCCCCC; 
			font-weight: bold; 
			font-size: 16px
		}
		.button2 {
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffffff;
			background-image: url("images/buttom_bg4.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			width:63px;
		}
		-->
	</style>
	<script>
	 	function changeCountry(cid){
			hiddenFrame.location.href="stateList.action?countryId="+cid;
		}

		function plantDayStatistics(){
			var sDate=$('#startDate').val();
			var eDate=$('#endDate').val();
			if(sDate == ""){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:"请输入统计日期",
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
				return false;
			}
			if(sDate>eDate){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:"开始时间不能大于结束时间",
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
				return false;
			}
			//if(confirm("")){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:"您确定要重算日数据吗？",
				ok:function(){
					var url = "plantManagerDaily.action";
					var datajson = {"startDate":sDate, "endDate":eDate};
					$.ajax({
				            type: "POST",
				            url: url,
				            dataType: "json",
				            data: datajson,
				            success: function(){
								art.dialog({
									width:300,
									height:50,
									title:"Solarcloud Message",
									content:"日数据统计成功",
									ok:function(){},
									okValue:RES.CONF_ART_OK
								});
			            	},
				            error: function () {
			            		art.dialog({
									width:300,
									height:50,
									title:"Solarcloud Message",
									content:RES.REQUESTWRONG,
									ok:function(){},
									okValue:RES.CONF_ART_OK
								});
				            }
				    });
					
				},
				okValue:RES.CONF_ART_OK,
				cancelValue:RES.CONF_ART_CANCEL,
				cancel:true
			});
			
		}
	</script>
</head>
<body >
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
      	<td colspan="2"><%@include file="HeadMenu.jsp" %></td>
        <script>
        	menuOver('adminMenu',19);
        </script>
  	</tr>
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table border="0" cellspacing="18" cellpadding="0">
      			<form action="" method="post" id="searchForm" name="searchForm">
    			<input type="hidden" name="pageNo" id="pageNo" value="<s:property value="pageNo" />"/>
    			<input type="hidden" name="totalPage" id="totalPage" value="<s:property value="totalPage" />"/>
      			<tr>
        			<td width="896" height="64" align="center" background="images/list_bg3.gif">
        				<table width="98%" border="0" cellspacing="0" cellpadding="0">
          					<tr style="height: 30px;">		
            					<td width="15%" align="right" class="black4"><s:text name="RES_COUNTRY"/></td>
            					<td width="15%" align="center">
            						<select name="countryId" id="countryId" class="test_input7" >
                						<option value="0">All</option>
                						<s:set name="cou" value="countryId" />
                 						<s:iterator id="country" status="ss" value="countryList">
	                 						<s:if test='#cou==#country.c_code'>
			         							<option value="<s:property value="#country.c_code" />" selected="selected"><s:property value="countryname" /></option>
		     		 						</s:if>
		     		 						<s:else>
		     		 							<option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
		     		 						</s:else>
	     								</s:iterator>
                  					</select>
                  				</td>
            					<td width="15%" align="right" class="black4"><s:text name="RES_STATE"/></td>
            					<td width="15%" align="center">
            						<select name="state" id="state" class="test_input7" >
              							<option value="0">All</option>
            							<s:set name="sst" value="state" />
                 						<s:iterator id="st" status="ss" value="stateList">
	                 						<s:if test='#sst==#st.c_code'>
			         							<option value="<s:property value="#st.c_code" />" selected="selected"><s:property value="countryname" /></option>
		     		 						</s:if>
		     		 						<s:else>
		     		 							<option value="<s:property value="#st.c_code" />"><s:property value="countryname" /></option>
		     		 						</s:else>
	     								</s:iterator>
                					</select>
                				</td>
                				<td width="15%" align="right" class="black4"><s:text name="RES_TRACK"/></td>
                				<td width="15%" align="center">
	                				<select name="status" id="status" class="test_input7">
					                	<option value="-1">All</option>
					                 	<s:if test='status==0'>
							         	<option value="0" selected="selected">未关注</option>
							         	<option value="1" >已关注</option>
						     		 	</s:if>
						     		 	<s:elseif test='status==1'>
							         	<option value="0" >未关注</option>
							         	<option value="1" selected="selected">已关注</option>
						     		 	</s:elseif>
						     		 	<s:else>
							         	<option value="0" >未关注</option>
							         	<option value="1">已关注</option>
						     		 	</s:else>
					                </select>
                				</td>
                				<td width="10%"></td>
          					</tr>
          					<tr style="height: 30px;">
          						<td width="15%" align="right" class="black4"><s:text name="RES_STATIONNAME"/></td>
            					<td width="15%" align="center"><input name="stationName" type="text" class="test_input7" id="stationName" value="<s:property value="stationName" />"/></td>
            					<td width="15%" align="right" class="black4"><s:text name="RES_CAACCOUNT"/></td>
            					<td width="15%" align="center"><input name="account" type="text" class="test_input7" id="account" value="<s:property value="account" />"/></td>
            					<td width="15%"></td>
            					<td width="15%"></td>
            					<td width="10%" align="center"><input type="button" value="<s:text name="RES_QUERY"/>" class="button2" id="searchImg" style="cursor:pointer"/></td>
            					
          					</tr>
						</table>
					</td>
      			</tr>
      			<tr>
	        		<td height="121" align="center">
	        			<table width="896" border="0" cellspacing="0" cellpadding="0">
	          				<tr>
	            				<td height="34" align="center" background="images/list_bg4.gif">
	            					<table width="894" border="0" cellspacing="0" cellpadding="0">
	              						<tr>
	                						<td width="39" height="30" align="center">&nbsp;</td>
	                						<td width="130" align="left" class="black"><s:text name="RES_STATIONNAME"/></td>
	                						<td width="85" align="left" class="black"><s:text name="RES_COUNTRY"/></td>
	                						<td width="85" align="left" class="black"><s:text name="RES_STATE"/></td>
	                						<td width="90" align="left" class="black"><s:text name="RES_CITY"/></td>
	                						<td width="90" align="left" class="black"><s:text name="RES_ADUITEDATE"/></td>
	                						<td width="110" align="center" class="black"><s:text name="RES_INSTALLCAP"/></td>
	                						<td width="111" align="left" class="black"><s:text name="RES_LASTUPDATEDATE"/></td>
	                						<td width="154" align="left" class="black"><s:text name="RES_CAACCOUNT"/></td>
	              						</tr>
	            					</table>
	            				</td>
	          				</tr>
	          				<tr>
	            				<td align="center" background="images/list_bg6.gif">
	            					<table width="894" border="0" cellspacing="0" cellpadding="0">
	              						<s:iterator id="st" value="stationList" status="em">
										<s:if test="#em.odd">
										<tr>
										</s:if>
										<s:else>
										<tr bgcolor="#B5D5EA">
										</s:else>
	                						<td width="39" height="36" align="center">
	                						<s:if test="#st.isselect==0">
					                        	<img src="images/unattention.gif" title="点击关注此电站" style="cursor:pointer" onclick="Attention('<s:property value="#st.stationid" />',this)"/>
					                        </s:if>
					                        <s:elseif test="#st.isselect==1">
					                            <img src="images/attention.gif" title="点击取消关注此电站" style="cursor:pointer" onclick="unAttention('<s:property value="#st.stationid" />',this)"/>
					                        </s:elseif>
	                						</td>
	                						<td width="134" align="left" class="black2" onclick="location.href='overview.action?stationid=<s:property value="#st.stationid" />'" style="cursor:pointer"><s:property value="#st.stationname" /></td>
	                						<td width="94" align="left" class="black2"><s:property value="#st.country" /></td>
	                						<td width="94" align="left" class="black2"><s:property value="#st.province" /></td>
	                						<td width="94" align="left" class="black2"><s:property value="#st.city" /></td>
	                						<td width="100" align="left" class="black2"><s:property value="#st.createdt" /></td>
	                						<td width="100" align="center" class="black2"><s:property value="#st.totalpower" /></td>
	                						<td width="101" align="left" class="black2"><s:property value="#st.ludt" /></td>
	                						<td width="138" align="left" class="black2"><s:property value="#st.account" /></td>
	              						</tr>
	             						</s:iterator> 
	            					</table>
	            				</td>
	          				</tr>
	          				<tr>
	            				<td height="34" align="right" background="images/list_bg5.gif">
	            					<table width="20%" border="0" cellspacing="0" cellpadding="0">
	              						<tr>
	                						<td align="center"><img src="images/dz_list8.gif" width="17" height="19" id="firstP" style="cursor:pointer" /></td>
	                        				<td align="center"><img src="images/dz_list10.gif" width="19" height="19" id="preP" style="cursor:pointer" /></td>
	                        				<td align="center"><input name="inputpage" type="text" class="test_input4" id="inputpage" value="<s:property value="pageNo" />/<s:property value="totalPage" />" size="6" /></td>
	                        				<td align="center"><img src="images/dz_list11.gif" width="19" height="19" id="nextP" style="cursor:pointer" /></td>
	                        				<td align="center"><img src="images/dz_list9.gif" width="17" height="19" id="lastP" style="cursor:pointer" /></td>
	                        				<td>&nbsp;</td>
	              						</tr>
	            					</table>
	            				</td>
	          				</tr>
	        			</table>
	        		</td>
      			</tr>
      			</form>
      			<!-- 2014-03-20新增日统计 -->
      			<tr>
        			<td width="896" height="64" align="center" style="background: url('images/list_bg3.gif');">
        				
        				<table width="98%" border="0" cellspacing="0" cellpadding="0">
          					<tr style="height: 30px;">
          						<td width="15%" align="right" class="black4"><s:text name="RES_EPICKDATE"/></td>
            					<td width="30%" align="center">
            						<input type="text" id="startDate" name="startDate" value="<s:property value="startDate" />" class="Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\',{d:-7});}',lang:'zh_CN',maxDate:'#F{$dp.$D(\'endDate\')}'})" size="13"/>-
            						<input type="text" id="endDate" name="endDate" value="<s:property value="endDate" />" class="Wdate" onfocus="WdatePicker({maxDate:'%y-%M-{%d-1}'})" size="13"/>
            					</td>
            					<td width="15%" align="right" class="black4"></td>
            					<td width="15%"></td>
            					<td width="15%"></td>
            					<td width="10%" align="center"><input type="button" value="<s:text name="RES_RECALCULATE"/>" onclick="plantDayStatistics()" class="button2" id="searchImg" style="cursor:pointer; background:url('${pageContext.request.contextPath }/images/buttom_bg41.gif'); width:85px"/></td>
          					</tr>
						</table>
					</td>
      			</tr>
			</table>
    		
    	</td>
	</tr>
  	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
