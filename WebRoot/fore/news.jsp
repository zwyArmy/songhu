<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>公司新闻</title>
<link rel="stylesheet" href="css/animate.css" type="text/css">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
%>
<style type="text/css">
.paginate {
    margin-left: 100px;
    background-color: #fff;
    padding: 20px 0 10px 0;
    text-align: center;
    font-size: 12px;
    float: left;
}
</style>
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
				<jsp:include  page="include/left.jsp" flush="true" /> 
				
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
					<div class="article-list">
					{@if root.length > 0}
							  <ul>
									{@each root as item,k}
									  <li style="list-style: none;">
									  <font style="font-size: 18px;font-family: Microsoft&nbsp;JhengHei;"><a onclick="openWin('&&{item.id}');"><strong>&&{item.title}</strong></a></font>
									  </li>
									  <li style="list-style: none;height: auto;"><font style="font-size: 12px;font-family: SimSun;">&nbsp;&nbsp;&nbsp;&nbsp;&&{item.summary}...&nbsp;<a onclick="openWin('&&{item.id}');"  style="color:#cd2a01; ">[详情]</a></font></li>
									  <li style="list-style: none;height: auto;">
									  <font style="color: #999;font-size: 12px;font-family: SimSun;">&&{item.createTime|dateFormat}</font>
									  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<font style="color: #db000;font-size: 12px;font-family: SimSun;">&&{item.author}</font>
									  </li>
									  <br>
									  <div class="divbottom"></div>
									  {@/each}
							  </ul>
					&&{page,totalProperty,pagecount,getlistFunc|pagingFun}
					
				{@else}
					<div > 没有文章.</div>
				{@/if}
				</div>
				</div>
			
		</script>
<script type="text/javascript">
		 var openWin = function(id){
		 	location.href = id+'_'+'<%=cumd%>'+'.html';
		 };
		$(document).ready(function() {

			getCurList(1);
			
			
		});
		var pagecount = 10;
		function getCurList(page){
			 limit = (page) * pagecount;
			 start = (page-1) * pagecount;
	  	  	var url = "<%=basePath%>/articleController.do?find";
	  	  	$.ajax({
				url:url,
				type:"POST",
				data:{"limit":limit, "start":start,"columnId":"<%=cumd%>"},
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