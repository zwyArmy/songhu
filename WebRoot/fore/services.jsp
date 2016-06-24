<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
List<Column> listColumn = com.listColumnByParent("0");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>核心业务</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.0.min.js"></script>
<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Civil Engineer Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!--Google Fonts-->


<!-- start-smoth-scrolling -->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
	<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
				});
			});
	</script>
<!-- //end-smoth-scrolling -->
</head>
<body>
<!--banner start here-->
<div class="banner-two">
  <div class="header">
	<div class="container">
		 <div class="header-main">
				<div class="logo">
					<h1><a href="index.html">嵩湖环保</a></h1>
				</div>
				<div class="top-nav">
					<span class="menu"> <img src="images/icon.png" alt=""/></span>
				  <nav class="cl-effect-1">
					<ul class="res">
					   <%for(int i=0;i<listColumn.size();i++){ %>
					   <li>
					   <a href="<%=listColumn.get(i).getLink() %>" <%if(listColumn.get(i).getId().equals(cumd)) {%>class="active"<%} %>><%=listColumn.get(i).getColName() %></a>
					   </li> 
					<%} %>
				   </ul>
				  </nav>
					<!-- script-for-menu -->
						 <script>
						   $( "span.menu" ).click(function() {
							 $( "ul.res" ).slideToggle( 300, function() {
							 // Animation complete.
							  });
							 });
						</script>
		        <!-- /script-for-menu -->
				</div>
				 <div class="clearfix"> </div>
		 </div>
	  </div>
	 </div>
 </div>
<!--banner end here-->
<!--services start here-->
<div class="services">
	<div class="container">
		<div class="services-main">
			<div class="services-top">
				<h2>Services</h2>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
			</div>
			<div class="services-bottom">
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-grain" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-leaf" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-cloud" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-tint" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-globe" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="col-md-3 services-grid">
					<span class="glyphicon glyphicon-tree-deciduous" aria-hidden="true"></span>
					<h4>Denouncing</h4>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
</div>
<!--services end here-->
<!--over view start here-->
<div class="over-view">
	<div class="container">
		<div class="over-view-main">
			<div class="over-view-top">
				<h3>Services Overview</h3>
			</div>
			<div class="over-view-bott">
			  <div class="col-md-4 over-view-grid">
	  			<div class="col-md-3 cord-drop">
	  				<span class="numbers">1</span>
	  			</div>
	  			 <div class="col-md-9 over-ve-text">
		  				<h4><a href="single.html">There are variations passage</a></h4>
		  				<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
	  			 </div>	
	  		     <div class="clearfix"> </div>
	  		   </div>
				<div class="col-md-4 over-view-grid">
	  			<div class="col-md-3 cord-drop">
	  				<span class="numbers">2</span>
	  			</div>
	  			 <div class="col-md-9 over-ve-text">
		  				<h4><a href="single.html">There are variations passage</a></h4>
		  				<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
	  			 </div>	
	  		     <div class="clearfix"> </div>
	  		  </div>
			 <div class="col-md-4 over-view-grid">
	  			<div class="col-md-3 cord-drop">
	  				<span class="numbers">3</span>
	  			</div>
	  			 <div class="col-md-9 over-ve-text">
		  				<h4><a href="single.html">There are variations passage</a></h4>
		  				<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
	  			 </div>	
	  		     <div class="clearfix"> </div>
	  		  </div>
			   <div class="clearfix"> </div>
			</div>
			<div class="other-serv">
					<h3>Other Services</h3>
					<div class="col-md-4 other-serv-grid">
						<h4><a href="single.html">Nam libero tempore cum soluta</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
						<h4><a href="single.html">Et harum quidem facilis distin</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
					</div>
					<div class="col-md-4 other-serv-grid">
						<h4><a href="single.html">Lorem ipsum dolor consectetur</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
						<h4><a href="single.html">Nam libero tempore cum soluta</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
					</div>
					<div class="col-md-4 other-serv-grid">
						<h4><a href="single.html">Nam libero tempore cum soluta</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
						<h4><a href="single.html">Et harum quidem facilis distin</a></h4>
						<p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
					</div>
				  <div class="clearfix"> </div>
				</div>
		</div>
	</div>
</div>
<!--over-view end here-->
<!--footer start here-->
<div class="footer">
	<div class="container">
		<div class="footer-main">
				<div class="col-md-4 ftr-gd">
					<h3>加入我们</h3>
					<ul>
						<li><a href="#" class="fa"> </a></li>
						<li><a href="#" class="tw"> </a></li>
						<li><a href="#" class="g"> </a></li>
					</ul>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>邮箱</h3>
					<form>
						<input  type="text" value="输入您的邮箱" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '输入您的邮箱';}">
						<input type="submit" value="发送">
					</form>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>联系方式</h3>
					<p>地址：厦门湖里区云顶中路2777号市政大厦24层</p>
					<p>电话:0592-5172555</p>
				</div>
			<div class="clearfix"> </div>
		</div>
		<div class="copyright">
			   <p>© 2016 厦门嵩湖环保股份有限公司保留所有权力| 设计于：  <a href="http://user.qzone.qq.com/75742471/infocenter?ptsig=BzgxE7qGKt9LwgRZZ--koWI-EOgR8Hi9XciUf3RwCWc_" target="_blank">  Woody </a></p>
		</div>
		<script type="text/javascript">
										$(document).ready(function() {
											/*
											var defaults = {
									  			containerID: 'toTop', // fading element id
												containerHoverID: 'toTopHover', // fading element hover id
												scrollSpeed: 1200,
												easingType: 'linear' 
									 		};
											*/
											
											$().UItoTop({ easingType: 'easeOutQuart' });
											
										});
									</script>
						<a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

	</div>
</div>
<!--footer end here-->
</body>
</html>