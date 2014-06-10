
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
    	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confFindEvent.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
  		//js获取当前日期，格式化成xxxx-xx-xx的格式(根据情况补零)  
  		var date = new Date();
  		var year = 0;
  		var month = 0;
  		var day = 0;
  		var clientdate = "";
  		year = date.getFullYear();
  		month = date.getMonth()+1;
  		day = date.getDate();
  		clientdate = year+"-";
  		if(month>=10)
  		{
  			clientdate += month+"-";
  	  	}
  		else
  		{
  			clientdate += "0"+month+"-";
  		}
  		if(day>=10)
  		{
  			clientdate += day;
  		}
  		else
  		{
  			clientdate += "0"+day;
  		}
  		$.post("client_date.action",{"clientdate":clientdate});
  	</script>
	<script type="text/javascript">
  		$(document).ready(function() {
			confFindEvent.init();
			initDevModel();
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
       if(!isNaN(ipg))
        {
        
       	$('#page').val(ipg+'');
	       if(parseInt(ipg)>parseInt($('#allPage').val()))
	        {
	       	alert(RES.INPUT_TOOLARGE)
	       	return false;
	       }
       }
       else{
       	$('#page').val('1');
       }
       
        
        $("#searchForm").submit();	
    }   
    return true;
    }
    
    function downCsv(){
    
	downForm.msgtype.value=$('#msgtype').val();
	downForm.status.value=$('#status').val();
	downForm.desc.value=$('#desc').val();
	downForm.countryId.value=$('#countryId').val();
	downForm.stationName.value=$('#stationName').val();
	downForm.devtype.value=$('#devtype').val();
	downForm.startDt.value=$('#startDt').val();
	downForm.endDt.value=$('#endDt').val();
	downForm.listno.value=$('#listno').val();
	downForm.devmodel.value=$('#devmodel').val();
	
	downForm.submit();
	
}

function changeDev(dev){

dev=parseInt(dev);
var modelobj=document.getElementById("devmodel");
for (var i = modelobj.options.length-1; i >=1; i--) {        
                modelobj.options.remove(i);     
        } 
	if (dev==-1){
		devmodel.value="-1";
	}
	else{
	
		   
		if (dev==1){
		
			for (var i=0;i<pumtypelist.length;i++){
			var varItem = new Option(pumtypelist[i],pumtypelist[i]);      
        	modelobj.options.add(varItem);  
			}
		}else if (dev==2){
		
			for (var i=0;i<invtypelist.length;i++){
			var varItem = new Option(invtypelist[i],invtypelist[i]);      
        	modelobj.options.add(varItem);  
			}
		}
	}
}

