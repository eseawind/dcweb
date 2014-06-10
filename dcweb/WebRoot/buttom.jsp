<table width="960" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="483" align="left" class="black2"><s:text name="RES_COPYRIGHT"/></td>
        <td width="477" align="right" class="black2"> V140123 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 
        
        <%
        String lans="";
        if (session.getAttribute("WW_TRANS_I18N_LOCALE")!=null && session.getAttribute("WW_TRANS_I18N_LOCALE").toString().trim().equals("zh_CN"))
        lans=".cn";
        %>
        <a href="http://www.zeversolar.com<%=lans%>/company.php" target="_blank"><s:text name="RES_ABOUTWE"/></a>
         | <a href="http://www.zeversolar.com<%=lans%>/contact_main.php" target="_blank"><s:text name="RES_LINKWE"/></a> 
         | </td>
      </tr>
    </table>