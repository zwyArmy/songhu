<%@page import="songhu.common.pojo.Xyrz"%>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="songhu.common.pojo.Article"%>
<%@page import="songhu.common.bean.ArticleBean"%>
<%@page import="songhu.common.service.ArticleService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>公司简介</title>
<link rel="stylesheet" href="css/animate.css" type="text/css">


<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = request.getParameter("id");
%>
</head>
<body class="backcolor">
<!--banner start here-->
<div class="banner-two">
<div class="header">
<jsp:include  page="include/top.jsp" flush="true" /> 
</div>
 </div>
<!--single start here-->
		 <div class="single">
			<div class="container">
			<div class="col-md-3 categories-grid">
				<jsp:include  page="include/left.jsp" flush="false" /> 
			</div>
			<div class="col-md-8 " id='container'>		
				<div class=" single-profile"></div>
				</div>
			<div class="clearfix"> </div>
			
			</div>
	</div>

<!--//single end here-->
<!--footer start here-->

<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
<link rel="stylesheet" type="text/css" href="css/style_common.css" />
<link rel="stylesheet" type="text/css" href="css/style7.css" />
<script src="js/juicer.js"></script>
<script src="js/juicer.ext.js"></script>
		<script type="text/html" id="templ">
			<div class=" single-grid">
					<!--<img class="img-responsive" src="images/123456.jpg" alt=""  class="img-responsive">
					-->					
					<div class="lone-line">
						<h2>&&{title}</h2>
						<div class="cal">
							<ul>
								<li><span ><i class="glyphicon glyphicon-calendar"> </i>&&{createTime|dateFormat}</span></li>
								<li><a href="#" ><i class="glyphicon glyphicon-user"> </i>&&{author}</a></li>
							</ul>
						</div>
						&&{content}
					</div>
			</div>		
		</script>
<script type="text/javascript">
		$(document).ready(function() {
			getPage('<%=id%>');	
		});
		function getPage(id){
	  	  	var url = "<%=basePath%>/articleController.do?get";
	  	  	$.ajax({
				url:url,
				type:"GET",
				data:{"id":id},
				async:false,
				dataType:"json",
				success:function(data){
					var tmpl =$('#templ').html();
			        var json = data;
			        console.log(data);
					$("#container").html(juicer(tmpl,json.data));
				}
	  	  	});
			
	  	}
</script>
</html>