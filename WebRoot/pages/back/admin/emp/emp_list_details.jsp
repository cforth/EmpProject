<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cfxyz.cf.vo.*"%>
<%@ page import="com.cfxyz.cf.factory.*"%>
<%
    request.setCharacterEncoding("UTF-8") ;
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String insertUrl = basePath + "pages/back/admin/emp/emp_insert.jsp" ;
String deleteUrl = basePath + "pages/back/admin/emp/emp_delete_do.jsp" ;
String updatePreUrl = basePath + "pages/back/admin/emp/emp_update.jsp" ;
String backUrl = basePath + "pages/back/admin/emp/emp_list_details.jsp" ;
String showUrl = basePath + "pages/back/admin/emp/emp_show.jsp" ;
String deptShowUrl = basePath + "pages/back/admin/dept/dept_show.jsp" ;
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
    int currentPage = 1 ;
    String keyWord = "" ; //默认的关键字
    int lineSize = 5 ;
    int allRecorders = 0 ; //保存总记录数
    int lsData[] = new int [] {1,5,10,15,20,30,50,100} ;
    String column = "ename"; //默认查询列
    String columnData = "雇员编号:empno|雇员姓名:ename|雇员职位:job" ;
%>
<%
    try {
        //如果没有输入参数那么就会是null，null无法变为数字
        currentPage = Integer.parseInt(request.getParameter("cp"));
    } catch (Exception e) {}
    try {
        //如果没有输入参数那么就会是null，null无法变为数字
        lineSize = Integer.parseInt(request.getParameter("ls"));
    } catch (Exception e) {}
    if(request.getParameter("col") != null) { //表示有查询列
        column = request.getParameter("col") ;
    }
    if(request.getParameter("kw") != null) { //表示有查询关键字
        keyWord = request.getParameter("kw") ;
    }
%>
<%
	Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().listDetails(column, keyWord, currentPage, lineSize);
	List<Emp> all = (List<Emp>)map.get("allEmps") ;
	allRecorders = (Integer)map.get("empCount") ;
	Iterator<Emp> iter = all.iterator() ;
%>
<h1>雇员列表</h1>
<div id="splitSearchDiv">
    <jsp:include page="/pages/split_plugin_search.jsp">
        <jsp:param name="columnData" value="<%=columnData%>"/>
        <jsp:param name="keyWord" value="<%=keyWord%>"/>
        <jsp:param name="allRecorders" value="<%=allRecorders%>"/>
        <jsp:param name="column" value="<%=column%>"/>
    </jsp:include>
</div>
<div id="dataDiv">
<table border="1" cellpadding="5" cellspacing="0" bgcolor="#F2F2F2" width="100%">
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td width=10%><input type="checkbox" id="selall" onclick="checkboxSelect(this,'empno')"></td>
		<td width=10%><strong>雇员编号</strong></td>
		<td width=15%><strong>名称</strong></td>
		<td width=10%><strong>职位</strong></td>
		<td width=10%><strong>领导</strong></td>
		<td width=10%><strong>部门</strong></td>
		<td width=10%><strong>雇佣日期</strong></td>
		<td width=10%><strong>工资</strong></td>
		<td width=10%><strong>佣金</strong></td>
		<td width=10%><strong>操作</strong></td>
	</tr>
	<% 
		while(iter.hasNext()) {
			Emp vo = iter.next() ;
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td><input type="checkbox" id="empno" name="empno" value="<%=vo.getEmpno()%>:<%=vo.getPhoto()%>"></td>
		<td><%=vo.getEmpno()%></td>
		<td><a onclick="openPage('<%=showUrl%>?empno=<%=vo.getEmpno()%>')"><%=vo.getEname()%></a></td>
		<td><%=vo.getJob()%></td>
		<td><a onclick="openPage('<%=showUrl%>?empno=<%=vo.getMgr().getEmpno()%>')"><%=vo.getMgr().getEname() == null ? "" : vo.getMgr().getEname()%></a></td>
		<td><a onclick="openPage('<%=deptShowUrl%>?deptno=<%=vo.getDept().getDeptno()%>')"><%=vo.getDept().getDname() == null ? "" : vo.getDept().getDname()%></a></td>
		<td><%=vo.getHiredate()%></td>
		<td><%=vo.getSal()%></td>
		<td><%=vo.getComm()%></td>
		<td><a href="<%=updatePreUrl%>?empno=<%=vo.getEmpno()%>&backurl=<%=backUrl%>&cp=<%=currentPage%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>">修改</a></td>
	</tr>
	<%
		}
	%>
	<tr onmouseover="changColor(this,'#FFFFFF')" onmouseout="changColor(this,'#F2F2F2')">
		<td colspan="10">
		<input type="button" value="删除雇员信息" onclick="deleteAll('<%=deleteUrl%>?backurl=<%=backUrl%>&cp=<%=currentPage%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>','eno','empno')">
		<a href="<%=insertUrl%>">增加新雇员</a>
		</td>
	</tr>
</table>
</div>
<div id="barDiv" style="float:right">
    <jsp:include page="/pages/split_plugin_bars.jsp">
        <jsp:param name="currentPage" value="<%=currentPage%>"/>
        <jsp:param name="lineSize" value="<%=lineSize%>"/>
        <jsp:param name="column" value="<%=column%>"/>
        <jsp:param name="keyWord" value="<%=keyWord%>"/>
        <jsp:param name="allRecorders" value="<%=allRecorders%>"/>
        <jsp:param name="url" value="<%=backUrl%>"/>
    </jsp:include>
	</div>
</body>
</html>
