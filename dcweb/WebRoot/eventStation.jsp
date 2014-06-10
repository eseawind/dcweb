<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String lang = "en_US";
	if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
		lang = session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
	}
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script> 
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/register.js"></script>
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>
    <script type="text/javascript">
		document.onkeydown = function(e){   
		    var theEvent = e || window.event;   
		    var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
	    	if(code == 13){   
	       		var ipg=$('#inputpage').val();
		       	if(ipg==""){
		       		alert(RES.NEED_NUMBER)
		       		return false;
		       	}
		       	if(!isNaN(ipg)){
		       		$('#pageNo').val(ipg+'');
			       	if(parseInt(ipg)>parseInt($('#totalPage').val())){
			       		alert(RES.INPUT_TOOLARGE)
			       		return false;
			       	}
		       	}else{
		       		$('#pageNo').val('1');
		       	}
				$("#eventForm").submit();	
	    	}   
	    	return true;
		}
    
		function changeMenus(str){
			changeMenu.action=str;
			changeMenu.submit();
		}

		function searchEvent(theForm){
			var approves=0;
			if (theForm.approved1.checked && theForm.approved2.checked){
				approves=3;
			}else if (!theForm.approved1.checked && !theForm.approved2.checked){
				approves=0;
			}else if (theForm.approved1.checked){
				approves=1;
			}else if (theForm.approved2.checked){
				approves=-1;
			}
			theForm.approved.value=approves;
			var ipg=$('#inputpage').val();	
			if(isNaN(ipg)){
       			$('#pageNo').val('1');
       		}
			return true;
		}
		
		function gotoPage(page){
			if (page<=parseInt(document.eventForm2.totalPage.value) && page>=1){
				document.eventForm2.pageNo.value=page+"";
				document.eventForm2.submit();
			}
		}
	</script>
    <script type="text/javascript">
  		//js获取当前日期，格式化成xxxx-xx-xx的格式(根据情况补零)  
  		var date = new Date();
  		var year = 0;
  		var month = 0;
  		var day = 0;
  		var clientdate = "";
  		year = date.getFullYear();
  		month = date.getMonth()+1;
  		day = date.getDate();
  		clientdate = year+"-";
  		if(month>=10)
  		{
  			clientdate += month+"-";
  	  	}
  		else
  		{
  			clientdate += "0"+month+"-";
  		}
  		if(day>=10)
  		{
  			clientdate += day;
  		}
  		else
  		{
  			clientdate += "0"+day;
  		}
  		$.post("client_date.action",{"clientdate":clientdate});
  	</script>
  	<style type="text/css">
		<!--
		.button1 {
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/buttom_bg1.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			height: 30px;
			width:63px;
		}
		-->
	</style>
</head>
<body>
<form id="changeMenu" name="changeMenu" action="" method="post" >
	<input type="hidden" name="stationid" value="<s:property value="stationid" />"/>
