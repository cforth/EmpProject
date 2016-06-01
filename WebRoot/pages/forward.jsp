<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
				+ request.getServerName()
				+ ":" + request.getServerPort() + path;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>雇员管理程序</title>
    <base href="<%=basePath%>">
	<link type="text/css" rel="stylesheet" href="css/cfxyz.css">
	<script type="text/javascript" src="js/cfxyz.js"></script>
</head>
  
<body>
<script type="text/javascript">
	alert("<%=request.getAttribute("msg")%>");
	window.location = "<%=basePath%><%=request.getAttribute("url")%>";
</script>
</body>
</html>
