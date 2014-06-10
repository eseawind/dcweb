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
	    <script type="text/javascript" src="js/parseXML.js"></script>
	  	<link href="./skins/blue.css" rel="stylesheet" />
		<script src="./js/artDialog.min.js"></script>
	    <script type="text/javascript" src="js/cookie.js"></script>
	</head> 
</html>
<script>
//alert("Modify the default inverter success!");
</script>