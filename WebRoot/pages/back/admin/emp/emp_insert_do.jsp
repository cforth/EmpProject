<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String url = basePath + "pages/back/admin/emp/emp_insert.jsp" ;
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
	SmartUpload smart = new SmartUpload();
	smart.initialize(config, request, response);
	smart.upload();
	Emp vo = new Emp() ;
	vo.setEmpno(Integer.parseInt(smart.getRequest().getParameter("empno"))) ;
	vo.setEname(smart.getRequest().getParameter("ename")) ;
	vo.setJob(smart.getRequest().getParameter("job")) ;
	vo.setHiredate(new SimpleDateFormat("yyyy-MM-dd").parse(smart.getRequest().getParameter("hiredate"))) ;
	vo.setSal(Double.parseDouble(smart.getRequest().getParameter("sal"))) ;
	vo.setComm(Double.parseDouble(smart.getRequest().getParameter("comm"))) ;
	int tempMgr = Integer.parseInt(smart.getRequest().getParameter("mgr")) ;
	if(tempMgr != 0) { //表示现在有领导
		Emp mgr = new Emp();
		mgr.setEmpno(tempMgr); //保存领导编号
		vo.setMgr(mgr);
	}
	int tempDept = Integer.parseInt(smart.getRequest().getParameter("deptno")) ;
	if(tempDept != 0) { //表示现在有部门
		Dept dept = new Dept(); //保存部门编号
		dept.setDeptno(tempDept);
		vo.setDept(dept);
	}
	String fileName = "nophoto.jsp"; //上传的图片名称
	if(smart.getFiles().getFile(0).getSize() > 0) {
		if(smart.getFiles().getFile(0).getContentType()
			.contains("image")) { //判断文件类型
			fileName = java.util.UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
		}
	}
	vo.setPhoto(fileName);
	vo.setNote(smart.getRequest().getParameter("note"));
	String msg = "雇员信息增加失败！";
	if(ServiceFactory.getIEmpServiceInstance().insert(vo)) {
		if(smart.getFiles().getFile(0).getSize() > 0) {
			if(smart.getFiles().getFile(0).getContentType()
				.contains("image")) { //判断文件类型
				String filePath = getServletContext().getRealPath("/upload/") + fileName;
				smart.getFiles().getFile(0).saveAs(filePath);
			}
		}
		msg = "雇员信息增加成功！";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=url%>";
</script>
</body>
</html>
