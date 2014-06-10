<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles_lang.css" type="text/css"></link>
	<link rel="stylesheet" href="./skins/blue.css" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/images/css.css" type="text/css"></link>
    <script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/index.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
	<script type="text/javascript" src="./js/artDialog.min.js"></script>
  	<script type="text/javascript" src="js/swfobject.js"></script>
    <script type="text/javascript" src="js/iphoto_flash.js"></script>
  	<script type="text/javascript">
		$(document).ready(function() {
			try {
				var email = Cookie.getCookie("email2");
				var password =  Cookie.getCookie("password2");
				if(email!="" && email!=null){
					$("#account").val(email);
					$("#password").val(password);
					$("#remain").attr("checked", true); 
				}
			} catch(e) {
				
			}
			var s1="<s:property value="servertime" />"; 
			s1 = s1.replace(/-/g, "/");
			s1 = new Date(s1);
			var s2 = new Date();
			var days= s2.getTime() - s1.getTime();
			if (days<0) 
				days=0-days;
			days = parseInt(days / (1000 * 60 * 60 * 24));
			if (days>90){
				alert(RES.RES_INDEX_ERR_TIME);
			}
		});
		
		document.onkeydown = function(e) {   
    		var theEvent = e || window.event;   
    		var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
    		if (code == 13) {   
        		login();
        		return false;   
    		}   
    		return true;
    	}
    	
    	function changeVerCode(){
    		document.getElementById("verImg").src = "verCode?"+Math.random();
    	}
  	</script>
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
	<style type="text/css">
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
			color: #ffff00;
			background-image: url("images/buttom7.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			width:63px;
		}
		.button3 {
			font-family: Tahoma, Verdana;
			font-size: 14px;
			font-weight: bold;
			padding: 0 5px;
			color: #ffff00;
			background-image: url("images/buttom8.gif");
			background-repeat: repeat-x;
			background-position: 0 50%;
			outline: 0px solid #D3E0E7;
			height: 28px !important;
			border: 0px solid ;
			width:71px;
		}
		.tablelimit { 
			table-layout: fixed;
			word-wrap:break-word;
		}
		-->
	</style>
