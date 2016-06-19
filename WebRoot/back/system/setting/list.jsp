<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	User user = com.getSessionUser();
	String rl = user.getRigthLevel(); 
	String DeptId = user.getDeptId();
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
	<link rel="stylesheet" type="text/css" href="../../../resource/extjs/resources/css/ext-all.css" /> 
    <link rel="stylesheet" type="text/css" href="../../../resource/css/default.css" /> 
	<link rel="stylesheet" type="text/css" href="../../../resource/css/ext_icon.css" />
	<script type="text/javascript" src="../../../resource/extjs/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="../../../resource/extjs/ext-all.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/ext-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/cook.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/mytools.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/treecombo.js"></script>
	<script type="text/javascript" src="window.js"></script>
  </head>
<script language="javascript">
Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
Ext.onReady(function(){
	var orgGrid=Ext.get("grid-example");
	store = new Ext.data.Store({
		url:'../../../settingController.do?find',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'password'},
					{name:'description'},
					{name:'value'}
			]
		}),
		listeners:{'beforeload':function(sto,opt){
			sto.baseParams = {
				start:0,
				limit:30
		}
		}
	}}
	);
	var grid = new Ext.grid.GridPanel({
		store:store,
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
			loadMask:({msg:'数据正在加载中......'}),
		columns: [
			new Ext.grid.RowNumberer(),
			{header:"修改",width:2,sortable:true,dataIndex:'update',algin:'left',renderer: function () { 
			 return '<span style="cursor:pointer;color:blue"> [ 修改 ] </span>';
			}},
			{header:"参数",width:12,hidden:false,sortable:true,dataIndex:'password',align:'left'},
			{header:"",width:12,hidden:true,sortable:true,dataIndex:'value',align:'left'},
			{header:"说明",width:10,sortable:true,dataIndex:'description',algin:'left'}
			
		],
		frame:false,
		autoWidth:true,
		height:orgGrid.getComputedHeight(),
	    animCollapse: false,
		bbar: new Ext.PagingToolbar(
		),
		buttonAlign:'left',
		renderTo:'grid-example',
		viewConfig:{forceFit:true,templates:{cell:gridCopy}}
	}
	);
	
	grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store = grid.getStore();
				var record = store.getAt(rowIndex);
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
			    if(fieldName =='update')
				{
				   new Ext.SettingWindow({Keyid:record.data['password'],cz:'0'});
				}
	});
	store.load({params:{start:0,limit:30}});
	
		new Ext.Viewport({
				layout : 'fit',
				deferHeight:true,
				region:'center',
				border:false,
				items : [grid]
			});
});
</script>
  <body>
  	<div id="grid-example" style="width:100%;height:100%"></div>
  </body>
</html>
