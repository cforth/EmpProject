<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String loginUrl = basePath +"/pages/back/login.jsp" ;
String indexUrl = basePath +"/pages/back/index.jsp" ;
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
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<%
	session.invalidate(); //注销
%>
<script type="text/javascript">
	window.alert("用户注销成功，欢迎再来！");
	window.location = "<%=loginUrl%>";
</script>
</body>
</html>
