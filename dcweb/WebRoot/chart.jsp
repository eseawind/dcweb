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
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
    <script type="text/javascript" src="js/parseXML.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>

  </head>
<script>
function changeMenus(str){
	changeMenu.action=str;
	changeMenu.submit();
}
var page=1;
var pageRows=10;
var allRows=0;
var allPage=1;
var nextpages=1;
var lastPages=1;
function loadMenu(){
    var id="<s:property value="tableId" />";
	
	
	if (allRows!=0){
		if ((allRows % pageRows)!=0){
			allPage=(allRows-(allRows % pageRows))/pageRows+1;
		}
		else{
			allPage=allRows/pageRows;
		}
		
		
	}
	loadPageInv(1);
}
function loadPageInv(pg){
	page=pg;
	if (page>=1 && page<=allPage){
	
		var bgr=(page-1)*pageRows+1;
		var enr=page*pageRows;
		if (enr>allRows)
			enr=allRows;
		for (var i=1;i<=allRows;i++){
		
			var invobj=document.getElementById("invlist"+i);
			invobj.style.display='none';
		}
		
		for (var i=bgr;i<=enr;i++){
			var invobj=document.getElementById("invlist"+i);
			invobj.style.display='';
		}
		if (page>1)
		{
			lastPages=1;
		}
		else{
			lastpages=page-1;
		}
		if (page<allPage){
			nextPages=page+1;
		}
		else{
			nextPages=page;
		}
	}
	var invpgobj=document.getElementById("invPages");
	invpgobj.innerHTML=page+"/"+allPage;
}
function firstPage(){
loadPageInv(1);
}
function lastPage(){
loadPageInv(lastPages);
}
function nextPage(){
loadPageInv(nextPages);
}
function buttomPage(){
loadPageInv(allPage);
}
</script>

