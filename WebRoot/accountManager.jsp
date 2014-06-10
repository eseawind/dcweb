
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  	<head>
		<%@ include file="meta.jsp" %>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
	  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
	    	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confAccountManager.js"></script>
	  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
	  	<link href="./skins/blue.css" rel="stylesheet" />
	
		<script src="./js/artDialog.min.js"></script>
		<script type="text/javascript">
			<s:if test="#session.userMenu.user==0">
	    		location.href="index.action";
	    	</s:if>
	
	  		$(document).ready(function() {
				confAccountManager.init();
			});
			
			document.onkeydown = function(e){   
	    		var theEvent = e || window.event;   
	    		var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
	    		if(code == 13){   
	       			var ipg=$('#inputpage').val();
	       			if(ipg==""){
	       				alert(RES.NEED_NUMBER);
	       				return false;
	       			}
	       			if(!isNaN(ipg)){
	       				$('#page').val(ipg+'');
			       		if(parseInt(ipg)>parseInt($('#allPage').val())){
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
	  	<script type="text/javascript">
	  		function changeCountry(cid){
				hiddenFrame.location.href="stateList.action?countryId="+cid;
			}
			
			function changesUserId(uid){
				$("#changeUserId").val(uid);
				searchForm.action="powerlist.action";
				searchForm.submit();
			}
			
	 		function viewAccount(account){
		  		var iWidth=800;		//弹出窗口的宽度;
		  		var iHeight=530;    //弹出窗口的高度;
		  		var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
		  		var iLeft = (window.screen.availWidth-10-iWidth)/2;        //获得窗口的水平位置;
		  		var viewAccount=showModalDialog('viewAccountConfig.action?email='+account+'&'+Math.random(),'viewAccount','dialogWidth:'+iWidth+'px;dialogHeight:'+iHeight+'px;dialogLeft:'+iLeft+'px;dialogTop:'+iTop+'px;center:yes;help:no;resizable:no;status:no')
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
		.tablelimit { 
			table-layout: fixed;
			word-wrap:break-word;
		}
		.button1 {
			font: 14px Tahoma, Verdana;
			padding: 0 5px;
			color: #D3E0E7;
			background-image: url("images/regin17_bg.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 30px !important;
			border: 0px solid ;
			height: 30px;
			width:152px;
		}
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
        <%@include file="HeadMenu.jsp" %>   
        <script>
        menuOver('adminMenu',23);
        </script>
         </td>
  </tr>
  <s:if test="#session.userMenu.user==1">
  
  <tr>
    <td align="center" bgcolor="#E5EFF9">
     <form action="" method="post" id="searchForm" name="searchForm">
     <input type="hidden" name="changeUserId" id="changeUserId">
    <input type="hidden" name="page" id="page" value="<s:property value="page" />">
    <input type="hidden" name="totalPage" id="totalPage" value="<s:property value="allPage" />">
  
    <table border="0" cellspacing="18" cellpadding="0">
      <tr>
        <td width="896" height="65" align="center" background="images/list_bg3.gif">
		  <table width="840" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="1" align="center"></td>
            <td width="192" align="center" class="black2">邮箱              
              <input name="email" type="text" class="test_input12" id="email" size="6" value="<s:property value="email" />"/></td>
            <td width="192" align="center" class="black2">姓
              <input name="firstName" type="text" class="test_input50" id="firstName" size="6" value="<s:property value="firstName" />"/>
              名
              <input name="secondName" type="text" class="test_input50" id="secondName" size="6" value="<s:property value="secondName" />"/></td>
            <td width="192" align="center" class="black2">电话
              <input name="tel" type="text" class="test_input12" id="tel" size="6" value="<s:property value="tel" />"/></td>
            <td width="192" align="center" class="black2">手机
              <input name="mobile" type="text" class="test_input12" id="mobile" size="6" value="<s:property value="mobile" />"/></td>
            <td width="72" rowspan="2" align="center"><img src="images/list18.gif" width="63" height="28" id="searchImg"  style="cursor:pointer"/></td>
          </tr>
		   <tr>
            <td width="1" align="center"></td>
            <td width="192"  class="black6" hight="30">国家
              <select name="country" id="country" class="test_input15" onchange="changeCountry(this.value)">
                <option value="0">All</option>
                <s:set name="cou" value="country" />
                 <s:iterator id="country" status="ss" value="countryList">
                 <s:if test='#cou==#country.c_code'>
		         <option value="<s:property value="#country.c_code" />" selected="selected"><s:property value="countryname" /></option>
	     		 </s:if>
	     		 <s:else>
	     		 <option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
	     		 </s:else>
	     		</s:iterator>
                </select></td>
            <td width="192" align="center" class="black2">州/省
              <select name="state" id="state" class="test_input15" >
              <option value="0">All</option>
            	<s:set name="sst" value="state" />
                 <s:iterator id="st" status="ss" value="stateList">
                 <s:if test='#sst==#st.c_code'>
		         <option value="<s:property value="#st.c_code" />" selected="selected"><s:property value="countryname" /></option>
	     		 </s:if>
	     		 <s:else>
	     		 <option value="<s:property value="#st.c_code" />"><s:property value="countryname" /></option>
	     		 </s:else>
	     		</s:iterator>
                </select></td>
            <td width="192" align="center" class="black2">              城市
              <input name="city" type="text" class="test_input12" id="city" value="<s:property value="city" />"/>
            </td>
            <td width="192" align="center" class="black2">公司
              <input name="company" type="text" class="test_input12" id="company" value="<s:property value="company" />"/></td>
            </tr>
        </table></td>
      </tr>

      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="34" align="center" background="images/list_bg4.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="180" height="30" align="left" class="black">邮箱</td>
                <td width="84" align="center" class="black">注册时间</td>
                <td width="60" align="center" class="black">姓</td>
                <td width="90" align="center" class="black">名</td>
                <td width="90" align="center" class="black">国家</td>
                <td width="90" align="center" class="black">州/省</td>
                <td width="90" align="center" class="black">城市</td>
                <td width="60" align="center" class="black">激活状态</td>
                <td width="90" align="center" class="black">公司</td>
                <td width="60" align="center" class="black">操作</td>
                </tr>
              
            </table></td>
          </tr>
          <tr>
            <td align="center" background="images/list_bg6.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0" class="tablelimit">
                 <s:iterator id="st" value="accountList" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
                  <td width="180" height="36" align="left" class="black2"><s:property value="#st.account" /></td>
                  <td width="84" align="center" class="black2"><s:property value="#st.createdt" /></td>
                  <td width="60" align="center" class="black2"><s:property value="#st.firstname" /></td>
                  <td width="90" align="center" class="black2"><s:property value="#st.secondname" /></td>
                  <td width="90" align="center" class="black2"><s:property value="#st.country" /></td>
                  <td width="90" align="center" class="black2"><s:property value="#st.province" /></td>
                  <td width="90" align="center" class="black2"><s:property value="#st.city" /></td>
                  <td width="60" align="center" class="black2">
                  	<s:if test="#st.active==1">
                  	Yes
                  	</s:if>
                  	<s:if test="#st.active==0">
                  	<input type="button" value="激活" onclick="activeAccount(<s:property value="#st.userid" />)">
                  	</s:if>
                  </td>
                  <td width="90" align="center" class="black2"><s:property value="#st.company" /></td>
                  <td width="60" align="center" class="black2"><a href="javascript:changesUserId(<s:property value="#st.userid" />)">进入</a>   <a href="javascript:viewAccount('<s:property value="#st.account" />')">详细</a></td>
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
    </table>
    </form>
    </td>
  </tr>
  </s:if>
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table><iframe id="hiddenFrame" src="" MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>

</body>
</html>
