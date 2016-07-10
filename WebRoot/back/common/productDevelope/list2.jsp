<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
   User user = com.getSessionUser();
   String UserCode = user.getUserId();
   String bhCd = request.getParameter("bhCd");
   String columnId = request.getParameter("columnId");
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
	<script type="text/javascript" src="window7.js"></script>
	<script type="text/javascript" src="../../../resource/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="../../../resource/ckfinder/ckfinder.js"></script>
  </head>
<script language="javascript">
Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var bhCd = '<%=bhCd%>';
Ext.onReady(function(){
	var orgGrid=Ext.get("grid-example");
	var form_delete = new Ext.FormPanel({
		id:'ext-form-delete',
		hidden:true,
		renderTo:"grid-example"
}
);
	store = new Ext.data.Store({
		url:'../../../articleController.do?find2',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'id'},
					{name:'title'},
					{name:'author'},
					{name:'columnId'},
				 	{name:'createTime',type:'date',dateFormat:'time'},
					{name:'publishTime'},
					{name:'creator'},
					{name:'isTop'},
					{name:'state'},
					{name:'wordPath'},
					{name:'content'},
					{name:'views'},
					{name:'columnMc'}
			]
		}),
		listeners:{'beforeload':function(sto,opt){
			sto.baseParams = {
				start:0,
				limit:30,
				columnId:'<%=columnId%>'
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
			{header:"审批",width:40,fixed:true,menuDisabled:true,sortable:false,algin:'center',dataIndex:'btn',renderer:function(){
			return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/edit1.png"/></span>';
			}},
			{header: "文章编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
			{header: "",  width: 5,hidden: true, sortable: true, dataIndex: 'columnId'},
			{header:"标题",width:30,hidden:false,sortable:true,dataIndex:'title',align:'left'},
			{header:"创建人",width:8,sortable:true,dataIndex:'creator',algin:'left'},
			{header:"创建时间",width:8,sortable:true,dataIndex:'createTime',algin:'left',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"发布时间",width:8,sortable:true,dataIndex:'publishTime',algin:'center',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"状态",width:8,sortable:true,dataIndex:'state',algin:'left',renderer:function(val){
			switch(val)
			{
			    case '0':
			    return "未审核";break;
			    case '1':
			    return "审核通过";break;
			    case '3':
			    return "审核未通过";break;
			}}},
			{header:"文章来源",width:8,sortable:true,dataIndex:'columnMc',algin:'left'}
		],
		frame:false,
		autoWidth:true,
		height:orgGrid.getComputedHeight(),
	    animCollapse: false,
		tbar:[
		{text:'删除',iconCls:'delete', tooltip:'删除文章',
		handler:function(){
	                var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 文 章！');
					}
					else if(rec.data['creator']=='<%=UserCode%>'||rl=='3'){
					    Ext.MessageBox.show({
					               title:'提示',
					               msg: '<font color=red>是否确定要删除该篇文章？</font><br/><br/> ',
					               buttons: Ext.Msg.YESNO  ,
					               fn: function(conf){
					                 if(conf=='yes'){
										Ext.getCmp('ext-form-delete').getForm().submit({
								                  url:'../../../articleController.do?delete',
								                  params:{"id":rec.data['id']},
											      method:'post',
											      waitMsg:'数据处理中..',
										          success:function(form,action){	
                                                  Ext.MessageBox.show({
														title:'提示',
														msg: action.result.msg,
														buttons: Ext.Msg.OK ,
														fn: function(){
														 store.load();
														},
														animEl: 'elId',
														icon: Ext.MessageBox.WARNING
														}); 					                       
												  },
											      failure:function(form,action){
											               Ext.Msg.alert("提示",action.result.msg);
											      }
										}) 
					           		}
					          }
					   })
	          		}
	          		else if(rec.data['creator']!='<%=UserCode%>')
					{
						Ext.Msg.alert('提示','发表人非当前登录用户不能删除！');
	          		}
	        }},
	    '-',
		'标题:',
		{
			xtype:"textfield",
			id:"cx_title",
			width:100
		},
		'-',
		{text:'查询',iconCls:'search', tooltip:'查询文章',
	          handler:function(){
	          		store.load({params:{title:Ext.getCmp("cx_title").getValue(),columnId:'<%=columnId%>'}});
		}},
		'-',
		{
			text:'清空',
			tooltip:'清空查询条件',
			iconCls:'tbar_synchronizeIcon',
			handler:function(){
				Ext.getCmp("cx_title").reset();
			}
		}		
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
			   if(fieldName=='btn')
				{
				new Ext.ArticleWindow3({articleID2:record.data['id'],rec:record,cz:"00",view:false});
				}
	});	
	store.load({params:{'state':'',start:0,limit:30,columnId:'<%=columnId%>'}});
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
