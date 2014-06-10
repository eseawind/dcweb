<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
  <form action='<s:url includeParams="get" encode="true"/>' id="langform" method="post">
		 		  <input type="hidden" name="request_locale" id="langlocale" />
		   </form>
  <form action='' id="menumainform" method="post">
		 		  <input type="hidden" name="stationId" id="stationId" value="<s:property value="#session.defaultStation" />" />
		 		  <input type="hidden" name="tableId" id="tableId" />
		   </form>
		   
<script>
function changeMenusMain(url,tid){
	menumainform.action=url;
	if (tid!=null)
	menumainform.tableId.value=tid;
	
	menumainform.submit();
}
function menuOver(menuName){
	var menu=document.getElementById(menuName);
	overviewMenu.style.display='none';
	graphsMenu.style.display='none';
	configMenu.style.display='none';
	userMenu.style.display='none';
	menu.style.display='';
}
function changeMenus(str){
	changeMenu.action=str;
	changeMenu.submit();
}
</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td height="120" align="center" background="images/top_bg.gif">
    <table width="960" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="668" height="120" align="left" valign="bottom" class="logo">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%" height="80" onclick="window.location.href='http://solarcloud.zeversolar.com'" style="cursor:pointer">&nbsp;</td>
            <td width="70%" align="left" class="blue">&nbsp;</td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">&nbsp;</td>
            <td width="81%" align="left" class="blue">
            <table  width="600"  border="0" cellpadding="0" cellspacing="0">
              <tr>
              <s:if test="#session.defaultStation!=0">
                <td width="43" height="34" class="blue"><img src="images/dh_list_1.gif" height="30" id="mainMenuImg1"/></td>
				<td id="mainMenu1" width="150" height="34" class="blue" onmouseOver="menuOver('overviewMenu')">
                  <s:text name="RES_OVERVIEW"/>&nbsp;</td>
                <td width="43" height="34" class="blue"><img src="images/dh_list_2_1.gif" width="43" height="30" id="mainMenuImg2"/></td>
				<td id="mainMenu2" width="150" align="right" class="white3"  onmouseOver="menuOver('graphsMenu')" onclick="changeMenusMain('chartShow.action',13)" style="cursor:pointer"> <div align="left"><strong> 
                  <s:text name="RES_CHART"/>&nbsp;</strong></div></td>
               </s:if>
                <s:if test="#session.user.UserId!=0">
               <s:if test="#session.userMenu.haveMenu==1">
                 <td width="43" height="34" class="blue"><img src="images/dh_list_3_1.gif" width="43" height="30" id="mainMenuImg3"/></td>
				 <td id="mainMenu3" width="150"  class="white3"  onmouseOver="menuOver('configMenu')" onclick="changeMenusMain('<s:property value="#session.userMenu.page"/>')" style="cursor:pointer"><strong>
                  <s:text name="RES_CONF"/></strong>
                 &nbsp;</td>
                 </s:if>
                <td width="43" height="34" class="blue"><img src="images/dh_list_4_1.gif" width="43" height="30" id="mainMenuImg4"/></td>
				<td id="mainMenu2" width="150"  class="white3" onmouseOver="menuOver('userMenu')" onclick="changeMenusMain('editAccountConfig.action')" style="cursor:pointer"><strong><s:text name="RES_USER"/></strong>&nbsp;</td>
                </s:if>
                 <td></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="292" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%" height="60"   align="right" colspan="3">
            <table width="70%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="80%" align="center">
            <div class="divlang" style="z-index:2;">
                    <ul>
	                    <li style="background: transparent url(images/lang/language_drop.gif) no-repeat scroll 0pt 3px; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; height: 22px; width: 167px;">
	                    <a class="droplang" href="#"><img id="_ctl0_HeaderLanguageMenuControl_ImgLanguageSelected" src="images/lang/<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>_on.gif" border="0"><!--[if IE 7]><!--></a><!--<![endif]--><!--[if IE 8]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table cellpadding="0" cellspacing="0"><tr><td><![endif]-->
	                    <ul>
		                 <li><a href="#"><img src="images/lang/uk_tp.gif" alt="English" title="English" width="118" height="22" onclick="changeLange('en_US')"/></a></li>
		                 <li><a href="#"><img src="images/lang/china_tp.gif" alt="Chinese" title="Chinese" width="118" height="22" onclick="changeLange('zh_CN')"/></a></li>
	                  	 <li><a href="#"><img src="images/lang/dansk_tp.gif" alt="Dansk" title="Dansk" width="118" height="22" onclick="changeLange('da_DK')"/></a></li>
		                 
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
          <tr>
            <td height="30"  align="center" class="black2"><s:text name="RES_WELCOME"/> <s:property value="#session.user.firstName"/>&nbsp;<s:property value="#session.user.secondName"/></td>
              <td width="30" align="right"><img src="images/home_icob.gif" width="21" height="21" onclick="location.href='mainPage.action'" style="cursor:pointer" title="<s:text name="RES_POWERLIST"/>"/></td>
            <td width="30" align="center"><img src="images/home_icon2.gif" width="21" height="21" onclick="logout();" style="cursor:pointer" title="<s:text name="RES_QUIT"/>"/></td>
          </tr> 
        </table></td>
      </tr>
    </table>
    </td>
  </tr>
  <!-- admin管理菜单 -->
   <tr  style="display:none" id="configMenu" >
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
    <!-- user菜单 -->
    <tr  style="display:none" id="userMenu">
  <td height="30" align="center" bgcolor="#E2F0FA">
  <table width="960" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <s:if test="#session.defaultStation==0">
       <td width="1" height="30" align="center" class="blue1"></td>
      <td width="950" align="left">
    </s:if>
    <s:else>
    <td width="190" height="30" align="center" class="blue1"></td>
      <td width="581">
    </s:else> 
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="96" height="30" align="center" class="white3">&nbsp;</td>
         
          <td width="96" align="center" class="white3">&nbsp;</td>
          <td width="96" align="center" class="white3">&nbsp;</td>
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="blue"><s:text name="RES_CONF_USER_EDITINFO"/></td>
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="location.href='changeUserPwd.action'" style="cursor:pointer" ><s:text name="RES_CHANGEPASSWORD"/></td>
          <td width="1" align="center" bgcolor="#ffffff" ></td>
          <td width="96" align="center" class="white3">&nbsp;</td>
        </tr>
        </table></td>
    </tr>
  </table></td>
  </tr>
  <!-- overview菜单 -->
   <tr  style="display:none" id="overviewMenu">
  <td height="30" align="center" bgcolor="#E2F0FA">
  <table width="960" border="0" cellspacing="0" cellpadding="0">
  <tr >
            <td  width="100" height="34" align="center" class="blue1" ></td>
            <td width="901" align="left" >
			<table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="96" height="34" align="center" bgcolor="#7A7E98" class="blue"><s:text name="RES_Allview"/></td>
                <td width="1" bgcolor="#FFFFFF"></td>
                <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenus('power.action')" style="cursor:pointer"><s:text name="RES_POWER"/></td>
                <td width="1" bgcolor="#FFFFFF"></td>
                <td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="changeMenus('event.action')" style="cursor:pointer"><s:text name="RES_EVENT"/></td>
              </tr>
            </table>
			</td>
  </tr>
  </table></td>
  </tr>
  <!-- graphs菜单 -->
  <tr style="display:none" id="graphsMenu">
  <td height="30" align="center" bgcolor="#E2F0FA" colspan="2">
  <table width="960" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="145" height="34" align="center"><span class="blue1" id="chartMenuSpan"></span></td>
      <td width="815">
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="96" height="34" align="center" class="white3">&nbsp;</td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',17)" style="cursor:pointer" id="menu17"><s:text name="RES_INVE"/>                     <br /></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',12)" style="cursor:pointer" id="menu12"> <s:text name="RES_DCC"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',13)" style="cursor:pointer" id="menu13"><s:text name="RES_DCV"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',18)" style="cursor:pointer" id="menu18"><s:text name="RED_CHART_ENERGY"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',14)" style="cursor:pointer" id="menu14"><s:text name="RES_ACF"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',15)" style="cursor:pointer" id="menu15"><s:text name="RES_ACC"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',16)" style="cursor:pointer" id="menu16"><s:text name="RES_ACV"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',11)" style="cursor:pointer" id="menu11"><s:text name="RES_INCOME"/> </td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          <td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',10)" style="cursor:pointer" id="menu10"><s:text name="RES_CO2V"/></td>
          <td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
       
       
        </tr>
      </table></td>
    </tr>
  </table></td>

  </tr>
  </table>