<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.util.StartOnLoadService"%>
<%
String webaddress = StartOnLoadService.parameterMap.get("webaddress");
String webphone = StartOnLoadService.parameterMap.get("webphone");
%>
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