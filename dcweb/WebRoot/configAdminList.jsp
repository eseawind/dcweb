<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/inner.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/confAdminStation.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/iphoto_flash.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/swfobject.js"></script>
  	  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confAdmin.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
  	<script type="text/javascript">
  	function showAddPmu(){
 var iWidth=500; //弹出窗口的宽度;
 var iHeight=200; //弹出窗口的高度;
 var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
 var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
 var showAddPmu=showModalDialog('addConfig.action?'+Math.random(),'showAddPmu','dialogWidth:'+iWidth+'px;dialogHeight:'+iHeight+'px;dialogLeft:'+iLeft+'px;dialogTop:'+iTop+'px;center:yes;help:no;resizable:no;status:no')
} 
     
  	function  editConfig(this){
    var td =$(this).parent();
    var html=td.val();
    var html1=td.html();
    alert(td.val());
    

}
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
       if(!isNaN(ipg))
        {
        
       	$('#pageNo').val(ipg+'');
	       if(parseInt(ipg)>parseInt($('#allPage').val()))
	        {
	       	alert(RES.INPUT_TOOLARGE)
	       	return false;
	       }
       }
       else{
       $('#pageNo').val('1');
       }
        
        $("#searchForm").submit();	
    }   
    return true;
    }
    </script>
  	<script type="text/javascript">
  	   $(document).ready(function(){
  	       var listtr=$("#selecttr").find("tr").find("td").find("a");
  	      listtr.click(function(){
  	         var tem=$(this);
  	         alert(tem);
  	      });
  	       });
  	   });
  	</script >
  	
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>
<style type="text/css">
<!--
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px
}
.STYLE3 {color: #CCCCCC; font-weight: bold; font-size: 16px}
.button2 {

	font-family: Tahoma, Verdana;
	font-size: 14px;
	font-weight: bold;
padding: 0 5px;
color: #ffffff;
background-image: url("images/buttom_bg4.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 28px !important;
border: 0px solid ;
width:63px;
}
-->
</style>
<script>
 function changeCountry(cid){
	
		hiddenFrame.location.href="stateList.action?countryId="+cid;
	
}
function queryConfig(){
       var subtag=$("#subtag1").val();
       var language=$("#langua1").val();
       var val1=$("#val1").val();
       var val2=$("#val2").val();
       var context=$("#context1").val();
       location.href="stateList.action?subtag="+subtag+"&language="+language+"&val1="+val1+"&val2="+val2+"&context="+context;
}

</script>
<script >

      
</script>
</head>
<body>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td colspan="2">
        <%@include file="HeadConfig.jsp" %>    </td>
  </tr>
   <tr>
  <td height="30" align="center" bgcolor="#E2F0FA" colspan="2">
  
      <table width="960" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <s:if test="#session.defaultStation==0">
      <td width="60" height="30" align="center"></td>
      <td width="715">
      </s:if>
    <s:else>
     <td width="538" height="30" align="center"></td>
      <td width="715">
    </s:else>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td width="6" height="30" align="center" class="white3">&nbsp;</td>
          <s:if test="#session.userMenu.station==1">
          <td width="1" bgcolor="#FFFFFF"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="blue"  style="cursor:pointer" id="menu17"><s:text name="RES_CONFIG_ADMINSTTAIONLIST"/></td>
          </s:if>
          <s:if test="#session.userMenu.dev==1">
          <td width="1" bgcolor="#FFFFFF"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='equip_view.action'" style="cursor:pointer" id="menu17"><s:text name="RES_EQUIPMENTOVERVIEW"/></td>
          </s:if>
          <s:if test="#session.userMenu.report==1">
          <td width="1" bgcolor="#FFFFFF"></td>
          <td width="96" align="center" bgcolor="#7A7E98"  class="white3"   onclick="location.href='reportDayShow.action'" style="cursor:pointer" id="menu12"> <s:text name="RES_CONFIG_REPORT"/></td>
          </s:if>
          <s:if test="#session.userMenu.plant==1">
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='showStationModify.action'" style="cursor:pointer"  id="menu13"><s:text name="RES_CONFIG_STATION"/></td>
          </s:if>
          <s:if test="#session.userMenu.admin==1">
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='accountList.action'" style="cursor:pointer" id="menu18"><s:text name="RES_CONFIG_ADMIN"/></td>
          </s:if>
          <s:if test="#session.userMenu.pmu==1">
          <td width="1" align="center" bgcolor="#ffffff" ></td>
           <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='confPmuList.action'" style="cursor:pointer" id="menu14"><s:text name="RES_CONFIG_PUM"/></td>
          </s:if>
          <s:if test="#session.userMenu.inv==1">
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='confInvList.action'" style="cursor:pointer" style="cursor:pointer" id="menu14"><s:text name="RES_CONFIG_INV"/></td>
		  </s:if>
		  <s:if test="#session.userMenu.share==1">
		  <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='shareAccountList.action'" style="cursor:pointer" id="menu14"><s:text name="RES_CONFIG_SHARE"/></td>
          </s:if>
          <s:if test="#session.userMenu.user==1">
		  <td width="1" align="center" bgcolor="#ffffff" ></td>
           <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='accountManagerList.action'" style="cursor:pointer" id="menu14"><s:text name="RES_CONFIG_ACCOUNT"/></td>
          </s:if>         
          <s:if test="#session.userMenu.event==1">
		  <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='sysqueryevent.action'" style="cursor:pointer" id="menu14"><s:text name="RES_CONFIG_EVENT"/></td>
          </s:if>
          </tr>
      </table></td>
    </tr>
  </table>
      </td>
    </tr>
  <tr>
    <td  align="center" bgcolor="#E5EFF9">
    <form action="" method="post" id="searchForm" name="searchForm">
    <input type="hidden" name="pageNo" id="pageNo" value="<s:property value="pageNo" />">
    <input type="hidden" name="totalPage" id="totalPage" value="<s:property value="totalPage" />">
    <table border="0" cellspacing="18" cellpadding="0">
      <tr>
        <td width="896" height="64" align="center" background="images/list_bg3.gif">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="13%" align="right" class="black4">参数段：</td>
            <td width="13%" align="center">
            <select name="countryId" id="subtag1" class="test_input7" >
                <option value="0">All</option>
                <s:iterator id="lange" value="#session.subtag" >
                            <option value="<s:property value='subtag'/> " selected="selected"><s:property value='subtag'/></option>
                               
                        </s:iterator>
                  </select></td>
            <td width="10%" align="right" class="black4">语言：</td>
            <td width="13%" align="center"><select name="language1" id="language1" class="test_input7" >
              <option value="">All</option>
            	 <s:iterator id="lange" value="#session.language" >
                            <option value="<s:property value='language'/> " selected="selected"><s:property value='language'/></option>
                               
                        </s:iterator>
                 
                
		         
	     		
	     		 
	     		
                </select></td>
            <td width="10%" align="right" class="black4">Val1:</td>
            <td width="8%" align="center"><input name="stationName" type="text" class="test_input7" id="val1" value="<s:property value="stationName" />"/></td>
            <td width="10%" align="right" class="black4">Val2:</td>
            <td width="8%" align="center"><input name="account" type="text" class="test_input7" id="val2" value="<s:property value="account" />"/></td>
             <td width="11%" align="right" class="black4">文本：:</td>
            <td width="14%" align="center"><input name="account" type="text" class="test_input7" id="context1" value="<s:property value="account" />"/></td>
            <td width="7%"><input type="button" value="<s:text name="RES_QUERY"/>" class="button2" id="searchImg" style="cursor:pointer" onclick="javascript:queryConfig()"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="121" align="center">
        <table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="34" align="center" background="images/list_bg4.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0">
              <tr>
               
                <td width="130" align="left" class="black">参数段</td>
                <td width="85" align="left" class="black">语言</td>
                <td width="85" align="left" class="black">val1</td>
                <td width="90" align="left" class="black">val2</td>
                <td width="90" align="left" class="black">文版</td>
                <td width="110" align="center" class="black">删除</td>
                <td width="111" align="left" class="black">修改</td>
               
              </tr>
              
            </table></td>
          </tr>
          <tr>
            <td align="center" background="images/list_bg6.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0" id="selecttr">
              <s:iterator id="al" value="#session.adminList" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
               
                <td width="134" align="left" class="black2"><s:property value="#al.context" /></td>
                <td width="94" align="left" class="black2"><s:property value="#al.language" /></td>
                <td width="94" align="left" class="black2"><s:property value="#al.subtag" /></td>
                <td width="94" align="left" class="black2"><s:property value="#al.val1" /></td>
                <td width="100" align="left" class="black2"><s:property value="#al.val2" /></td>
                <td width="74" align="center" class="black2"><img onclick="deleteConfig(<s:property value="#al.val2" />)" style="cursor:pointer" id="" src="images/remove.gif"></td>
                <td width="74" align="center" class="black2"><a >修改</a></td>
              </tr>
             </s:iterator> 
            <tr> <td width="200" height="45" align="center" class="black2"><img width="38" height="33" onclick="showAddPmu()" style="cursor:pointer" src="images/pmuAdd.gif"></td></tr>
            </table></td>
          </tr>
          <tr>
            <td height="34" align="right" background="images/list_bg5.gif"><table width="20%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><img src="images/dz_list8.gif" width="17" height="19" id="firstP" style="cursor:pointer" /></td>
                        <td align="center"><img src="images/dz_list10.gif" width="19" height="19" id="preP" style="cursor:pointer" /></td>
                        <td align="center"><input name="inputpage" type="text" class="test_input4" id="inputpage" value="<s:property value="pageNo" />/<s:property value="totalPage" />" size="6" /></td>
                        <td align="center"><img src="images/dz_list11.gif" width="19" height="19" id="nextP" style="cursor:pointer" /></td>
                        <td align="center"><img src="images/dz_list9.gif" width="17" height="19" id="lastP" style="cursor:pointer" /></td>
                        <td>&nbsp;</td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      
    </table>
    </form>
    </td>
  </tr>
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>
		<div id="showbox" style="display:none" >
			<table>
				<tr>
					<td ></td>
				</tr>
				<tr>
					<td>
						<table>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
</body>
</html>
