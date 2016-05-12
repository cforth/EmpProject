<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	Emp vo = new Emp() ;
	vo.setEmpno(Integer.parseInt(request.getParameter("empno"))) ;
	vo.setEname(request.getParameter("ename")) ;
	vo.setJob(request.getParameter("job")) ;
	vo.setHiredate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("hiredate"))) ;
	vo.setSal(Double.parseDouble(request.getParameter("sal"))) ;
	vo.setComm(Double.parseDouble(request.getParameter("comm"))) ;
	String msg = "雇员信息修改失败！";
	if(ServiceFactory.getIEmpServiceInstance().update(vo)) {
		msg = "雇员信息修改成功！";
	}
	StringBuffer buf = new StringBuffer() ;
	buf.append(request.getParameter("backurl")).append("?") ;
	buf.append("cp=").append(request.getParameter("cp")) ;
	buf.append("&ls=").append(request.getParameter("ls")) ;
	buf.append("&col=").append(request.getParameter("col")) ;
	buf.append("&kw=").append(request.getParameter("kw")) ;
%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=buf%>";
</script>
</body>
</html>
