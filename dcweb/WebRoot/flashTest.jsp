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
  	

  </head>
</head>

<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td>
        <%@include file="head.jsp" %>
    </td>
  </tr>
  <tr>
    <td height="547" align="center" bgcolor="#E5EFF9">
	<OBJECT style="VISIBILITY: visible" id=flashCont classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width="892" height="560">
<PARAM NAME="_cx" VALUE="37570">
<PARAM NAME="_cy" VALUE="5080">
<PARAM NAME="FlashVars" VALUE="lang=en_US&amp;sid=36&amp;baseUrl=http://58.210.73.86/dc/">
<PARAM NAME="Movie" VALUE="swf/OverView.swf?seed=001">
<PARAM NAME="Src" VALUE="swf/OverView.swf?seed=001">
<PARAM NAME="WMode" VALUE="Transparent">
<PARAM NAME="Play" VALUE="0">
<PARAM NAME="Loop" VALUE="-1">
<PARAM NAME="Quality" VALUE="High">
<PARAM NAME="SAlign" VALUE="">
<PARAM NAME="Menu" VALUE="0">
<PARAM NAME="Base" VALUE="">
<PARAM NAME="AllowScriptAccess" VALUE="always">
<PARAM NAME="Scale" VALUE="ShowAll">
<PARAM NAME="DeviceFont" VALUE="0">
<PARAM NAME="EmbedMovie" VALUE="0">
<PARAM NAME="BGColor" VALUE="">
<PARAM NAME="SWRemote" VALUE="">
<PARAM NAME="MovieData" VALUE="">
<PARAM NAME="SeamlessTabbing" VALUE="1">
<PARAM NAME="Profile" VALUE="0">
<PARAM NAME="ProfileAddress" VALUE="">
<PARAM NAME="ProfilePort" VALUE="0">
<PARAM NAME="AllowNetworking" VALUE="all">
<PARAM NAME="AllowFullScreen" VALUE="true">
</OBJECT>
  </td>
  </tr>
  <tr>
    <td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  </tr>
</table>
</body>
</html>