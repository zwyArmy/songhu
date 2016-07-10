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
String cumd = request.getParameter("cumd");
%>
</head>
<body>
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
				<div class="grid-categories">
					<h4>Categories</h4>
					<ul class="popular ">
						<li><a href="services.html"><i class="glyphicon glyphicon-ok"> </i>市政建设</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>环保产业技术服务</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>产品研发</a></li>
					</ul>
				</div>
				<div class="grid-categories">
					<h4>最近新闻</h4>
					<ul class="popular popular-in">
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>J嵩湖环保十三周年庆</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
					</ul>
				</div> 
			</div>
			<div class="col-md-8 " id='container'>

				

				<div class=" single-profile">
				</div>
			</div>

				<div class="clearfix"> </div>
			
			</div>
	</div>

<!--//single end here-->
<!--footer start here-->

<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
<script src="js/juicer.js"></script>
<script src="js/juicer.ext.js"></script>
		<script type="text/html" id="templ">
				<div class=" single-grid">
					{@if root.length > 0}
					<div class="divMainRight" style="margin-left: 100px; min-height: 600px;">
						<div class="divModule20" style="margin-left: -220px;">
						<div class="divModule20Content">
						  <div class="divModule20Content1" id="divModule20Content1">
							  <ul>
									{@each root as item,k}
									  <li style="list-style: none;">
									  <font style="font-size: 18px;font-family: Microsoft&nbsp;JhengHei;"><a href="article.html" onclick=""><strong>&&{item.title}</strong></a></font>
									  </li>
									  <li style="list-style: none;height: auto;"><font style="font-size: 12px;font-family: SimSun;">&nbsp;&nbsp;&nbsp;&nbsp;&&{item.summary}...&nbsp;<a href="javascript:void(0);" onclick="openWin(this,'ca477549','0204');" style="color:#cd2a01; ">[详情]</a></font></li>
									  <li style="list-style: none;height: auto;">
									  <font style="color: #999;font-size: 12px;font-family: SimSun;">&&{item.createTime|dateFormat}</font>
									  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<font style="color: #db000;font-size: 12px;font-family: SimSun;">&&{item.author}</font>
									  </li>
									  <br>
									  <div class="divbottom"></div>
									  {@/each}
							  </ul>
							</div>
						  </div>
						</div>
					</div>
					&&{page,totalProperty,pagecount,getlistFunc|pagingFun}
					
				{@else}
				<div class="divMainRight" style="margin-left: 100px;">
					<div class="divModule20" style="margin-left: -220px;"> 没有文章.</div>
				</div>
				{@/if}

				</div>
			
		</script>
<script type="text/javascript">
/*{"total":"6","page":"1","getlistFunc":"getCurTask","pagecount":"9","list":[{"course_name":"会计基础（2016年新）","course_id":"0516084FAC1102FC00013332796649","coursetotal":"0","chaptertotal":"0"},{"course_name":"初级会计电算化（2016新）","course_id":"0515E4B6AC1102FC00013331176200","coursetotal":"0","chaptertotal":"0"},{"course_name":"财经法规与会计职业道德（2016年新）","course_id":"0515C4DEAC1102FC00013330212591","coursetotal":"0","chaptertotal":"0"},{"course_name":"初级会计电算化","course_id":"CDD2F1A3C0A80ACE00000001352695","coursetotal":"0","chaptertotal":"0"},{"course_name":"财经法规与会计职业道德","course_id":"CDDAFCA8C0A80ACE00000030863693","coursetotal":"0","chaptertotal":"0"},{"course_name":"会计基础","course_id":"CE066360C0A80ACE00000932324961","coursetotal":"0","chaptertotal":"0"}]}*/
		$(document).ready(function() {

			getCurList(1);
			
			
		});
		var pagecount = 5;
		function getCurList(page){
			 limit = (page) * pagecount;
			 start = (page-1) * pagecount;
	  	  	var url = "<%=basePath%>/articleController.do?find";
	  	  	$.ajax({
				url:url,
				type:"POST",
				data:{"limit":limit, "start":start,"columnId":"0301"},
				async:false,
				dataType:"json",
				success:function(data){
					var tmpl =$('#templ').html();
			        var json = data;
			        console.log(data);
			        data.pagecount = pagecount;
			        data.page = page;
			        data.getlistFunc = "getCurList";
					$("#container").html(juicer(tmpl,json));
				}
	  	  	});
			
	  	}
</script>
</html>