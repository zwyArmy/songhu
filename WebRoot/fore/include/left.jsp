<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String parentId = request.getParameter("parentId");
	
	List<Column> list2 = com.listColumnByParent(parentId);
	System.out.println(parentId);
	System.out.println(list2);
%>


		<div class="grid-categories">
			<h4>栏目</h4>
			<ul class="popular ">
				<%for(int i = 0 ; i < list2.size(); i++){%>
					<li><a href="<%=list2.get(i).getLink() %>"><i class="glyphicon glyphicon-ok"> </i><%=list2.get(i).getColName() %></a></li>
					
				
				<%} %>
				</ul>
		</div>
		<div class="grid-categories">
			<h4>最近新闻</h4>
			<ul class="popular popular-in">
				<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>J嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon glyphicon-ok"> </i>嵩湖环保十三周年庆</a></li>
			</ul>
		</div> 
			