<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
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
    	<script type="text/javascript" src="../../../resource/commonjs/upload/swfupload.js"></script>
    <script type="text/javascript" src="../../../resource/commonjs/upload/uploaderPanel.js"></script>
</head>
<script language="javascript">
	Ext.BLANK_IMAGE_URL = "../../../resource/extjs/resources/images/default/s.gif";
	var store;
	Ext.onReady(function() {
		var orgGrid = Ext.get("grid-example");
		var form_delete = new Ext.FormPanel({
			id : 'ext-form-delete',
			hidden : true,
			renderTo : "grid-example"
		});
		store = new Ext.data.Store({
			url : '../../../cmsDownloadController.do?find',
			reader : new Ext.data.JsonReader({
				root : 'root',
				totalProperty : 'totalProperty',
				fields : [ {
					name : 'id'
				}, {
					name : 'format'
				}, {
					name : 'mc'
				}, {
					name : 'path'
				}, {
					name : 'scsj'
				}, {
					name : 'scry'
				}, {
					name : 'state'
				}, {
					name : 'auditTime'
				}, {
					name : 'auditor'
				}  ]
			}),
			listeners : {
				'beforeload' : function(sto, opt) {
					sto.baseParams = {
						start : 0,
						limit : 30,						
						mc : Ext.getCmp("cx_mc").getValue(),
						state : Ext.getCmp("cx_state").getValue()
					};
				}
			}
		});
		grid = new Ext.grid.GridPanel({
			store : store,
			sm : new Ext.grid.RowSelectionModel({
				singleSelect : true
			}),
			loadMask : ({
				msg : '数据正在加载中......'
			}),
			columns : [ new Ext.grid.RowNumberer(), {
				header : "id",
				width : 8,
				hidden : true,
				sortable : true,
				dataIndex : 'id'
			},{
				header : "format",
				width : 8,
				hidden : true,
				sortable : true,
				dataIndex : 'format'
			},{
				header : "path",
				width : 8,
				hidden : true,
				sortable : true,
				dataIndex : 'path'
			},{
				header : "名称",
				width : 8,
				hidden : false,
				sortable : true,
				dataIndex : 'mc'
			}, {
				header : "创建时间",
				width : 8,
				hidden : false,
				sortable : true,
				dataIndex : 'scsj',
				align : 'left',
				renderer: function(val){
				return new Date(val).dateFormat('Y-m-d');
				}
			}, {
				header : "创建人",
				width : 8,
				sortable : true,
				dataIndex : 'scry',
				algin : 'left'
			}, {
				header : "状态",
				width : 8,
				sortable : true,
				dataIndex : 'state',
				algin : 'left',
				renderer:function(val){
					if(val==0)
					return "<font color=blue>未审核</font>";
					if(val==1)
					return "<font color=green>审核通过</font>";
					if(val==2)
					return "<font color=red>审核未通过</font>";
				}
			}],
			frame : false,
			autoWidth : true,
			height : orgGrid.getComputedHeight(),
			animCollapse : false,
			tbar : [ {
				text:'添加',iconCls:'add', tooltip:'新增文件',
				handler:function(){
					new Ext.DownloadWindow({title:"新增文件", cz:"1"});
	        }},'-', {
				text:'删除',iconCls:'delete', tooltip:'删除文件',
				handler:function(){
					var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 文件！');
					}else{
						Ext.MessageBox.show({
		                title:'提示',
		                msg: '<font color=red>是否确定要删除该文件 ？</font><br/><br/> ',
		                buttons: Ext.Msg.YESNO  ,
		                fn: function(conf){
		                	if(conf=='yes'){
		                		Ext.getCmp('ext-form-delete').getForm().submit({
					                  url:'../../../cmsDownloadController.do?delete',
					                  params:{"id":rec.data['id'],"path":rec.data['path']},
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
								}); 
		                	}
		                }});
					}
					
				}
			}, '-', '名称:', {
				xtype : "textfield",
				id : "cx_mc",
				width : 100
			}, '-', '状态:', {
				id : 'cx_state',
					xtype : "combo",
				width : 100,
				editable : false,
				fieldLabel : "状态",
				emptyText : '请选择...',
				store : new Ext.data.SimpleStore({
					fields : [ 'value', 'text' ],
					data : [ [ '', '全部' ], [ '0', '未审核' ],[ '1', '审核通过' ],['2','审核未通过'] ]
				}),
				mode : 'local',
				triggerAction : 'all',
				valueField : 'value',
				displayField : 'text'
			}, '-', {
				text : '查询',
				iconCls : 'search',
				tooltip : '查询文章',
				handler : function() {

					store.load({
						params : {
							mc : Ext.getCmp("cx_mc").getValue(),
							state : Ext.getCmp("cx_state").getValue()
						}
					});
				}
			}, '-', {
				text : '清空',
				tooltip : '清空查询条件',
				iconCls : 'tbar_synchronizeIcon',
				handler : function() {
					Ext.getCmp("cx_mc").reset();
					Ext.getCmp("cx_state").reset();
				}
			}

			],
			bbar : new Ext.PagingToolbar({
				pageSize : 30,
				store : store,
				displayInfo : true,
				displayMsg : '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
				emptyMsg : "没有记录"
			}),
			buttonAlign : 'left',
			renderTo : 'grid-example',
			viewConfig : {
				forceFit : true,
				templates : {
					cell : gridCopy
				}
			}
		});
		store.load({
			params : {
				start : 0,
				limit : 30
			}
		});
		new Ext.Viewport({
			layout : 'fit',
			deferHeight : true,
			region : 'center',
			border : false,
			items : [ grid ]
		});
	});
</script>
<body>
	<div id="grid-example" style="width:100%;height:100%"></div>
</body>
</html>
