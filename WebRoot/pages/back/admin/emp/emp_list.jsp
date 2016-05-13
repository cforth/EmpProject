<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/emp/emp_insert.jsp" ;
String deleteUrl = basePath + "pages/back/admin/emp/emp_delete_do.jsp" ;
String updatePreUrl = basePath + "pages/back/admin/emp/emp_update.jsp" ;
String backUrl = basePath + "pages/back/admin/emp/emp_list.jsp" ;
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
	List<Emp> all = ServiceFactory.getIEmpServiceInstance().list() ;
	Iterator<Emp> iter = all.iterator() ;
%>
<h1>雇员列表</h1>
<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td width=10%><input type="checkbox" id="selall" onclick="checkboxSelect(this,'empno')"></td>
		<td width=15%><strong>雇员编号</strong></td>
		<td width=15%><strong>名称</strong></td>
		<td width=15%><strong>职位</strong></td>
		<td width=15%><strong>雇佣日期</strong></td>
		<td width=10%><strong>工资</strong></td>
		<td width=10%><strong>佣金</strong></td>
		<td width=10%><strong>操作</strong></td>
	</tr>
	<% 
		while(iter.hasNext()) {
			Emp vo = iter.next() ;
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td><input type="checkbox" id="empno" name="empno" value="<%=vo.getEmpno()%>"></td>
		<td><%=vo.getEmpno()%></td>
		<td><%=vo.getEname()%></td>
		<td><%=vo.getJob()%></td>
		<td><%=vo.getHiredate()%></td>
		<td><%=vo.getSal()%></td>
		<td><%=vo.getComm()%></td>
		<td><a href="<%=updatePreUrl%>?empno=<%=vo.getEmpno()%>&backurl=<%=backUrl%>">修改</a></td>
	</tr>
	<%
		}
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td colspan="8">
		<input type="button" value="删除雇员信息" onclick="deleteAll('<%=deleteUrl%>?backurl=<%=backUrl%>','eno','empno')">
		<a href="<%=insertUrl%>">增加新雇员</a>
		</td>
	</tr>
</table>
</body>
</html>
