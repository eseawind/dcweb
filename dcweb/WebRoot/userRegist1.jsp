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
			var ds = document.getElementById("accept");
			if (ds.checked){
				agreeBon.disabled=false;
			}else{
				agreeBon.disabled=true;
			}
		});
  	</script>
  	<script type="text/javascript">
		function changeAgree(obj){
			if (obj){
				agreeBon.disabled=false;
				agreeBon.className="button2";
			}else{
				agreeBon.disabled=true;
				agreeBon.className="button2ex";
			}
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
		background-image: url("images/buttom_bg1.gif");
		background-repeat: repeat-x;
		background-position: 0 50%;
		outline: 0px solid #D3E0E7;
		height: 28px !important;
		border: 0px solid ;
		height: 28px;
		width:63px;
	}
	.button2ex {
		font: 14px Tahoma, Verdana;
		padding: 0 5px;
		color: 'none';
		background-image: url("images/buttom_bg1.gif");
		background-repeat: repeat-x;
		background-position: 0 50%;
		outline: 0px solid #D3E0E7;
		height: 28px !important;
		border: 0px solid ;
		height: 28px;
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
	-->
	</style>
  	</head>
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  		<tr>
    		<td><%@include file="headUserReg.jsp" %></td>
  		</tr>
  		<tr>
    		<td height="590" align="center" bgcolor="#E5EFF9"><table width="921" border="0" cellspacing="0" cellpadding="0">
       			<tr>
        			<td height="78" align="center" valign="bottom" background="images/regin1.gif">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				          	<tr>
					            <td width="23%" height="40" align="center" class="blue4"><s:text name="RES_REGISTER_STEP1" ></s:text></td>
					            <td width="59%" align="center" class="black5"><s:text name="RES_REGISTER_STEP2" ></s:text></td>
					            <td width="18%" align="center" class="black5"><s:text name="RES_REGISTER_STEP3" ></s:text></td>
				          	</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td height="467" align="center" valign="top" background="images/regin3.gif">
        				<table width="760" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="53" align="left" class="blue2"><s:text name="RES_REGISTER_AGREEMENT"></s:text></td>
          					</tr>
          					<tr>
            					<td>
					               	<%
					               		String langs="en_US";
					 		  			if(session.getAttribute("WW_TRANS_I18N_LOCALE")!=null){
					 		  				langs=session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
					 		  			}
									%>
            						<iframe src="regAgreement/agreement_<%=langs%>.txt" MARGINHEIGHT="5" MARGINWIDTH="5"  width="760" height="200" vspace="1"></iframe>
            					</td>
          					</tr>
          					<tr>
            					<td height="40">
            						<table width="80%" border="0" cellspacing="0" cellpadding="0">
					              	<tr>
						                <td width="7%" align="center"><input type="checkbox"  onclick="changeAgree(this.checked)" id="accept"/></td>
						                <td width="93%" align="left" class="white"><span class="black2"><s:text name="RES_REGISTER_AGREE"></s:text></span></td>
					                </tr>
            						</table>
            					</td>
          					</tr>
          					<tr>
            					<td height="80">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
              							<tr>
							                <td align="left"><input type="button" class="button2" value="<s:text name="RES_REGISTER_CANCELTEXT"></s:text>" onclick="location.href='index.action'" style="cursor:pointer"/></td>
							                <td align="right"><input type="button" class="button2ex" id="agreeBon" disabled="true" value="<s:text name="RES_REGISTER_AGREETEXT" ></s:text>" onclick="location.href='register2step.action'" style="cursor:pointer" /></td>
              							</tr>
            						</table>
            					</td>
          					</tr>
        				</table>
        			</td>
      			</tr>
      			<tr>
        			<td height="12"><img src="images/regin2.gif" width="921" height="12" /></td>
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
