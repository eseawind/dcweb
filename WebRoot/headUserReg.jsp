<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
  <form action='<s:url includeParams="get" encode="true"/>' id="langform" method="post">
		 		  <input type="hidden" name="request_locale" id="langlocale" />
		   </form>
		   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td height="120" align="center" background="images/top_bg.gif"><table width="960" border="0" cellspacing="0" cellpadding="0">
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
            <td width="19%" height="34">&nbsp;</td>
            <td width="81%" align="left" class="blue"><span id="titleTip"><s:text name="RES_REGISTER_USER"/></span></td>
          </tr>
        </table>
        </td>
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
            <!-- 
            <td height="30"  align="center" class="black2"><s:text name="RES_WELCOME"/><s:text name="RES_NEWACCOUNT"/></td>
              <td width="30" align="right"><img src="images/home_icob.gif" width="21" height="21" onclick="location.href='mainPage.action'" style="cursor:pointer" title="<s:text name="RES_POWERLIST"/>"/></td>
            <td width="30" align="center"><img src="images/home_icon2.gif" width="21" height="21" onclick="logout();" style="cursor:pointer" title="<s:text name="RES_QUIT"/>"/></td>
             -->
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  </table>