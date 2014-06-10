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
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript">
  		$(document).ready(function() {
			register.init();
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
background-image: url("images/regin18_bg.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:198px;
cursor: pointer;
}
.button2 {
font: 14px Tahoma, Verdana;
padding: 0 5px;
color: #D3E0E7;
background-image: url("images/regin16_bg.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:63px;
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
.STYLETIP {
	font-size: 16px;
	font-weight: bold;
	color: #0099CC;
}
-->
</style>
</head>

<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td>
        	<%@include file="headUserReg.jsp" %>
    	</td>
  	</tr>
  	<tr>
    	<td height="487" align="center" bgcolor="#E5EFF9">
    		<table width="920" border="0" cellspacing="0" cellpadding="0">
       			<tr>
        			<td height="78" valign="bottom" background="images/regin12.gif">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td width="23%" height="40" align="center" class="blue4"><s:text name="RES_REGISTER_STEP1" ></s:text></td>
            					<td width="59%" align="center" class="blue4"><s:text name="RES_REGISTER_STEP2" ></s:text></td>
            					<td width="18%" align="center" class="blue4"><s:text name="RES_REGISTER_STEP3" ></s:text></td>
          					</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td height="335" align="center" background="images/regin6.gif">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td width="24%" height="30" align="center"><div align="right"><img src="images/regin7.gif" width="22" height="22" /></div></td>
            					<td width="76%" align="left" class="black"><s:text name="RED_ACTIVE_ACCOUNT_TITLE"></s:text></td>
          					</tr>
          					
          					<s:if test="yourId==0">
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"> <s:text name="RED_ACTIVE_ACCOUNT_OK"></s:text></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="center"></td>
          					</tr>
          					</s:if>
          					
          					<s:if test="yourId==1">
          					<tr>
					            <td height="30">&nbsp;</td>
					            <td align="left" class="black2"></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"> <s:text name="RED_ACTIVE_ACCOUNT_HAVEACT"></s:text></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="center"></td>
          					</tr>
          					</s:if>
          					
          					<s:if test="yourId==2">
         	 				<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"> <s:text name="RED_ACTIVE_ACCOUNT_NOACC"></s:text></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="center"></td>
          					</tr>
          					</s:if>
          					
          					<s:if test="yourId==3">
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="left" class="black2"> <s:text name="RED_ACTIVE_ACCOUNT_ERRCODE"></s:text></td>
          					</tr>
          					<tr>
            					<td height="30">&nbsp;</td>
            					<td align="center"></td>
          					</tr>
          					</s:if>
        				</table>
						<p>&nbsp;</p>
				        <p>&nbsp;</p>
				        <p>&nbsp;</p>
					</td>
      			</tr>
      			<tr>
        			<td><img src="images/regin5.gif" width="920" height="10" /></td>
      			</tr>
    		</table>
		</td>
  	</tr>
   	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
</body>
</html>
