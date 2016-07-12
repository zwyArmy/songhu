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
String column_id = request.getParameter("column_id");
String parentId = request.getParameter("parentId");

//column_id=0301&parentId=03
%>
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
					{@if root.length > 0}
					<div class="divMainRight" style="margin-left: 100px; min-height: 600px;">
						<div class="divModule20" style="margin-left: -220px;">
						<div class="divModule20Content">
						  <div class="divModule20Content1" id="divModule20Content1">
							  <ul>
									{@each root as item,k}
									  <li style="list-style: none;">
									  <font style="font-size: 18px;font-family: Microsoft&nbsp;JhengHei;"><a href="article.html?id=&&{item.id}&column_id=<%=column_id%>&parentId=<%=parentId%>" onclick=""><strong>&&{item.title}</strong></a></font>
									  </li>
									  <li style="list-style: none;height: auto;"><font style="font-size: 12px;font-family: SimSun;">&nbsp;&nbsp;&nbsp;&nbsp;&&{item.summary}...&nbsp;<a href="article.html?id=&&{item.id}&column_id=<%=column_id%>&parentId=<%=parentId%>"  style="color:#cd2a01; ">[详情]</a></font></li>
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