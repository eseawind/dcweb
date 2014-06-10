<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/inner.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/images/css.css" type="text/css"></link>
  	<link rel="stylesheet" href="./skins/blue.css" />
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/artDialog.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/menu.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/iphoto_flash.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/swfobject.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
		function createStation(){
			//var clientzonestr = new Date().getTimezoneOffset()/60*-1;
			var dd=new Date();
			 
			/*
			if(inDaylightTime(dd)){
				clientzonestr = (dd.getTimezoneOffset()-60)/60*-1;
			}else{
				clientzonestr = dd.getTimezoneOffset()/60*-1;
			}
			*/
			var clientzonestr = inDaylightTime(dd)/60*-1;
			
			$.post("getTimeOffset.action",{"clientzonestr":clientzonestr}, function(){
				window.location.href='createStation.action';
			});
		}
		
function isEastEarthTime(newDate)
{
    var dj= newDate.getTimezoneOffset();
    if (dj<0){
        return true;
    } else {
        return false;
    }
}

function inDaylightTime(date){
        var start = new Date();
        start.setMonth(0);
        start.setDate(1);
        start.setHours(0);
        start.setMinutes(0);
        start.setSeconds(0);
        var middle = new Date(start.getTime());
        middle.setMonth(6);
        /*
        if ((middle.getTimezoneOffset() - start.getTimezoneOffset()) == 0) {
            return false;
        }
        */
        var tmp = middle.getTimezoneOffset() > start.getTimezoneOffset() ? middle.getTimezoneOffset():start.getTimezoneOffset()
        return tmp;
        /*
        if(date.getTimezoneOffset() == tmp){
        	return true;
        }
        
        var margin = 0;
        if (this.isEastEarthTime(date)) {
            margin = middle.getTimezoneOffset();
        } else {
            margin = start.getTimezoneOffset();
        }
        if (date.getTimezoneOffset() == margin) {
            return true;
        }
        */
       // return false;
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
		-->
	</style>
</head>
<body >
<img src="images/list_bg2.gif" width=0 height=0 style="display:none" />
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td ><%@include file="HeadMenu.jsp" %></td>
  	</tr>
  	<tr>
    	<td align="center" bgcolor="#E5EFF9">
    		<table width="930" border="0" cellspacing="18" cellpadding="0">   
     			<s:iterator id="station" status="ss" value="stationList">
	   			<s:set id="stid" name="stid" value="'St_'+#station.stationid"/>
      			<tr>
        			<td width="894" height="121" align="center" class="list_bg" onmouseover="canA=true;this.className='list_bg2'" onmouseout="this.className='list_bg'" >
        				<table width="894" border="0" cellspacing="0" cellpadding="0">
        					<tr>
        						<td align="center">
        							<table width="854" border="0" cellspacing="0" cellpadding="0" onclick="if (canA){location.href='overview.action?stationid=<s:property value="#station.stationid" />';}" style="cursor:pointer">
          								<tr>
            								<td width="82"><img src="<s:property value="#station.iconindex" />" width="82" height="82" /></td>
            								<td width="154" align="left" class="black3">&nbsp;&nbsp;
            									<s:property value="#station.stationname" />
	            								<br>
	            								<s:if test="#station.state==0">
            									<input type="button" value="<s:text name="RES_SHAREPLANT_ACCEPT"></s:text>" onmouseover="canA=false;" onmouseup="canA=false;" onmouseout="canA=false;" onclick="canA=false;acceptShare(<s:property value="#station.stationid" />)">&nbsp;&nbsp;<input type="button" value="<s:text name="RES_SHAREPLANT_REFUSE"></s:text>" onmouseover="canA=false;" onmouseup="canA=false;" onmouseout="canA=false;" onclick="refuseShare(<s:property value="#station.stationid" />)"/>
            									</s:if>
           	 								</td>
            								<td width="1"><img src="images/dz_list2.gif" width="1" height="115" /></td>
            								<td width="271" align="center">
            									<table width="95%" border="0" cellspacing="0" cellpadding="0">
              										<tr>
                										<td width="35%" height="25" align="right" class="black2">E-Today：</td>
                										<td width="65%" align="left" class="black2"><s:property value="#station.etoday" /> <s:property value="#station.etoday_unit" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2">E-Total：</td>
                										<td align="left" class="black2"><s:property value="#station.etotal" /> <s:property value="#station.etotal_unit" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2"><s:text name="RES_ALLINCOME"></s:text>：</td>
                										<td align="left" class="black2"><s:property value="#station.inval" /> <s:property value="#station.inval_unit" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2"><s:text name="RES_CO2V"></s:text>：</td>
                										<td align="left" class="black2"><s:property value="#station.Co2Val" /> <s:property value="#station.co2val_unit" /></td>
              										</tr>
            									</table>
            								</td>
            								<td width="1"><img src="images/dz_list2.gif" width="1" height="115" /></td>
            								<td align="center">
            									<table width="95%" border="0" cellspacing="0" cellpadding="0">
              										<tr>
                										<td width="35%" height="25" align="right" class="black2"><s:text name="RES_INVENUM"></s:text>：</td>
                										<td width="65%" align="left" class="black2"><s:property value="#station.invnum" />/<s:property value="#station.invtnum" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2"><s:text name="RES_MONITOR"></s:text>：</td>
                										<td align="left" class="black2"><s:property value="#station.pmunum" />/<s:property value="#station.pmutnum" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2"><s:text name="RES_EVENT"></s:text>：</td>
                										<td align="left" class="black2"><s:property value="#station.eve0num" /></td>
              										</tr>
              										<tr>
                										<td height="25" align="right" class="black2"><s:text name="RES_LASTUPDATE"></s:text>：</td>
                										<td align="left" class="black2"><s:property value="#station.ludt" /></td>
              										</tr>
            									</table>
            								</td>
          								</tr>
        							</table>
        						</td>
        	 					<td width="30" valign="top">
        	 					<s:if test="#station.roleid==1">
        	 					<image src="images/share.png" onclick="refuseShare('<s:property value="#station.stationid" />');" style="cursor:pointer" title="<s:text name="RES_SHAREPLANT_REFUSED"></s:text>"/>
        	 					</s:if>
        	 					<s:else>      
        	 					<s:if test="#session.user.UserId!=0">
        	 					<image src="images/delStation.gif" onclick="removeStation('<s:property value="#station.stationid" />');" style="cursor:pointer" title="<s:text name="RES_PLANTLIST_DELPLANT"></s:text>"/>
        	 					</s:if>
        	 					</s:else>
        	 					</td>
        					</tr>
        				</table>
        			</td>
      			</tr>
      			</s:iterator>
      			<s:if test="#session.user.UserId!=0">
      			<tr>
        			<td height="121">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
					            <td width="128" height="121" align="left" valign="middle" background="images/new_station_bg.gif"><img src="images/new_station1.gif" width="128" height="121" onclick="createStation()" style="cursor:pointer"/></td>
								<td width="22%" height="121" align="left" valign="middle" background="images/new_station_bg.gif"> <span class="STYLE1"><s:text name="RES_CREATESTATION"></s:text></span></td>
					            <td width="10" height="121" background="images/new_station_bg2.gif"></td>
					            <td background="images/new_station_bg.gif"><span class="STYLE3">&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="RES_CREATENEWSTATIONDESC"></s:text></span></td>
          					</tr>
        				</table>
					</td>
      			</tr> 
      			</s:if>
    		</table>
    	</td>
	</tr>
   	<tr>
    	<td height="48" align="center" bgcolor="#A4A7AE" ><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
</body>
</html>
