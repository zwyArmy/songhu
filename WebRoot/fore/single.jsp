<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Article"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Article get = com.getByArticleId(request.getParameter("id"));
%>
<!DOCTYPE HTML>
<html>
<head>
<title><%=get.getTitle() %></title>
</head>
<body>
<!--banner start here-->
<div class="banner-two">
  <div class="header">
	<div class="container">
		 <div class="header-main">
		 <jsp:include  page="include/top.jsp" flush="true" /> 
		 </div>
	  </div>
	 </div>
 </div>
<!--banner end here-->
<!--single start here-->
		 <div class="single">
			<div class="container">
			<%=get.getContent() %>
				<div class="clearfix"> </div>
			
			</div>
	</div>

<!--//single end here-->
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>