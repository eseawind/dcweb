<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<form action='<s:url includeParams="get" encode="true"/>' id="langform" method="post">
	<input type="hidden" name="request_locale" id="langlocale" />
	<input type="hidden" name="stationId" id="stationId" value="<s:property value="#session.defaultStation" />" />
	<input type="hidden" name="tableId" id="tableId" value="<s:property value="#session.tableId"/>"/>
</form>
<form action='' name="menumainform" id="menumainform" method="post">
	<input type="hidden" name="stationId" id="stationId" value="<s:property value="#session.defaultStation" />" />
	<input type="hidden" name="tableId" id="tableId" />
</form>
<script type="text/javascript">
	var nowMenuId="menu";
	function changeMenusMain(url,tid){
		document.menumainform.action=url;
		if (tid!=null)
			document.menumainform.tableId.value=tid;
		document.menumainform.submit();
	}
	
	function menuOver(menuName,menuId){
		if(menuId!=null)
			nowMenuId=nowMenuId+menuId;
		var menu=document.getElementById(menuName);
		var ovmenu=document.getElementById("overviewMenu");
		ovmenu.style.display='none';
		var gmenu=document.getElementById("graphsMenu");
		gmenu.style.display='none';
		var cmenu=document.getElementById("configMenu");
		cmenu.style.display='none';
		var umenu=document.getElementById("userMenu");
		umenu.style.display='none';
		var amenu=document.getElementById("adminMenu");
		amenu.style.display='none';
		var nmenu=document.getElementById("nullMenu");
		nmenu.style.display='none';
		menu.style.display='';
	 	menu=document.getElementById("mainMenuImg1");
		if(menu!=null){
			menu.src="images/dh_list_1_1.gif";
			mainMenu1.className="white3";
		}
	 	menu=document.getElementById("mainMenuImg2");
		if(menu!=null){
			menu.src="images/dh_list_2_1.gif";
			mainMenu2.className="white3";
		}
	 	menu=document.getElementById("mainMenuImg3");
		if(menu!=null){
			menu.src="images/dh_list_3_1.gif";
			mainMenu3.className="white3";
		}
	 	menu=document.getElementById("mainMenuImg4");
	 	if(menu!=null){
			menu.src="images/dh_list_4_1.gif";
			mainMenu4.className="white3";
		}
	 	menu=document.getElementById("mainMenuImg5");
		if(menu!=null){
			menu.src="images/dh_list_4_1.gif";
			mainMenu5.className="white3";
		}
		
		if (menuName=="overviewMenu"){
			mainMenuImg1.src="images/dh_list_1.gif";
			mainMenu1.className="blue";
		}else if(menuName=="graphsMenu"){
			mainMenuImg2.src="images/dh_list_2.gif";
			mainMenu2.className="blue";
		}else if(menuName=="configMenu"){
			mainMenuImg3.src="images/dh_list_3.gif";
			mainMenu3.className="blue";
		}else if(menuName=="userMenu"){
			mainMenuImg4.src="images/dh_list_4.gif";
			mainMenu4.className="blue";
		}else if(menuName=="adminMenu"){
			mainMenuImg5.src="images/dh_list_4.gif";
			mainMenu5.className="blue";
		}
		if(menuId!=null){
			var menu=document.getElementById("menu"+menuId);
			menu.className="blue";
		}
	}
	
	function changeMenus(str){
		changeMenu.action=str;
		changeMenu.submit();
	}

	function selectMenuStyle(menuId){
		var menu=document.getElementById("menu"+menuId);
		menu.className="blue";
	}

	// 鼠标经过事件 
	function overMenuID(obj){
		obj.className="blue";
	}

	// 鼠标离开事件 
	function outMenuID(obj){
		if(obj.id!=nowMenuId){
			obj.className="white3";
		}
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
					            <td width="5%">&nbsp;</td>
					            <td width="95%" align="left" class="blue">
            						<table  border="0" cellpadding="0" cellspacing="0" alight="left">
              							<tr>
              								<s:if test="#session.defaultStation!=0">
                							<td width="43" height="34" class="blue">
                								<img src="images/dh_list_1_1.gif" height="30" id="mainMenuImg1" name="mainMenuImg1"/>
                							</td>
											<td id="mainMenu1" width="150" height="34" class="white3" onmouseOver="menuOver('overviewMenu')" style="cursor:pointer">
                  								<s:text name="RES_OVERVIEW"/>&nbsp;
                  							</td>
                							<td width="43" height="34" class="blue"><img src="images/dh_list_2_1.gif" width="43" height="30" id="mainMenuImg2"/></td>
											<td id="mainMenu2" width="150" align="right" class="white3" onmouseOver="menuOver('graphsMenu')" style="cursor:pointer"> 
												<div align="left"><strong><s:text name="RES_CHART"/>&nbsp;</strong></div>
											</td>
              								</s:if> 
               								<s:if test="#session.user.UserId!=0">
              								<s:if test="#session.userMenu.config==1"> 
											<td width="43" height="34" class="blue">
												<img src="images/dh_list_3_1.gif" width="43" height="30" id="mainMenuImg3"/>
							                </td>
				 							<td id="mainMenu3" width="150" class="white3" onmouseOver="menuOver('configMenu')" style="cursor:pointer">
				 								<strong><s:text name="RES_CONF"/></strong>&nbsp;
				 							</td>
               								</s:if>  
                							<td width="43" height="34" class="blue">
                								<img src="images/dh_list_4_1.gif" width="43" height="30" id="mainMenuImg4"/>
                							</td>
											<td id="mainMenu4" width="150" class="white3" onmouseOver="menuOver('userMenu')" style="cursor:pointer">
												<strong><s:text name="RES_USER"/></strong>&nbsp;
											</td>
                							</s:if> 
                							<s:if test="#session.user.UserId!=0">
              								<s:if test="#session.userMenu.manager==1"> 
               								<td width="43" height="34" class="blue">
               									<img src="images/dh_list_4_1.gif" width="43" height="30" id="mainMenuImg5"/>
               								</td>
											<td id="mainMenu5" width="150"  class="white3" onmouseOver="menuOver('adminMenu')" style="cursor:pointer">
												<strong><s:text name="RES_MANAGER"/></strong>&nbsp;
											</td>
                 							<td></td>
                 							</s:if> 
                 							</s:if> 
              							</tr>
            						</table>
            					</td>
          					</tr>
        				</table>
        			</td>
        			<td width="292" align="center" valign="top">
        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
          					<tr>
          						<td height="30"  align="center" class="black2"><s:property value="#session.user.Account"/></td>
			            		<!-- <td height="30"  align="center" class="black2"><s:text name="RES_WELCOME"/><s:property value="#session.user.firstName"/>&nbsp;<s:property value="#session.user.secondName"/></td>	-->
			            		
			              		<td width="30" align="right"><img src="images/home_icob.gif" width="21" height="20" onclick="location.href='mainPage.action'" style="cursor:pointer" title="<s:text name="RES_POWERLIST"/>"/></td>
			            		<td width="30" align="center"><img src="images/home_icon2.gif" width="21" height="20" onclick="logout();" style="cursor:pointer" title="<s:text name="RES_QUIT"/>"/></td>
			          		</tr> 
        				</table>
        			</td>
				</tr>
			</table>
		</td>
  	</tr>
  	<!-- config管理菜单 -->
   	<tr style="display:none" id="configMenu" >
   		<td height="34" align="center" bgcolor="#E2F0FA" colspan="2">
      		<table width="960" border="0" cellspacing="0" cellpadding="0">
    			<tr>
     				<td width="335" height="34" align="center"></td>
     				<td align="left">
      					<table border="0" cellspacing="0" cellpadding="0">
        					<tr>
        						<td width="6" height="34" align="center" class="white3">&nbsp;</td>
          						<s:if test="#session.userMenu.dev==1">
					          	<td width="1" bgcolor="#FFFFFF"></td>
					          	<td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='equip_view.action'" style="cursor:pointer" id="menu1" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_EQUIPMENTOVERVIEW"/></td>
					          	</s:if>
          						<s:if test="#session.userMenu.report==1">
						        <td width="1" bgcolor="#FFFFFF"></td>
						        <td width="96" align="center" bgcolor="#7A7E98"  class="white3"   onclick="location.href='reportDayShow.action'" style="cursor:pointer" id="menu2" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"> <s:text name="RES_CONFIG_REPORT"/></td>
          						</s:if>
          						<s:if test="#session.userMenu.plant==1">
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='showStationModify.action'" style="cursor:pointer"  id="menu3" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_STATION"/></td>
          						</s:if>
		  						<s:if test="#session.userMenu.share==1">
		  						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='shareAccountList.action'" style="cursor:pointer" id="menu4" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_SHARE"/></td>
          						</s:if>
          					</tr>
      					</table>
      				</td>
    			</tr>
  			</table>
		</td>
    </tr>
    <!-- user菜单 -->
    <tr style="display:none" id="userMenu">
  		<td height="34" align="center" bgcolor="#E2F0FA">
  			<table width="960" border="0" cellspacing="0" cellpadding="0">
    			<tr>
       				<s:if test="#session.defaultStation==0">
       				<td width="80" height="34" align="center" class="blue1"></td>
       				<td width="950" align="left">
    				</s:if>
    				<s:else>
     				<td width="460" height="34" align="center" class="blue1"></td>
      				<td align="left" >
    				</s:else> 
    					<table border="0" cellspacing="0" cellpadding="0">
        					<tr>         
          						<td width="1" height="34" align="center" bgcolor="#ffffff" ></td>
         						<td width="96" align="center" bgcolor="#7A7E98" style="cursor:pointer" class="white3" onclick="location.href='editAccountConfig.action'" id="menu5" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONF_USER_EDITINFO"/></td>
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="140" align="center" bgcolor="#7A7E98" class="white3" onclick="location.href='changeUserPwd.action'" style="cursor:pointer"  id="menu6" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CHANGEPASSWORD"/></td>
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
        					</tr>
        				</table>
        			</td>
    			</tr>
  			</table>
  		</td>
  	</tr>
  	<!-- overview菜单 -->
   	<tr style="display:none" id="overviewMenu" name="overviewMenu">
  		<td height="34" align="center" bgcolor="#E2F0FA">
  			<table width="960" border="0" cellspacing="0" cellpadding="0">
  				<tr>
    				<td width="70" height="34" align="left" class="blue1" ></td>
            		<td align="left" >
						<table border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td width="96" height="34" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='overview.action'" style="cursor:pointer" id="menu7" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_Allview"/></td>
                				<td width="1" bgcolor="#FFFFFF"></td>
                				<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="location.href='power.action'" style="cursor:pointer" id="menu8" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_POWER"/></td>
                				<td width="1" bgcolor="#FFFFFF"></td>
                				<td width="96" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='event.action'" style="cursor:pointer" id="menu9" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_EVENT_LINK"/></td>
              				</tr>
            			</table>
					</td>
  				</tr>
  			</table>
  		</td>
  	</tr>
  	<!-- graphs菜单 -->
  	<tr style="display:none" id="graphsMenu">
  		<td height="34" align="center" bgcolor="#E2F0FA" colspan="2">
  			<table width="960" border="0" cellspacing="0" cellpadding="0">
    			<tr>
      				<td width="135" height="34" align="center"><span class="blue1" id="chartMenuSpan"></span></td>
      				<td >
      					<table border="0" cellspacing="0" cellpadding="0">
        					<tr>
          						<td width="96" height="34" align="center" class="white3">&nbsp;</td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',18)" style="cursor:pointer" id="menu18" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RED_CHART_ENERGY"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',11)" style="cursor:pointer" id="menu11" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_INCOME"/> </td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',10)" style="cursor:pointer" id="menu10" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CO2V"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',13)" style="cursor:pointer" id="menu13" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_DCV"/></td>
         	 					<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',12)" style="cursor:pointer" id="menu12" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"> <s:text name="RES_DCC"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',14)" style="cursor:pointer" id="menu14" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_ACF"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',15)" style="cursor:pointer" id="menu15" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_ACC"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',16)" style="cursor:pointer" id="menu16" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_ACV"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
          						<td width="96" align="center" bgcolor="#7A7E98" class="white3" onclick="changeMenusMain('chartShow.action',17)" style="cursor:pointer" id="menu17" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_INVE"/></td>
          						<td width="1" bgcolor="#FFFFFF"><img src="images/list_bg8.gif"></td>
        					</tr>
      					</table>
      				</td>
    			</tr>
  			</table>
  		</td>
  	</tr>
  	<!--  admin菜单 -->
  	<tr style="display:none" id="adminMenu">
  		<td height="34" align="center" bgcolor="#E2F0FA" colspan="2">
  			<table width="960" border="0" cellspacing="0" cellpadding="0">
    			<tr>
      				<s:if test="#session.defaultStation==0">
       					<td width="160" height="34" align="center" class="blue1"></td>
      					<td width="800" align="left">
    				</s:if>
    				<s:else>
     				<td width="160" height="34" align="center" class="blue1"></td><td >
    				</s:else> 
      					<table border="0" cellspacing="0" cellpadding="0">
       						<tr>
        						<td width="6" height="34" align="center" class="white3">&nbsp;</td>
           						<s:if test="#session.userMenu.station==1">
          						<td width="1" bgcolor="#FFFFFF"></td>
          						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='plantmanager.action'" style="cursor:pointer" id="menu19" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_ADMINSTTAIONLIST"/></td>
          						</s:if>
          						<s:if test="#session.userMenu.admin==1">
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='accountList.action'" style="cursor:pointer" id="menu20" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_ADMIN"/></td>
          						</s:if>
          						<s:if test="#session.userMenu.pmu==1">
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
           						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='confPmuList.action'" style="cursor:pointer" id="menu21" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_PUM"/></td>
          						</s:if>
          						<s:if test="#session.userMenu.inv==1">
          						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='confInvList.action'" style="cursor:pointer" style="cursor:pointer" id="menu22" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_INV"/></td>
		  						</s:if>
          						<s:if test="#session.userMenu.user==1">
		  						<td width="1" align="center" bgcolor="#ffffff" ></td>
           						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='accountManagerList.action'" style="cursor:pointer" id="menu23" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_ACCOUNT"/></td>
          						</s:if>         
          						<s:if test="#session.userMenu.event==1">
		  						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='sysqueryevent.action'" style="cursor:pointer" id="menu24" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_EVENT"/></td>
          						</s:if>
          						<s:if test="#session.user.roleId==4">
		  						<td width="1" align="center" bgcolor="#ffffff" ></td>
          						<td width="116" align="center" bgcolor="#7A7E98" class="white3"  onclick="location.href='searchDict.action'" style="cursor:pointer" id="menu25" onmouseover="overMenuID(this)" onmouseout="outMenuID(this)"><s:text name="RES_CONFIG_PARAMETERS"/></td>
          						</s:if>	
          					</tr>	
      					</table>
      				</td>
    			</tr>
  			</table>
  		</td>
  	</tr>
  	<!-- 空菜单 -->
   	<tr id="nullMenu">
  		<td height="34" align="center" bgcolor="#E2F0FA">
  			<table width="960" border="0" cellspacing="0" cellpadding="0">
  				<tr>
    				<td width="70" height="34" align="left" class="blue1"></td>
            		<td align="left"></td>
  				</tr>
  			</table>
  		</td>
  	</tr>
</table>