<body onload="loadMenu();">
<form id="changeMenu" name="changeMenu" action="" method="post" >
<input type="hidden" name="stationid" value="<s:property value="stationid" />">
</form>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
        <script>
        var id="<s:property value="tableId" />";
		menuOver('graphsMenu',id);
        </script>
  </tr>
   
  <tr>
    <td align="center" bgcolor="#E5EFF9"><table border="0" cellspacing="18" cellpadding="0">
      <tr>
        <td width="896" height="121" align="center" background="images/list_bg7.gif">
        <%@include file="stationInfoSub.jsp" %></td>
      </tr>
      <script>
      function viewData(Str){
    	var doc = XMLJS.parseXML(Str);
		var root = XMLJS.getXMLRootNode(doc);
		
		var sessionID = XMLJS.getAttributeNodeValue(root,"sessionID");
		var time="";
		var tableid="";
		var unit="";
		var vnum=1;
		var vl="";
		var datelist=1;
		time=XMLJS.getAttributeNodeValue(root,"time");		
		tableid=XMLJS.getAttributeNodeValue(root,"tableid");	
		unit=XMLJS.getAttributeNodeValue(root,"unit");
		if (unit=="null")
			unit="";
		var vlnum=3;
		tableid=parseInt(tableid);
		 if (tableid==1201){
		 vl="IDC";
		 vlnum=2;
		 datelist=1;
		}else if (tableid==1202){
		 vl="IDC";
		 datelist=7;
		 vlnum=2;
		}else if (tableid==1301){
		 vl="VDC";
		 datelist=1;
		 vlnum=2;
		}else if (tableid==1302){
		 vl="VDC";
		 datelist=7;
		 vlnum=2;
		}else if (tableid==1401){
		 vl="FAC";
		 vlnum=1;
		 datelist=1;
		}else if (tableid==1402){
		 vl="FAC";
		 vlnum=1;
		 datelist=7;
		}else if (tableid==1501){
		 vl="IAC";
		 datelist=1;
		}else if (tableid==1502){
		 vl="IAC";
		 datelist=7;
		}else if (tableid==1601){
		 vl="VAC";
		 datelist=1;
		}else if (tableid==1602){
		 vl="VAC";
		 datelist=7;
		}else if (tableid==1701){
		 vl=RES.RES_CHART_DOWN_TEMP;
		 vlnum=1;
		 datelist=1;
		}else if (tableid==1702){
		 vl=RES.RES_CHART_DOWN_TEMP;
		 vlnum=1;
		 datelist=7;
		}else if (tableid==1801){
		 vl="Power";
		 vlnum=2;
		 datelist=1;
		}else if (tableid==1802){
		 vl="Power";
		 vlnum=2;
		 datelist=7;
		}
		var dateA=new Array();
		var width=500;
		if (vlnum==1){
			width=400;
		}
		var nodes = XMLJS.getXMLChildNodes(root);
		    var tbls="<div id='bbb' style='height:400px; width:620px;  overflow-y:auto; overflow-x:no'>";
			  tbls=tbls+"<table width='600' border='0' cellspacing='0' cellpadding='0'>";
			  tbls=tbls+"        <tr>";
			  tbls=tbls+"          <td height='34' align='center' background='images/list_bg4_2.gif'>";
			  tbls=tbls+"          <table width='98%' border='0' cellspacing='0' cellpadding='0'>";
			  tbls=tbls+"              <tr>";
			  tbls=tbls+"                <td width='30%' align='center' class='black'>"+RES.RES_CHART_DOWN_ISNO+"</td>";
			  tbls=tbls+"                <td width='30%' align='center' class='black'>"+RES.RES_CHART_DOWN_TIME+"</td>";
			  if (vlnum==1){
			  tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"("+unit+")</td>";
			  }else if (vlnum==3){
			   tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"1("+unit+")</td>";
			  tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"2("+unit+")</td>";
			  tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"3("+unit+")</td>";
			  }else if (vlnum==2){
			  tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"1("+unit+")</td>";
			  tbls=tbls+"                <td width='10%' align='center' class='black'>"+vl+"2("+unit+")</td>";
			  }
			  
			  tbls=tbls+"              </tr>";
			  tbls=tbls+"          </table></td>";
			  tbls=tbls+"        </tr>";
			  tbls=tbls+"        <tr>";
			  tbls=tbls+"          <td align='center' background='images/list_bg6.gif'>";
			  tbls=tbls+"          <table width='98%' border='0' cellspacing='0' cellpadding='0'>";
		var is=1;
		var dateE = XMLJS.getXMLChildNodes(nodes[nodes.length-1]);
		
		for(var i=0;i<dateE.length;i++)
		   {
		 	
		   dateA[i]=XMLJS.getAttributeNodeValue(dateE[i],"d");
		   }
		
		for(var i=0;i<nodes.length-1;i++)
		   {
		   var isno=XMLJS.getAttributeNodeValue(nodes[i],"i");
		   var nodes2 = XMLJS.getXMLChildNodes(nodes[i]);
		   var dateNo=0;
		   var dateL=0;
		   for(var j=0;j<nodes2.length;j++)
		   {
			   if (is==1){
			   tbls=tbls+" <tr>";
			   is=0;
			   }
			   else{
			   tbls=tbls+" <tr bgcolor='#B5D5EA'>";
			   is=1;
			   }
			   
				tbls=tbls+" <td width='30%' align='center' class='black2'>"+isno+"</td>";
				tbls=tbls+" <td width='30%' align='center' class='black2'>"+dateA[dateNo]+" "+XMLJS.getAttributeNodeValue(nodes2[j],"t")+"</td>";
				  if (vlnum==1){
			  tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v")+"</td>";
			  }else if (vlnum==3){
			  tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v1")+"</td>";
	            tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v2")+"</td>";
	            tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v3")+"</td>";
			  }else if (vlnum==2){
			  tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v1")+"</td>";
	            tbls=tbls+" <td width='10%' align='center' class='black2'>"+XMLJS.getAttributeNodeValue(nodes2[j],"v2")+"</td>";
			  }
				
	            tbls=tbls+" </tr>";		
	            if (dateL==144){
		            dateNo++;
		            dateL=0;
	            } 
	            else{
	            dateL++;
	            }
		   }
		   }
                
            tbls=tbls+"</table></td>";	
          	tbls=tbls+"</tr>";	
          	tbls=tbls+"<tr>";	
            tbls=tbls+"<td height='34' align='right' background='images/list_bg5_2.gif'>&nbsp;</td>";	
            tbls=tbls+"    </tr>";	
            tbls=tbls+"</table></td>";	
          	tbls=tbls+"</tr>";	
        	tbls=tbls+"</table></div>";	
		   art.dialog({
			    title: RES.RES_DATA_LIST,
				width: 640,
				height: 200,
			    content: tbls
			});
    	}
    	
    	
    	function downCvs(Str){
    	var doc = XMLJS.parseXML(Str);
		var root = XMLJS.getXMLRootNode(doc);
		
		var sessionID = XMLJS.getAttributeNodeValue(root,"sessionID");
		var tableid="";
		var unit="";
		tableid=XMLJS.getAttributeNodeValue(root,"tableid");	
		unit=XMLJS.getAttributeNodeValue(root,"unit");
		var obj="";
		var til=RES.RES_CHART_DOWN_TIME+",";
		var vlnum=3;
		tableid=parseInt(tableid);
		 if (tableid==1201){
		 obj=RES.RES_CHART_DOWN_OBJ_1201;
		 til=til+"IDC1("+unit+"),"+"IDC2("+unit+"),";
		}else if (tableid==1202){
		 obj=RES.RES_CHART_DOWN_OBJ_1202;
		 til=til+"IDC1("+unit+"),"+"IDC2("+unit+"),";
		 datelist=7;
		}else if (tableid==1301){
		 obj=RES.RES_CHART_DOWN_OBJ_1301;
		 til=til+"VDC1("+unit+"),"+"VDC2("+unit+"),";
		}else if (tableid==1302){
		 obj=RES.RES_CHART_DOWN_OBJ_1302;
		 til=til+"VDC1("+unit+"),"+"VDC2("+unit+"),";
		}else if (tableid==1401){
		 obj=RES.RES_CHART_DOWN_OBJ_1401;
		til=til+"FAC("+unit+")";
		}else if (tableid==1402){
		 obj=RES.RES_CHART_DOWN_OBJ_1402;
		til=til+"FAC("+unit+")";
		}else if (tableid==1501){
		 obj=RES.RES_CHART_DOWN_OBJ_1501;
		til=til+"IAC1("+unit+"),"+"IAC2("+unit+"),"+"IAC3("+unit+"),";
		}else if (tableid==1502){
		 obj=RES.RES_CHART_DOWN_OBJ_1502;
		 til=til+"IAC1("+unit+"),"+"IAC2("+unit+"),"+"IAC3("+unit+"),";
		}else if (tableid==1601){
		 obj=RES.RES_CHART_DOWN_OBJ_1601;
		 til=til+"VAC1("+unit+"),"+"VAC2("+unit+"),"+"VAC3("+unit+"),";
		}else if (tableid==1602){
		 obj=RES.RES_CHART_DOWN_OBJ_1602;
		  til=til+"VAC1("+unit+"),"+"VAC2("+unit+"),"+"VAC3("+unit+"),";
		}else if (tableid==1701){
		 obj=RES.RES_CHART_DOWN_OBJ_1701;
		 til=til+RES.RES_CHART_DOWN_TEMP+"("+unit+")";
		}else if (tableid==1702){
		 obj=RES.RES_CHART_DOWN_OBJ_1702;
		 til=til+RES.RES_CHART_DOWN_TEMP+"("+unit+")";
		}else if (tableid==1801){
		 obj=RES.RES_CHART_DOWN_OBJ_1801;
		  til=til+"Power1("+unit+"),"+"Power2("+unit+"),";
		}else if (tableid==1802){
		 obj=RES.RES_CHART_DOWN_OBJ_1802;
		 til=til+"Power1("+unit+"),"+"Power2("+unit+"),";
		}
    	downForm.dataS.value=Str;
    	downForm.obj.value=obj;
    	downForm.til.value=til;
    	
    	downForm.type.value="1";
		downForm.submit();
    	}
    	
    	function downText(Str){
    	var doc = XMLJS.parseXML(Str);
		var root = XMLJS.getXMLRootNode(doc);
		
		var sessionID = XMLJS.getAttributeNodeValue(root,"sessionID");
		var tableid="";
		var unit="";
		tableid=XMLJS.getAttributeNodeValue(root,"tableid");	
		unit=XMLJS.getAttributeNodeValue(root,"unit");
		var obj="";
		var til=RES.RES_CHART_DOWN_TIME+",";
		var vlnum=3;
		
		tableid=parseInt(tableid);
		 if (tableid==1201){
		 obj=RES.RES_CHART_DOWN_OBJ_1201;
		 til=til+"IDC1("+unit+"),"+"IDC2("+unit+"),";
		}else if (tableid==1202){
		 obj=RES.RES_CHART_DOWN_OBJ_1202;
		 til=til+"IDC1("+unit+"),"+"IDC2("+unit+"),";
		 datelist=7;
		}else if (tableid==1301){
		 obj=RES.RES_CHART_DOWN_OBJ_1301;
		 til=til+"VDC1("+unit+"),"+"VDC2("+unit+"),";
		}else if (tableid==1302){
		 obj=RES.RES_CHART_DOWN_OBJ_1302;
		 til=til+"VDC1("+unit+"),"+"VDC2("+unit+"),";
		}else if (tableid==1401){
		 obj=RES.RES_CHART_DOWN_OBJ_1401;
		til=til+"FAC("+unit+")";
		}else if (tableid==1402){
		 obj=RES.RES_CHART_DOWN_OBJ_1402;
		til=til+"FAC("+unit+")";
		}else if (tableid==1501){
		 obj=RES.RES_CHART_DOWN_OBJ_1501;
		til=til+"IAC1("+unit+"),"+"IAC2("+unit+"),"+"IAC3("+unit+"),";
		}else if (tableid==1502){
		 obj=RES.RES_CHART_DOWN_OBJ_1502;
		 til=til+"IAC1("+unit+"),"+"IAC2("+unit+"),"+"IAC3("+unit+"),";
		}else if (tableid==1601){
		 obj=RES.RES_CHART_DOWN_OBJ_1601;
		 til=til+"VAC1("+unit+"),"+"VAC2("+unit+"),"+"VAC3("+unit+"),";
		}else if (tableid==1602){
		 obj=RES.RES_CHART_DOWN_OBJ_1602;
		  til=til+"VAC1("+unit+"),"+"VAC2("+unit+"),"+"VAC3("+unit+"),";
		}else if (tableid==1701){
		 obj=RES.RES_CHART_DOWN_OBJ_1701;
		 til=til+RES.RES_CHART_DOWN_TEMP+"("+unit+")";
		}else if (tableid==1702){
		 obj=RES.RES_CHART_DOWN_OBJ_1702;
		 til=til+RES.RES_CHART_DOWN_TEMP+"("+unit+")";
		}else if (tableid==1801){
		 obj=RES.RES_CHART_DOWN_OBJ_1801;
		  til=til+"Power1("+unit+"),"+"Power2("+unit+"),";
		}else if (tableid==1802){
		 obj=RES.RES_CHART_DOWN_OBJ_1802;
		 til=til+"Power1("+unit+"),"+"Power2("+unit+"),";
		}
    	downForm.dataS.value=Str;
    	downForm.obj.value=obj;
    	downForm.til.value=til;
    	downForm.type.value="2";
		downForm.submit();
    	}
      </script>
      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          
          <tr>
            <td height="500" align="center">
            <div id="flashCont" width="882" height="500"></div>
            <%
     
    String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/" ;
     %>
    
                <script type="text/javascript">
                 function getSName(){
                	return "<s:property value="#session.defaultStationMap.stationname" />";
                }
                var sp1=" ";
                <%
                if (session.getAttribute("WW_TRANS_I18N_LOCALE")==null || session.getAttribute("WW_TRANS_I18N_LOCALE").toString().equals("zh_CN")){
                %>
                sp1="";
                <%
                }
                %>
                //<s:property value="tableId" />
                var chartName="<s:text name="RES_CHART2"/>";
                var tipName;
       <s:if test="tableId==10">
       	chartName=chartName+sp1+"<s:text name="RES_CO2V"/>"
       	tipName="<s:text name="RES_CO2V"/>";
       </s:if>
       <s:if test="tableId==11">
       	chartName=chartName+sp1+"<s:text name="RES_INCOME"/>"
       	tipName="<s:text name="RES_INCOME"/>";
       </s:if>
       <s:if test="tableId==12">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_DCC"/>"+sp1;
       	tipName="<s:text name="RES_DCC"/>";
       </s:if>
       <s:if test="tableId==13">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_DCV"/>"+sp1;
       	tipName="<s:text name="RES_DCV"/>";
       </s:if>
       <s:if test="tableId==14">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_ACF"/>"+sp1;
       	tipName="<s:text name="RES_ACF"/>";
       </s:if>
       <s:if test="tableId==15">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_ACC"/>"+sp1;
       	tipName="<s:text name="RES_ACC"/>";
       </s:if>
       <s:if test="tableId==16">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_ACV"/>"+sp1;
       	tipName="<s:text name="RES_ACV"/>";
       </s:if>
       <s:if test="tableId==17">
       	chartName=sp1+chartName+sp1+"<s:text name="RES_INVE"/>"+sp1;
       	tipName="<s:text name="RES_INVE"/>";
       </s:if>
       <s:if test="tableId==18">
       	chartName=chartName+sp1+"<s:text name="RED_CHART_ENERGY"/>"
       </s:if>
       var flashvars = {"lang":"<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>",
		"sid":"<s:property value="#session.defaultStation" />",
		"uid":"<s:property value="#session.userId" />",
		"tid":"<s:property value="tableId" />",
		"baseUrl":"<%=baseUrl%>",
		"admin":"<s:property value="#session.defaultStationMap.account" />",
		"printer":"<s:property value="#session.user.Account" />",
		"sname":"<s:property value="#session.defaultStationMap.stationname" />",
		"url":"<%=baseUrl%><s:property value="#session.defaultStationMap.iconindex" />",
		"today":"<s:property value="#session.defaultStationMap.etoday" />KWh",
		"total":"<s:property value="#session.defaultStationMap.etotal" /> <s:property value="#session.defaultStationMap.etotal_unit" />",
		"income":"<s:property value="#session.defaultStationMap.inval" /> <s:property value="#session.defaultStationMap.inval_unit" />",
		"co2":"<s:property value="#session.defaultStationMap.Co2Val" /> <s:property value="#session.defaultStationMap.co2val_unit" />",
		"inverter":"<s:property value="#session.defaultStationMap.inv1num" />/<s:property value="#session.defaultStationMap.invtnum" />",
		"monitor":"<s:property value="#session.defaultStationMap.pmu1num" />/<s:property value="#session.defaultStationMap.pmutnum" />",
		"events":"<s:property value="#session.defaultStationMap.eve0num" />",
		"lastimport":"<s:property value="#session.defaultStationMap.ludt" />",
		"chart":chartName,
		"tip":tipName+":",
		"now":"<s:property value="#session.defaultStationMap.curdt" />"}; 			
        showFlashElement("swf/Chart3.swf", flashvars);
    </script>
           </td>
          </tr>
        </table></td>
      </tr>
      
      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="34" align="center" background="images/list_bg4.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="214" height="30" align="center" class="black"><s:text name="RES_EQUIPMENTNAME"/></td>
                  <td width="52" align="center" class="black"><s:text name="RES_ESTATUS"/></td>
                  <td width="117" align="center" class="black">E-Today（<s:property value="e_today_u" />）</td>
                  <td width="112" align="center" class="black">E-Total（<s:property value="e_total_u" />）</td>
                  <td width="110" align="center" class="black">Pac(<s:property value="pac_u" />)</td>
                  <td width="127" align="center" class="black">P-Peak(<s:property value="pacmax_u" />)</td>
                  <td width="83" align="center" class="black"><s:text name="RES_PERCENTAGE"/></td>
                  <td width="79" align="center" class="black"><s:text name="RES_EVENT"/></td>
                
                </tr>
            </table></td>
          </tr>
            <td align="center" background="images/list_bg6.gif">
            <table width="894" border="0" cellspacing="0" cellpadding="0">
           <%
           int rows=0;       
            %>
                <s:iterator id="inv" value="invList" status="em">
                
					<s:if test="#em.odd">
						<tr id="invlist<%=++rows%>" style="display:none">
					</s:if>
					<s:else>
						<tr bgcolor="#B5D5EA" id="invlist<%=++rows%>"  style="display:none">
					</s:else>
                  <td width="45" align="center" class="black2">
                  <s:if test="#inv.isselect==0">
				<input type="checkbox" name="isno" id="isno" value="<s:property value="#inv.isno" />" onclick="submitIsno(this)"/>
				</s:if>
				 <s:elseif test="#inv.isselect==1">
				<input type="checkbox" name="isno" id="isno" value="<s:property value="#inv.isno" />" checked="true"  onclick="submitIsno(this)"/>
				</s:elseif>
                  </td>
                  <td width="101" height="36" align="center" class="black2"> <s:property value="#inv.isname" /></td>
                  <td width="121" align="center" class="black2">
                  <s:if test="#inv.state==1">
				<img src="images/list3.gif" />
				</s:if>
				 <s:elseif test="#inv.state==0">
				<img src="images/list4.gif" />
				</s:elseif></td>
                  <td width="117" align="center" class="black2"><s:property value="#inv.etoday" /></td>
                  <td width="112" align="center" class="black2"><s:property value="#inv.etotal" /></td>
                  <td width="110" align="center" class="black2"><s:property value="#inv.pac" /></td>
                  <td width="127" align="center" class="black2"><s:property value="#inv.pacmax" /></td>
                  <td width="84" align="center" class="black2"><s:property value="#inv.et_percent" />%</td>
                  <td width="77" align="center" class="black2"><s:property value="#inv.eve0num" /></td>
                </tr>
                </s:iterator>
                <script>
                allRows=<%=rows%>;
                </script>
            </table></td>
          </tr>
          <tr>
            <td height="34" align="right" background="images/list_bg5.gif"><table width="20%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                   <td align="center"><img src="images/dz_list8.gif" width="17" height="19" id="firstP" style="cursor:pointer"  onclick="firstPage()"/></td>
                        <td align="center"><img src="images/dz_list10.gif" width="19" height="19" id="preP" style="cursor:pointer"  onclick="lastPage()"/></td>
                        <td align="center"><span id="invPages"></span></td>
                        <td align="center"><img src="images/dz_list11.gif" width="19" height="19" id="nextP" style="cursor:pointer"  onclick="nextPage()"/></td>
                        <td align="center"><img src="images/dz_list9.gif" width="17" height="19" id="lastP" style="cursor:pointer" onclick="buttomPage()"/></td>
                        <td>&nbsp;</td>
                </tr>
            </table></td>
          </tr>
        </table></td>
        
        
      </tr>
    </table></td>
  </tr>
   <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
  <form action="dataDownloadComplex" name="downForm" target="hiddenFrame" method="post">
	  <input type="hidden" name="time" value="">
	  <input type="hidden" name="til" value="">
	  <input type="hidden" name="obj" value="">
	  <input type="hidden" name="type" value="">
	  <input type="hidden" name="unit" value="">
	  <input type="hidden" name="fileName" value="">
	  <input type="hidden" name="dataS" value="">
  </form>
  <form action="updateInvListForUser.action" name="saveInvtForm" target="hiddenFrame" method="post">
	  <input type="hidden" name="invtList" value="">
  </form>
</table>
<iframe id="hiddenFrame"  name="hiddenFrame"  MARGINHEIGHT="5" MARGINWIDTH="5"  width="0" height="0" vspace="1"></iframe>
<script>
function submitIsno(chk){
var s="";
var num=0;
$('input[name="isno"]:checked').each(function(){
    s+=$(this).val()+',';
    num++;
});
if (num>5){
	alert(RES.CHART_UPDATEUSERINVT_MAX);
	chk.checked=false;
	return false;
}
document.getElementById("flashCont").ChangeIsno(s);
document.saveInvtForm.invtList.value=s;
document.saveInvtForm.submit();
}


function saveIsno(){
var s="";
var num=0;
$('input[name="isno"]:checked').each(function(){
    s+=$(this).val()+',';
    num++;
});
if (num>5){
	alert(RES.CHART_UPDATEUSERINVT_MAX);
	return false;
}
document.saveInvtForm.invtList.value=s;
document.saveInvtForm.submit();
}
</script>
</body>
</html>
