<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 	<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confDev.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
  		$(document).ready(function() {
			confDev.init();
			
		});
  	</script>
  	<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
	
	
		.button2 {
		
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffffff;
			background-image: url("images/buttom_bg3.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 27px !important;
			border: 0px solid ;
			width:121px;
			border-style:none; 
			background-repeat:no-repeat;
		}
	
		.button1 {
		
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffffff;
			background-image: url("images/buttom_bg1.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			width:63px;
			border-style:none; 
			background-repeat:no-repeat;
		}
		-->
	</style>
 	</head>

<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
      	<td colspan="2"><%@include file="HeadMenu.jsp" %></td>
        <script type="text/javascript">
       		menuOver('configMenu',1);
        </script>
  	</tr>
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table border="0" cellspacing="10" cellpadding="0">
      			<tr>
        			<td width="896" height="121" align="center" background="images/list_bg7.gif">
        				<%@include file="stationInfoSub.jsp" %>
        			</td>
      			</tr>
      			<tr>
        			<td align="center">
        				<table width="896" border="0" cellspacing="0" cellpadding="0">
          					<tr>	
            					<td height="5">&nbsp;</td>
          					</tr>
          					<tr>
            					<td align="center">
            						<table width="896" border="0" cellspacing="0" cellpadding="0">
                						<tr>
                  							<td height="20" align="center" background="images/list_bg4.gif">
				  								<table width="894" border="0" cellspacing="0" cellpadding="0">
                      								<tr>
                        								<td width="12%" height="30" align="center" class="black"><s:text name="RES_ETYPE"/></td>
								                        <td width="20%" align="center" class="black"><s:text name="RES_QUERY_ENAME"/></td>
								                        <td width="20%" align="center" class="black"><s:text name="RES_SERIALNUMBER"/></td>
								                        <td width="10%" align="center" class="black"><s:text name="RES_CONF_MODEL"/> </td>
								                        <td width="10%" align="center" class="black"><s:text name="RES_CONF_DOWNLOADDATA"/></td>
								                        <td width="10%" align="center" class="black"><s:text name="RES_SETCONFIG"/></td>
								                        <td width="18%" align="center" class="black" colspan="2"><s:text name="RES_ATTRIBUTE"/></td>
                        							</tr>
                  								</table>
                  							</td>
                						</tr>
                						<tr>
                  							<td align="center" background="images/list_bg6.gif">
                  								<table width="894" border="0" cellspacing="0" cellpadding="0">
                       								<s:iterator id="dev" value="stationDevList" status="em">
													<s:if test="#em.odd">
													<tr >
													</s:if>
													<s:else>
													<tr bgcolor="#B5D5EA" >
													</s:else>
                        								<td width="12%" height="36" align="right" class="black2">
                        									<s:if test="#dev.devtyp==1">
	                           									<s:if test="#dev.state==1">
		                        								<img src="images/pum.gif"  />
		                        								</s:if>
		                        								<s:elseif test="#dev.state==0">
		                        								<img src="images/pum_2.gif"  />
		                        								</s:elseif>
                        									</s:if>
                        									<s:elseif test="#dev.devtyp==2">
		                          								<s:if test="#dev.state==1">
		                        								<img src="images/dev1.gif"  />
		                        								</s:if>
		                        								<s:elseif test="#dev.state==0">
		                        								<img src="images/dev1_2.gif"  />
		                        								</s:elseif>
                        									</s:elseif>
                        								</td>
								                        <td width="20%" align="center" class="black2"><s:property value="#dev.byname" /></td>
								                        <td width="20%" align="left" class="black2"><s:property value="#dev.devno" /></td>
								                        <td width="10%" align="center" class="black2"><s:property value="#dev.kind" /></td>
								                        <td width="10%" align="center" class="black2">
                         									<s:if test="#dev.devtyp==2">
                           									<image src="images/downloaddata.gif" onclick="downDevInfo('<s:property value="#dev.devno" />','<s:property value="#dev.byname" />','<s:property value="nowDay" />')" style="cursor:pointer"/>
                        									</s:if>
                        									<s:else>
	                      									&nbsp;  
                        									</s:else>
                        								</td>
                        								<td width="10%" align="center" class="black2"><image src="images/set.gif" onclick="setDevInfo('<s:property value="#dev.devno" />','<s:property value="#dev.byname" />','<s:property value="nowDay" />')" style="cursor:pointer"/></td>
                        								<td width="12%" align="center" class="black2">
                        									<a href="javascript:viewDev('<s:property value="#dev.devno" />')"><s:text name="RES_CONF_VIEW"/></a>
                        								</td>
                        								<td width="6%" align="center" class="black2">
                        									<s:if test="#dev.devtyp==1">
		                        								&nbsp;
                        									</s:if>
                        									<s:elseif test="#dev.devtyp==2">
		                          								<s:if test="#dev.state==1">
		                        									&nbsp;
		                        								</s:if>
		                        								<s:elseif test="#dev.state==0">
		                        								<img src="images/remove.gif" onclick="deleteDev('<s:property value="#dev.devno" />')" style=" cursor:pointer;" title="<s:text name="RES_CONF_REMOVEINV"/>"/>
		                        								</s:elseif>
                        									</s:elseif>
                        								</td>
                      								</tr>
                      								</s:iterator> 
                  								</table>
                  							</td>
                						</tr>
               	 						<tr>
                  							<td height="34" align="right" background="images/list_bg5.gif">&nbsp;</td>
                						</tr>
            						</table>
            					</td>
          					</tr>
        				</table>
        			</td>
      			</tr>
     			<tr>
            		<td height="64" align="center" background="images/list_bg3.gif">
            			<table width="93%" border="0" cellspacing="0" cellpadding="0">
                			<tr class='black2'>
			                  	<td width="130" align="left" ><div align="right"><s:text name="RES_SERIALNUMBER"/></div></td>
			                  	<td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
			                  	<td width="130" align="center"><input name="listno" type="text" class="test_input11" id="listno" size="6" /></td>
			                  	<td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
							  	<td width="90" align="center"><s:text name="RES_PMULCODE"/></td>
			                  	<td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
			                  	<td width="130" align="center"><input name="serialno" type="text" class="test_input11" id="serialno" size="6" /></td>
			                  	<td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
			                  	<td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
			                  	<td align="center"><input name="button" type="button" class="button2" value="<s:text name="RES_CONF_ADDDEVICE"/>" id="addDev" style="cursor:pointer"/>
				 					&nbsp;&nbsp;&nbsp;&nbsp;
                  					<input name="button2" type="button" class="button2" value="<s:text name="RES_CONF_DELDEVICE"/>"  id="delDev" style="cursor:pointer"/>
                  				</td>
                			</tr>
            			</table>
            		</td>
        		</tr>
    		</table>
    		<p>&nbsp;</p>
    	</td>
  	</tr>
  	<tr >
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<input type="hidden" id="stationId" value="<s:property value="#session.defaultStation" />"/>
  	<form action="plantInvDownload" name="downForm" target="hiddenFrame" method="post">
	  	<input type="hidden" name="lsno" value=""/>
	  	<input type="hidden" name="startdt" value=""/>
	  	<input type="hidden" name="enddt" value=""/>
	  	<input type="hidden" name="tp" value=""/>
  	</form>
<iframe id="hiddenFrame"  name="hiddenFrame"  MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
