<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	vo.setNote(smart.getRequest().getParameter("note"));
	String fileName = smart.getRequest().getParameter("oldpic");
	if(smart.getFiles().getSize() > 0) { //有文件上传
		if(smart.getFiles().getFile(0).getContentType().contains("image")) {
			fileName = java.util.UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
		}
	}
	vo.setPhoto(fileName) ;
	String msg = "雇员信息修改失败！";
	if(ServiceFactory.getIEmpServiceInstance().update(vo)) {
		if(smart.getFiles().getFile(0).getSize() > 0) {
			if(smart.getFiles().getFile(0).getContentType()
				.contains("image")) { //判断文件类型
				if(!"nophoto.jpg".equals(fileName)) {
					String filePath = getServletContext().getRealPath("/upload/") + fileName;
					smart.getFiles().getFile(0).saveAs(filePath);
				}
			}
		}
		msg = "雇员信息修改成功！";
	}
	StringBuffer buf = new StringBuffer() ;
	buf.append(smart.getRequest().getParameter("backurl")).append("?") ;
	buf.append("cp=").append(smart.getRequest().getParameter("cp")) ;
	buf.append("&ls=").append(smart.getRequest().getParameter("ls")) ;
	buf.append("&col=").append(smart.getRequest().getParameter("col")) ;
	buf.append("&kw=").append(smart.getRequest().getParameter("kw")) ;
	buf.append("&deptno=").append(smart.getRequest().getParameter("deptno")) ;
%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=buf%>";
</script>
</body>
</html>
