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
	String msg = "验证码错误，请重新输入！";
	String url = loginUrl ;
	//首先进行验证码的判断
	String code = request.getParameter("code");
	String rand = (String) session.getAttribute("rand");
	if(rand.equalsIgnoreCase(code)) {
		//如果要进行检查。则必须使用MD5进行密码的加密处理
		Admin vo = new Admin();
		vo.setAid(request.getParameter("aid"));
		vo.setPassword(new MD5Code().getMD5ofStr(request.getParameter("password")));
		if(ServiceFactory.getIAdminServiceInstance().login(vo)) {
			msg = "登陆成功，欢迎您的光临";
			url = indexUrl;
		} else {
			msg = "登陆失败，错误的用户名或密码";
			url = loginUrl;
		}
	}
%>
<script type="text/javascript">
	window.alert("<%=msg%>");
	window.location = "<%=url%>";
</script>
</body>
</html>
