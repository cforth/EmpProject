<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://www.cfxyz.com/c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/emp/EmpServlet/insert" ;
String listUrl = basePath + "pages/back/admin/emp/EmpServlet/listDetails" ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>雇员管理程序</title>
    <base href="<%=basePath%>">
    <style type="text/css" rel="stylesheet">
    .source {
    width: 700px;
    font-size: 12px;
    font-family:Courier New;
    border: 1px solid #AAAAAA;
    background-color: #F0F0EE;
    padding: 5px;
    }
    .source pre {
    margin: 0;
    }
    form {
    margin: 0;
    }
    .editor {
    margin-top: 5px;
    margin-bottom: 5px;
    }
  	</style>
	<link type="text/css" rel="stylesheet" href="css/cfxyz.css">
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/cfxyz.js"></script>
	<script type="text/javascript" src="js/emp.js"></script>
	<script type="text/javascript" charset="utf-8" src="edit/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="edit/kindeditor-core.js"></script>
	<script type="text/javascript" charset="utf-8" src="edit/plugin-all.js"></script>
	<script type="text/javascript">
		KE.show({
			id : 'note',
			cssPath : 'edit/index.css'
		});
	</script>
</head>
  
<body>
	<form action="<%=insertUrl%>" method="post" onsubmit="return validateInsert()" enctype="multipart/form-data">
		<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="4"><span class="title">增加雇员信息</span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td width="15%"><strong>雇员编号：</strong></td>
				<td width="25%"><input type="text" name="empno" id="empno" class="init" onblur="validateEmpno()"></td>
				<td width="20%"><span id="empnoMsg"></span></td>
				<td width="40%"><strong>雇员照片:</strong></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇员名称：</strong></td>
				<td><input type="text" name="ename" id="ename" class="init" onblur="validateEname()"></td>
				<td><span id="enameMsg"></span></td>
				<td rowspan="9"><div id="preview"></div></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇员职位：</strong></td>
				<td><input type="text" name="job" id="job" class="init" onblur="validateJob()"></td>
				<td><span id="jobMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇员领导：</strong></td>
				<td>
					<select name="mgr" id="mgr" class="init">
						<option value="0">==== 没有领导 ====</option>
						<c:if test="${allEmps != null}" var="res">
							<c:forEach items="${allEmps}" var="t_emp">
								<option value="${t_emp.empno}">${t_emp.ename}</option>
							</c:forEach>
						</c:if>
					</select>
				</td>
				<td><span id="mgrMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>所在部门：</strong></td>
				<td>
					<select name="deptno" id="deptno" class="init">
						<option value="0">==== 没有部门 ====</option>
						<c:if test="${allDepts != null}" var="res">
							<c:forEach items="${allDepts}" var="t_dept">
								<option value="${t_dept.deptno}" ${t_dept.deptno == param.deptno ? "selected" : ""}>${t_dept.dname}</option>
							</c:forEach>
						</c:if>
					</select>
				</td>
				<td><span id="deptnoMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇佣日期：</strong></td>
				<td><input type="text" name="hiredate" id="hiredate" class="init" onclick = "WdatePicker()" readonly></td>
				<td><span id="hiredateMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>工资：</strong></td>
				<td><input type="text" name="sal" id="sal" class="init" onblur="validateSal()"></td>
				<td><span id="salMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>佣金：</strong></td>
				<td><input type="text" name="comm" id="comm" class="init" onblur="validateComm()"></td>
				<td><span id="commMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇员照片：</strong></td>
				<td><input type="file" name="photo" id="photo" class="init" onchange="preview(this)"></td>
				<td><span id="fileMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>雇员简介：</strong></td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="4">
					<div class="editor">
						<textarea id="note" name="note" style="width:650px;height:200px;visibility:hidden;"></textarea>
					</div>
				</td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td colspan="4">
					<input type="submit" value="增加">
					<input type="reset" value="重置">
					<a href="<%=listUrl%>">雇员列表</a>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">  
		function preview(file) {
			var prevDiv = document.getElementById('preview');
			if (file.files && file.files[0]) {
				var reader = new FileReader();
				reader.onload = function(evt) {
					prevDiv.innerHTML = "<img src='" + evt.target.result + "' width='100%' />";
				} 
				reader.readAsDataURL(file.files[0]);
			} else {
				prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
			}
		}
	</script>
</body>
</html>
