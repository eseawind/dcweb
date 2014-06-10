<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confPmu.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet"/>
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
		<s:if test="#session.userMenu.pmu==0">
	    	location.href="index.action";
	    </s:if>
	    
  		$(document).ready(function() {
			confPmu.init();
		});
		
		document.onkeydown = function(e){   
    		var theEvent = e || window.event;   
    		var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
    		if (code == 13){   
	       		var ipg=$('#inputpage').val();
	       		if (ipg==""){
	       			art.dialog({
	       				width:300,
	       				height:50,
	       				title:"Solarcloud Message",
	       				content:RES.NEED_NUMBER,
	       				ok:function(){},
	       				okValue:RES.CONF_ART_OK
	       			});
	       			return false;
	       		}
	       		if(!isNaN(ipg)){
	       			$('#page').val(ipg+'');
			       	if(parseInt(ipg)>parseInt($('#allPage').val())){
			       		art.dialog({
		       				width:300,
		       				height:50,
		       				title:"Solarcloud Message",
		       				content:RES.INPUT_TOOLARGE,
		       				ok:function(){},
		       				okValue:RES.CONF_ART_OK
		       			});
			       		return false;
					}
	       		}else{
	       			$('#page').val('1');
	       		}
	        	$("#searchForm").submit();	
	    	}   
	    	return true;
    	}

		function showAddPmu(){
			var iWidth=570;		//弹出窗口的宽度;
		  	var iHeight=270;	//弹出窗口的高度;
		  	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
		  	var iLeft = (window.screen.availWidth-10-iWidth)/2;        //获得窗口的水平位置;
		  	var showAddPmu=showModalDialog('inputPmuShow.action?'+Math.random(),'showAddPmu','dialogWidth:'+iWidth+'px;dialogHeight:'+iHeight+'px;dialogLeft:'+iLeft+'px;dialogTop:'+iTop+'px;center:yes;help:no;resizable:no;status:no')
	    }
    
	    function changeState(ch){
	    	if (ch.checked)
	    	$('#searchOnline').val("1");
	    	else
	    	$('#searchOnline').val("0");
	    }
  	</script>
  	<style>
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		.button1 {
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffffff;
			background-image: url("images/regin18_bg.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 30px !important;
			border: 0px solid ;
			height: 30px;
			width:198px;
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
</head>
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2"><%@include file="HeadMenu.jsp" %></td>
        <script type="text/javascript">
       		menuOver('adminMenu',21);
        </script>
  	</tr>
  	<tr>
		<td align="center" bgcolor="#E5EFF9">
			<table border="0" cellspacing="10" cellpadding="0">
      		<form action="" method="get" id="searchForm" name="searchForm">
				<tr>
        			<td align="center">
      					<input type="hidden" name="allPage" value="<s:property value="allPage" />" id="allPage"/>
      					<input type="hidden" name="page" value="<s:property value="page" />" id="page"/>
        				<table width="896" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td align="center" background="images/main_bg6.gif">
            						<table width="98%" border="0" cellspacing="0" cellpadding="0">
                						<tr>
                  							<td width="119" align="right" class="black2"><s:text name="RES_ETYPE"/>&nbsp;</td>
                  							<td width="115" align="left">
                  								<s:set name="tp" value="type" />
												<select name="type" id="type" class="test_input14" >
	                  								<option value="">All</option>
	                 								<s:iterator id="typel" status="ss" value="typeList">
	                 								<s:if test='#tp==#typel.type'>
 													<option value="<s:property value="#typel.type" />" selected="selected"><s:property value="#typel.type" /></option>
 													</s:if>
 													<s:else>
 													<option value="<s:property value="#typel.type" />"><s:property value="#typel.type" /></option>
 													</s:else>
			         								</s:iterator>
			         							</select>
				  							</td>
                  							<td width="1" align="center"><img src="images/list19.gif" width="1" height="45" /></td>
				  							<td width="92" align="right" class="black2"><s:text name="RES_CONF_MODEL"/>&nbsp;</td>
                  							<td width="115" align="left">
                  								<s:set name="md" value="model" />
                  								<select name="model" id="model" class="test_input14" >
	                								<option value="">All</option>
	                 								<s:iterator id="modell" status="ss" value="modelList">
	                 								<s:if test='#md==#modell.model'>
 													<option value="<s:property value="#modell.model" />" selected="selected"><s:property value="#modell.model" /></option>
 													</s:if>
 													<s:else>
 													<option value="<s:property value="#modell.model" />"><s:property value="#modell.model" /></option>
 													</s:else>
		     										</s:iterator>
		     									</select>
		     								</td>
		     								<td width="1" align="center"><img src="images/list19.gif" width="1" height="45" /></td>
		     								<td width="100" align="right" class="black2"><s:text name="RES_ESTATUS"/>&nbsp;</td>
		     								<td width="88" align="left" class="black2">
		     									<select name="searchOnline" id="searchOnline" class="test_input14" >
	                								<option value="100">All</option>
									                 <s:if test="searchOnline==0">
													<option value="0" selected><s:text name="RES_OFFLINE"/></option>
													<option value="1"><s:text name="RES_ONLINE"/></option>
													</s:if>
													<s:elseif test="searchOnline==1">
													<option value="0"><s:text name="RES_OFFLINE"/></option>
													<option value="1" selected><s:text name="RES_ONLINE"/></option>
													</s:elseif>
													<s:else>
													<option value="0"><s:text name="RES_OFFLINE"/></option>
													<option value="1"><s:text name="RES_ONLINE"/></option>
													</s:else>
		     									</select>
                 							</td>
                  							<td width="1" align="center"><img src="images/list19.gif" width="1" height="45" /></td>
                  							<td width="106" align="right" class="black2"><s:text name="RES_SERIALNUMBER"/>&nbsp;</td>
                  							<td width="112" align="left">
                  								<input name="listno" type="text" class="test_input8" id="listno" size="6" value="<s:property value="listno" />" />
                  							</td>
                  							<td width="1" align="center"><img src="images/list19.gif" width="1" height="45" /></td>
                  							<td width="117" align="center">
                  								<!-- <img src="images/list18.gif" width="63" height="28" id="searchImg" style="cursor:pointer"/> -->
                  							<input type="button" value="<s:text name="RES_QUERY"/>" class="button2" id="searchImg" style="cursor:pointer"/>	
                  							</td>
                						</tr>
                						<tr>
                  							<td align="right" class="black2"><s:text name="RES_PMULIST_HARDVRE"/>&nbsp;</td>
                  							<td align="left">
                  								<input name="hardver" type="text" class="test_input8" id="hardver"  value="<s:property value="hardver" />" />
				  							</td>
                  							<td align="center"><img src="images/list19.gif" width="1"  /></td>
				  							<td align="right" class="black2"><s:text name="RES_PMULIST_SOFTVRE"/>&nbsp;</td>
                  							<td align="left">
                  								<input name="softver" type="text" class="test_input8" id="softver" size="6" value="<s:property value="softver" />" />
                 							</td>
		     								<td align="center"><img src="images/list19.gif" width="1" /></td>
		     								<td align="right" class="black2"><s:text name="RES_PMULIST_AUTOUPDATE"/>&nbsp;</td>
		     								<td align="left" >
		     									<select name="autoupdate" id="autoupdate" class="test_input14" >
		     										<s:if test="autoupdate==-1">
									                <option value="-1" selected>All</option>
									                <option value="1" ><s:text name="RES_PMULIST_AUTOUPDATE"/></option>
									                <option value="0" ><s:text name="RES_PMULIST_AUTO_CLOSE_UPDATE"/></option>
								 					</s:if>
								 					<s:elseif test="autoupdate==1">
									                <option value="-1">All</option>
									                <option value="1" selected><s:text name="RES_PMULIST_AUTOUPDATE"/></option>
									                <option value="0" ><s:text name="RES_PMULIST_AUTO_CLOSE_UPDATE"/></option>
								 					</s:elseif>
								 					<s:elseif test="autoupdate==0">
									                <option value="-1">All</option>
									                <option value="1" ><s:text name="RES_PMULIST_AUTOUPDATE"/></option>
									                <option value="0" selected><s:text name="RES_PMULIST_AUTO_CLOSE_UPDATE"/></option>
								 					</s:elseif>
	     										</select>
		     								</td>
		     								<td align="center"><img src="images/list19.gif" width="1"  /></td>
		     								<td align="right" class="black2" ><s:text name="RES_PMULIST_AUTO_IFNEED"/>&nbsp;</td>
                    						<td align="left" class="black2" >
									     		<select name="needupdate" id="needupdate" class="test_input14" >
										     		<s:if test="needupdate==-1">
									                <option value="-1" selected>All</option>
									                <option value="1" ><s:text name="RES_PMULIST_AUTO_IFNEED"/></option>
									                <option value="0" ><s:text name="RES_PMULIST_AUTO_NOTNEED"/></option>
								 					</s:if>
								 					<s:elseif test="needupdate==1">
									                <option value="-1">All</option>
									                <option value="1" selected><s:text name="RES_PMULIST_AUTO_IFNEED"/></option>
									                <option value="0" ><s:text name="RES_PMULIST_AUTO_NOTNEED"/></option>
								 					</s:elseif>
								 					<s:elseif test="needupdate==0">
									                <option value="-1">All</option>
									                <option value="1" ><s:text name="RES_PMULIST_AUTO_IFNEED"/></option>
									                <option value="0" selected><s:text name="RES_PMULIST_AUTO_NOTNEED"/></option>
								 					</s:elseif>
									     		</select>
                							</td>
                							<td align="left" class="black2" colspan="2"></td>
                 						</tr>
            						</table>
            					</td> 
            				</form>
          					</tr>
          					<tr><td height="5">&nbsp;</td></tr>
         	 				<tr>
            					<td align="center">
            						<table width="896" border="0" cellspacing="0" cellpadding="0">
                						<tr>
                  							<td>
                  								<table width="896" border="0" cellspacing="0" cellpadding="0">
                    								<tr>
								                      	<td width="10">&nbsp;</td>
								                      	<td width="93" align="center" valign="middle" background="images/listbg25_1.gif" class="white3"><s:text name="RES_CONF_LIST"/></td>
								                      	<td width="4">&nbsp;</td>
								                      	<td width="93" align="center" valign="middle" background="images/listbg25.gif" class="white3" onclick="location.href='confPmuManager.action'" style="cursor:pointer"><s:text name="RES_CONF_STATISTICS"/></td>
								                      	<td width="93" background="images/list9.gif">&nbsp;</td>
                      									<td align="right" valign="top">
                      										<table width="15%" border="0" cellspacing="0" cellpadding="0">
                          										<tr>
										                            <td align="center"><img src="images/pmuAdd.gif" width="38" height="33" style="cursor:pointer" onclick="showAddPmu()"/></td>
										                            <td align="center"><img src="images/list15.gif" width="38" height="33"  style="cursor:pointer" onclick="downPmuCsv()"/></td>
										                            <td align="center"><img src="images/list16.gif" width="38" height="33"  style="cursor:pointer" onclick="downPmuTxt()"/></td>
                          										</tr>
                      										</table>
                      									</td>
                      									<td width="10">&nbsp;</td>
                    								</tr>
                  								</table>
                  							</td>
                						</tr>
                						<tr>
                  							<td height="34" align="center" background="images/list_bg4.gif">
				  								<table width="894" border="0" cellspacing="0" cellpadding="0">
                      								<tr>
                        								<td width="93" height="30" align="center" class="black"></td>
                        								<s:if test="updateRight==1">
                        								<td width="20" align="center" class="black"></td>
                        								</s:if>
								                        <td width="130" align="center" class="black"><s:text name="RES_SERIALNUMBER"/></td>
								                        <td width="130" align="center" class="black"><s:text name="RES_PMULIST_HARDVRE"/></td>
								                        <td width="120" align="center" class="black"><s:text name="RES_PMULIST_SOFTVRE"/></td>
								                        <td width="89" align="center" class="black"><s:text name="RES_PMULIST_AUTOUPDATE"/></td>
								                        <td width="159" align="center" class="black"><s:text name="RES_CONF_STATION"/></td>
								                        <td width="60" align="center" class="black"><s:text name="RES_ATTRIBUTE"/></td>
                      								</tr>
                  								</table>
                  							</td>
                						</tr>
                						<tr>
                  							<td align="center" background="images/list_bg6.gif">
                  								<table width="894" border="0" cellspacing="0" cellpadding="0">
		                   							<s:iterator id="pum" value="pmuListEx" status="em">
													<s:if test="#em.odd">
													<tr>
													</s:if>
													<s:else>
													<tr bgcolor="#B5D5EA" >
													</s:else>
                        								<td width="93" height="36" align="center" class="black2">
	                        								<s:if test="#pum.state==1">
	                        								<img src="images/pum.gif"  />
	                        								</s:if>
									                        <s:elseif test="#pum.state==0">
									                        <img src="images/pum_2.gif"  />
									                        </s:elseif>
                        								</td>
                        								<s:if test="updateRight==1">
                        								<td width="20" align="center" class="black2">
                        									<input type="checkbox" name="selectno" value="<s:property value="#pum.psno" />" />
                        								</td>
                        								</s:if>
                        								<td width="130" align="center" class="black2"><s:property value="#pum.psno" /></td>
								                        <td width="130" align="center" class="black2"><s:property value="#pum.hardver" /></td>
								                        <td width="120" align="center" class="black2"><s:property value="#pum.softver" /></td>
								                        <td width="89" align="center" class="black2" id="sp<s:property value="#pum.psno" />">
                         									<s:if test="#pum.needup==1">
                       										<s:text name="RES_PMULIST_UPDATEST_AUTO"/>
                        									</s:if>
                        									<s:elseif test="#pum.needup==0">
                        									<s:text name="RES_PMULIST_UPDATEST_CLOSE"/>
                        									</s:elseif>
                        								</td>
                        								<td width="159" align="center" class="black2"><s:property value="#pum.stationname" /></td>
                        								<td width="60" align="center" class="black2"><a href="javascript:confPmuView.init('<s:property value="#pum.psno" />')"><s:text name="RES_CONF_VIEW"/></a></td>
                      								</tr>
                       								</s:iterator> 
                  								</table>
                  							</td>
                						</tr>
                						<tr>
                  							<td height="34" align="right" background="images/list_bg5.gif">
                  								<table width="98%" border="0" cellspacing="0" cellpadding="0" >
                      								<tr>
                      									<td width="12%" align="right">
                      										<s:if test="updateRight==1">
                       										<input type="checkbox" name="checkbox" value="checkbox" onclick="selectnos(this)"/>
                       										</s:if>
                        								</td>
                        								<td width="60%" align="center">
									                        <s:if test="updateRight==1">
									                        <input type="button" value="<s:text name="RES_PMULIST_OPENUPDATE"/>" class="button11"  style="cursor:pointer" onclick="openUpdate()"/>
									                        <input type="button" value="<s:text name="RES_PMULIST_CLOSEUPDATE"/>" class="button11"  style="cursor:pointer" onclick="closeUpdate()"/>
									                        <input type="button" value="<s:text name="RES_PMULIST_NOWUPDATE"/>" class="button21" style="cursor:pointer" onclick="nowUpdate()"/>
									                        </s:if>
                        								</td>
								                        <td align="center"><img src="images/dz_list8.gif" width="17" height="19" id="firstP" style="cursor:pointer" /></td>
								                        <td align="center"><img src="images/dz_list10.gif" width="19" height="19" id="preP" style="cursor:pointer" /></td>
								                        <td align="center"><input name="inputpage" type="text" class="test_input4" id="inputpage" value="<s:property value="page" />/<s:property value="#session.allPage" />" size="6" /></td>
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
        				</table>
        			</td>
      			</tr>
    		</table>
    		<p>&nbsp;</p>
    	</td>
	</tr>
  	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<form action="pmuDownload" name="downPmuForm" target="hiddenFrame" method="post">
	<input type="hidden" name="lsno" value=""/>
	<input type="hidden" name="type" value=""/>
	<input type="hidden" name="model" value=""/>
	<input type="hidden" name="searchOnline" value=""/>
	<input type="hidden" name="tp" value=""/>
	<input type="hidden" name="hardver" value=""/>
	<input type="hidden" name="softver" value=""/>
	<input type="hidden" name="autoupdate" value=""/>
	<input type="hidden" name="needupdate" value=""/>
</form>
<iframe id="hiddenFrame"  name="hiddenFrame"  MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
