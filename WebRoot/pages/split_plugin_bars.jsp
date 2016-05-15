<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/cfxyz.css">
<%--
	代码的引用过程
	<div id="barDiv" style="float:right">
    <jsp:include page="/pages/split_plugin_bars.jsp">
        <jsp:param name="currentPage" value="<%=currentPage%>"/>
        <jsp:param name="lineSize" value="<%=lineSize%>"/>
        <jsp:param name="column" value="<%=column%>"/>
        <jsp:param name="keyWord" value="<%=keyWord%>"/>
        <jsp:param name="allRecorders" value="<%=allRecorders%>"/>
        <jsp:param name="url" value="<%=url%>"/>
        <jsp:param name="paramName" value="参数名称"/>
        <jsp:param name="paramValue" value="参数内容"/>
    </jsp:include>
	</div>
--%>
<%
    request.setCharacterEncoding("UTF-8") ;
%>
<%
	String url = null;
	int currentPage = 1;
	int lineSize = 5 ;
	String column = null ;
	String keyWord = null;
	int allRecorders = 0 ;
	int pageSize = 0 ;
	int lsData[] = new int [] {1,5,10,15,20,30,50,100} ;
    int seed = 3; //种子数
    String paramName = request.getParameter("paramName");
    String paramValue = request.getParameter("paramValue");
    %>
<% //接受传递的参数
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage")) ;
	} catch (Exception e) {}
	try {
		lineSize = Integer.parseInt(request.getParameter("lineSize")) ;
	} catch (Exception e) {}
    try {
		allRecorders = Integer.parseInt(request.getParameter("allRecorders")) ;
	} catch (Exception e) {}
	column = request.getParameter("column") ;
	keyWord = request.getParameter("keyWord") ;
	url = request.getParameter("url") ;
%>
<script type="text/javascript">
    function goSplit(vcp) { //根据外部传递的cp内容进行操作
        try {
        	var eleKw = document.getElementById("kw").value ;
        	var eleCol = document.getElementById("colSel").value ;
        	window.location = "<%=url%>?cp=" + vcp + "&ls=<%=lineSize%>" + "&col=" + eleCol + "&kw=" + eleKw + "&<%=paramName%>=<%=paramValue%>" ; 
        } catch (Exception) {
			window.location = "<%=url%>?cp=" + vcp + "&ls=<%=lineSize%>" + "&<%=paramName%>=<%=paramValue%>" ;
        }
    }
</script>
<%
    if(allRecorders > 0) {
        pageSize = (allRecorders + lineSize - 1) / lineSize ;
    } else { //没有记录
        pageSize = 1 ;
    }
%>

<ul class="pagination">
<%
if(pageSize > seed * 3) {
%>
    <li class="<%=currentPage == 1 ? "active" : ""%>"><a onclick="goSplit(1)">1</a></li>
<%
    if(currentPage > seed * 2) {
%>
        <li><span>...</span></li>
<%  
        int startPage = currentPage - seed;
        int endPage = currentPage + seed;
        for(int x = startPage; x <= endPage; x++) {
            if(x < pageSize) {
%>
                <li class="<%=currentPage == x ? "active" : ""%>"><a onclick="goSplit(<%=x%>)"><%=x%></a></li>
<%
            }
        }
        if((currentPage + seed * 2) < pageSize) {
%>
            <li><span>...</span></li>
<%  
        } else {
            for (int x = currentPage + seed + 1; x < pageSize; x++) {
%>
                <li class="<%=currentPage == x ? "active" : ""%>"><a onclick="goSplit(<%=x%>)"><%=x%></a></li>
<%        
            }  
        }
    } else { //还在6页以前
        for (int x = 2; x <= currentPage + seed; x++) {
%>
            <li class="<%=currentPage == x ? "active" : ""%>"><a onclick="goSplit(<%=x%>)"><%=x%></a></li>
<%
        }
        if(currentPage + seed * 2 < pageSize) {
%>
            <li><span>...</span></li>
<%  
        }
    }
%>
    <li class="<%=currentPage == pageSize ? "active" : ""%>"><a onclick="goSplit(<%=pageSize%>)"><%=pageSize%></a></li>
<%
} else {
    for(int x = 1; x <= pageSize; x ++) {
%>
        <li class="<%=currentPage == x ? "active" : ""%>"><a onclick="goSplit(<%=x%>)"><%=x%></a></li>
<%
    }
}
%>
    </ul>