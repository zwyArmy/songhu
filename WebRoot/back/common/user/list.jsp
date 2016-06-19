<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
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
	var form_delete = new Ext.FormPanel({
		id:'ext-form-delete',
		hidden:true,
		renderTo:"grid-example"
}
);
	store = new Ext.data.Store({
		url:'../../../mallUserController.do?find',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'id'},
					{name:'email'},
					{name:'password'},
					{name:'name'},
					{name:'phone'},
					{name:'address'},
					{name:'postcode'},
					{name:'state'},
					{name:'verifyCode'}
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
			{header:"查看",width:40,fixed:true,menuDisabled:true,sortable:false,algin:'center',dataIndex:'ck',renderer:function(){
			return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/page.png"/></span>';
			}},
			{header: "编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
			{header: "姓名",width:6,hidden:false,sortable:true,dataIndex:'name',align:'left'},
			{header: "地址",width:10,sortable:true,dataIndex:'address',algin:'left'},
			{header: "邮箱",width:8,sortable:true,dataIndex:'email',algin:'left'},
			{header: "电话",width:8,sortable:true,dataIndex:'phone',algin:'left'},
			{header: "状态",width:6,sortable:true,dataIndex:'state',algin:'left',
			renderer:function(val){
			return val==1?"<font color=blue>已验证邮箱</font>":"<font color=red>未验证邮箱</font>";
			}}
		],
		frame:false,
		autoWidth:true,
		height:orgGrid.getComputedHeight(),
	    animCollapse: false,
		tbar:[
		{text:'删除',iconCls:'delete', tooltip:'删除会员',
		handler:function(){
	                var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 链 接！');
					}
					else {
					    Ext.MessageBox.show({
					               title:'提示',
					               msg: '<font color=red>是否确定要删除该用户？</font><br/><br/> ',
					               buttons: Ext.Msg.YESNO  ,
					               fn: function(conf){
					                 if(conf=='yes'){
										Ext.getCmp('ext-form-delete').getForm().submit({
								                  url:'../../../mallUserController.do?delete',
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
	        }}
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
			    if(fieldName =='ck')
				{
				   new Ext.MemberWindow({rec:record,cz:"00"});
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
