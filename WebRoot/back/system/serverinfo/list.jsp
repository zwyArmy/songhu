<%@ page contentType="text/html; charset=UTF-8" %>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../../ext3.2/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../../resource/css/common.css" />
<script type="text/javascript" src="../../ext3.2/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../ext3.2/ext-all.js"></script>
<script type="text/javascript" src="../../ext3.2/src/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="../../script/mytools.js"></script>
<script type="text/javascript" src="../../script/cook.js"></script>
<script type="text/javascript" src="window.js"></script>
<script type="text/javascript" src="../../script/theme.js"></script>
</head>
<script language="javascript">

Ext.BLANK_IMAGE_URL="../../ext3.2/resources/images/default/s.gif";
Ext.onReady(function(){
	var serverInfoGrid = new Ext.grid.PropertyGrid({
							title : '<span class="commoncss">服务器信息</span>',
							width : 400,
							height: 350,
							collapsible : false,
							renderTo: Ext.getBody()
						});
	Ext.Ajax.request({
		url : '/Httpsession/serverInfo.do',
		success : function(response, opts) {
			var data = Ext.util.JSON.decode(response.responseText);
			serverInfoGrid.setSource(data);
		},
		failure : function(response, opts) {
				Ext.MessageBox.alert('提示', '获取服务器信息失败');
		},
		params : {}
	});

});
</script>
<body>
</body>
</html>

