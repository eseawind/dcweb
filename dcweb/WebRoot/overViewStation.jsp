<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  	<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/register.js"></script>
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>
  	<script type="text/javascript">
		function changeMenus(str){
			changeMenu.action=str;
			changeMenu.submit();
		}
	</script>
  	</head>
<body>
<form id="changeMenu" name="changeMenu" action="" method="post" >
	<input type="hidden" name="stationid" value="<s:property value="stationid" />"/>
</form>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td colspan="2"><%@include file="HeadMenu.jsp" %></td>
     	<script type="text/javascript">
        	menuOver('overviewMenu',7);
        </script>
  	</tr>
  	<tr>
    	<td height="560" valign="top" align="center" bgcolor="#E5EFF9" colspan="2">
	    	<br/>
		    <div id="flashCont" width="890" height="550"></div>
		    <%
		    String role=((Map)session.getAttribute("user")).get("roleId").toString();
		    String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
		    %>
	    	<script type="text/javascript">
	        var flashvars = {
				"role":<%=role%>,
	            "lang":"<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>",
	            "sid":"<s:property value="#session.defaultStation" />",
	            "baseUrl":"<%=baseUrl%>"
			}
	        showFlashElement("swf/OverView.swf", flashvars);
	    	</script>
			<br/>
  		</td>
  	</tr> 
  	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="2"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
</body>
</html>  