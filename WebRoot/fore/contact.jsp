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
<title>联系我们</title>
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
<!--content-->
<div class="container">
   <div class="contact">
	 <div class="contact-md">
			 <h3>Contact</h3>
			 <p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born</p>
		 </div>
				<div class="col-md-6 contact-top">
					<h3>Want to work with me?</h3>
					<form>
						<div>
							<span>Your Name </span>		
							<input type="text" placeholder="">					
						</div>
						<div>
							<span>Your Email </span>		
							<input type="text" placeholder="">						
						</div>
						<div>
							<span>Subject</span>		
							<input type="text" placeholder="">	
						</div>
						<div>
							<span>Your Message</span>		
							<textarea placeholder="" required></textarea>		
						</div>
						<input type="submit" value="Submit">	
				  </form>
				</div>
				<div class="col-md-6 contact-top">
					<h3>Info</h3>
					
					<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas </p>
					<p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id </p>				
					<div class="map">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d37494223.23909492!2d103!3d55!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x453c569a896724fb%3A0x1409fdf86611f613!2sRussia!5e0!3m2!1sen!2sin!4v1415776049771"></iframe>
					</div>
				</div>
			<div class="clearfix"> </div>
	</div>
</div>
<!--contact end here-->
<!--footer start here-->
<div class="footer">
	<div class="container">
		<div class="footer-main">
				<div class="col-md-4 ftr-gd">
					<h3>å å¥æä»¬</h3>
					<ul>
						<li><a href="#" class="fa"> </a></li>
						<li><a href="#" class="tw"> </a></li>
						<li><a href="#" class="g"> </a></li>
					</ul>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>é®ç®±</h3>
					<form>
						<input  type="text" value="è¾å¥æ¨çé®ç®±" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'è¾å¥æ¨çé®ç®±';}">
						<input type="submit" value="åé">
					</form>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>èç³»æ¹å¼</h3>
					<p>å°åï¼å¦é¨æ¹éåºäºé¡¶ä¸­è·¯2777å·å¸æ¿å¤§å¦24å±</p>
					<p>çµè¯:0592-5172555</p>
				</div>
			<div class="clearfix"> </div>
		</div>
		<div class="copyright">
			   <p>Â© 2016 å¦é¨åµ©æ¹ç¯ä¿è¡ä»½æéå¬å¸ä¿çæææå| è®¾è®¡äºï¼  <a href="http://user.qzone.qq.com/75742471/infocenter?ptsig=BzgxE7qGKt9LwgRZZ--koWI-EOgR8Hi9XciUf3RwCWc_" target="_blank">  Woody </a></p>
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