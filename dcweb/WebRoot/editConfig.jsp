<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@ include file="meta.jsp" %>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css" type="text/css"></link>
  	<script type="text/javascript" src='<%= request.getContextPath() %>/js/resource_<%= session.getAttribute("WW_TRANS_I18N_LOCALE")==null?"en_US":session.getAttribute("WW_TRANS_I18N_LOCALE") %>.js'></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.5.1.min.js"></script>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/js/cookie.js"></script>
  		<script type="text/javascript" src="<%= request.getContextPath() %>/js/FoshanRen.js"></script>
  	<link href="./skins/blue.css" rel="stylesheet" />
	<script src="./js/artDialog.min.js"></script>
	<base   target= "_parent"/>
  </head>
  <script language="javascript" type="text/javascript">

function Formfield(name, label){
	this.name=name;
	this.label=label;
}
function verifyForm(objForm){

	var list  = new Array(new Formfield("language", "language"),new Formfield("subtag", "subtag")
	,new Formfield("val1", "val1")
	,new Formfield("val2", "val2")
	,new Formfield("context", "context")
	);
	for(var i=0;i<list.length;i++){
		var objfield = eval("objForm."+ list[i].name);
		if(trim(objfield.value)==""){
		
			alert(list[i].label+ "不能为空");
			if(objfield.type!="hidden" && objfield.focus()) objfield.focus();
			return false;
		}
	}
	
    return true;
}
function SureSubmit(objForm){
	if (verifyForm(objForm)) objForm.submit();
	alert("添加成功");
	window.close();
} 
</script>


<body scroll="no">


<form  method="post" action="addAminConfig.action">
<table width="480" border="0"  align="center" cellpadding="0" cellspacing="0">
 
  <tr height="195">
    <td align="center" bgcolor="#E5EFF9"><table width="98%" border="0" cellspacing="0" cellpadding="0">
     
      <tr>
        <td align="center" background="images/regin6.gif">
        <table width="90%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="30" colspan="3" class="blue"><div align="left">信息录入</div></td>
            </tr>
          
         
          <tr>
            <td colspan="3" bgcolor="#FFFFFF" class="black2">
			<table width="100%" border="0" cellpadding="0" cellspacing="1">

             
              <tr>
                <td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">language：</div></td>
                <td width="24%" height="30" bgcolor="#c7edff">
                <input id="language"  name="language" type="text" class="test_input8" value="<s:property value="#session.adminConfig.language" />"/></td>
                <td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">subtag：</div></td>
                <td width="29%" height="30" bgcolor="#c7edff">
                <input  id="subtag" name="subtag" type="text" class="test_input8" value="<s:property value="#session.adminConfig.subtag" />" /></td>
              </tr>
              <tr>
                <td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">val1：</div></td>
                <td width="24%" height="30" bgcolor="#c7edff">
                <input  id="val1" name="val1" type="text" class="test_input8" value="<s:property value="#session.adminConfig.val1" />" /></td>
                <td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right">val2：</div></td>
                <td width="29%" height="30" bgcolor="#c7edff">
                <input id="val2"  name="val2" type="text" class="test_input8" value="<s:property value="#session.adminConfig.val2" />" /></td>
              </tr>
              <tr>
                <td width="29%" height="30" bgcolor="#c7edff" class="black2"><div align="right">context：</div></td>
                <td width="24%" height="30" bgcolor="#c7edff">
                <input id="context"  name="context" type="text" class="test_input8" value="<s:property value="#session.adminConfig.context" />" /></td>
                <td width="25%" height="30" bgcolor="#c7edff" class="black2"><div align="right"></div></td>
                <td width="29%" height="30" bgcolor="#c7edff">
                </td>
              </tr>
           
            </table></td>
          </tr>
        </table></td>
          <tr>
            <td height="30" colspan="3" class="blue" bgcolor="#c7edff"><div align="center"><input type="button" name="Add" value=" 确 认 " class="frm_btn" onClick="javascript:SureSubmit(this.form)"></div></td>
            </tr>
      </tr>
    </table></td>
  </tr>
</table>
</form>


</body>
</html>
