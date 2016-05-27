<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String updateUrl = basePath + "pages/back/admin/dept/DeptServlet/update" ;
String listUrl = basePath + "pages/back/admin/dept/DeptServlet/list" ;
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
	//接收地址重写传递而来的部门编号
	Dept vo = (Dept)request.getAttribute("dept") ;
	if(vo != null) {
%>
	<form action="<%=updateUrl%>" method="post" onsubmit="return validateUpdate()">
		<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="3"><span class="title">编辑部门信息</span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>部门编号：</strong></td>
				<td width="45%"><span class="init"><%=vo.getDeptno()%></span></td>
				<td width="40%"><span id="deptnoMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>部门名称：</strong></td>
				<td width="45%"><input type="text" name="dname" id="dname" class="init" onblur="validateDname()" value="<%=vo.getDname()%>"></td>
				<td width="40%"><span id="dnameMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>部门位置：</strong></td>
				<td width="45%"><input type="text" name="loc" id="loc" class="init" onblur="validateLoc()" value="<%=vo.getLoc()%>"></td>
				<td width="40%"><span id="locMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="3">
					<input type="hidden" id="deptno" name="deptno" value="<%=vo.getDeptno()%>">
					<input type="submit" value="修改">
					<input type="reset" value="重置">
					<a href="<%=listUrl%>">部门列表</a>
				</td>
			</tr>
		</table>
	</form>
<% 
	}
%>
</body>
</html>
