<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confInv.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	
	<script type="text/javascript">
		<s:if test="#session.userMenu.inv==0">
	    	location.href="index.action";
	    </s:if>
  		$(document).ready(function() {
			confPmu.init();
		});
		document.onkeydown = function(e) {   
    	var theEvent = e || window.event;   
    	var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
    	var listno = $("#listno").val();
		var stationName = $("#stationName").val();
    	if (code == 13) {   
       		var ipg=$('#inputpage').val();
       		if (ipg==""){
           		//请输入整数 
	       		alert(RES.NEED_NUMBER);
	       		return false;
       		}
	       	if(!isNaN(ipg)){
	       		$('#page').val(ipg+'');
		       	if(parseInt(ipg)>parseInt($('#allPage').val())){
			       	//输入数值过大 
		       		alert(RES.INPUT_TOOLARGE);
		       		return false;
		       	}
	       	}else{
				$('#page').val('1');
			}
			$("#searchForm").submit();	
	    }   
	    return true;
    }
  	</script>
  </head>
<style>
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
height: 30px !important;
border: 0px solid ;
width:121px;
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
height: 30px !important;
border: 0px solid ;
width:63px;
}
-->
</style>
<body >

<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
         <script>
       menuOver('adminMenu',22);
        </script>
  </tr>
  <tr>
  <tr>
    <td align="center" bgcolor="#E5EFF9">
    <table border="0" cellspacing="10" cellpadding="0">
    
      <form action="" method="post" id="searchForm" name="searchForm">
      <tr>
        <td align="center">
        
      <input type="hidden" name="allPage" value="<s:property value="allPage" />" id="allPage">
      <input type="hidden" name="page" value="<s:property value="page" />" id="page">
        <table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="64" align="center" background="images/list_bg3.gif">
            <table width="93%" border="0" cellspacing="0" cellpadding="0">
                <tr>
               <td width="74" align="center" class="black2"><div align="right"><s:text name="RES_ETYPE"/></div></td>
                  <td width="153" align="center">
                  
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
				  </td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
				  <td width="92" align="center" class="black2"><div align="right"><s:text name="RES_STATIONNAME"/></div></td>
                  <td width="135" align="center">
                 <input name="stationName" type="text" class="test_input8" id="stationName" size="6" value="<s:property value="stationName" />" />
                 </td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="104" align="center" class="black2"><div align="right"><s:text name="RES_SERIALNUMBER"/></div></td>
                  <td width="154" align="center"><input name="listno" type="text" class="test_input8" id="listno" size="6" value="<s:property value="listno" />" /></td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="117" align="center"><img src="images/list18.gif" width="63" height="28" id="searchImg" style="cursor:pointer"/></td>
                </tr>
            </table>
            
     
            </td> </form>
          </tr>
          <tr>
            <td height="5">&nbsp;</td>
          </tr>
          <tr>
            <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><table width="896" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="10">&nbsp;</td>
                      <td width="93" align="center" valign="middle" background="images/listbg25_1.gif" class="white3"><s:text name="RES_CONF_LIST"/></td>
                      <td width="4">&nbsp;</td>
                      <td width="93" align="center" valign="middle" background="images/listbg25.gif" class="white3" onclick="location.href='confInvManager.action'" style="cursor:pointer"><s:text name="RES_CONF_STATISTICS"/></td>
                      <td width="93" background="images/list9.gif">&nbsp;</td>
                      <td align="right" valign="top"><table width="15%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><img src="images/list15.gif" width="38" height="33" style="cursor:pointer" onclick="downInvCsv()"/></td>
                            <td align="center"><img src="images/list16.gif" width="38" height="33"  style="cursor:pointer" onclick="downInvTxt()"/></td>
                          </tr>
                      </table></td>
                      <td width="10">&nbsp;</td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="34" align="center" background="images/list_bg4.gif">
					  <table width="894" border="0" cellspacing="0" cellpadding="0">
	                      <tr>
	                        <td width="93" height="30" align="center" class="black"></td>
	                        <td width="164" align="center" class="black"><s:text name="RES_SERIALNUMBER"/></td>
	                        <td width="100" align="center" class="black"><s:text name="RES_ETYPE"/></td>
	                        <td width="100" align="center" class="black"><s:text name="RES_CONF_FACTORY"/></td>
	                        <td width="100" align="center" class="black"><s:text name="RES_CONF_PINPAI"/></td>
	                        <td width="156" align="center" class="black"><s:text name="RES_CONF_STATION"/></td>
	                        <td width="100" align="center" class="black"><s:text name="RES_CITY"/></td>
	                        <td width="80" align="center" class="black"><s:text name="RES_ATTRIBUTE"/></td>
	                        <td width="100" align="center" class="black"><s:text name="RES_CONF_DOWNLOADDATA"/></td>
	                      </tr>
	                  </table>
                  </td>
                </tr>
                <tr>
                  <td align="center" background="images/list_bg6.gif">
                  <table width="894" border="0" cellspacing="0" cellpadding="0">
                   <s:iterator id="pum" value="invListEx" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
                     
                        <td width="93" height="36" align="center" class="black2">
	                        <s:if test="#pum.state==1">
	                        	<img src="images/dev1.gif"  />
	                        </s:if>
	                        <s:elseif test="#pum.state==0">
	                        	<img src="images/dev1_2.gif"  />
	                        </s:elseif>
                        </td>
                        <td width="164" align="center" class="black2"><s:property value="#pum.psno" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#pum.invtype" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#pum.factoryname" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#pum.penpai" /></td>
                        <td width="156" align="center" class="black2"><s:property value="#pum.stationname" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#pum.city" /></td>
                        <td width="80" align="center" class="black2"><a href="javascript:confPmuView.init('<s:property value="#pum.psno" />')"><s:text name="RES_CONF_VIEW"/></a></td>
                      	<td width="100" align="center" class="black2">
						<image src="images/downloaddata.gif" onclick="downDevInfo('<s:property value="#pum.psno" />','<s:property value="nowDay" />')" style="cursor:pointer">
                          
						</td>
                      </tr>
                       </s:iterator> 
                  </table></td>
                </tr>
                <tr>
                  <td height="34" align="right" background="images/list_bg5.gif"><table width="20%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="center"><img src="images/dz_list8.gif" width="17" height="19" id="firstP" style="cursor:pointer" /></td>
                        <td align="center"><img src="images/dz_list10.gif" width="19" height="19" id="preP" style="cursor:pointer" /></td>
                        <td align="center"><input name="inputpage" type="text" class="test_input4" id="inputpage" value="<s:property value="page" />/<s:property value="allPage" />" size="6" /></td>
                        <td align="center"><img src="images/dz_list11.gif" width="19" height="19" id="nextP" style="cursor:pointer" /></td>
                        <td align="center"><img src="images/dz_list9.gif" width="17" height="19" id="lastP" style="cursor:pointer" /></td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
         
        </table></td>
      </tr>
    </table>
    <p>&nbsp;</p></td>
  </tr>
  
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>
  <form action="plantInvDownload" name="downForm" target="hiddenFrame" method="post">
	  <input type="hidden" name="lsno" value="">
	  <input type="hidden" name="startdt" value="">
	  <input type="hidden" name="enddt" value="">
	  <input type="hidden" name="tp" value="">
  </form>
    <form action="invDownload" name="downInvForm" target="hiddenFrame" method="post">
	  <input type="hidden" name="lsno" value="">
	  <input type="hidden" name="stationName" value="">
	  <input type="hidden" name="model" value="">
	  <input type="hidden" name="tp" value="">
  </form>
<iframe id="hiddenFrame"  name="hiddenFrame"  MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>

</body>
</html>
