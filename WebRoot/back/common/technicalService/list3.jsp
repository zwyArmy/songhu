<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
    String bhCd = request.getParameter("cdbh");
    String isPhoto = request.getParameter("isPhoto");
   	User user = com.getSessionUser();
   	String UserCode = user.getUserId();
   	String rl = user.getRigthLevel();
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
	<link rel="stylesheet" type="text/css" href="../../../resource/extjs/resources/css/ext-all.css" /> 
    <link rel="stylesheet" type="text/css" href="../../../resource/css/default.css" /> 
	<link rel="stylesheet" type="text/css" href="../../../resource/css/ext_icon.css" />
	<link rel="stylesheet" type="text/css" href="../../../resource/myux/datatimefield/css/Spinner.css" />
	<script type="text/javascript" src="../../../resource/extjs/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="../../../resource/extjs/ext-all.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/ext-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/cook.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/mytools.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/DateTimeField.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/Spinner.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/SpinnerField.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/treecombo.js"></script>
	<script type="text/javascript" src="test.js"></script>
	<script type="text/javascript" src="window2.js"></script>
	<script type="text/javascript" src="window3.js"></script>
	<script type="text/javascript" src="window4.js"></script>
	<script type="text/javascript" src="window5.js"></script>
	<script type="text/javascript" src="window6.js"></script>
	 <script type="text/javascript" src="../../../resource/ckeditor/ckeditor.js"></script>
	  <script type="text/javascript" src="../../../resource/ckfinder/ckfinder.js"></script>
  </head>
<script language="javascript">
Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var rl = '<%=rl%>';
var bhCd = '<%=bhCd%>';
Ext.onReady(function(){
	CKEDITOR.on('instanceReady', CKinstanceReady);
	var orgGrid=Ext.get("grid-example");
	var form_delete = new Ext.FormPanel({
		id:'ext-form-delete',
		hidden:true,
		//renderTo:Ext.getBody()
		renderTo:"grid-example"
}
);
	store = new Ext.data.Store({
		url:'../../../articleController.do?find',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'id'},
					{name:'title'},
					{name:'author'},
					{name:'columnId'},
				 	{name:'createTime'},
					{name:'publishTime'},
					{name:'creator'},
					{name:'isTop'},
					{name:'state'},
					{name:'content'},
					{name:'wordPath'},
					{name:'views'},
					{name:'auditTime'},
					{name:'auditor'}
			]
		}),
		listeners:{'beforeload':function(sto,opt){
			sto.baseParams = {
				start:0,
				limit:30,
				columnId:'<%=bhCd%>'
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
			{header:"修改",width:40,fixed:true,menuDisabled:true,sortable:false,algin:'center',dataIndex:'ck',renderer:function(){
			return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/page_edit_1.png"/></span>';
			}},
			{header: "文章编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
			{header:"标题",width:30,hidden:false,sortable:true,dataIndex:'title',align:'left'},
			{header:"创建人",width:10,sortable:true,dataIndex:'creator',algin:'left'},
			{header:"创建时间",width:10,sortable:true,dataIndex:'createTime',algin:'center',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"发布时间",width:10,sortable:true,dataIndex:'publishTime',algin:'center',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"审核人员",width:10,sortable:true,dataIndex:'auditor',algin:'left'},
			{header:"审核时间",width:10,sortable:true,dataIndex:'auditTime',algin:'center',renderer:function(val){ return val==null?'':new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"状态",width:8,sortable:true,dataIndex:'state',algin:'left',renderer:function(val){
			switch(val)
			{
			    case '0':
			    return "<font color=blue>未审核</font>";break;
			    case '1':
			    return "<font color=green>审核通过</font>";break;
			    case '3':
			    return "<font color=red>审核未通过</font>";break;
			}}}
		],
		bbar: new Ext.PagingToolbar({
	        pageSize: 30,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
		}),
		buttonAlign:'left',
		renderTo:'grid-example',
		viewConfig:{forceFit:true,templates:{cell:gridCopy}}
	}
	);
   grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			var store = grid.getStore();
			var record = store.getAt(rowIndex);
			var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
		   	if(fieldName=='ck'){
		   	    new Ext.ArticleWindow2({title:"", cz:"0",view:false,articleId:record.data['id']});
				//new Ext.ArticleckWindow({yy:record.data['id'],view:false});
			}
	});
	store.load({params:{'columnId':'<%=bhCd%>',start:0,limit:30}});
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
