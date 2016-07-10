<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
String parentId = request.getParameter("parentId");
if(StringUtil.isEmpty(cumd)){
cumd = "01";
parentId = "01";
}
List<Column> listColumn = com.listColumnByParent("0");
%>
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
<script type="text/javascript">
    $(function () {
    		//$('#nav-<%=parentId%>').show();
            $('#nav-1 >li').mouseover(function () {
                $('#nav-1 >li >a').each(function () {
                 this.className = "";
                }); 
                $('#link_'+this.id).addClass('active');
                $('.res-0').hide();
                $('#nav-'+this.id).show();
            });
            });
</script>
<div class="container">
		 <div class="header-main">
		   <div class="logo">
		     <h1><a href="index.html"><img src="images/logo.png" style="width:100px;"></a></h1>
				</div>
				<div class="top-nav">
					<span class="menu"> <img src="images/icon.png" alt=""/></span>
				<nav class="cl-effect-1">
					<ul class="res" id="nav-1">
					<%for(int i=0;i<listColumn.size();i++){ 
					%>
					   <li class="relative" id="<%=listColumn.get(i).getId()%>">
					   	<a id="<%="link_"+listColumn.get(i).getId()%>" href="<%=listColumn.get(i).getLink() %>" <%if(listColumn.get(i).getId().equals(parentId)) {%>class="active"<%} %>><%=listColumn.get(i).getColName() %></a>
							<%
							List<Column> list2 = com.listColumnByParent(listColumn.get(i).getId());
							if(list2.size()>0){
							%>
						    <ul class="res-0" id="nav-<%=listColumn.get(i).getId()%>" style="display:none; position:absolution;">
							<%for(int j=0;j<list2.size();j++) {%>
							   <li >
							   <a href="<%=list2.get(j).getLink() %>" ><%=list2.get(j).getColName() %></a>
							   </li> 
							<%} %>
						   </ul><%}else{ %>
						    <ul class="res-0" id="nav-<%=listColumn.get(i).getId()%>"  style="display:none;    ">
						     <li >
						     <a href="#" ></a>
							 </li> 
						    </ul>
						   <%} %>
					   
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
  <script>
  if(!console.log) console.log = function(){};
  </script>