<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
List<Column> listColumn = com.listColumnByParent(request.getParameter("parentId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>公司简介</title>
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
					 <li>
					   <a href="index.html"><%="<<" %></a>
					   </li> 
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
<!--banner-info strat here-->
<div class="bann-info">
	<div class="container">
		<div class="bann-info-main">
			<div class="bann-info-bottom">
			  <div class="clearfix"> </div>
			</div>
			<h3>嵩湖环保，让生活更美好！</h3>			
			<p> 自2003年6月创立以来，嵩湖环保始终坚持“创造技术价值，服务环境保护”的经营理念，依托先进的技术、科学的管理，以推动中国环保事业发展为己任，不断追求卓越、阔步前行。经过十余年的积累沉淀，公司由小变大、由弱变强，于2016年1月在全国中小企业股份转让系统成功挂牌上市。</p>
		</div>
	</div>
</div>
<!--banner info end here-->
<!--banner-strip start here-->
<div class="jianjie_time">
<img src="images/time.jpg" width="100%" height="730" align="baseline"> </div>
<!--banner-strip end here-->
<!--time start here-->
<div class="bann-strip gold">
	<div class="container">
		<div class="banner-strip-main">
			<h3>打造一流企业，共创美好生活</h3>
			<p>嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的环境而努力。</p>
		</div>
	</div>
</div>
<!--time end here-->
<!--about start here-->
<div class="about">
	<div class="container">
		<div class="about-main">
			<div class="about-top">
				<h2>简介</h2>
				<p>“打造一流企业，共创美好生活”是嵩湖环保人孜孜以求的奋斗目标。嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的</p>
			</div>
			<div class="about-bottom">
				<div class="col-md-6 ab-left">
					<h4><a href="single.html"><span class="font_jianjie">厦门嵩湖环保股份有限公司（以下简称“嵩湖环保”）是一家集投资建设环保工程、开发运用新能源新技术、提供环保技术服务的现代高新技术企业。自2003年6月创立以来，嵩湖环保始终坚持“创造技术价值，服务环境保护”的经营理念，依托先进的技术、科学的管理，以推动中国环保事业发展为己任，不断追求卓越、阔步前行。经过十余年的积累沉淀，公司由小变大、由弱变强，于2016年1月在全国中小企业股份转让系统成功挂牌上市。
</p>
				</span></div>
                
				<div class="col-md-6 ab-right">
					<a href="single.html"><img src="images/ab.jpg" alt="" class="img-responsive"></a>
				</div>
			   <div class="clearfix"> </div>
			</div>
		</div>
	</div>
</div>

<div class="staff">
	<div class="container">
		<div class="staff-main">
			<div class="staff-top">
				<h3>环保工程投资建设</h3>
			</div>
			<div class="staff-bottom">
				<div class="col-md-3 staff-grid">
					<img src="images/no1.JPG" alt="" class="img-responsive">
					<h4>NO.1</h4>
					<p> 福建仙游县经济开发区污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/no2.JPG" alt="" class="img-responsive">
					<h4>NO.2</h4>
					<p>福建仙游县第二污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/no3.jpg" alt="" class="img-responsive">
					<h4>NO.3</h4>
					<p> 福建霞浦县台湾水产品集散中心污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/no4.jpg" alt="" class="img-responsive">
					<h4>NO.4</h4>
					<p> 甘肃金昌市河西镇生活污水处理厂</p>
				</div>
			  <div class="clearfix"> </div>
			</div>
		</div>
	</div>
</div>
<!--about end here-->
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