</form>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td colspan="2"><%@include file="HeadMenu.jsp" %></td>
       	<script type="text/javascript">
       		menuOver('overviewMenu',9);
       	</script>
  	</tr>
  	<tr>
    	<td colspan="2" salign="center" bgcolor="#E5EFF9">
    		<table border="0" align="center" cellspacing="18" cellpadding="0">
      		<form name="eventForm" id="eventForm" action="event.action" method="post" onsubmit="return searchEvent(this);">
		      	<input type="hidden" name="totalPage" id="totalPage" value="<s:property value='totalPage'/>"/>
		      	<input type="hidden" name="pageNo" id="pageNo" value="<s:property value='pageNo'/>"/>
      			<tr>
        			<td width="896" height="64" align="center" background="images/list_bg3.gif">
        				<table width="99%" border="0" height="30" cellspacing="0" cellpadding="0">
          					<tr>
            					<td align="center" class="black2" width="5%" valign="bottom"><s:text name="RES_ETYPE"/></td>
            					<td width="10%" align="center" valign="bottom">
            					<select name="e_level" style="margin-top:5px;width:80px;height: 23px;" >
              					<s:if test="#session.user.roleId<3">
              						<s:if test="e_level.indexOf('0')>=0">
									<option value="0" selected="true">All</option> 
									</s:if>
									<s:else>
									<option value="0" >All</option> 
									</s:else>
									<s:if test="e_level.indexOf('1')>=0">
									<option value="1" selected="true"><s:text name="RES_ETYPE_INFO"/></option>
									</s:if>
									<s:else>
									<option value="1" ><s:text name="RES_ETYPE_INFO"/></option>
									</s:else>
									<s:if test="e_level.indexOf('3')>=0">
									<option value="3" selected="true"><s:text name="RES_ETYPE_ERR"/></option> 
									</s:if>
									<s:else>
									<option value="3" ><s:text name="RES_ETYPE_ERR"/></option> 
									</s:else>
								</s:if>
								<s:else>
					 				<s:if test="#session.user.roleId==12">
              						<s:if test="e_level.indexOf('0')>=0">
									<option value="0" selected="true">All</option> 
									</s:if>
									<s:else>
									<option value="0" >All</option> 
									</s:else>
									<s:if test="e_level.indexOf('1')>=0">
									<option value="1" selected="true"><s:text name="RES_ETYPE_INFO"/></option>
									</s:if>
									<s:else>
									<option value="1" ><s:text name="RES_ETYPE_INFO"/></option>
									</s:else>
									<s:if test="e_level.indexOf('3')>=0">
									<option value="3" selected="true"><s:text name="RES_ETYPE_ERR"/></option> 
									</s:if>
									<s:else>
									<option value="3" ><s:text name="RES_ETYPE_ERR"/></option> 
									</s:else>
									</s:if>
									<s:else>
									<s:if test="e_level.indexOf('0')>=0">
									<option value="0" selected="true">All</option> 
									</s:if>
									<s:else>
									<option value="0" >All</option> 
									</s:else>
									<s:if test="e_level.indexOf('1')>=0">
									<option value="1" selected="true"><s:text name="RES_ETYPE_INFO"/></option>
									</s:if>
									<s:else>
									<option value="1" ><s:text name="RES_ETYPE_INFO"/></option>
									</s:else>
									<s:if test="e_level.indexOf('2')>=0">
									<option value="2" selected="true"><s:text name="RES_ETYPE_ART"/></option>
									</s:if>
									<s:else>
									<option value="2" ><s:text name="RES_ETYPE_ART"/></option>
									</s:else>
									<s:if test="e_level.indexOf('3')>=0">
									<option value="3" selected="true"><s:text name="RES_ETYPE_ERR"/></option> 
									</s:if>
									<s:else>
									<option value="3" ><s:text name="RES_ETYPE_ERR"/></option> 
									</s:else>
									</s:else>
								</s:else>
            					</select>            
            					</td>
					            <td width="1" align="center"><img src="images/list19.gif" width="1"   height="30"/></td>
					            <td width="4%" align="center" class="black2" valign="bottom"><s:text name="RES_EPICKDATE"/></td>
					            <td width="14%" align="center" valign="bottom"><input id="startdate" size="13" class="Wdate" type="text" name="occdt1" value="<s:property value='occdt1'/>" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'enddate\')||\'2050-01-01\'}',lang:'<%= lang %>'})"/></td>
					            <td width="4" align="center" >-</td>
					            <td width="14%" align="center" valign="bottom"><input id="enddate" size="13" class="Wdate" type="text" name="occdt2" value="<s:property value='occdt2'/>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startdate\')}',maxDate:'2050-01-01',lang:'<%= lang %>'})"/></td>
					            <td width="1" align="center"><img src="images/list19.gif" width="1"  height="30"/></td>
					            <td width="28%" align="left" class="black2" valign="bottom"><s:text name="RES_EPLANT"/>
            					<select id="isno" name="isno" style="margin-top:5px;width:200px;height: 23px;">
								<s:if test="isno=='-1'">
								<option selected="selected" value="-1">--<s:text name="RES_ECHOOSESTATUS" />--</option>
								</s:if>
								<s:else>
								<option value="-1">--<s:text name="RES_ECHOOSESTATUS" />--</option>
								</s:else>
								<s:set id="isnoStr" name="isnoStr" value="isno"/>
								<s:iterator id="inv" value="InvMap" status="invt">
									<s:if test="#isnoStr==#inv.isno">
										<option selected="selected" value='<s:property value="#inv.isno" />'><s:property value="#inv.isno" /></option>
									</s:if>
									<s:else>
										<option value='<s:property value="#inv.isno" />'><s:property value="#inv.isno" /></option>
									</s:else>
								</s:iterator>
				  				</select>
				  				</td>
            					<td width="1" align="center"><img src="images/list19.gif" width="1"  height="30" /></td>
					             <!-- <td width="15%" align="center" valign="bottom" class="black2" >
					           
					             <input id="approved" name="approved" type="hidden" value="<s:property value="approved" />" />
					             
					                 <s:if test="approved==-1">
										<input name="approved1" type="checkbox" value="1"/><s:text name="RES_APPROVED" />
										<input type="checkbox" name="approved2" value="-1" checked="checked"/><s:text name="RES_UNAPPROVED" />
					                 
									</s:if>
									  <s:elseif test="approved==1">
										<input name="approved1" type="checkbox" value="1" checked="checked"/><s:text name="RES_APPROVED" />
					                    <input type="checkbox" name="approved2" value="-1"/><s:text name="RES_UNAPPROVED" />
									</s:elseif>
									  <s:elseif test="approved==0">
										<input name="approved1" type="checkbox" value="1" /><s:text name="RES_APPROVED" />
					                    <input type="checkbox" name="approved2" value="-1" checked="checked"/><s:text name="RES_UNAPPROVED" />
									</s:elseif><s:elseif test="approved==3">
										<input name="approved1" type="checkbox" value="1" checked="checked"/><s:text name="RES_APPROVED" />
										<input type="checkbox" name="approved2" value="-1" checked="checked"/><s:text name="RES_UNAPPROVED" />
									</s:elseif>
									<s:else>
										<input name="approved1" type="checkbox" value="1" checked="checked" /><s:text name="RES_APPROVED" />
					                    <input type="checkbox" name="approved2" value="-1" checked="checked" /><s:text name="RES_UNAPPROVED" />
									</s:else>
					               </td>
					               //-->
					            <td width="15%" align="center"></td>
					            <td width="8%" align="center" valign="bottom"><input type="submit" class="button1" value="<s:text name="RES_QUERY" />" width="63" height="28"  style="cursor:pointer"/></td>
          					</tr>
						</table>
					</td>
      			</tr>
			</form>
	      		<tr>
	        		<td align="center">
	        			<table width="896" border="0" cellspacing="0" cellpadding="0">
	          				<tr>
	            				<td height="34" align="center" background="images/list_bg4.gif">
	            					<table width="894" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
							                <td width="69" height="30" align="center" class="black"><s:text name="RES_ETYPE" /></td>
							                <td width="138" align="left" class="black"><s:text name="RES_QUERY_ENAME" /></td>
							                <td width="173" align="left" class="black"><s:text name="RES_SERIALNUMBER" /></td>
							                <td width="159" align="left" class="black"><s:text name="RES_QUERY_DATETIME" /></td>
							                <td width="355" align="left" class="black"><s:text name="RES_EDESC" /></td>
						                </tr>
	            					</table>
	            				</td>
	          				</tr>
	          				<tr>
	            				<td align="center" background="images/list_bg6.gif">
	            					<table width="894" border="0" cellspacing="0" cellpadding="0">
	                					<s:iterator id="event" value="eventMap" status="em">
										<s:if test="#em.odd">
										<tr >
										</s:if>
										<s:else>
										<tr bgcolor="#B5D5EA" >
										</s:else>
	                  						<td width="68" height="36" align="center" class="black2">
						                  	<s:if test="#event.msgtype==1">
											<img src="images/list22.gif" />
											</s:if>
										 	<s:elseif test="#event.msgtype==2">
											<img src="images/list24.gif" />
											</s:elseif>
											<s:else>
											<img src="images/list23.gif" />
											</s:else>
											</td>
					 						<s:if test="#event.haveread==0">
										 	<td width="139" align="left" class="black5"><s:property value="#event.byname" /></td>
						                  	<td width="172" align="left" class="black5"><s:property value="#event.isno" /></td>
						                  	<td width="159" align="left" class="black5"><s:property value="#event.occdt" /></td>
						                  	<td width="356" align="left" class="black5"><s:property value="#event.context" /></td>
											</s:if>
											<s:else>
										 	<td width="139" align="left" class="black2"><s:property value="#event.byname" /></td>
						                  	<td width="172" align="left" class="black2"><s:property value="#event.isno" /></td>
						                  	<td width="159" align="left" class="black2"><s:property value="#event.occdt" /></td>
						                  	<td width="356" align="left" class="black2"><s:property value="#event.context" /></td>
											</s:else>
	                  					</tr>
	                					</s:iterator> 
	            					</table>
	            				</td>
	          				</tr>
	          				<tr>
	            				<td height="34" align="right" background="images/list_bg5.gif">
	            				<table width="20%" border="0" cellspacing="0" cellpadding="0">
	                			<tr>
				                  	<td align="center"><img src="images/dz_list8.gif" width="17" height="19" style="cursor:pointer" onclick="gotoPage(1)"/></td>
				                  	<td align="center"><img src="images/dz_list10.gif" width="19" height="19"  style="cursor:pointer" onclick="gotoPage(<s:property value='pageNo'/>-1)"/></td>
				                  	<td align="center"><input name="inputpage" type="text" class="test_input4" id="inputpage" onfocus="this.value=''" value="<s:property value='pageNo'/>/<s:property value='totalPage'/>" size="6" /></td>
				                  	<td align="center"><img src="images/dz_list11.gif" width="19" height="19"  style="cursor:pointer" onclick="gotoPage(<s:property value='pageNo'/>+1)"/></td>
				                  	<td align="center"><img src="images/dz_list9.gif" width="17" height="19" style="cursor:pointer" onclick="gotoPage(<s:property value='totalPage'/>)"/></td>
				                  	<td>&nbsp;</td>
	                			</tr>
	            				</table>
	            				</td>
	          				</tr>
	        			</table>
	        		</td>
	      		</tr>
    		</table>
    	</td>
	</tr>
  	<tr >
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<form name="eventForm2" id="eventForm2" action="event.action" method="post" onsubmit="return searchEvent(this);">
	<input type="hidden" name="totalPage"  value="<s:property value='totalPage'/>"/>
    <input type="hidden" name="pageNo" value="<s:property value='pageNo'/>"/>
    <input type="hidden" name="e_level" value="<s:property value='e_level'/>"/>
    <input type="hidden" name="occdt1" value="<s:property value='occdt1'/>"/>
    <input type="hidden" name="occdt2" value="<s:property value='occdt2'/>"/>
    <input type="hidden" name="isno" value="<s:property value='isno'/>"/>
    <input type="hidden" name="approved" value="<s:property value='approved'/>"/>
</form>
</body>
</html>  