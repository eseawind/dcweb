<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="./skins/blue.css"/>
	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
	<script src="./js/artDialog.min.js"></script>
	<base target="_parent"/>
	<script type="text/javascript">
		var inputT=0;
		function changeType(raid){
			inputT=raid.value;
		}

		function submitForm(form){
			if(inputT==0){
				form.enctype="multipart/form-data";
				if(form.file.value==""){
					alert("请选择需要导入的文件！");
					return false;
				}
				form.action="pmuImport.action";
				return true;
			}else{
				var psno = $("#psno").val();
				if(""==jQuery.trim(psno)){
					alert("请输入序列号！");
					return false;
				}
				var idex = $("#idex").val();
				if(""==jQuery.trim(idex)){
					alert("请输入注册码！");
					return false;
				}
				var type = $("#type").val();
				var devname = $("#devname").val();
				var xh = $("#xh").val();
				var factory = $("#factory").val();
				var penpai = $("#penpai").val();
				var softver = $("#softver").val();
				var hardver = $("#hardver").val();
				var url = "inputPmu.action";
				var datajson = {"psno":psno, "idex":idex, "type":type, "devname":devname, "xh":xh, "factory":factory, "penpai":penpai, "softver":softver, "hardver":hardver};
				$.ajax({
		            type: "POST",
		            url: url,
		            dataType: "json",
		            data: datajson,
		            success: listPmuInfo,
		            error: function () {
	                	alert(RES.REQUESTWRONG);
	            	}
    			});
			}
			return false;
		}
		
		function listPmuInfo(data, textStatus, jqXHR){
			if(data.status == 'ok'){
				alert("录入成功！")
				$("#psno").val("EA8989");
				$("#idex").val("");
				//$("#type").val("");
				//$("#devname").val("");
				//$("#xh").val("");
				//$("#factory").val("");
				//$("#penpai").val("");
				//$("#softver").val("");
				//$("#hardver").val("");
			}else{
				if(data.errorcode == "1"){
					alert('该序列号的PMU已经存在！');
				}
			}
		}

		function checkNum(val){
			var re = /^[0-9]+.?[0-9]*$/; 
     		if (!re.test(val)){
        		return false;
     		}
     		return true;
		}
	</script>
</head>
<body scroll="no">
<form id="form1" name="form1" method="post" action="pmuImport.action" enctype="multipart/form-data" onsubmit="return submitForm(this);">
	<table width="550" border="0" align="center" cellpadding="0" cellspacing="0">
  		<tr>
    		<td align="center" bgcolor="#E5EFF9">
	    		<table width="98%" border="0" cellspacing="0" cellpadding="0">
			      	<tr>
			        	<td align="center" background="images/regin6.gif">
			        		<table width="90%" border="0" cellspacing="0" cellpadding="0">
			          			<tr>
			            			<td height="30" colspan="3" class="blue"><div align="left">PMU信息录入</div></td>
			            		</tr>
			          			<tr>
			            			<td height="30" colspan="3" class="black2">
			            				<label>
			              				<div align="left">
			                			<input type="radio" name="inputType" value="0" checked onclick="changeType(this)"/>
			               				 批量导入
			                			<input name="file" type="file" class="test_input5" />
			                			</div>
			            				</label>
			            			</td>
			            		</tr>
			          			<tr>
			            			<td width="29%" height="30" class="black2">
			            				<div align="left">
			              				<input type="radio" name="inputType" value="1" onclick="changeType(this)"/>
			             				 手工录入
			             				</div>
			             			</td>
			            			<td width="25%" height="30" class="black2">
			            				<label>
			              				<input type="submit" name="Submit" value="提交" />
			            				</label>
			            			</td>
			            			<td width="29%" height="30" class="black2">&nbsp;</td>
			          			</tr>
			          			<tr>
			            			<td colspan="3" bgcolor="#FFFFFF" class="black2">
										<table width="100%" border="0" cellpadding="0" cellspacing="1">
			              					<tr>
			                					<td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">序列号：</div></td>
			                					<td width="24%" height="30" bgcolor="#c7edff">
			                  						<input id="psno" name="psno" type="text" class="test_input8" value="EA8989"/>
			               						</td>
			                					<td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">注册码：</div></td>
			                					<td width="29%" height="30" bgcolor="#c7edff">
			                						<input id="idex"  name="idex" type="text" class="test_input8" />
			                					</td>
			              					</tr>
			             	 				<tr>
			                					<td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">类型：</div></td>
			                					<td width="24%" height="30" bgcolor="#c7edff">
			                						<input id="type"  name="type" type="text" class="test_input8"  value="<s:property value="type"/>"/>
			                					</td>
			                					<td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">名称：</div></td>
			                					<td width="29%" height="30" bgcolor="#c7edff">
			                						<input id="devname" name="devname" type="text" class="test_input8" value="<s:property value="devname"/>"/>
			                					</td>
			              					</tr>
			              					<tr>
			                					<td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">型号：</div></td>
			                					<td width="24%" height="30" bgcolor="#c7edff">
			                						<input id="xh" name="xh" type="text" class="test_input8" value="<s:property value="xh"/>"/>
			                					</td>
			                					<td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">厂家制造商：</div></td>
			                					<td width="29%" height="30" bgcolor="#c7edff">
			               	 						<input id="factory" name="factory" type="text" class="test_input8"  value="<s:property value="factory"/>"/>
			               						</td>
			              					</tr>
			              					<tr>
			                					<td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">品牌：</div></td>
			                					<td width="24%" height="30" bgcolor="#c7edff">
			                						<input id="penpai" name="penpai" type="text" class="test_input8"  value="<s:property value="penpai"/>"/>
			                					</td>
			                					<td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">软件版本号：</div></td>
			                					<td width="29%" height="30" bgcolor="#c7edff">
			                						<input id="softver" name="softver" type="text" class="test_input8"  value="<s:property value="softver"/>"/>
			                					</td>
			              					</tr>
			              					<tr>
			                					<td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">硬件版本号：</div></td>
			                					<td width="24%" height="30" bgcolor="#c7edff">
			                						<input id="hardver" name="hardver" type="text" class="test_input8" value="<s:property value="hardver"/>"/>
			                					</td>
			                					<td width="25%" height="30" bgcolor="#c7edff">&nbsp;</td>
			                					<td width="29%" height="30" bgcolor="#c7edff">&nbsp;</td>
			              					</tr>
			            				</table>
			            			</td>
			          			</tr>
			        		</table>
			        	</td>
			      	</tr>
				</table>
			</td>
  		</tr>
	</table>
