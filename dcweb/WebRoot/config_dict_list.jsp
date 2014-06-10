<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confDict.js"></script>
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
    if (code == 13) {   
    
       var ipg=$('#inputpage').val();
       if (ipg=="")
       {
       	alert(RES.NEED_NUMBER)
       	return false;
       }
       if(!isNaN(ipg)){ 
       	$('#page').val(ipg+'');
	       if(parseInt(ipg)>parseInt($('#allPage').val())){
	       		alert(RES.INPUT_TOOLARGE)
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
       menuOver('adminMenu',25);
        </script>
  </tr>
  <tr>
    <td align="center" bgcolor="#E5EFF9">
    <table border="0" cellspacing="10" cellpadding="0">
    
      <form action="" method="get" id="searchForm" name="searchForm">
      <tr>
        <td align="center">
        
      <input type="hidden" name="allPage" value="<s:property value="allPage" />" id="allPage">
      <input type="hidden" name="page" value="<s:property value="page" />" id="page">
        <table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="64" align="center" background="images/list_bg3.gif">
            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                <tr>
               <td width="118" align="center" class="black2"><div align="right">参数段</div></td>
                  <td width="153" align="center">
                  
                  <s:set name="sb" value="subtag" />
					<select name="subtag" id="subtag" class="test_input14" >
	               		
	                  <option value="">All</option>
	                  <s:iterator id="sb1" value="subTagList" status="em">
	                 	 <s:if test='#sb==#sb1.subtag'>
 						<option value="<s:property value="#sb1.subtag" />" selected="selected"><s:property value="#sb1.subtag" /></option>
 					</s:if>
 					<s:else>
 						<option value="<s:property value="#sb1.subtag" />"><s:property value="#sb1.subtag" /></option>
 					</s:else>
			         </s:iterator>
			         
			         </select>
				  </td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
				  <td width="92" align="center" class="black2"><div align="right">语种</div></td>
                  <td width="135" align="center">
                 <s:set name="ln" value="lan" />
					<select name="lan" id="lan" class="test_input14" >
	               		
	                  <option value="">All</option>
	                  <s:iterator id="ln1" value="lang" status="em">
	                 <s:if test='#ln==#ln1.lang'>
 						<option value="<s:property value="#ln1.lang" />" selected="selected"><s:property value="#ln1.lang" /></option>
 					</s:if>
 					<s:else>
 						<option value="<s:property value="#ln1.lang" />"><s:property value="#ln1.lang" /></option>
 					</s:else>
			         </s:iterator>
			         </select>
                 </td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="90" align="center" class="black2"><div align="right">val1</div></td>
                  <td width="135" align="center">
                 <input name="Val1" type="text" class="test_input8" id="Val1" size="6" value="<s:property value="Val1" />" />
                 </td>
                 <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="90" align="center" class="black2"><div align="right">val2</div></td>
                  <td width="135" align="center">
                 <input name="val2" type="text" class="test_input8" id="val2" size="6" value="<s:property value="val2" />" />
                 </td>
                 <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="104" align="center" class="black2"><div align="right">文本</div></td>
                  <td width="140" align="center"><input name="content" type="text" class="test_input8" id="content" size="6" value="<s:property value="content" />" /></td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="1" align="center"><img src="images/list19.gif" width="1" height="51" /></td>
                  <td width="117" align="center"><img src="images/list18.gif" width="63" height="28" id="searchImg" style="cursor:pointer"/></td>
                </tr>
            </table>
            
     
            </td> </form>
          </tr>
          <tr>
                  <td><table width="896" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="10">&nbsp;</td>
                       <td align="right" valign="top">
                       <table width="38" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><img src="images/pmuAdd.gif" width="38" height="33" style="cursor:pointer" onclick="addDict()"/></td>
                           </tr>
                      </table></td>
                      <td width="10">&nbsp;</td>
                    </tr>
                  </table></td>
                </tr>
          <tr>
            <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
               
                <tr>
                  <td height="34" align="center" background="images/list_bg4.gif">
				  <table width="894" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        
                        <td width="164" align="center" class="black">参数段</td>
                        <td width="100" align="center" class="black">语种</td>
                        <td width="100" align="center" class="black">val1</td>
                        <td width="100" align="center" class="black">val2</td>
                        <td width="156" align="center" class="black">文本</td>
                        <td width="100" align="center" class="black">操作</td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td align="center" background="images/list_bg6.gif"><table width="894" border="0" cellspacing="0" cellpadding="0">
                   <s:iterator id="param" value="paramList" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
                     
                        
                        <td width="164" align="center" class="black2"><s:property value="#param.subtag" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#param.lang" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#param.val1" /></td>
                        <td width="100" align="center" class="black2"><s:property value="#param.val2" /></td>
                        <td width="156" align="center" class="black2"><s:property value="#param.context" /></td>
                        <td width="100" align="center" class="black2"><a href="javascript:updateDict('<s:property value="#param.subtag" />','<s:property value="#param.lang" />','<s:property value="#param.val1" />','<s:property value="#param.val2" />','<s:property value="#param.context" />')">编辑</a>      <a href="javascript:removeDict('<s:property value="#param.subtag" />','<s:property value="#param.lang" />','<s:property value="#param.val1" />','<s:property value="#param.val2" />')">删除</a></td>
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
