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
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/updatePasswd.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
			updatePasswd2.init();
			$('#titleTip').html("<s:text name="RES_FIND_PASSWD_TITLE"/>");
		});
		
  	</script>
  </head>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.button1 {
font: 14px Tahoma, Verdana;
padding: 0 5px;
color: #D3E0E7;
background-image: url("images/buttom_bg2.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:63px;
}
.button2 {
font: 14px Tahoma, Verdana;
padding: 0 5px;
color: #D3E0E7;
background-image: url("images/buttom_bg3.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:120px;
}

.button3{
font: 14px Tahoma, Verdana;
padding: 0 5px;
color: #D3E0E7;
background-image: url("images/buttom_bg5.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:180px;
}
.black4 {
	font-size: 14px;
	color: #000;
	text-decoration: none;
	}
.black5 {
	font-size: 14px;
	color: #787c7d;
	font-weight:bold;
	text-decoration: none;
	}
	.blue4 {
	font-size: 14px;
	color: #1B8FC5;
	text-decoration: none;
	font-weight: bold;
}
-->
</style>
<style type="text/css">
<!--
.STYLE1 {
	color: #663366;
	font-size: 36px;
}
-->
</style>

<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
        <%@include file="headUserReg.jsp" %>
    </td>
  </tr>
  <tr>
    <td height="547" align="center" bgcolor="#E5EFF9"><table width="920" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="images/regin5_1.gif" width="920" height="10" /></td>
      </tr>
      <tr>
        <td height="435" align="center" background="images/regin6.gif"><table width="50%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="30" colspan="2" align="center" class="blue2"><s:text name="RES_FIND_PASSWD_TITLE"/></td>
            </tr>
          <tr>
            <td width="50%" height="30" align="right" class="black4"><s:text name="RES_FIND_PASSWD_SELECT_VER"/></td>
            <td width="50%" height="30" align="left"><select name="select3" class="test_input8" id="select3">
              <option><s:text name="RES_FIND_PASSWD_SELECT_VER1"/></option>
                        </select></td>
          </tr>
          <tr>
            <td height="30" colspan="2" align="center"><input id="submitForm" name="submitForm" type="button" class="button2" value="<s:text name="RES_SENDMAIL"></s:text>" style="cursor:pointer"/></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td><img src="images/regin5.gif" width="920" height="10" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  </tr>
</table>
</body>
</html>
