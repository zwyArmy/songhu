<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Article"%>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.DateUtils"%>
<%@page import="com.weixin.core.util.Tools"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
//分页
int pagesize = 10;  //每页行数
int pagecount = 0; //一共多少页
String pagestmp = request.getParameter("pages");  //当前页
pagestmp = pagestmp==null?"1":pagestmp;
int pages = Integer.parseInt(pagestmp);
int countnum = com.countByColumnId(cumd) ;  //栏目总行数

if(countnum % pagesize == 0){
	pagecount=countnum / pagesize;
}else{
	pagecount=countnum / pagesize+1;
}
List<Article> list = com.listByColumnId(cumd,(pages - 1) * pagesize,pagesize);
List<Column> colList=com.listColumnByParent("04");
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
<script type="text/javascript">
 var openWin = function(id){
 	location.href = id+'_'+'<%=cumd%>'+'.html';
 }
</script>
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
					<%for(int i = 0;i < colList.size(); i++){ %>
						<li><a href="news,<%=colList.get(i).getId() %>,0,1.html"><i class="glyphicon <%if(colList.get(i).getId().equals(cumd)){ %>glyphicon-ok<%}%>"> </i><%=colList.get(i).getColName() %></a></li>
						<%} %>
					</ul>
				</div>
			</div>
			<div class="col-md-8 ">
				<div class=" single-grid">
				<div class="article-list">
				<ul>
				<%for(int i=0;i<list.size();i++){ 
				String content = Tools.getTextFromHtml(list.get(i).getContent(),200);
				if(content.length()>100){
				content = content.substring(0,100)+"...";
				}
				%>
			              <li style="list-style: none;">
			              <font style="font-size: 18px;font-family: Microsoft&nbsp;JhengHei;"><a href="javascript:void(0);" onclick="openWin('<%=list.get(i).getId()%>');"><strong><%=list.get(i).getTitle() %></strong></a></font>
			              </li>
			              <li style="list-style: none;height: auto;"><font style="font-size: 12px;font-family: SimSun;">&nbsp;&nbsp;&nbsp;&nbsp;<%=content %>&nbsp;<a href="javascript:void(0);" onclick="openWin('<%=list.get(i).getId()%>');" style="color:#cd2a01; ">[详情]</a></font></li>
			              <li style="list-style: none;height: auto;">
			              <font style="color: #999;font-size: 12px;font-family: SimSun;"><%=DateUtils.date2Str(list.get(i).getCreateTime(), DateUtils.date_sdf) %></font>
			              &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<font style="color: #db000;font-size: 12px;font-family: SimSun;"><%=list.get(i).getAuthor() %></font>
			              </li>
			              <br>
			    <%} %>
			      </ul>
			    <div class="paginate" <%if(list.size()==0){ %>style="display:none;"<%} %>>
				<span class="first">
				<a href="news,<%=cumd %>,0,1.html">《 首页</a>
				</span>
				<%if(pages != 1){ %>
				<span class="prev"><a href="news,<%=cumd %>,0,<%=pages-1 %>.html">《</a></span>
				<%} %>
					<%
			 		  //起始页
			 		  int beginnum = 1;
			 		  //结束页
			 		  int endnum = pagecount;
			 		  
			 		  //如果当前页大于2时，设置起始页为当前页减2
			 		  //if(pages > 2){
			 			//  beginnum = pages - 2;
			 		  //}
			 		  //如果当前页大于2时，设置起始页为当前页减2
			 		  if((pages + 2) <= pagecount){
			 			  endnum = pages + 2;
			 		  }
			 		  if(pagecount >=5 && endnum < 5){
			 			  endnum = 5;
			 		  }
			 		  if(endnum < 5){
			 			  beginnum = 1;
			 		  }else if(endnum >= 5){
			 			  beginnum = endnum - 4;
			 		  }
			 		  
			 		  if(beginnum != 1){
					%>
					   <span class="active"><a href="news,<%=cumd %>,0,1.html">1...</a></span> 
					<%
			 		  }
			 		  for(int i = beginnum;i <= endnum;i++ ){
				 		  if(pages == i){
			 		%>
			 		<span class="active"><a href="news,<%=cumd %>,0,<%=i %>.html"><%=i %></a></span> 
			 		<%
				 		  }else{
		 			%>
			 		   <span ><a href="news,<%=cumd %>,0,<%=i %>.html"><%=i %></a></span> 
			 		<%
			 		    }
			 		  }
			 		  if(endnum != pagecount){
					%>
					<span ><a href="news,<%=cumd %>,0,<%=pagecount %>.html">...<%=pagecount %></a></span> 
					<%
			 		  }
			 		  //当前页为最后页时不显示"下一页"
			 		  if(pages != pagecount){
			 		%>
			 		        <span class="next"><a href="news,<%=cumd %>,0,<%=pages + 1 %>.html">》</a></span>
			 		<% }%>
				<span class="last"><a href="news,<%=cumd %>,0,<%=pagecount %>.html">尾页 》</a></span>
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