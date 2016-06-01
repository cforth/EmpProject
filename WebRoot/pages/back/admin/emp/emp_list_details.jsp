<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://www.cfxyz.com/c"%>
<%
    request.setCharacterEncoding("UTF-8") ;
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/emp/EmpServlet/insertPre" ;
String deleteUrl = basePath + "pages/back/admin/emp/EmpServlet/delete" ;
String updatePreUrl = basePath + "pages/back/admin/emp/EmpServlet/updatePre" ;
String showUrl = basePath + "pages/back/admin//emp/EmpServlet/show" ;
String deptShowUrl = basePath + "pages/back/admin/dept/dept_show.jsp" ;
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
<h1>雇员列表</h1>
<div id="splitSearchDiv">
    <jsp:include page="/pages/split_plugin_search.jsp"/>
</div>
<div id="dataDiv">
<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td width=10%><input type="checkbox" id="selall" onclick="checkboxSelect(this,'empno')"></td>
		<td width=10%><strong>雇员编号</strong></td>
		<td width=15%><strong>名称</strong></td>
		<td width=10%><strong>职位</strong></td>
		<td width=10%><strong>领导</strong></td>
		<td width=10%><strong>部门</strong></td>
		<td width=10%><strong>雇佣日期</strong></td>
		<td width=10%><strong>工资</strong></td>
		<td width=10%><strong>佣金</strong></td>
		<td width=10%><strong>操作</strong></td>
	</tr>
	<c:if test="${allEmps != null}" var="res">
		<c:forEach items="${allEmps}" var="t_emp">
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><input type="checkbox" id="empno" name="empno" value="${t_emp.empno}:${t_emp.photo}"></td>
				<td>${t_emp.empno}</td>
				<td><a onclick="openPage('<%=showUrl%>?empno=${t_emp.empno}')">${t_emp.ename}</a></td>
				<td>${t_emp.job}</td>
				<td><a onclick="openPage('<%=showUrl%>?empno=${t_emp.mgr.empno}')">${t_emp.mgr.ename}</a></td>
				<td><a onclick="openPage('<%=deptShowUrl%>?deptno=${t_emp.dept.deptno}')">${t_emp.dept.dname}</a></td>
				<td>${t_emp.hiredate}</td>
				<td>${t_emp.sal}</td>
				<td>${t_emp.comm}</td>
				<td><a href="<%=updatePreUrl%>?empno=${t_emp.empno}&backurl=${url}&cp=${currentPage}&ls=${lineSize}&col=${column}&kw=${keyWord}">修改</a></td>
			</tr>
	</c:forEach>
	</c:if>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td colspan="10">
		<input type="button" value="删除雇员信息" onclick="deleteAll('<%=deleteUrl%>?backurl=${url}&cp=${currentPage}&ls=${lineSize}&col=${column}&kw=${keyWord}','eno','empno')">
		<a href="<%=insertUrl%>">增加新雇员</a>
		</td>
	</tr>
</table>
</div>
<div id="barDiv" style="float:right">
    <jsp:include page="/pages/split_plugin_bars.jsp"/>
</div>
</body>
</html>
