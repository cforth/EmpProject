<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String url = basePath + "pages/back/admin/dept/dept_list.jsp" ;
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
	String dno = request.getParameter("dno"); //数据之间使用'|'分割
	String msg = "部门信息删除失败！";
	if(!(dno == null || "".equals(dno))) { //dno确定有数据
		String result[] = dno.split("\\|");
		Set<Integer> ids = new HashSet<Integer>();
		for(int x = 0; x < result.length; x++) {
			ids.add(Integer.parseInt(result[x]));
		}
		if(ServiceFactory.getIDeptServiceInstance().delete(ids)) {
			msg = "部门信息删除成功！";
		}
	}



%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=url%>";
</script>
</body>
</html>
