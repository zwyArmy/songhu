<%@page import="songhu.common.pojo.Xyrz"%>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="songhu.common.pojo.Article"%>
<%@page import="songhu.common.bean.ArticleBean"%>
<%@page import="songhu.common.service.ArticleService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>核心业务</title>
<link rel="stylesheet" href="css/animate.css" type="text/css">


<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>

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
						<div class="divMainRight" style="margin-left: 30px;">
							<div class="标题标题-main">

			<div class="标题标题-bottom" style="    width: 900px;">
				{@each root as item,k}
			   <div class="view view-seventh">
                    <a href="article.html?id=&&{item.id}&column_id=<%=column_id%>&parentId=<%=parentId%>" class="b-link-stripe b-animate-go  swipebox" title="Image Title"><img src="<%=basePath%>/userfiles/images/thumbs/&&{item.tnPath}" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>&&{item.title}</h2>
                        <p>&&{item.author}</p>
                        <span class="gall">详情</span>
                    </div></a>
                </div>
                {@/each}
        
             <div class="clearfix"> </div>
             </div>
		</div>
						&&{page,totalProperty,pagecount,getlistFunc|pagingFun}
	
						</div>
					
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
				data:{"limit":limit, "start":start,"columnId":"<%=column_id%>"},
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