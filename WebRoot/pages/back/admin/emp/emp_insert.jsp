<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/emp/emp_insert_do.jsp" ;
String listUrl = basePath + "pages/back/admin/emp/emp_list_details.jsp" ;
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
	<script type="text/javascript" charset="utf-8" src="pages/back/admin/emp/edit/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="pages/back/admin/emp/edit/kindeditor-core.js"></script>
	<script type="text/javascript" charset="utf-8" src="pages/back/admin/emp/edit/plugin-all.js"></script>
	<script type="text/javascript">
		KE.show({
			id : 'note',
			cssPath : 'edit/index.css'
		});
	</script>
</head>
  
<body>
<% 
	int deptno = 0;
	if(request.getParameter("deptno") != null) {
		deptno = Integer.parseInt(request.getParameter("deptno")) ;
	}
	Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().insertPre();
	List<Emp> allEmps = (List<Emp>)map.get("allEmps"); //列出已有的雇员信息
	List<Dept> allDepts = (List<Dept>)map.get("allDepts"); //列出已有的部门信息
%>
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
						<% 
							Iterator<Emp> empIter = allEmps.iterator();
							while(empIter.hasNext()) {
								Emp tempEmp = empIter.next();
						%>
								<option value="<%=tempEmp.getEmpno()%>"><%=tempEmp.getEname()%></option>
						<%
							}
						%>
					</select>
				</td>
				<td><span id="mgrMsg"></span></td>
			</tr>
			<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
				<td><strong>所在部门：</strong></td>
				<td>
					<select name="deptno" id="deptno" class="init">
						<option value="0">==== 没有部门 ====</option>
						<% 
							Iterator<Dept> deptIter = allDepts.iterator();
							while(deptIter.hasNext()) {
								Dept tempDept = deptIter.next();
						%>
								<option value="<%=tempDept.getDeptno()%>" <%=tempDept.getDeptno().equals(deptno) ? "selected" : ""%> ><%=tempDept.getDname()%></option>
						<%
							}
						%>
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
