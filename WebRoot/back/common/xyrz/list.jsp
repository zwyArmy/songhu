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
			url : '../../../xyrzController.do?find',
			reader : new Ext.data.JsonReader({
				root : 'root',
				totalProperty : 'totalProperty',
				fields : [ {
					name : 'id'
				}, {
					name : 'name'
				}, {
					name : 'itemNo'
				}, {
					name : 'createTime'
				}, {
					name : 'visits'
				}, {
					name : 'description'
				}, {
					name : 'state'
				} , {
					name : 'author'
				} , {
					name : 'path'
				} , {
					name : 'type'
				} , {
					name : 'typeName'
				} ]
			}),
			listeners : {
				'beforeload' : function(sto, opt) {
					sto.baseParams = {
						start : 0,
						limit : 30,						
						name : Ext.getCmp("cx_name").getValue(),
						type : Ext.getCmp("cx_type").getValue()
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
				header : "type",
				width : 8,
				hidden : true,
				sortable : true,
				dataIndex : 'type'
			},{
				header : "类型",
				width : 8,
				hidden : false,
				sortable : true,
				dataIndex : 'typeName'
			}, {
				header : "名称",
				width : 8,
				hidden : false,
				sortable : true,
				dataIndex : 'name',
				align : 'left'
			}, {
				header : "编号",
				width : 8,
				sortable : true,
				dataIndex : 'itemNo',
				algin : 'left'
			}, {
				header : "上架时间",
				width : 8,
				sortable : true,
				dataIndex : 'createTime',
				algin : 'left',
				renderer: function(val){
				return new Date(val).dateFormat('Y-m-d');
				}
			}, {
				header : "浏览次数",
				width : 8,
				sortable : true,
				dataIndex : 'visits',
				algin : 'left'
			}],
			frame : false,
			autoWidth : true,
			height : orgGrid.getComputedHeight(),
			animCollapse : false,
			tbar : [ {
				text:'添加',iconCls:'add', tooltip:'新增信誉认证',
				handler:function(){
					new Ext.XyrzWindow({title:"新增信誉认证", cz:"1"});
	        }},'-',{
				text : '修改',
				iconCls : 'update',
				tooltip : '修改信誉认证',
				handler : function() {
					var rec = grid.getSelectionModel().getSelected();
					if (!rec) {
						Ext.Msg.alert('提示', '请 选 择 要 修 改 的 记 录！');
					} else {
						new Ext.XyrzWindow({
							title:"修改信誉认证",
							cz : "0",
							rec:rec
						});
					}
				}
			},'-', {
				text:'删除',iconCls:'delete', tooltip:'删除信誉认证',
				handler:function(){
					var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 信誉认证！');
					}else{
						Ext.MessageBox.show({
		                title:'提示',
		                msg: '<font color=red>是否确定要删除该信誉认证 ？</font><br/><br/> ',
		                buttons: Ext.Msg.YESNO  ,
		                fn: function(conf){
		                	if(conf=='yes'){
		                		Ext.getCmp('ext-form-delete').getForm().submit({
					                  url:'../../../xyrzController.do?delete',
					                  params:{"id":rec.data['id'],"picPath":rec.data['path']},
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
				id : "cx_name",
				width : 100
			}, '-', '类型:', {
				id : 'cx_type',
				xtype : "combo",
				width : 100,
				store : new Ext.data.Store({
							url:'../../../codeController.do?findByParent&zldm=RZLX',
							reader:new Ext.data.JsonReader({
							fields:[
								{name:'id'},
								{name:'dmmc'}
							]
							}),
							autoLoad:true
									}),
							mode : 'local',
							triggerAction : 'all',
							valueField : 'id',
							displayField : 'dmmc',
							emptyText : '请选择...',
							allowBlank : false,
							forceSelection : true,
							editable : false,
							typeAhead : true
			}, '-', {
				text : '查询',
				iconCls : 'search',
				tooltip : '查询文章',
				handler : function() {

					store.load({
						params : {
							name : Ext.getCmp("cx_name").getValue(),
							type : Ext.getCmp("cx_type").getValue()
						}
					});
				}
			}, '-', {
				text : '清空',
				tooltip : '清空查询条件',
				iconCls : 'tbar_synchronizeIcon',
				handler : function() {
					Ext.getCmp("cx_name").reset();
					Ext.getCmp("cx_type").reset();
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
