
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
    	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confReport.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script type="text/javascript">
  		$(document).ready(function() {
			confReportMon.init();
			
		});
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


.button1 {
	font-family: Tahoma, Verdana;
	font-size: 14px;
	font-weight: bold;
padding: 0 5px;
color: #ffffff;
background-image: url("images/regin18_bg.gif");
background-repeat: repeat-x;
background-position: 0 50%;
outline: 0px solid #D3E0E7;
height: 30px !important;
border: 0px solid ;
height: 30px;
width:198px;
}
.button2 {
	font-family: Tahoma, Verdana;
	font-size: 14px;
	font-weight: bold;
	padding: 0 5px;
	color: #ffffff;
	background-image: url("images/regin18_bg.gif");
	background-repeat: repeat-x;
	background-position: 0 50%;
	outline: 0px solid #D3E0E7;
	height: 30px !important;
	border: 0px solid ;
	width:198px;
}


-->
</style>
<body  >
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
         <script>
        menuOver('configMenu',2);
        </script>
  </tr>
  
  <tr>
  	<td height="10" bgcolor="#E2F0FA" >
  	</td>
  </tr>
  <tr>
    <td align="center" bgcolor="#E5EFF9"><table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="896" height="121" align="center" background="images/list_bg7.gif">
        <%@include file="stationInfoSub.jsp" %></td>
      </tr>
	   <tr>
         <td align="center"><table width="896" height="45" border="0" cellpadding="0" cellspacing="0">
           <tr height="15"></tr>
           <tr>
             <td width="10">&nbsp;</td>
             <td width="93" align="center" valign="middle" background="images/listbg25.gif" class="white3" onclick="location.href='reportDayShow.action'" style="cursor:pointer"><s:text name="RES_CONF_REPORT_T_DAY"/></td>
             <td width="4">&nbsp;</td>
             <td width="93" align="center" valign="middle" background="images/listbg25_1.gif" class="white3"><s:text name="RES_CONF_REPORT_T_MON"/></td>
             <td width="4">&nbsp;</td>
             <td width="93" align="center" valign="middle" background="images/listbg25.gif" class="white3" onclick="location.href='reportEventShow.action'" style="cursor:pointer"><s:text name="RES_CONF_REPORT_T_EVENT"/></td>
             <td width="93" background="images/list9.gif">&nbsp;</td>
             <td align="right" valign="top">&nbsp;</td>
             <td width="10">&nbsp;</td>
           </tr>
         </table></td>
	   </tr>
      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><img src="images/list5_1.gif" width="896" height="6" /></td>
          </tr>
          <tr>
            <td height="258" align="center" valign="top" background="images/list6.gif"><table width="90%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="40" align="left"><table style="display:none" width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="12%" align="center" class="blue"><s:text name="RES_CONF_REPORT_INFO"/></td>
                    <td width="29%" align="left">
                    <select name="reportId" class="test_input2" id="reportId" onchange="changeReportId(this)">
                    <s:if test="reportId==1">
                      <option value="1" selected="selected"><s:text name="RES_CONF_REPORT_DAY1"/></option>
                    </s:if>
                    <s:else>
                    <option value="1"><s:text name="RES_CONF_REPORT_DAY1"/></option>
                    </s:else>
                     <s:if test="reportId==2">
                      <option value="2" selected="selected"><s:text name="RES_CONF_REPORT_DAY2"/></option>
                    </s:if>
                    <s:else>
                    <option value="2"><s:text name="RES_CONF_REPORT_DAY2"/></option>
                    </s:else>
                     <s:if test="reportId==3">
                      <option value="3" selected="selected"><s:text name="RES_CONF_REPORT_DAY3"/></option>
                    </s:if>
                    <s:else>
                    <option value="3"><s:text name="RES_CONF_REPORT_DAY3"/></option>
                    </s:else>
                    </select></td>
                    <td width="22%" align="right"><img src="images/regin7.gif" width="22" height="22" /></td>
                    <td width="37%" align="center" class="black2"><s:text name="RES_CONF_REPORT_MON_INFO"/></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td bgcolor="#669cb8"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                  <tr>
                    <td width="18%" height="30" align="center" bgcolor="#8fe2fd" class="black3"><s:text name="RES_CONF_REPORT_STATE"/></td>
                    <td width="82%" align="left" bgcolor="#C7EDFF"><table width="20%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="center"> <s:set name="st" value="reportConMap.state"/>
                        <s:if test="#st==0">
                        <input type="radio" name="state" id="state" value="0" checked/>
                        </s:if>
                        <s:else>
                         <input type="radio" name="state" id="state" value="0" />
                        </s:else>
                        </td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_STATE_1"/></td>
                        <td align="center"> 
                        <s:if test="#st==1">
                        <input type="radio" name="state" id="state" value="1" checked/>
                        </s:if>
                        <s:else>
                         <input type="radio" name="state" id="state" value="1" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_STATE_2"/></td>
                      </tr>
                    </table></td>
                  </tr>
                   <tr>
                    <td height="30" align="center" bgcolor="#8fe2fd" class="black3"><s:text name="RES_CONF_REPORT_EMAIL"/></td>
                    <td align="left" bgcolor="#C7EDFF" class="black2"><input name="recieverList" type="text" size="70" id="recieverList" value="<s:property value="reportConMap.reciverlist" />"/><s:text name="RES_CONF_REPORT_EMAIL_FORMAT"/></td>
                  </tr>
                  <tr style="display:none">
                    <td height="30" align="center" bgcolor="#8fe2fd" class="black3"><s:text name="RES_CONF_REPORT_FORMAT"/></td>
                    <td bgcolor="#C7EDFF" align="left" ><table width="20%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="center">
                        <s:set name="rpf" value="reportConMap.rep_format"/>
                        <s:if test="#rpf==0">
                        <input type="radio" name="repFormat" id="repFormat" value="0" checked/>
                        </s:if>
                        <s:else>
                         <input type="radio" name="repFormat" id="repFormat" value="0" />
                        </s:else>
                        
                        </td>
                        <td align="left" class="black2">HTML</td>
                        <td align="center">
                        <s:if test="#rpf==1">
                        <input type="radio" name="repFormat" id="repFormat" value="1" checked/>
                        </s:if>
                        <s:else>
                         <input type="radio" name="repFormat" id="repFormat" value="1" />
                        </s:else>
                        </td>
                        <td align="left" class="black2">TEXT</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr style="display:none">
                    <td height="250" align="center" bgcolor="#8fe2fd" class="black3"><s:text name="RES_CONF_REPORT_DAY_INFO"/></td>
                    <td bgcolor="#C7EDFF" align="left"><table width="30%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="17%" height="33" align="center">
                        <s:if test="reportConMap.itemstr1==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td width="83%" align="left" class="black2"><s:text name="RES_OVERVIEW_E_MONTH"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr2==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_MON_INFO2"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr3==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_MON_INFO3"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr4==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_MON_INFO4"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr5==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_OVERVIEW_E_TOTAL"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr6==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_ALLINCOME"/><br /></td>
                      </tr>
                      <tr>
                        <td height="33" align="center"><s:if test="reportConMap.itemstr7==1">
                        <input type="checkbox" name="itemstr" id="itemstr" checked/>
                        </s:if>
                        <s:else>
                         <input type="checkbox" name="itemstr" id="itemstr" />
                        </s:else></td>
                        <td align="left" class="black2"><s:text name="RES_CONF_REPORT_DAY_INFO7"/></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
	              <td>
	              	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	              		<tr>
	              			<td height="32" align="center"><img src="images/regin7.gif" width="22" height="22" /></td>
                        	<td align="left" class="black2"><s:text name="RES_CONF_REPORT_MON_INFO"/></td>
	              		</tr>
	              	</table>
	              </td>
			  </tr>
			  <tr>
			  	<td height="58">
				</td>
			  </tr>
              <tr>
                <td height="60" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="left"><input type="button" value="<s:text name="RES_CONF_REPORT_SENDNOW"/>" class="button1" id="sendreport" style="cursor:pointer"></td>
                    <td align="right"><input type="button" value="<s:text name="RES_CONF_REPORT_SAVE"/>" class="button2" id="savereport" style="cursor:pointer"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="6"><img src="images/list5.gif" width="896" height="6" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
      				
      				<td height="15"></td>
                    
      </tr>
    </table></td>
  </tr>
  <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>
<form name="changeForm" method="post">
<input type="hidden" name="reportId" value="">
</form>
</body>
</html>
