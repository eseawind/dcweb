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
			updatePasswd.init();
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

<script>
function changeAgree(obj){
	if (obj){
		agreeBon.disabled=false
	}else{
		agreeBon.disabled=true
	}
}
</script>

<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
    <td>
        <%@include file="headUserReg.jsp" %>
    </td>
  </tr>
  <tr>
    <td height="547" align="center" bgcolor="#E5EFF9">
    <table width="920" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="10" background="images/add1.gif"></td>
      </tr>
      <tr>
        <td height="435" align="center" background="images/regin6.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="100"><div align="center" class="STYLE1"><s:text name="RES_FIND_PASSWD_TITLE"/></div></td>
          </tr>
          <tr>
            <td align="center"><table width="60%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="10%" height="30" align="center"><img src="images/regin7.gif" width="22" height="22" /></td>
                <td width="90%" align="left" class="black"><s:text name="RES_FIND_PASSWD_STEP"/></td>
              </tr>
              <tr>
                <td height="30">&nbsp;</td>
                <td align="left" class="black2">■ <s:text name="RES_FIND_PASSWD_STEP1"/></td>
              </tr>
              <tr>
                <td height="60">&nbsp;</td>
                <td align="left" class="black2">■ <s:text name="RES_FIND_PASSWD_STEP2"/></td>
              </tr>
			   <tr>
                <td height="30" colspan="2" class="black2"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="RES_FIND_PASSWD_ACCOUNT"/>
                  
                  <input type="text" name="email" id="email" class="reg_input"/><span id="emailTip"></span>
                  
                </div></td>
              <tr>
                <td height="60" colspan="2"><div align="center"><input id="submitForm" type="button" class="button3" value="<s:text name="RES_FIND_PASSWD_SENDMAIL"/>"  style="cursor:pointer"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button2" value="<s:text name="RES_CHANGEPASSWORD"/>" onclick="location.href='updatePasswd.action'" style="cursor:pointer"/></div></td>
              </tr>
            </table></td>
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
