<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/dept/dept_insert.jsp" ;
String deleteUrl = basePath + "pages/back/admin/dept/DeptServlet/delete" ;
String updatePreUrl = basePath + "pages/back/admin/dept/DeptServlet/updatePre" ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>雇员管理程序</title>
    <base href="<%=basePath%>">
	<link type="text/css" rel="stylesheet" href="css/cfxyz.css">
	<script type="text/javascript" src="js/cfxyz.js"></script>
	<script type="text/javascript" src="js/dept.js"></script>
</head>
  
<body>
<%
	List<Dept> all = (List<Dept>)request.getAttribute("allDepts") ;
	Iterator<Dept> iter = all.iterator() ;
%>
<h1>部门列表</h1>
<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td width=10%><input type="checkbox" id="selall" onclick="checkboxSelect(this,'deptno')"></td>
		<td width=25%><strong>部门编号</strong></td>
		<td width=25%><strong>部门名称</strong></td>
		<td width=25%><strong>部门位置</strong></td>
		<td width=15%><strong>操作</strong></td>
	</tr>
	<% 
		while(iter.hasNext()) {
			Dept vo = iter.next() ;
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td><input type="checkbox" id="deptno" name="deptno" value="<%=vo.getDeptno()%>"></td>
		<td><%=vo.getDeptno()%></td>
		<td><%=vo.getDname()%></td>
		<td><%=vo.getLoc()%></td>
		<td><a href="<%=updatePreUrl%>?deptno=<%=vo.getDeptno()%>">修改</a></td>
	</tr>
	<%
		}
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td colspan="5">
		<input type="button" value="删除部门信息" onclick="deleteAll('<%=deleteUrl%>?p=p','dno','deptno')">
		<a href="<%=insertUrl%>">增加新部门</a>
		</td>
	</tr>
</table>
</body>
</html>