</head>
<body onload="flashChecker();">
<img src="images/main_bg3.gif" width=0 height=0 style="display:none"/>
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  	<tr>
    	<td height="121" align="center" background="images/top_bg.gif">
    		<table width="960" border="0" cellspacing="0" cellpadding="0">
      			<tr>
			        <td width="189" height="121" align="left" valign="bottom" class="logo" onclick="window.location.href='http://solarcloud.zeversolar.com'" style="cursor:pointer">&nbsp;</td>
			        <td width="510" height="121" align="left" valign="bottom" >&nbsp;</td>
			        <td width="261" align="left">
        				<table width="80%" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td width="80%">
									<div class="divlang" style="z-index:2;">
									<ul>
									<li style="background: transparent url(images/lang/language_drop.gif) no-repeat scroll 0pt 3px; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; height: 22px; width: 167px;">
										<a class="droplang" href="#"><img id="_ctl0_HeaderLanguageMenuControl_ImgLanguageSelected" src="images/lang/<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>_on.gif" border="0"><!--[if IE 7]><!--></a><!--<![endif]--><!--[if IE 8]><!--></a><!--<![endif]-->
				                    	<!--[if lte IE 6]><table cellpadding="0" cellspacing="0"><tr><td><![endif]-->
				                    	<ul>
					                    	<li><a href="#"><img src="images/lang/uk_tp.gif" alt="English" title="English" width="118" height="22" onclick="changeLange('en_US')"/></a></li>
					                    	<li><a href="#"><img src="images/lang/china_tp.gif" alt="Chinese" title="Chinese" width="118" height="22" onclick="changeLange('zh_CN')"/></a></li>
					                    	<li><a href="#"><img src="images/lang/dansk_tp.gif" alt="Dansk" title="Dansk" width="118" height="22" onclick="changeLange('da_DK')"/></a></li>
					                    	<li><a href="#"><img src="images/lang/german_tp.gif" alt="German" title="German" width="118" height="22" onclick="changeLange('de_DE')"/></a></li>
				                    	</ul>
				                    	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
				                    </li>
				                    </ul>
									</div>
            					</td>
          					</tr>
        				</table>
        			</td>
      			</tr>
    		</table>
    	</td>
  	</tr>
  	<tr>
    	<td height="373" align="center" bgcolor="#E5EFF9">
    		<div id="flashCont" width="960" height="373"></div>
		    <object width="960" height="373" index="-1" border="0" align="absmiddle" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0">  
				<param name="movie" value="swf/carousel.swf">  
				<param name="quality" value="high">  
				<embed width="960" height="373" align="absmiddle" src="swf/carousel.swf" quality="high" 
				pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="opaque">
				<param name="wmode" value="opaque">
			</object>
    	</td>
  	</tr>
  	<!-- 
  		includeParams属性值为get时, 该url会将访问其所在jsp的请求的所有的get方法的参数添加到自身来
   	-->
  	<form action='<s:url includeParams="get" encode="true"/>' id="langform" method="post">
		<input type="hidden" name="request_locale" id="langlocale" />
	</form>
  	<tr>
    	<td height="254" align="center" background="images/main_bg.gif" aalign="center" >
    		<table width="960" border="0" cellspacing="0" cellpadding="0">
      			<tr>
        			<td width="240" height="254" align="center" class="main_bg" onMouseOver="this.className='main_bg2'" onMouseOut="this.className='main_bg'">
        				<table width="200" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="30">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
							                <td width="36%" align="right" class="white"><s:text name="RES_EMAIL"/>:&nbsp;&nbsp;</td>
							                <td width="64%" align="left"><input id="account" name="account" type="text" class="input1" id="textfield" onfocus="this.className='input2'" onblur="this.className='input1'"/></td>
						              	</tr>
            						</table>
            					</td>
          					</tr>
          					<tr>
					            <td height="30">
					            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablelimit">
						              	<tr>
							                <td width="36%"  align="right" class="white"><s:text name="RES_PASSWORD"/>:&nbsp;&nbsp;</td>
							                <td width="64%" align="left"><input id="password" name="password" type="password" class="input1" id="textfield2" onfocus="this.className='input2'" onblur="this.className='input1'"/></td>
						              	</tr>
					            	</table>
					            </td>
          					</tr>
          					<tr>
            					<td height="30">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablelimit">
						              	<tr>
						                	<td width="36%" align="right" class="white"><s:text name="RES_FIND_PASSWD_VERCODE"/>:&nbsp;&nbsp;</td>
						                	<td width="32%" align="left"><input id="vercode" name="vercode" type="text" class="input3" id="textfield2" onfocus="this.className='input4'" onblur="this.className='input3'" maxlength="4"/></td>
						                	<td width="32%" align="left"><img src="verCode" width="60" height="24" border="0" id="verImg" onclick="changeVerCode()" style="cursor:pointer"/></td>
						              	</tr>
           							</table>			
            					</td>
          					</tr>
          					<tr>
            					<td height="30" align="center">
            						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
						                	<td align="center"><input type="button" value="<s:text name="RES_LOGIN"/>" class="button2" id="deluimg" name="deluimg"  onClick="login();" style="cursor:pointer" /></td>
						                	<td align="center"><input type="button" value="<s:text name="RES_REGISTER"/>" class="button3"  onclick="location.href='register.action'" style="cursor:pointer" /></td>
						              	</tr>
            						</table>
            					</td>
          					</tr>
          					<tr>
            					<td height="30" align="center">
						            <table width="80%" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
						                	<td width="20%" align="right"><input type="checkbox"  value="" id="remain" name="remain" /></td>
						                	<td width="80%" align="left" class="white"><s:text name="RES_REMAINPWD"/></td>
						              	</tr>
						            </table>
            					</td>
          					</tr>
          					<tr>
            					<td height="30" align="center" class="white"><a href="updatePasswdShow.action"><s:text name="RES_FORGOTPWD"/></a></td>
          					</tr>
        				</table>
        			</td>
        			<td width="240" align="center" class="main_bg"  onmouseover="this.className='main_bg2'" onMouseOut="this.className='main_bg'">
        				<table width="190" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="30" align="center" class="white2"><strong><s:text name="RES_OVERVIEW"/></strong></td>
          					</tr>
          					<tr>
            					<td height="21">
            						<table border="0" cellspacing="0" cellpadding="0">
			              				<tr>
			              					<td >&nbsp;</td>
							                <td id="overview_today_lg" style="cursor:pointer" width="66" class="flag2" height="21" align="center" onClick="this.className='flag1';overview_totil_lg.className='flag2';overview_today.style.display='';overview_totil.style.display='none';"><s:text name="RES_YESTERDAY"/></td>
							                <td width="1"></td>
							                <td id="overview_totil_lg" style="cursor:pointer" width="66" class="flag1" height="21" align="center" onClick="this.className='flag1';overview_today_lg.className='flag2';overview_today.style.display='none';overview_totil.style.display='';"><s:text name="RES_TOTAL"/></td>
			              				</tr>
			            			</table>
            					</td>
          					</tr>
          					<tr>
            					<td height="149" align="center" valign="top">
            						<table id="overview_today" width="100%" border="0" cellspacing="0" cellpadding="0" style="display:none">
						              	<tr>
						                	<td width="59%" height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_CREATESTATION"/></span></td>
						                	<td width="41%" align="right" background="images/main_bg4.gif"><span class="white"><s:property value="ystationnum"/></span>&nbsp;&nbsp;</td>
						              	</tr>
              							<tr>
							                <td height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_OVERVIEW_E_TOTAL"/></span></td>
							                <td align="right" background="images/main_bg4.gif"><span class="white"><s:property value="e_ytotal"/> <s:property value="e_ytotal_unit"/></span>&nbsp;&nbsp;</td>
              							</tr>
              							<tr>
							                <td height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_CO2V"/></span></td>
							                <td align="right" background="images/main_bg4.gif"><span class="white"><s:property value="co2_ytotal"/> <s:property value="co2_ytotal_unit"/></span>&nbsp;&nbsp;</td>
              							</tr>
            						</table>
            						<table id="overview_totil" width="100%" border="0" cellspacing="0" cellpadding="0" >
              							<tr>
							                <td width="59%" height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_PLANT"/></span></td>
							                <td width="41%" align="right" background="images/main_bg4.gif"><span class="white"><s:property value="stationnum"/></span>&nbsp;&nbsp;</td>
              							</tr>
						              	<tr>
							                <td height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_OVERVIEW_E_TOTAL"/></span></td>
							                <td align="right" background="images/main_bg4.gif"><span class="white"><s:property value="e_total"/> <s:property value="e_total_unit"/></span>&nbsp;&nbsp;</td>
						              	</tr>
              							<tr>
							                <td height="45" align="left" background="images/main_bg4.gif"><span class="white"><s:text name="RES_CO2V"/></span></td>
							                <td align="right" background="images/main_bg4.gif"><span class="white"><s:property value="co2_total"/> <s:property value="co2_total_unit"/></span>&nbsp;&nbsp;</td>
              							</tr>
            						</table>
            					</td>
          					</tr>
          				</table>
          			</td>
        			<td width="240" align="center" class="main_bg" onMouseOver="this.className='main_bg2'" onMouseOut="this.className='main_bg'" onClick="example()"  style="cursor:pointer">
        				<table width="190" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="35" colspan="2" align="center" class="white2"><br><strong><s:text name="RES_EXTITLE"/></strong></td>
            				</tr>
          					<tr>
					            <td width="80" height="77"><img src="<s:property value="iConIndex"/>" width="75" height="75" /></td>
					            <td width="110" align="left">
					            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
						              	<tr>
						                	<td height="22" align="left" class="white"><strong><s:property value="stationName"/></strong></td>
						              	</tr>
						              	<tr>
						                	<td height="22" align="left" class="white">  </td>
						              	</tr>
            						</table>
            					</td>
          					</tr>
          					<tr>
				              	<td height="35" align="left" ><span class="white">E-Today:</span></td>
				              	<td align="right" ><span class="white"><s:property value="e_Today"/> <s:property value="e_Today_unit"/></span>&nbsp;&nbsp;&nbsp;</td>
            				</tr>
          					<tr>
           						<td height="35" align="left" background="images/main_bg4.gif"><span class="white">E-Total:</span></td>
              					<td align="right" background="images/main_bg4.gif"><span class="white"><s:property value="e_Total"/> <s:property value="e_Total_unit"/></span>&nbsp;&nbsp;&nbsp;</td>
               				</tr>
          					<tr>
            					<td height="30" colspan="2" align="left" class="white" background="images/main_bg4.gif"><s:text name="RES_LASTUPDATE"/>:<s:property value="ludt"/></td>
            				</tr>
        				</table>
        			</td>
        			<td width="240" align="center">
        				<table width="230" border="0" cellspacing="0" cellpadding="0">
          					<tr>
            					<td height="82" valign="bottom"><a href="https://itunes.apple.com/us/app/solarcloud-for-iphone/id536480852?ls=1&mt=8" target="_blank"><img src="images/pic3.gif" width="230" height="74" border="0"/></a></td>
          					</tr>
          					<tr>
           						<td><a href="https://play.google.com/store/apps/details?id=com.org.datacenter&feature=search_result#?t=W251bGwsMSwxLDEsImNvbS5vcmcuZGF0YWNlbnRlciJd" target="_blank"><img src="images/pic4.gif" width="230" height="75"  border="0"/></a></td>
          					</tr>
          					<tr>
            					<td><img src="images/pic5.gif" width="230" height="77" onclick="wapTip()" style="cursor:pointer"/></td>
          					</tr>
        				</table>
        			</td>
      			</tr>
    		</table>
    	</td>
  	</tr>
  	<tr >
    	<td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  	</tr>
</table>
<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="mFlash" 
codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" 
WIDTH="120" HEIGHT="60" id="468x60" ALIGN="" VIEWASTEXT> 
</OBJECT> 
</body>
</html>
