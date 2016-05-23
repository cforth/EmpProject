<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="java.io.*"%>
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
		Map<String,Object> map = ServiceFactory.getIDeptServiceInstance().delete(ids);
		boolean flag = (boolean) map.get("flag");
		if(flag) {
			msg = "部门信息删除成功！";
			//部门信息删除之后一定要删除对应的雇员照片
			Set<String> photos = (Set<String>) map.get("allPhotos");
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
		}
	}

%>
<script type="text/javascript">
	alert("<%=msg%>");
	window.location = "<%=url%>";
</script>
</body>
</html>
