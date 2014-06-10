<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>e</title>
    <link type="text/css" href="<%=request.getContextPath() %>/css/menu1.css" rel="stylesheet" />
	
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/menu1.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <style type="text/css">
* { margin:0;
    padding:0;
}

div#menu { margin:5px auto; }
div#copyright {
    font:11px 'Trebuchet MS';
    color:#222;
    text-indent:30px;
    padding:40px 0 0 0;
}
div#copyright a { color:#aaa; }
div#copyright a:hover { color:#222; }
</style>
    <div id="menu">
    <ul class="menu">
        <li><a href="#" class="parent"><span><s:text name="RES_OVERVIEW"/></span></a>
            <ul>
                <li><a href="#" class="parent"><span>Sub Item 1</span></a>
                    <ul>
                        <li><a href="#" class="parent"><span>Sub Item 1.1</span></a>
                            <ul>
                                <li><a href="#"><span>Sub Item 1.1.1</span></a></li>
                                <li><a href="#"><span>Sub Item 1.1.2</span></a></li>
                            </ul>
                        </li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                        <li><a href="#"><span>Sub Item 1.3</span></a></li>
                        <li><a href="#"><span>Sub Item 1.4</span></a></li>
                        <li><a href="#"><span>Sub Item 1.5</span></a></li>
                        <li><a href="#"><span>Sub Item 1.6</span></a></li>
                        <li><a href="#" class="parent"><span>Sub Item 1.7</span></a>
                            <ul>
                                <li><a href="#"><span>Sub Item 1.7.1</span></a></li>
                                <li><a href="#"><span>Sub Item 1.7.2</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#"><span>Sub Item 2</span></a></li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
            </ul>
        </li>
        <li><a href="#" class="parent"><span>Overview</span></a>
            <ul>
                <li><a href="#" class="parent"><span>Sub Item 1</span></a>
                    <ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul>
                </li>
                <li><a href="#" class="parent"><span>Sub Item 2</span></a>
                    <ul>
                        <li><a href="#"><span>Sub Item 2.1</span></a></li>
                        <li><a href="#"><span>Sub Item 2.2</span></a></li>
                    </ul>
                </li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
                <li><a href="#"><span>Sub Item 4</span></a></li>
                <li><a href="#"><span>Sub Item 5</span></a></li>
                <li><a href="#"><span>Sub Item 6</span></a></li>
                <li><a href="#"><span>Sub Item 7</span></a></li>
            </ul>
        </li>
        <li><a href="#"><span>Graphs</span></a>
		 <ul>
                <li><a href="#" class="parent"><span>Sub Item 1</span></a>
                    <ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul>
                </li>
                <li><a href="#" class="parent"><span>Sub Item 2</span></a>
                    <ul>
                        <li><a href="#"><span>Sub Item 2.1</span></a></li>
                        <li><a href="#"><span>Sub Item 2.2</span></a></li>
                    </ul>
                </li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
                <li><a href="#"><span>Sub Item 4</span></a></li>
                <li><a href="#"><span>Sub Item 5</span></a></li>
                <li><a href="#"><span>Sub Item 6</span></a></li>
                <li><a href="#"><span>Sub Item 7</span></a></li>
            </ul></li>
        <li class="last"><a href="#"><span>Config</span></a></li>
    </ul>
</div>

  </body>
</html>
