<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confAdmin.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
	<s:if test="#session.userMenu.admin==0">
    
    	location.href="index.action";
    </s:if>
  		$(document).ready(function() {
			confAdmin.init();
			
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
background-image: url("images/buttom_bg4.gif");
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
-->
</style>
<body >

<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
         <script>
       menuOver('adminMenu',20);
        </script>
  </tr>
  <s:if test="#session.userMenu.admin==1">
  
  <tr>
    <td align="center" bgcolor="#E5EFF9">
    <table height="300" border="0" cellspacing="10" cellpadding="0">
    
      
          <tr>
            <td height="5">&nbsp;</td>
          </tr>
          <tr>
            <td align="center">
            <table width="896" border="0" cellspacing="0" cellpadding="0">
               
                <tr>
                  <td height="34" align="center" background="images/list_bg4.gif">
				  <table width="894" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="200" height="30" align="center" class="black"><s:text name="RES_CONF_ADMIN_ACCOUNT"/></td>
                        <td width="50" align="center" class="black"><s:text name="RES_FRISTNAME"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_SECONDNAME"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_CONF_ADMIN_UPDATET"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_CONF_ADMIN_PLANTT"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_CONF_ADMIN_USERT"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_EQUIPMENTOVERVIEW"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_CONFIG_EVENT"/></td>
                        <td width="70" align="center" class="black"><s:text name="RES_ESTATUS"/></td>
                        <td width="84" align="center" class="black"></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td align="center" background="images/list_bg6.gif"><table width="894" border="0" cellspacing="0" cellpadding="0">
                   <s:iterator id="acc" value="accountList" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
                     
                        <td width="200" height="45" align="center" class="black2"><s:property value="#acc.account" /></td>
                        <td width="50" align="center" class="black2"><s:property value="#acc.firstname" /></td>
                        <td width="70" align="center" class="black2"><s:property value="#acc.secondname" /></td>
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.updatet==0">
                        	<input type="checkbox" name="checkbox" value="checkbox"  onclick="updateAcc('<s:property value="#acc.account" />',this,'<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:if>
                        <s:elseif test="#acc.updatet==1">
                            <input type="checkbox" name="checkbox" value="checkbox"  checked onclick="updateAcc('<s:property value="#acc.account" />',this,'<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:elseif>
                        
                        </td>
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.plantt==0">
                        	<input type="checkbox" name="checkbox" value="checkbox"  onclick="plantAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />',this,'<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:if>
                        <s:elseif test="#acc.plantt==1">
                            <input type="checkbox" name="checkbox" value="checkbox"  checked onclick="plantAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />',this,'<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:elseif>
                        </td>
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.usert==0">
                        	<input type="checkbox" name="checkbox" value="checkbox"  onclick="userAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />',this,'<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:if>
                        <s:elseif test="#acc.usert==1">
                            <input type="checkbox" name="checkbox" value="checkbox"  checked onclick="userAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />',this,'<s:property value="#acc.devt" />','<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:elseif>
                        </td>
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.devt==0">
                        	<input type="checkbox" name="checkbox" value="checkbox"  onclick="devAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />',this,'<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:if>
                        <s:elseif test="#acc.devt==1">
                            <input type="checkbox" name="checkbox" value="checkbox"  checked onclick="devAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />',this,'<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:elseif>
                        </td>
                        
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.eventt==0">
                        	<input type="checkbox" name="checkbox" value="checkbox"  onclick="eventAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.devt" />','<s:property value="#acc.usert" />',this,'<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:if>
                        <s:elseif test="#acc.eventt==1">
                            <input type="checkbox" name="checkbox" value="checkbox"  checked onclick="eventAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.devt" />','<s:property value="#acc.usert" />',this,'<s:property value="#acc.state" />','<s:property value="#acc.eventt" />')"/>
                        </s:elseif>
                        </td>
                        <td width="70" align="center" class="black2">
                        <s:if test="#acc.state==1">
                        	<img src="images/unlock.gif"  id="" style="cursor:pointer" onclick="lockAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.eventt" />',this)"/>
                        </s:if>
                        <s:elseif test="#acc.state==2">
                            <img src="images/lock.gif"  id="" style="cursor:pointer" onclick="unlockAcc('<s:property value="#acc.account" />','<s:property value="#acc.updatet" />','<s:property value="#acc.plantt" />','<s:property value="#acc.usert" />','<s:property value="#acc.devt" />','<s:property value="#acc.eventt" />',this)"/>
                        </s:elseif>
                        </td>
                        <td width="84" align="left" class="black2"><img src="images/remove.gif"  id="" style="cursor:pointer" onclick="removeAcc('<s:property value="#acc.account" />')"/></td>
                      </tr>
                       </s:iterator> 
                  </table></td>
                </tr>
                <tr>
                  <td align="center" background="images/listbg30.gif">
                  <table width="894" border="0" cellspacing="0" cellpadding="0">
                  
						<tr >
                     
                        <td width="200" height="45" align="center" class="black2"><img src="images/accountAdd.gif"  id="" style="cursor:pointer" onclick="addAccount()"/></td>
                        <td width="134" align="center" class="black2">
                        
                        <td width="100" align="left" class="black2"></td>
                      </tr>
                     
                  </table></td>
                </tr>
                <tr>
                  <td height="34" align="right" background="images/list_bg5.gif"></td>
                </tr>
            </table></td>
          </tr>
         
        </table></td>
      </tr>
  </s:if>
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>
</body>
</html>
