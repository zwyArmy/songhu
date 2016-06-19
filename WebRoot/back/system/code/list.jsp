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
	<script type="text/javascript" src="windowDm.js"></script>
  </head>
<script language="javascript">
Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var  ZLDM;
Ext.onReady(function(){
	var h = (document.body.clientHeight)/2;
	var w = (document.body.clientWidth)/2;
	var orgGrid=Ext.get("grid-example");
	var form_delete = new Ext.FormPanel({
		id:'ext-form-delete',
		hidden:true,
		renderTo:"grid-example"
}
);
	store = new Ext.data.Store({
		url:'../../../codeController.do?find',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'zldm'},
					{name:'dmmc'}
					
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
		title:'字典',
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
			loadMask:({msg:'数据正在加载中......'}),
		columns: [
		  new Ext.grid.RowNumberer(),
		 {header: "代码", width: 8, sortable: true, dataIndex: 'zldm',align:'left'},
         {header: "名称", width: 15, sortable: true, dataIndex: 'dmmc',align:'left'}
		],
		frame:true,
	    animCollapse: false,
		tbar:[
		{text:'新增',iconCls:'add', tooltip:'新增代码',
		  handler:function(){
	           		new Ext.CodeFWindow({title:"新增代码",flag:"insertZldm",cz:'1'});
	        }
	    },
	     '-',
		{text:'修改',iconCls:'update', tooltip:'修改代码',
	          handler:function(){
	          	var rec = grid.getSelectionModel().getSelected();
				if(!rec){
					Ext.Msg.alert('提示','请 选 择 要 修 改 的 表 单！');
				}
				else
				{
					new Ext.CodeFWindow({title:"修改代码",flag:"updateZldm",cz:"0",rec:rec});
				}
	     }},
	     '-',
		{text:'删除',iconCls:'delete', tooltip:'删除代码',
		handler:function(){
	                var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请选择要删除的代码种类!');
					}
					else {
					    Ext.MessageBox.show({
						   title:'提示',
						   msg: '该操作将删除该代码种类及所属的子代码，是否确定要删除？ ',
						   buttons: Ext.Msg.YESNO  ,
						   fn: function(conf){
						  	   if(conf=='yes'){
								  Ext.getCmp('ext-form-delete').getForm().submit({
                                      url:'../../../codeController.do?deleteZldm',
                                      params:{'zldm':rec.data['zldm']},
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
	});
	grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store = grid.getStore();
				var record = store.getAt(rowIndex);
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
				ZLDM=record.data['zldm'];
				store2.load({params:{start:0,limit:30,'zldm':record.data['zldm']}});
				
	});	
	store2 = new Ext.data.Store({
		url:'../../../codeController.do?findBytoZldm',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'zldm'},
					{name:'dmmc'},
					{name:'dm'},
					{name:'kz'},
					{name:'enabled'}
			]
		}),
		listeners:{'beforeload':function(sto,opt){
			sto.baseParams = {
				start:0,
				limit:30,
				'zldm':ZLDM
		}
		}
	}}
	);     	    
 grid2 = new Ext.grid.GridPanel({
    store: store2,
    title:'子代码',

    sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask:({msg :'数据正在加载中……'}), 
    columns: [
		 {header: "父代码", width: 8, sortable: true, dataIndex: 'zldm',align:'left'},
         {header: "代码", width: 15, sortable: true, dataIndex: 'dm',align:'left'},
         {header: "名称", width: 15, sortable: true, dataIndex: 'dmmc',align:'left'},
         {header: "扩展", width: 15, sortable: true, dataIndex: 'kz',align:'left'},
         {header: "是否显示", width: 10, sortable: true, dataIndex: 'enabled',align:'center',renderer:function(val){return val==1?"<font color=blue>显示</font>":"<font color=red>不显示</font>";}}
    ],
    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
    frame:true,
    animCollapse: false,
    tbar:[
        {text:'添加',iconCls:'add', tooltip:'添加节点',
          handler:function(){
          				var rec = grid.getSelectionModel().getSelected();
									if(!rec){
									    Ext.Msg.alert('提示','请选择左边列表的节点记录！ ');
									 }else{
								        new Ext.CodeWindow({title:"添加节点", flag:"insert",zldm:rec.data['zldm'],cz:"1"});
          					         }
        }}, 
        '-',
        {text:'修改',iconCls:'update', tooltip:'修改节点',
          handler:function(){
          				var rec = grid2.getSelectionModel().getSelected();
									if(!rec){
									    Ext.Msg.alert('提示','请选择要修改的节点建议的记录！ ');
									 }else{
								        new Ext.CodeWindow({title:"修改节点", flag:"update",cz:"0",rec:rec});
          					         }
        }},
        '-',
        {text:'删除',iconCls:'delete', tooltip:'删除节点',
          handler:function(){
                         var rec = grid2.getSelectionModel().getSelected();
									if(!rec){
									    Ext.Msg.alert('提示','请选择要删除的记录！ ');
									 }else{
									    Ext.MessageBox.show({
												   title:'提示',
												   msg: '是否确定要删除该子代码？ ',
												   buttons: Ext.Msg.YESNO  ,
												   fn: function(conf){
												  	   if(conf=='yes'){
														  Ext.getCmp('ext-form-delete').getForm().submit({
						                                      url:'../../../codeController.do?delete',
						                                      params:{"dm":rec.data['dm'],"zldm":rec.data['zldm']},
									                          method:'post',
									                          waitMsg:'数据处理中..',
								                              success:function(form,action){	
								                                 Ext.MessageBox.show({
															        title:'提示',
																	msg: action.result.msg,
																	buttons: Ext.Msg.OK ,
																	fn: function(){
																	    store2.load();
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
        }}],  
		bbar: new Ext.PagingToolbar({
        pageSize: 30,
        store: store2,
        displayInfo: true,
        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
        emptyMsg: "没有记录"
	    }),
		buttonAlign:'left'
});
	
store.load({params:{start:0,limit:30}});
	
		new Ext.Viewport({
				layout : 'border',
				items : [
				        {
							width : w,
							minSize : 260,
							maxSize : 750,
							split : true,
							region : 'west',
							autoScroll : true,
							layout:'fit',
							items : [grid]
						}, 
						{
							width : w,
							minSize : 260,
							maxSize : 750,
							split : true,
							region : 'center',
							autoScroll : true,
							layout:'fit',
							items : [grid2]
						}]
			});
});
</script>
  <body>
  	<div id="grid-example" style="width:100%;height:100%"></div>
  </body>
</html>
