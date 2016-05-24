<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String showUrl = basePath + "pages/back/admin/emp/emp_show.jsp" ;
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
<% 
	//接收地址重写传递而来的部门编号
	int empno = Integer.parseInt(request.getParameter("empno")) ;
	Emp vo = ServiceFactory.getIEmpServiceInstance().show(empno) ;
	if(vo != null) {
%>
	<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td colspan="3"><span class="title">查看雇员信息</span></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员编号：</strong></td>
			<td width="45%"><span class="init"><%=vo.getEmpno()%></span></td>
			<td width="40%"><strong>雇员照片：</strong></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员名称：</strong></td>
			<td width="45%"><%=vo.getEname()%></td>
			<td width="40%" rowspan="8"><img src="upload/<%=vo.getPhoto()%>"></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员职位：</strong></td>
			<td width="45%"><%=vo.getJob()%></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员领导：</strong></td>
			<td width="45%"><a href="<%=showUrl%>?empno=<%=vo.getMgr().getEmpno()%>"><%=vo.getMgr().getEname() == null ? "" : vo.getMgr().getEname()%></a></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>所在部门：</strong></td>
			<td width="45%"><a href="<%=deptShowUrl%>?deptno=<%=vo.getDept().getDeptno()%>"><%=vo.getDept().getDname() == null ? "" : vo.getDept().getDname()%></a></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇佣日期：</strong></td>
			<td width="45%"><%=vo.getHiredate()%></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>工资：</strong></td>
			<td width="45%"><%=vo.getSal()%></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>佣金：</strong></td>
			<td width="45%"><%=vo.getComm()%></td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td width="15%"><strong>雇员介绍：</strong></td>
			<td width="45%">&nbsp;</td>
		</tr>
		<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
			<td colspan="3"><%=vo.getNote() != null ? vo.getNote() : "暂无介绍"%></td>
		</tr>
	</table>
<% 
	}
%>
<input type="button" value="关闭窗口" onclick="closePage()">
</body>
</html>
