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
<jsp:useBean id="hornor" scope="page" class="songhu.common.bean.XyrzBean"
	type="songhu.common.bean.XyrzBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");

Article introduce = com.listByColumnId("0201",0,1).get(0); //简介
List<Article> growths = com.listByColumnId("0203", 10);//成长
List<Article> cultures = com.listByColumnId("0202", 0,10);//企业文化
System.out.println(growths);
	List<Xyrz> list1 = hornor.findByTypeList("02", 4);
	List<Xyrz> list2 = hornor.findByTypeList("01", 8);

%>
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
<!--introduce start here-->
<div class="backcolor ">
<div class="about backimg" >
	<div class="container">
		<div class="about-main" >
			<div class="about-top fadeIn animated">
				<h2><%=introduce!=null?introduce.getTitle():"简介"%></h2>
				<p ></p>
			</div>
			<div class="about-bottom">
				<div class="col-md-2 ab-left">
				</div>
				<div class="col-md-8 ab-left">
					<span class="font_jianjie bounceInRight animated">
					<%=introduce!=null?introduce.getContent():""%>
				</span></div>
             </div>
               
		</div>
	</div>

</div>
<div>
		<div class="container" style="    margin-top: 4em;">
		<div class="about-top">
	                	<h2 class="">
							组织机构
						</h2>
	                	<div class="col-md-8 ab-right fadeIn animated">
						<a ><img src="images/zjjg.png" alt="" class="img-responsive"></a>
					</div> 
					<div class="col-md-4 company">
						<div><label>总&nbsp;&nbsp;部&nbsp;:</label><span>厦门嵩湖环保股份有限公司</span></div>
						<div><label>子公司&nbsp;:</label><span>莆田市华科环保工程有限公司 </span></div>
						<div><label></label><span>莆田中环水务有限公司</span></div>
						<div><label></label><span>霞浦中泓水务有限公司</span></div>
						<div><label></label><span>金昌华科环境技术有限公司 </span></div>
						
						
					</div>
				   <div class="clearfix"> </div>
				</div>
	</div>
</div>
<!--introduce end here-->

<!--banner-strip start here-->
<div class="bann-info-main1 bann-strip gold " >
	
	 <div class="bann-info" id="jianjie" >
		<div class="container">
			<div id="" class="bann-info-main ">
			<div  class="hide" >			
					<div class="container" style="display:block">
					
					
					<div class="col-md-7">
						<h3>成长足迹</h3>
						<ul class="list-unstyled" style="margin-top:2em;">
										<%
											
											for(int i = 0 ; cultures != null &&i < growths.size();i++) {
												int size = growths.size() -1;
											%>
										<li  ><label class=" left"><%=growths.get(size - i).getTitle() %></label><span><%=growths.get(size - i).getSummary() %></span></li>
									
									<% }%>
						</ul>	
					</div>
					<div class="col-md-2">
					</div>
				</div>
			</div>
			</div>
		</div>
	</div> 
	
	

</div>
<!--banner-info strat here-->
<%if(introduce != null) { %>
 
	 <div class="bann-info-main1  clutureimg" id="culture"   >
		<div class="container">
			<div  class="bann-info-main ">
			<div  class="hide">
				<div class="col-md-7" style="margin-top:4em;">
						<h3>企业文化</h3>
						<ul class="list-unstyled" style="margin-top:2em;">
							<%for(int i = 0 ; cultures != null &&i < cultures.size();i++) {%>
							<li  ><label class=" left"><%=cultures.get(i).getTitle() %></label><span><%=cultures.get(i).getSummary() %></span></li>
					
							<% }%>
						</ul>	
				</div>
				
				</div>
			</div>
		</div>
	</div>   
<%} %>
<!--banner info end here-->
<!--banner-strip start here-->

	
	


<!--time end here-->

<div class="staff " id="ryzj" style="margin: 2.5em 0em 0em 0em;min-height:650px;padding-bottom:2em">
	<div class="container  hide">
		<div class="staff-main">
			<div class="staff-top">
				<h3>资质</h3>
			</div>
			<div class="staff-bottom" style="    margin: 2.5em 0em 0em 0em;">
				<%for(int i = 0 ; i < list1.size(); i++) {
					Xyrz bean = list1.get(i);
				%>
				<div class="col-md-3 staff-grid">
					<img src="<%=basePath+bean.getPath() %>" alt="" class="img-responsive">
					<p> <%=bean.getName() %></p>
				</div>
				<%if(i == 3) {%>
					  <div class="clearfix"> </div>
				<%}%>
				<%} %>
				
				
			</div>
			
		</div>
		<div class="staff-main" style="margin: 3em 0em 0em 2em;">
			<div class="staff-top">
				<h3>荣誉</h3>
			</div>			
			<div class="staff-bottom">
				<%for(int i = 0 ; i < list2.size(); i++) {
					Xyrz bean = list2.get(i);
				%>
				<div class="col-md-3 staff-grid" style="    margin: 2.5em 0em 0em 0em;">
					<img src="<%=basePath+bean.getPath() %>" alt="" class="img-responsive">
					<p> <%=bean.getName() %></p>
				</div>
					<%if(i == 3) {%>
					  <div class="clearfix"> </div>
					<%}%>
				<%} %>
				
				
			</div>
			
		</div>
	</div>
</div>
</div>
<!--about end here-->
<!--about end here-->
<!--
<div class="bann-info backcolor">
	<div class="container">
		<div class="bann-info-main">
			<div class="bann-info-bottom">
			  <div class="clearfix"> </div>
			</div>
			<h3>社会责任</h3>			
			<p> 嵩湖环保在较短时间内迅速成长壮大，在行业内保持强劲的发展势头，源自对社会的责任。在责任就是事业的发展历程中，嵩湖环保对社会负责、对环境负责、对员工及客户负责，实现了企业的跨越式发展、可持续发展。</p>
		</div>
	</div>
</div>  -->

<!--footer start here-->

<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
<script type="text/javascript">
		$(document).ready(function() {
			var animate = false;
			var elemet = [{id:'jianjie',animate:false},{id:'culture',animate:false},{id:'ryzj',animate:false},{id:'jgzj',animate:false}]
			 $(window).scroll(function () {
				for(var ele in elemet) {
					var obj = elemet[ele];
					if(!document.getElementById(obj.id)) continue;

					var a = document.getElementById(obj.id).offsetTop + 100;
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
			var iaction = 0 ;
			var timeLineAminate = function(index,id){
				var action = ['fadeIn'];

				var that = $("#"+id).find(".hide").eq(index);
				if(that.size() > 0){
					setTimeout(function(){
						console.log(123)
						that.removeClass("hide").addClass(action[iaction++] + ' animated')
						.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
						  //$(this).removeClass();
						  timeLineAminate(index+1,id);
						});
					},1000);
							
																		
				}
			}
			
		});
</script>
</html>