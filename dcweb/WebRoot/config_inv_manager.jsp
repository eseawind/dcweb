<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/confInv.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<script src="<%= request.getContextPath() %>/js/highcharts/highcharts.js"></script>
	
	<script type="text/javascript">
	<s:if test="#session.userMenu.inv==0">
    
    	location.href="index.action";
    </s:if>
  		$(document).ready(function() {
			confPmu.init();
		});
  	</script>
  </head>

<body >
<table width="1001" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td colspan="2">
        <%@include file="HeadMenu.jsp" %>    </td>
  </tr>
  <script>
  menuOver('adminMenu',22);
  </script>
  <tr>
    <td align="center" bgcolor="#E5EFF9"><table border="0" cellspacing="10" cellpadding="0">
      <tr>
        <td width="896" height="4" align="center" ></td>
      </tr>
      <tr>
        <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
         
          <tr>
            <td align="center"><table width="896" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><table width="896" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="10">&nbsp;</td>
                      <td width="93" align="center" valign="middle" background="images/listbg25.gif" class="white3"  onclick="location.href='confInvList.action'" style="cursor:pointer"><s:text name="RES_CONF_LIST"/></td>
                      <td width="4">&nbsp;</td>
                      <td width="93" align="center" valign="middle" background="images/listbg25_1.gif" class="white3"><s:text name="RES_CONF_STATISTICS"/></td>
                      <td width="93" background="images/list9.gif">&nbsp;</td>
                      <td align="right" valign="top"><table width="15%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><img src="images/list15.gif" width="38" height="33" /></td>
                            <td align="center"><img src="images/list16.gif" width="38" height="33" /></td>
                          </tr>
                      </table></td>
                      <td width="10">&nbsp;</td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="9" align="center" background="images/listbg27.gif"></td>
                </tr>
                <tr>
                  <td align="center" background="images/list_bg6.gif">
                  <table width="80%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="6" colspan="2"></td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" valign="top" class="blue3"><s:text name="RES_CONF_TYLEPROPORTION"/></td>
                    </tr>
                    <tr>
                      <td height="270" align="center" valign="middle">
                      <table width="80%" border="0" cellspacing="4" cellpadding="0">
                         <s:iterator id="pumTp" value="pmuTypeAnalyList" status="em">
                        <tr>
                          <td width="8%" height="30" bgcolor="#<s:property value="#pumTp.color" />" class='black2'>&nbsp;</td>
                          <td width="92%" align="left" class='black2'><s:property value="#pumTp.pt" />:<s:property value="#pumTp.pn" />-------------------------------<s:property value="#pumTp.pp" />%</td>
                        </tr>
                        </s:iterator>
                        <tr>
                          <td></td>
                          <td align="left"></td>
                        </tr> <tr>
                          <td colspan="2"><s:text name="RES_CONF_ANALYTOTAL"/>:<s:property value="analyTotalType" /><s:text name="RES_CONF_ANALYUNIT"/></td>
                        </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                      </table>
                      </td>
                      <td width="270" valign="top">
                      <script type="text/javascript">
					$(function () {
					    var chart;
					    $(document).ready(function() {
					        chart = new Highcharts.Chart({
					            chart: {
					                renderTo: 'typeChart',    
									backgroundColor: '#cae6f9',
					                shadow: false
					            },
								colors: [
									'#AA4643', 
									'#DB843D', 
									'#B5CA92'
					
								],
								credits: {
								enabled  :false,
					            text: '',
					            href: ''
								 },
					
					            title: {
					                text: '',
									verticalAlign:'bottom',
									floating: true,
									y:-3,
									x:-20
					            },
								plotArea: {
					                        shadow: null,
					                        borderWidth: null,
					                        backgroundColor: null
					                    },
					            tooltip: {
					                formatter: function() {
					                    return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage,2, '.') +' %';
					                }
					            },
					            plotOptions: {
					                pie: {
					                    allowPointSelect: true,
					                    cursor: 'pointer',
					                    dataLabels: {
					                        enabled: false,
					                        color: '#000000',
					                        connectorColor: '#000000',
					                        formatter: function() {
					                            return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
					                        }
					
					
					                    },
										     showInLegend: false
					                }
					            },
								 legend: {
					                        layout: 'vertical',
					
					                        style: {
					                            left: 'auto',
					                            bottom: 'auto',
					                            right: '10px',
					                            top: '40px'
					                        }
					                    },
					            series: [{
					                type: 'pie',
					                name: 'Browser share',
					                data: [		
					                	<%
					                	int i=0;
					                	%>
					                     <s:iterator id="pumTp" value="pmuTypeAnalyList" status="em">
					                     <%
					                    if (i!=0)
					                    	out.print(",");
					                    i++;
					                    %>
										{
					                        name: '<s:property value="#pumTp.pt" />',
					                        y: <s:property value="#pumTp.pp" />,
											color:'#<s:property value="#pumTp.color" />'
					
					                    }
					                    
					                    </s:iterator>
					                ],
									 center: [110, 135],
									size:210
					            }]
					        });
					    });
					    
					});
				</script>
					  <div id="typeChart" style="min-width: 270px; height: 270px; margin: 0 auto"></div>
					  </td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" valign="top" class="blue3"><s:text name="RES_CONF_COUNTRYDISTRIBUTED"/></td>
                    </tr>
                    <tr>
                      <td height="270" align="center" valign="middle">
                      <table width="80%" border="0" cellspacing="4" cellpadding="0">
                         <s:iterator id="pumCountry" value="pmuCountryAnalyList" status="em">
                        <tr>
                          <td width="8%" height="30" bgcolor="#<s:property value="#pumCountry.color" />" class='black2'>&nbsp;</td>
                          <td width="92%" align="left" class='black2'><s:property value="#pumCountry.context" />:<s:property value="#pumCountry.pn" />-------------------------------<s:property value="#pumCountry.pp" />%</td>
                        </tr>
                        </s:iterator>
                        <tr>
                          <td></td>
                          <td align="left"></td>
                        </tr> <tr>
                          <td colspan="2"><s:text name="RES_CONF_ANALYTOTAL"/>:<s:property value="analyTotalCountry" /><s:text name="RES_CONF_ANALYUNIT"/></td>
                        </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                      </table>
                      
                      </td>
                      <td height="270" valign="top">
                      <script type="text/javascript">
					$(function () {
					    var chart;
					    $(document).ready(function() {
					        chart = new Highcharts.Chart({
					            chart: {
					                renderTo: 'countryChart',    
									backgroundColor: '#cae6f9',
					                shadow: false
					            },
								colors: [
									'#AA4643', 
									'#DB843D', 
									'#B5CA92'
					
								],
								credits: {
								enabled  :false,
					            text: '',
					            href: ''
								 },
					
					            title: {
					                text: '',
									verticalAlign:'bottom',
									floating: true,
									y:-3,
									x:-20
					            },
								plotArea: {
					                        shadow: null,
					                        borderWidth: null,
					                        backgroundColor: null
					                    },
					            tooltip: {
					                formatter: function() {
					                    return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage,2, '.') +' %';
					                }
					            },
					            plotOptions: {
					                pie: {
					                    allowPointSelect: true,
					                    cursor: 'pointer',
					                    dataLabels: {
					                        enabled: false,
					                        color: '#000000',
					                        connectorColor: '#000000',
					                        formatter: function() {
					                            return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
					                        }
					
					
					                    },
										     showInLegend: false
					                }
					            },
								 legend: {
					                        layout: 'vertical',
					
					                        style: {
					                            left: 'auto',
					                            bottom: 'auto',
					                            right: '10px',
					                            top: '40px'
					                        }
					                    },
					            series: [{
					                type: 'pie',
					                name: 'Browser share',
					                data: [		
					                	<%
					                	 i=0;
					                	%>
					                     <s:iterator id="pumCountry" value="pmuCountryAnalyList" status="em">
					                     <%
					                    if (i!=0)
					                    	out.print(",");
					                    i++;
					                    %>
										{
					                        name: '<s:property value="#pumCountry.context" />',
					                        y: <s:property value="#pumCountry.pp" />,
											color:'#<s:property value="#pumCountry.color" />'
					
					                    }
					                    
					                    </s:iterator>
					                ],
									 center: [110, 135],
									size:210
					            }]
					        });
					    });
					    
					});
				</script>
					   <div id="countryChart" style="min-width: 270px; height: 270px; margin: 0 auto"></div>
					  </td>
                    </tr>
                  </table>                  </td>
                </tr>
                <tr>
                  <td height="7" align="right" background="images/listbg26.gif"></td>
                </tr>
            </table></td>
          </tr>
         
        </table></td>
      </tr>
    </table>
    <p>&nbsp;</p></td>
  </tr>
   <tr >
    <td height="48" align="center" bgcolor="#A4A7AE" colspan="3"><%@include file="buttom.jsp" %></td>
  </tr>
</table>
</body>
</html>
