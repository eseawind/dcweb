<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<script>
var stateObj=parent.document.getElementById("state");

 for (var i = stateObj.options.length-1; i >=1; i--) {        
                stateObj.options.remove(i);     
        }   
 

     		<%
  List<Map> stateList=(List)session.getAttribute("stateList");
  for(int i=0;i<stateList.size();i++){
  		String name=(String)stateList.get(i).get("countryname");
  		String code=(String)stateList.get(i).get("c_code");
		%>
		var varItem = new Option("<%=name%>", "<%=code%>");      
        stateObj.options.add(varItem);  
		<%
	}
  
  %>
</script>