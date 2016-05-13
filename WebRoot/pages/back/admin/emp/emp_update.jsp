<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String updateUrl = basePath + "pages/back/admin/emp/emp_update_do.jsp" ;
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
	Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().updatePre(empno) ;
	List<Emp> allEmps = (List<Emp>)map.get("allEmps"); //列出所有雇员信息
	Emp vo = (Emp)map.get("emp");
	if(vo != null) {
%>
	<form action="<%=updateUrl%>" method="post" onsubmit="return validateUpdate()">
		<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="3"><span class="title">修改雇员信息</span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇员编号：</strong></td>
				<td width="45%"><span class="init"><%=vo.getEmpno()%></span></td>
				<td width="40%"><span id="empnoMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇员名称：</strong></td>
				<td width="45%"><input type="text" name="ename" id="ename" class="init" onblur="validateEname()" value="<%=vo.getEname()%>"></td>
				<td width="40%"><span id="enameMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇员职位：</strong></td>
				<td width="45%"><input type="text" name="job" id="job" class="init" onblur="validateJob()" value="<%=vo.getJob()%>"></td>
				<td width="40%"><span id="jobMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇员领导：</strong></td>
				<td width="45%">
					<select name="mgr" id="mgr" class="init">
						<option value="0">==== 没有领导 ====</option>
						<% 
							Iterator<Emp> empIter = allEmps.iterator();
							while(empIter.hasNext()) {
								Emp tempEmp = empIter.next();
						%>
								<option value="<%=tempEmp.getEmpno()%>" <%=tempEmp.getEmpno().equals(vo.getMgr().getEmpno())?"selected":""%>><%=tempEmp.getEname()%></option>
						<%
							}
						%>
					</select>
				</td>
				<td width="40%"><span id="mgrMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇佣日期：</strong></td>
				<td width="45%"><input type="text" name="hiredate" id="hiredate" class="init" onclick = "WdatePicker()" readonly  value="<%=vo.getHiredate()%>"></td>
				<td width="40%"><span id="hiredateMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>工资：</strong></td>
				<td width="45%"><input type="text" name="sal" id="sal" class="init" onblur="validateSal()" value="<%=vo.getSal()%>"></td>
				<td width="40%"><span id="salMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>佣金：</strong></td>
				<td width="45%"><input type="text" name="comm" id="comm" class="init" onblur="validateComm()" value="<%=vo.getComm()%>"></td>
				<td width="40%"><span id="commMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="3">
					<input type="hidden" id="empno" name="empno" value="<%=vo.getEmpno()%>">
					<input type="hidden" id="backurl" name="backurl" value="<%=request.getParameter("backurl")%>">
					<input type="hidden" id="cp" name="cp" value="<%=request.getParameter("cp")%>">
					<input type="hidden" id="ls" name="ls" value="<%=request.getParameter("ls")%>">
					<input type="hidden" id="col" name="col" value="<%=request.getParameter("col")%>">
					<input type="hidden" id="kw" name="kw" value="<%=request.getParameter("kw")%>">
					<input type="submit" value="修改">
					<input type="reset" value="重置">
					<a href="<%=request.getParameter("backurl")%>">雇员列表</a>
				</td>
			</tr>
		</table>
	</form>
<% 
	}
%>
</body>
</html>