function initDevModel(){

var dev=parseInt($('#devtype').val());

var modelobj=document.getElementById("devmodel");
for (var i = modelobj.options.length-1; i >=1; i--) {        
                modelobj.options.remove(i);     
        } 
	if (dev==-1){
		devmodel.value="-1";
	}
	else{
	
		   
		if (dev==1){
		
			for (var i=0;i<pumtypelist.length;i++){
			var varItem = new Option(pumtypelist[i],pumtypelist[i]);      
        	modelobj.options.add(varItem);  
			}
		}else if (dev==2){
		
			for (var i=0;i<invtypelist.length;i++){
			var varItem = new Option(invtypelist[i],invtypelist[i]);      
        	modelobj.options.add(varItem);  
			}
		}
		$('#devmodel').val(typeselect);
	}
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


.button3 {

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
</style><script>
 function changeCountry(cid){
	
		hiddenFrame.location.href="stateList.action?countryId="+cid;
	
}
function changesUserId(uid){
	$("#changeUserId").val(uid);
	searchForm.action="powerlist.action";
	searchForm.submit();
}
 function viewAccount(account){
    
 	  
	  var iWidth=800;                          //弹出窗口的宽度;
	  var iHeight=450;                        //弹出窗口的高度;
	  var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	  
	  var viewAccount=showModalDialog('viewAccountConfig.action?email='+account+'&'+Math.random(),'viewAccount','dialogWidth:'+iWidth+'px;dialogHeight:'+iHeight+'px;dialogLeft:'+iLeft+'px;dialogTop:'+iTop+'px;center:yes;help:no;resizable:no;status:no')
	   
    }
    <s:if test="#session.userMenu.event==0">
    
    	location.href="index.action";
    </s:if>
     
</script>
<body >
<%
      String lang="en_US";
      if (session.getAttribute("WW_TRANS_I18N_LOCALE")!=null)
       	lang= session.getAttribute("WW_TRANS_I18N_LOCALE").toString();
       %>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
        <script>
        menuOver('adminMenu',24);
        </script>
  </tr>
  
  <tr>
    <td align="center" bgcolor="#E5EFF9">
     <form action="" method="post" id="searchForm" name="searchForm">
    <input type="hidden" name="page" id="page" value="<s:property value="page" />">
    <input type="hidden" name="totalPage" id="totalPage" value="<s:property value="allPage" />">
  
    <table border="0" cellspacing="18" cellpadding="0">
      <tr>
        <td width="896" height="96" align="center" background="images/main_bg6.gif">
		  <table width="840" height="96" border="0" cellspacing="0" cellpadding="0">
          <tr height="32">
            <td width="18" align="center"></td>
            <td width="200" align="left" class="black2">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型              
              <select name="msgtype" id="msgtype" class="test_input8">
                <option value="-1">All</option>
                
                 <s:if test='msgtype==1'>
		         <option value="1" selected="selected">信息</option>
		         <option value="2" >警告</option>
		         <option value="3" >错误</option>
	     		 </s:if>
	     		 <s:elseif test='msgtype==2'>
		         <option value="1" >信息</option>
		         <option value="2" selected="selected">警告</option>
		         <option value="3" >错误</option>
	     		 </s:elseif>
	     		 <s:elseif test='msgtype==3'>
		         <option value="1" >信息</option>
		         <option value="2">警告</option>
		         <option value="3" selected="selected">错误</option>
	     		 </s:elseif>
	     		 <s:else>
		         <option value="1" >信息</option>
		         <option value="2">警告</option>
		         <option value="3">错误</option>
	     		 </s:else>
                </select>
                </td>
            <td width="360" align="left" class="black2">查看状态
              <select name="status" id="status" class="test_input8">
                <option value="-1">All</option>
                
                 <s:if test='status==0'>
		         <option value="0" selected="selected">未读</option>
		         <option value="1" >已读</option>
	     		 </s:if>
	     		 <s:elseif test='status==1'>
		         <option value="0" >未读</option>
		         <option value="1" selected="selected">已读</option>
	     		 </s:elseif>
	     		 <s:else>
		         <option value="0" >未读</option>
		         <option value="1">已读</option>
	     		 </s:else>
                </select>
               	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;错误代码<input type="text" name="errcode" id="errcode" size="8" value="<s:property value="errcode" />"/>
           	</td>
            
            <td  width="200"  align="left" class="black2">描&nbsp;&nbsp;&nbsp;&nbsp;述
              <input name="desc" type="text" class="test_input8" id="desc" size="6" value="<s:property value="desc" />"/></td>
           <td width="72"  align="center"><img src="images/list18.gif" width="63" height="28" id="searchImg"  style="cursor:pointer"/></td>
          </tr>
		   <tr  height="32">
            <td  align="center"></td>
             <td  align="left" class="black2">SN.&nbsp;
              <input name="listno" type="text" class="test_input11" id="listno" size="10" value="<s:property value="listno" />"/></td>
            <td   align="left" class="black2">设&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备
               <select name="devtype" id="devtype" class="test_input8" onchange="changeDev(this.value)">
                <option value="-1">All</option>
                
                 <s:if test='devtype==1'>
		         <option value="1" selected="selected">监控器</option>
		         <option value="2" >逆变器</option>
	     		 </s:if>
	     		 <s:elseif test='devtype==2'>
		         <option value="1" >监控器</option>
		         <option value="2" selected="selected">逆变器</option>
	     		 </s:elseif>
	     		 <s:else>
		         <option value="1" >监控器</option>
		         <option value="2">逆变器</option>
	     		 </s:else>
                </select></td>
             
            <td   align="left" class="black2">型&nbsp;&nbsp;&nbsp;&nbsp;号
            <script>
            var pumtypelist=new Array();
            var invtypelist=new Array();
            var typeselect="<s:property value="devmodel" />";
            <s:iterator id="modell" status="ss" value="modelList">
	                 pumtypelist[pumtypelist.length]="<s:property value="#modell.model" />";
	         </s:iterator>    
	         <s:iterator id="type1" status="ss" value="typeList">
	                 invtypelist[invtypelist.length]="<s:property value="#type1.type" />";
	         </s:iterator>        
            </script>
              <select name="devmodel" id="devmodel" class="test_input8">
                <option value="-1">All</option>
                
                </select>
            </td>
            
            <td    align="center"></td>
            </tr>
            <tr  height="32">
            <td   align="center"></td>
            <td    align="left" class="black6" hight="30">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家
              <select name="countryId" id="countryId" class="test_input8" >
                <option value="-1">All</option>
                <s:set name="cou" value="countryId" />
                 <s:iterator id="country" status="ss" value="countryList">
                 <s:if test='#cou==#country.c_code'>
		         <option value="<s:property value="#country.c_code" />" selected="selected"><s:property value="countryname" /></option>
	     		 </s:if>
	     		 <s:else>
	     		 <option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
	     		 </s:else>
	     		</s:iterator>
                </select></td>
                <td   align="left" class="black2">日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期
              <input name="startDt" id="startDt" type="text" size="13" class="Wdate"  class="test_input14" type="text" value="<s:property value='startDt'/>" onFocus="WdatePicker({maxDate:'#F{\'2050-01-01\'}',lang:'<%= lang %>'})"/>
              -<input name="endDt" id="endDt" type="text" size="13" class="Wdate" class="test_input14 type="text" value="<s:property value='endDt'/>" onFocus="WdatePicker({maxDate:'#F{\'2050-01-01\'}',lang:'<%= lang %>'})"/></td>
           
            <td   align="left" class="black2">电站名
              <input name="stationName" type="text" class="test_input8" id="stationName" value="<s:property value="stationName" />"/>
            </td>
            <td    align="center"><input type='button' class='button3' value='导 出'   style='cursor:pointer' onclick='downCsv()'/></td>
          </tr>
        </table></td>
      </tr>

      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="34" align="center" background="images/list_bg4.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="140" height="30" align="center" class="black">电站名</td>
                <td width="140" align="center" class="black">SN.</td>
                <td width="60" align="center" class="black">类型</td>
                <td width="140" align="center" class="black">时间</td>
                <td width="180" align="center" class="black">描述</td>
                <td width="80" align="center" class="black">国家</td>
                <td width="80" align="center" class="black">城市</td>
                </tr>
              
            </table></td>
          </tr>
          <tr>
            <td align="center" background="images/list_bg6.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0" class="tablelimit">
                 <s:iterator id="st" value="eventList" status="em">
					<s:if test="#em.odd">
						<tr >
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" >
					</s:else>
                  <td width="140" height="36" align="center" class="black2"><s:property value="#st.stationname" /></td>
                  <td width="140" align="center" class="black2"><s:property value="#st.ssno" /></td>
                  <td width="60" align="center" class="black2"><s:property value="#st.msgtype" /></td>
                  <td width="140" align="center" class="black2"><s:property value="#st.occdt" /></td>
                  <td width="180" align="center" class="black2"><s:property value="#st.msg_desc" /></td>
                  <td width="80" align="center" class="black2"><s:property value="#st.country" /></td>
                  <td width="80" align="center" class="black2"><s:property value="#st.city" /></td>
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
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>

    <form action="EventFindDown" name="downForm" target="hiddenFrame" method="post">
	  <input type="hidden" name="msgtype" value="">
	  <input type="hidden" name="status" value="">
	  <input type="hidden" name="desc" value="">
	  <input type="hidden" name="countryId" value="">
	  <input type="hidden" name="stationName" value="">
	  <input type="hidden" name="devtype" value="">
	  <input type="hidden" name="devmodel" value="">
	  <input type="hidden" name="startDt" value="">
	  <input type="hidden" name="endDt" value="">
	  <input type="hidden" name="listno" value="">
  </form>
<iframe id="hiddenFrame"  name="hiddenFrame"  MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>

</body>
</html>
