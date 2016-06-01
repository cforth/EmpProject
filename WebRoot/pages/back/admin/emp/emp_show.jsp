<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://www.cfxyz.com/c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String showUrl = basePath + "pages/back/admin/emp/EmpServlet/show" ;
String deptShowUrl = basePath + "pages/back/admin/dept/dept_show.jsp" ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>雇员管理程序</title>
    <base href="<%=basePath%>">
	<link type="text/css" rel="stylesheet" href="css/cfxyz.css">
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/cfxyz.js"></script>
	<script type="text/javascript" src="js/emp.js"></script>
</head>
  
<body>
<c:if test="${emp != null}" var="res">
	<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td colspan="3"><span class="title">查看雇员信息</span></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员编号：</strong></td>
			<td width="45%"><span class="init">${emp.empno}</span></td>
			<td width="40%"><strong>雇员照片：</strong></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员名称：</strong></td>
			<td width="45%">${emp.ename}</td>
			<td width="40%" rowspan="8"><img src="upload/${emp.photo}"></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员职位：</strong></td>
			<td width="45%">${emp.job}</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员领导：</strong></td>
			<td width="45%"><a href="<%=showUrl%>?empno=${emp.mgr.empno}">${emp.mgr.ename}</a></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>所在部门：</strong></td>
			<td width="45%"><a href="<%=deptShowUrl%>?deptno=${emp.dept.deptno}">${emp.dept.dname}</a></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇佣日期：</strong></td>
			<td width="45%">${emp.hiredate}</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>工资：</strong></td>
			<td width="45%">${emp.sal}</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>佣金：</strong></td>
			<td width="45%">${emp.comm}</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员介绍：</strong></td>
			<td width="45%">&nbsp;</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td colspan="3">${emp.note}</td>
		</tr>
	</table>
</c:if>
<input type="button" value="关闭窗口" onclick="closePage()">
</body>
</html>
