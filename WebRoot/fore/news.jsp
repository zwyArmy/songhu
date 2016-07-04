<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Article"%>
<%@page import="com.weixin.core.util.DateUtils"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Article> list = com.listByColumnId(request.getParameter("cumd"),0,30);
%>
<!DOCTYPE HTML>
<html>
<head>
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
<body>
<!--banner start here-->
<div class="banner-two">
  <div class="header">
	<div class="container">
		 <div class="header-main">
			 <jsp:include  page="include/top.jsp" flush="true" /> 
		 </div>
	  </div>
	 </div>
 </div>
<!--banner end here-->
<!--single start here-->
			 <div class="single">
			<div class="container">
					<div class="col-md-3 categories-grid">
				<div class="grid-categories">
					<h4>新闻</h4>
					<ul class="popular ">
						<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>公司新闻</a></li>
						<li><a href="#"><i class="glyphicon"> </i>行内新闻</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-8 ">
				<div class=" single-grid">
				<div class="article-list">
				<ul>
				<%for(int i=0;i<list.size();i++){ 
				String content = list.get(i).getContent();
				if(content.length()>30){
				content = content.substring(0,200)+"...";
				}
				%>
			              <li style="list-style: none;">
			              <font style="font-size: 18px;font-family: Microsoft&nbsp;JhengHei;"><a href="javascript:void(0);" onclick="openWin(this,'ca477549','0204');"><strong><%=list.get(i).getTitle() %></strong></a></font>
			              </li>
			              <li style="list-style: none;height: auto;"><font style="font-size: 12px;font-family: SimSun;">&nbsp;&nbsp;&nbsp;&nbsp;<%=content %>&nbsp;<a href="javascript:void(0);" onclick="openWin(this,'ca477549','0204');" style="color:#cd2a01; ">[详情]</a></font></li>
			              <li style="list-style: none;height: auto;">
			              <font style="color: #999;font-size: 12px;font-family: SimSun;"><%=DateUtils.date2Str(list.get(i).getCreateTime(), DateUtils.date_sdf) %></font>
			              &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<font style="color: #db000;font-size: 12px;font-family: SimSun;"><%=list.get(i).getAuthor() %></font>
			              </li>
			              <br>
			    <%} %>
			      </ul>
			    <div class="paginate">
				<span class="first">
				<a href="javascript:getCurTask(1)">《 首页</a>
				</span>
				<span class="prev"><a href="javascript:getCurTask(1)">《</a></span>
				<span class="active"><a href="javascript:getCurTask(1)">1</a></span> 
				<span class="next"><a href="javascript:getCurTask(1)">》</a></span>
				<span class="last"><a href="javascript:getCurTask(1)">尾页 》</a></span>
				</div>
				</div>
				</div>
			</div>
			</div>
	</div>
<!--//single end here-->
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>