<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dd1.css" type="text/css"></link>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/inner.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/menu.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/iphoto_flash.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/swfobject.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/datepicker/WdatePicker.js"></script>
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
<script>

 function getStateList(cid){ 
 alert(cid);
      var datajson = {"countryId":cid};
      var s;
       $.ajax({
	            type: "POST",
	            url:'json/ajaxgetstate.action', 
        		 dataType:'json',          
	    		 data: datajson,
	            success: function(data){
	            $each(data.stateList,function(i,value){
	             s.append(value.getStateId).append(value.getStateName);
	            })
	            },
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	        });
	   alert(s);
    } 
</script>
<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td >
    <%@include file="head.jsp" %>
    </td>
  </tr>
  <tr>
    <td height="554" align="center" bgcolor="#E5EFF9"><table border="0" cellspacing="18" cellpadding="0">
      <tr>
        <td width="896" height="64" align="center" background="images/list_bg3.gif"><table width="94%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="13%" align="right" class="black4"><s:text name="RES_COUNTRY"></s:text></td>
            <td width="20%" align="center"><select name="select2" class="test_input7" id="select2" onchange="getStateList(this.value)">
             <s:iterator id="country" status="ss" value="countryList">
	         <option value="<s:property value="#country.c_code" />"><s:property value="countryname" /></option>
     		</s:iterator>
                        </select></td>
            <td width="13%" align="right" class="black4"><s:text name="RES_STATE"></s:text></td>
            <td width="20%" align="center"><select name="select3" class="test_input7" id="select3" >
                        </select></td>
            <td width="13%" align="right" class="black4"><s:text name="RES_STATIONNAME"></s:text></td>
            <td width="20%" align="center"><input name="textfield4" type="text" class="test_input7" id="textfield4"  size="20"/></td>
            <td width="7%"><img src="images/dz_list5.gif" width="63" height="28" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="121" align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="34" align="center" background="images/list_bg4.gif"><table width="894" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="39" height="30" align="center">&nbsp;</td>
                <td width="134" align="center" class="black">çµç«åç§°</td>
                <td width="94" align="center" class="black">å½å®¶</td>
                <td width="94" align="center" class="black">å·/ç</td>
                <td width="94" align="center" class="black">åå¸</td>
                <td width="100" align="center" class="black">åå»ºæ¥æ</td>
                <td width="100" align="center" class="black">è£æºå®¹é</td>
                <td width="101" align="center" class="black">æ°æ®æ´æ°æ¶é´</td>
                <td width="138" align="center" class="black">ç®¡çåè´¦å·</td>
              </tr>
              
            </table></td>
          </tr>
          <tr>
            <td align="center" background="images/list_bg6.gif"><table width="894" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="39" height="36" align="center"><img src="images/dz_list6.gif" width="14" height="14" /></td>
                <td width="134" align="left" class="black2">**********</td>
                <td width="94" align="center" class="black2">ä¸­å½</td>
                <td width="94" align="center" class="black2">æ±è</td>
                <td width="94" align="center" class="black2">åäº¬</td>
                <td width="100" align="center" class="black2">2012-02-12</td>
                <td width="100" align="center" class="black2">000000</td>
                <td width="101" align="center" class="black2">2012-02-12</td>
                <td width="138" align="center" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center" bgcolor="#B5D5EA"><img src="images/dz_list7.gif" width="14" height="14" /></td>
                <td align="left" bgcolor="#B5D5EA" class="black2">**********</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">ä¸­å½</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">æ±è</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">åäº¬</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">000000</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center"><img src="images/dz_list6.gif" width="14" height="14" /></td>
                <td align="left" class="black2">**********</td>
                <td align="center" class="black2">ä¸­å½</td>
                <td align="center" class="black2">æ±è</td>
                <td align="center" class="black2">åäº¬</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">000000</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center" bgcolor="#B5D5EA"><img src="images/dz_list7.gif" width="14" height="14" /></td>
                <td align="left" bgcolor="#B5D5EA" class="black2">**********</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">ä¸­å½</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">æ±è</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">åäº¬</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">000000</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center"><img src="images/dz_list6.gif" width="14" height="14" /></td>
                <td align="left" class="black2">**********</td>
                <td align="center" class="black2">ä¸­å½</td>
                <td align="center" class="black2">æ±è</td>
                <td align="center" class="black2">åäº¬</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">000000</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center" bgcolor="#B5D5EA"><img src="images/dz_list7.gif" width="14" height="14" /></td>
                <td align="left" bgcolor="#B5D5EA" class="black2">**********</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">ä¸­å½</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">æ±è</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">åäº¬</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">000000</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center"><img src="images/dz_list6.gif" width="14" height="14" /></td>
                <td align="left" class="black2">**********</td>
                <td align="center" class="black2">ä¸­å½</td>
                <td align="center" class="black2">æ±è</td>
                <td align="center" class="black2">åäº¬</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">000000</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center" bgcolor="#B5D5EA"><img src="images/dz_list7.gif" width="14" height="14" /></td>
                <td align="left" bgcolor="#B5D5EA" class="black2">**********</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">ä¸­å½</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">æ±è</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">åäº¬</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">000000</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center"><img src="images/dz_list6.gif" width="14" height="14" /></td>
                <td align="left" class="black2">**********</td>
                <td align="center" class="black2">ä¸­å½</td>
                <td align="center" class="black2">æ±è</td>
                <td align="center" class="black2">åäº¬</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">000000</td>
                <td align="center" class="black2">2012-02-12</td>
                <td align="center" class="black2">deom@126.com</td>
              </tr>
              <tr>
                <td height="36" align="center" bgcolor="#B5D5EA"><img src="images/dz_list7.gif" width="14" height="14" /></td>
                <td align="left" bgcolor="#B5D5EA" class="black2">**********</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">ä¸­å½</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">æ±è</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">åäº¬</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">000000</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">2012-02-12</td>
                <td align="center" bgcolor="#B5D5EA" class="black2">deom@126.com</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="34" align="right" background="images/list_bg5.gif"><table width="20%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><img src="images/dz_list8.gif" width="17" height="19" /></td>
                <td align="center"><img src="images/dz_list10.gif" width="19" height="19" /></td>
                <td align="center"><input name="textfield13" type="text" class="test_input4" id="textfield15" value="1/20" size="6" /></td>
                <td align="center"><img src="images/dz_list11.gif" width="19" height="19" /></td>
                <td align="center"><img src="images/dz_list9.gif" width="17" height="19" /></td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      
    </table></td>
  </tr>
  <tr>
    <td height="48" align="center" bgcolor="#A4A7AE" ><table width="960" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="483" align="left" class="black2">@2012 zeversolar å¬å¸ï½å¤æ¡å·:FAQ</td>
        <td width="477" align="right" class="black2">ï½å³äºZECERSOLARï½èç³»æä»¬ï½ </td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
