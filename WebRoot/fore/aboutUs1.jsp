<%@page import="org.springframework.beans.factory.ListableBeanFactory"%>
<%@page import="songhu.common.pojo.Article"%>
<%@page import="songhu.common.bean.ArticleBean"%>
<%@page import="songhu.common.service.ArticleService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
	<jsp:useBean id="com" scope="page" class="songhu.common.bean."
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
<!-- <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all"> -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.0.min.js"></script>
<!-- Custom Theme files -->
<!-- <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/> -->
<link rel="stylesheet" href="css/animate.css" type="text/css">
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Civil Engineer Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!--Google Fonts-->

<%
	Article introduce = com.listByColumnId("0201"); //简介
	List<Article> growths = com.listByColumnId("0203", 10);//成长
	List<Article> cultures = com.listByColumnId("0202", 0,10);//企业文化
	
%>

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
	  <jsp:include  page="include/top.jsp" flush="true" /> 
	 </div>
 </div>
<!--banner end here-->
<!--introduce start here-->
<div class="about">
	<div class="container">
		<div class="about-main">
			<div class="about-top bounceInLeft animated">
				<h2><%=introduce!=null?introduce.getTitle():"简介"%></h2>
				<p>“打造一流企业，共创美好生活”是嵩湖环保人孜孜以求的奋斗目标。嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的</p>
			</div>
			<div class="about-bottom">
				<div class="col-md-6 ab-left">
					<span class="font_jianjie bounceInRight animated">
					<%=introduce!=null?introduce.getContent():""%>
				</span></div>
                
				<div class="col-md-6 ab-right bounceIn animated">
					<a href="single.html"><img src="images/ab.jpg" alt="" class="img-responsive"></a>
				</div>
			   <div class="clearfix"> </div>
			</div>
		</div>
	</div>
</div>
<!--introduce end here-->
<!--banner-info strat here-->
<%if(introduce != null) { %>
<!-- 
 <div class="bann-info">
	<div class="container">
		<div class="bann-info-main">
			<div class="bann-info-bottom">
			  <div class="clearfix"> </div>
			</div>
			<h3>企业文化</h3>			
			<p> 企业核心价值观：卓越、创新、责任、共赢 </p>
			<p>企业愿景：嵩湖环保，让生活更美好 （嵩湖环保，泽被万家）</p>
			<p>	经营理念：创造技术价值，服务环境保护</p>
			<p>	经营目标：提升规模效益、提升核心竞争力，打造产业特色，在发展壮大中实现社会价值，把嵩湖环保打造成有实力、信得过、有责任、敢担当的优秀企业。
			</p>
		</div>
	</div>
</div>  -->
<%} %>
<!--banner info end here-->
<!--banner-strip start here-->
<!--banner-strip start here-->
<div class="bann-info-main bann-strip gold">
	 <div class="bann-info">
		<div class="container">
			<div id="culture" class="bann-info-main ">
				<div class="bann-info-bottom">
				  <div class="clearfix"> </div>
				</div>
				<h3>企业文化</h3>
				<ul class="list-unstyled" style="min-height: 320px;">			
				   	<!-- <li class="hide" ><label class=" left">企业核心价值观：</label><span>卓越、创新、责任、共赢 </span></li>
					 -->
					<%for(int i = 0 ; cultures != null &&i < cultures.size();i++) {%>
						<li class="hide" ><label class=" left"><%=cultures.get(i).getTitle() %></label><span><%=cultures.get(i).getSummary() %></span></li>
					
					<% }%>
				</ul>
			</div>
		</div>
	</div> 
	<div id="jianjie"class="container" style="display:block">
		<h3>成长足迹</h3>
		<ul class="list-unstyled" >
						<%
							
							for(int i = 0 ; cultures != null &&i < growths.size();i++) {
								int size = growths.size() -1;
							%>
						<li class="hide" ><label class=" left"><%=growths.get(size - i).getTitle() %></label><span><%=growths.get(size - i).getSummary() %></span></li>
					
					<% }%>
		</ul>
	</div>
</div>
	
	
<!--banner-strip end here--
<!--banner-strip end here-->
<!--time start here--><!-- 
<div class="bann-strip gold">
	<div class="container">
		<div class="banner-strip-main">
			<h3>打造一流企业，共创美好生活</h3>
			<p>嵩湖环保愿以一流的技术、一流的产品、一流的服务和上市公司实力与各界朋友携手合作，共同为保护人类美好的环境而努力。</p>
		</div>
	</div>
</div>  -->
<!--time end here-->

<div class="staff">
	<div class="container">
		<div class="staff-main">
			<div class="staff-top">
				<h3>荣誉资质</h3>
			</div>
			<div class="staff-bottom">
				<div class="col-md-3 staff-grid">
					<img src="images/hornor/Aji.jpg" alt="" class="img-responsive">
					<h4>NO.1</h4>
					<p> 福建仙游县经济开发区污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/hornor/gaoxin.jpg" alt="" class="img-responsive">
					<h4>NO.2</h4>
					<p>福建仙游县第二污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/hornor/huiyuan.jpg" alt="" class="img-responsive">
					<h4>NO.3</h4>
					<p> 福建霞浦县台湾水产品集散中心污水处理厂</p>
				</div>
				<div class="col-md-3 staff-grid">
					<img src="images/hornor/shouhetong.jpg" alt="" class="img-responsive">
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
											
											
											var animate = false;
											var elemet = [{id:'jianjie',animate:false},{id:'culture',animate:false}]
											 $(window).scroll(function () {
												for(var ele in elemet) {
													var obj = elemet[ele]
													var a = document.getElementById(obj.id).offsetTop;
													if (a >= $(window).scrollTop() && a < ($(window).scrollTop()+$(window).height())) {
		
														if(!obj.animate) {
															var index = 0;
															timeLineAminate(index,obj.id);
															obj.animate = true;
														}																		
												};
												}
												
											});
											/**/
											var timeLineAminate = function(index,id){
												var that = $("#"+id).find("li").eq(index);
												if(that.size() > 0){
													setTimeout(function() { 	
															console.log(123)
															that.removeClass().addClass('bounceIn' + ' animated')
															.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
															  $(this).removeClass();
															  timeLineAminate(index+1,id);
															});
														},50);													
												}
											}
											
										});
									</script>
						<!-- <a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a> -->
						

	</div>
</div>
<!--footer end here-->
</body>
</html>