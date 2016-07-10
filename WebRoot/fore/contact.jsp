<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>联系我们</title>
</head>
<body>
<!--banner start here-->
<div class="banner-two">
<div class="header">
<jsp:include  page="include/top.jsp" flush="true" /> 
</div>
 </div>
<!--banner end here-->
<!--content-->
<div class="container">
   <div class="contact">
	 <div class="contact-md">
			 <h3>联系我们</h3>
			 <p>联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们联系我们</p>
		 </div>
				<div class="col-md-6 contact-top">
					<h3>公司地址:</h3>
					<div>
						<label><span class="span-name">公司名称:</span><span>厦门淞沪环保有限公司</span></label>
						<label><span class="span-name">地&nbsp;&nbsp;址:</span><span >厦门湖里区云顶中路2777号市政大厦24层</span></label>
						<label><span class="span-name">联系电话:</span><span>0592-5172555</span></label>
						<label><span class="span-name">定&nbsp;&nbsp;位:</span><span onclick="planeToIndex(0)">点击</span></label>
						
					</div>
					<div>
						<label><span class="span-name">公司名称:</span><span>莆田市华科环保工程有限公司</span></label>
						<label><span class="span-name">地&nbsp;&nbsp;址:</span><span>仙游县枫亭镇经济开发园区</span></label>
						<label><span class="span-name">联系电话:</span><span>0592-5172555</span></label>
						<label><span class="span-name">定&nbsp;&nbsp;位:</span><span onclick="planeToIndex(1)">点击</span></label>
						
						
					</div>
					<div>
						<label><span class="span-name">公司名称:</span><span>莆田中环水务有限公司</span></label>
						<label><span class="span-name">地&nbsp;&nbsp;址:</span><span>福建省莆田市仙游县盖尾镇仙溪村第二污水处理厂</span></label>
						<label><span class="span-name">联系电话:</span><span>0592-5172555</span></label>
						<label><span class="span-name">定&nbsp;&nbsp;位:</span><span onclick="planeToIndex(2)">点击</span></label>
						
						
					</div>
					<div>
						<label><span class="span-name">公司名称:</span><span>霞浦中泓水务有限公司</span></label>
						<label><span class="span-name">地&nbsp;&nbsp;址:</span><span>福建省宁德市霞浦县三沙镇陇头工业园区</span></label>
						<label><span class="span-name">联系电话:</span><span>0592-5172555</span></label>
						<label><span class="span-name">定&nbsp;&nbsp;位:</span><span onclick="planeToIndex(3)">点击</span></label>
						
						
					</div>
					<div>
						<label><span class="span-name">公司名称:</span><span>金昌华科环境技术有限公司</span></label>
						<label><span class="span-name">地&nbsp;&nbsp;址:</span><span>甘肃省金昌市金川区宝林里公路总段家属院14栋3口</span></label>
						<label><span class="span-name">联系电话:</span><span>0592-5172555</span></label>
						<label><span class="span-name">定&nbsp;&nbsp;位:</span><span onclick="planeToIndex(4)">点击</span></label>
						
						
					</div>
				</div>
				<div class="col-md-6 contact-top">
					<h3>地图展示:</h3>
					
					
					
					<div class="map">
					<jsp:include  page="include/map.jsp" flush="true" /> 
					</div>
				</div>
			<div class="clearfix"> </div>
	</div>
</div>
<!--contact end here-->
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>