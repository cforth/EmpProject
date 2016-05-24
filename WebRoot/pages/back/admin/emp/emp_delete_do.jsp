<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="java.io.*"%>
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
	String eno = request.getParameter("eno"); //数据之间使用'|'分割
	String msg = "雇员信息删除失败！";
	Set<String> photos = new HashSet<String>(); //保存雇员图片
	if(!(eno == null || "".equals(eno))) { //eno确定有数据
		String result[] = eno.split("\\|");
		Set<Integer> ids = new HashSet<Integer>();
		for(int x = 0; x < result.length; x++) {
			String temp[] = result[x].split(":");
			ids.add(Integer.parseInt(temp[0]));
			if(!"nophoto.jpg".equals(temp[1])) {
				photos.add(temp[1]);
			}
		}
		if(ServiceFactory.getIEmpServiceInstance().delete(ids)) {
			Iterator<String> iter = photos.iterator();
			while(iter.hasNext()) {
				String photo = iter.next();
				if(!"nophoto.jpg".equals(photo)) { //不是nophoto，可以删除
					String filePath = getServletContext().getRealPath("/upload/") + photo ;
					File file = new File(filePath);
					if(file.exists()) {
						file.delete();
					}
				}
			}
			msg = "雇员信息删除成功！";
		}
	}
	StringBuffer buf = new StringBuffer() ;
	buf.append(request.getParameter("backurl")).append("?") ;
	buf.append("cp=").append(request.getParameter("cp")) ;
	buf.append("&ls=").append(request.getParameter("ls")) ;
	buf.append("&col=").append(request.getParameter("col")) ;
	buf.append("&kw=").append(request.getParameter("kw")) ;
%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=buf%>";
</script>
</body>
</html>
