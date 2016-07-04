<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Article"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Article> banner = com.findByTop("0401", 0, 3);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>厦门嵩湖环保股份有限公司</title>
<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
<style type="text/css">
body,td,th {
	font-family: "MicrosoftYaHei";
}
</style>
</head>
<body>
<!--banner start here-->
<div class="banner">
  <div class="header">
  <jsp:include  page="include/top.jsp" flush="true" /> 
	  <section class="slider">
		 <div class="flexslider">
			<ul class="slides">
			<%for(int i = 0;i < banner.size();i++){ %>
			<li>
			  	<div class="banner-bottom">
				 	<h2><%=banner.get(i).getTitle() %></h2>
				 	<p><%=banner.get(i).getSummary() %></p>
				 	<a href="<%=banner.get(i).getId() %>_0401.html">点击查看</a>
			 	</div>
			  </li>
			<%} %>
		    </ul>
		 </div>
		 <div class="clearfix"> </div>
	  </section>
 </div>
</div>
<!--banner end here-->
<!-- FlexSlider -->
				  <script defer src="js/jquery.flexslider.js"></script>
				  <script type="text/javascript">
					$(function(){
					 
					});
					$(window).load(function(){
					  $('.flexslider').flexslider({
						animation: "slide",
						start: function(slider){
						  $('body').removeClass('loading');
						}
					  });
					});
				  </script>
			<!-- FlexSlider -->
<!--planing strat here-->
<div class="plan">
	<div class="container">
		<div class="plan-main">
 			<div class="plan-top">
				<h3>成功上市</h3>
				<p>提升规模效益、提升核心竞争力，打造产业特色，在发展壮大中实现社会价值，把嵩湖环保打造成有实力、信得过、有责任、敢担当的优秀企业。</p>
			
			</div> 
			<img alt="" src="images/xinsanban.jpg" style="width:100%;">
		</div>
	</div>
</div>
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>