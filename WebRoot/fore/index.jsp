<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<%@page import="songhu.util.StartOnLoadService"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
if(StringUtil.isEmpty(cumd)){
cumd = "0";
}
List<Column> listColumn = com.listColumnByParent(cumd);
String columnId = "01";
String webaddress = StartOnLoadService.parameterMap.get("webaddress");
String webphone = StartOnLoadService.parameterMap.get("webphone");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>厦门嵩湖环保股份有限公司</title>
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
			  <li>
			  	<div class="banner-bottom">
				 	<h2>成功上市</h2>
				 	<p>恭喜嵩湖环保在全国股份转让系统成功挂牌</p>
				 	<a href="single.html">点击查看</a>
			 	</div>
			  </li>
			  <li>
			 	<div class="banner-bottom">
				 	<h2>了解嵩湖</h2>
				 	<p>嵩湖环保,让生活更美好！</p>
				 	<a href="single.html">点击查看</a>
			 	</div>
			  </li>
			  <li>
			 	<div class="banner-bottom">
				 	<h2>选择我们</h2>
				 	<p>卓越  丨  创新  丨  责任  丨  共赢 </p>
				 	<a href="single.html">点击查看</a>
			 	</div>
			  </li>
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
			<div class="plan-bottom">
				<div class="col-md-6 plan-left">
					<a href="single.html"></a>
					<div class="plan-bot-text">
						<h4><a href="single.html">嵩湖环保成功挂牌新三板</a></h4>
						<p>经过十余年的积累沉淀，公司由小变大、由弱变强，于2016年1月在全国中小企业股份转让系统成功挂牌上市。</p>
				    </div>
				</div>
				<div class="col-md-6 plan-right">
					<a href="single.html"><img src="images/dongshizhang.JPG" alt="" class="img-responsive"></a>
					<div class="plan-bot-text">
						<h4><a href="single.html">嵩湖环保成功挂牌新三板</a></h4>
						<p>经过十余年的积累沉淀，公司由小变大、由弱变强，于2016年1月在全国中小企业股份转让系统成功挂</p>
				    </div>
				</div>
			   <div class="clearfix"> </div>
			</div>
		   <div class="clearfix"> </div>
		</div>
	</div>
</div>
<!--planing end here-->
<!--our mission start here-->
<div class="mission">
	<div class="container">
		<div class="mission-main">
			 <div class="col-md-6 mission-left">
			 	<div class="mission-top">
			 		<h3>嵩湖环保</h3>
			 		<p>嵩湖环保股份有限公司的最新动态</p>
			 	</div>
			 	<div class="mission-wedo">
			 	  <div class="mission-grid-left">
			 		<span class="glyphicon glyphicon-pushpin miss-wedo-icon" aria-hidden="true"></span>
			 		<div class="miss-text">
			 			<h4><a href="single.html">嵩湖环保成功挂牌新三板</a></h4>
			 			<p>“打造一流企业，共创美好生活”是嵩湖环保人孜孜以求的奋斗目标。嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的环境而努力</p>
			 		</div>
			 	  <div class="clearfix"> </div>
			 	</div>
			 	<div class="mission-grid-left">
			 		<span class="glyphicon glyphicon-wrench miss-wedo-icon" aria-hidden="true"></span>
			 		<div class="miss-text">
			 			<h4><a href="single.html">嵩湖环保成功挂牌新三板</a></h4>
			 			<p>“打造一流企业，共创美好生活”是嵩湖环保人孜孜以求的奋斗目标。嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的环境而努力。</p>
			 		</div>
			 	  <div class="clearfix"> </div>
			 	</div>
			  </div>
			 </div>
			 <div class="col-md-6 mission-right">
			 	<div class="mission-top">
			 		<h3>发展规划</h3>
			 		<p>嵩湖环保，让生活更美好！</p>
			 	</div>
			 	<div class="mission-wedo">
			 	  <div class="mission-grid-right">
			 		<div class="miss-img"></div>
			 		<span class="miss-img"><a href="single.html"><img src="images/mubiao.png" alt="" class="img-responsive"></a></span>
			 		<div class="miss-text miss-tex-rit">
		 			  <h4><a href="single.html">经营目标</a></h4>
			 			<p>提升规模效益、提升核心竞争力，打造产业特色，在发展壮大中实现社会价值，把嵩湖环保打造成有实力、信得过、有责任、敢担当的优秀企业。</p>
			 		</div>
			 	  <div class="clearfix"> </div>
			 	</div>
			 	<div class="mission-grid-right">
			 		<div class="miss-img"><a href="single.html"><img src="images/fanwei.png" alt="" class="img-responsive"></a></div>
			 		<div class="miss-text miss-tex-rit">
			 			<h4><a href="single.html">经营范围</a></h4>
			 			<p>市政工程、环保工程设计施工、设施营运、环境监理、环境影响评价、环保检测验收等</p>
			 		</div>
			 	  <div class="clearfix"> </div>
			 	</div>
			  </div>
			 </div>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<!--establish end here-->
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
					<p>地址：<%=webaddress %></p>
					<p>电话:<%=webphone %></p>
				</div>
			<div class="clearfix"> </div>
		</div>
		<div class="copyright">
			   <p>© 2016 厦门嵩湖环保股份有限公司保留所有权力</p>
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