</form>
<script type="text/javascript">
	<%
	String res=null;
	if(session.getAttribute("res")!=null)
		res=(String)session.getAttribute("res");
	session.removeAttribute("res");
	if(res!=null){
		if(res.equals("-1")){
	%>
			alert("文件格式不正确！<BR>导入失败！");
	<%
		}else{
			int ok=0,err=0,all=0;
			String ress="";
			String s[]=res.split(";");
			int rows=1;
			for(int i=0; i<s.length; i++){
				if (!s[i].equals("")){
					String ss[]=s[i].split(",");
					all++;
					if (ss[1].equals("1")){
						ok++;
					}else if (ss[1].equals("0")){
		  				ress=ress+"第"+ss[0]+"行序列号已经存在<BR>";
		  				err++;
					}else if (ss[1].equals("-1")){
		  				ress=ress+"第"+ss[0]+"行序列号格式错误，应该是5-20字符长度<BR>";
		  				err++;
					}else if (ss[1].equals("-2")){
		  				ress=ress+"第"+ss[0]+"行注册码格式错误，应该是10-24字符长度<BR>";
		  				err++;
					}else if (ss[1].equals("-3")){
		  				ress=ress+"第"+ss[0]+"行类型格式错误，应该是3-50字符长度<BR>";
		  				err++;
					}else if (ss[1].equals("-4")){
					  	ress=ress+"第"+ss[0]+"行名称格式错误，应该是3-50字符长度<BR>";
					  	err++;
					}else if (ss[1].equals("-5")){
					  	ress=ress+"第"+ss[0]+"行型号格式错误，应该是3-50字符长度<BR>";
					  	err++;
					}else if (ss[1].equals("-6")){
					  	ress=ress+"第"+ss[0]+"行制造商格式错误，应该是3-50字符长度<BR>";
					  	err++;
					}else if (ss[1].equals("-7")){
					  	ress=ress+"第"+ss[0]+"行品牌格式错误，应该是3-50字符长度<BR>";
					  	err++;
					}else if (ss[1].equals("-8")){
					  	ress=ress+"第"+ss[0]+"行软件版本号格式错误，应该是3-16字符长度<BR>";
					  	err++;
					}else if (ss[1].equals("-9")){
					  	ress=ress+"第"+ss[0]+"行硬件版本号格式错误，应该是3-16字符长度<BR>";
					  	err++;
					}
				}
				rows++;
			}
			ress="本次共"+all+"条数据，成功导入"+ok+"条数据。<BR>发生错误"+err+"次:<BR>"+ress;
	%>
			var infos="<div id='bbb' style='height:180px; width:300px;  overflow-y:auto; overflow-x:no'>";
			infos=infos+"<table width='290' border='0' cellspacing='0' cellpadding='0'>";
			infos= infos+"  <tr>";			 
			infos= infos+" 	<td width='100%' background='images/listbg29_1.gif' class='black2'><%=ress %></td>";
			infos= infos+"  </tr>";
			infos= infos+"</table>";
			infos=infos+"</div>";
			art.dialog({
			    title: '导入汇总',
				width: 300,
				height: 180,
			    content: infos
			});
	<%
		}
	}
	%>
</script>
</body>
</html>
