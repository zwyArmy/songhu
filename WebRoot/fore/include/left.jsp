<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
	String cumd = request.getParameter("cumd");
	List<Column> colList=com.listColumnByParent("04");
%>
		<div class="grid-categories">
			<h4>新闻</h4>
			<ul class="popular ">
				<%for(int i = 0 ; i < colList.size(); i++){%>
					<li><a href="<%=colList.get(i).getLink() %>"><i class="glyphicon <%if(colList.get(i).getId().equals(cumd)){ %>glyphicon-ok<%}%>"> </i><%=colList.get(i).getColName() %></a></li>
					
				
				<%} %>
				</ul>
		</div>
		<div class="grid-categories">
			<h4>最近新闻</h4>
			<ul class="popular popular-in">
				<li><a href="#"><i class="glyphicon"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon"> </i>J嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon"> </i>嵩湖环保十三周年庆</a></li>
				<li><a href="#"><i class="glyphicon"> </i>嵩湖环保十三周年庆</a></li>
			</ul>
		</div> 