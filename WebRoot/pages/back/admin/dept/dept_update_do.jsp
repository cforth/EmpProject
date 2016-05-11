<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String url = basePath + "pages/back/admin/dept/dept_list.jsp" ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>雇员管理程序</title>
    <base href="<%=basePath%>">
</head>
  
<body>
<%
	request.setCharacterEncoding("UTF-8");
	Dept vo = new Dept() ;
	vo.setDeptno(Integer.parseInt(request.getParameter("deptno"))) ;
	vo.setDname(request.getParameter("dname")) ;
	vo.setLoc(request.getParameter("loc")) ;
	String msg = "部门信息修改失败！";
	if(ServiceFactory.getIDeptServiceInstance().update(vo)) {
		msg = "部门信息修改成功！";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=url%>";
</script>
</body>
</html>
