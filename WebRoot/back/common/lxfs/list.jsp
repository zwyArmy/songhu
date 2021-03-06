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
			url : '../../../lxfsController.do?find',
			reader : new Ext.data.JsonReader({
				root : 'root',
				totalProperty : 'totalProperty',
				fields : [ {
					name : 'id'
				}, {
					name : 'companyname'
				}, {
					name : 'address'
				}, {
					name : 'contacts'
				}, {
					name : 'phone'
				}, {
					name : 'fax'
				}, {
					name : 'email'
				}, {
					name : 'x'
				}, {
					name : 'y'
				}, {
					name : 'state'
				} ]
			}),
			listeners : {
				'beforeload' : function(sto, opt) {
					sto.baseParams = {
						start : 0,
						limit : 30,
						companyname : Ext.getCmp("cx_name").getValue(),
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
				width : 4,
				hidden : true,
				sortable : true,
				dataIndex : 'id'
			},{
				header : "公司名",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'companyname',
				algin : 'left'
			},{
				header : "联系人",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'contacts',
				algin : 'left'
			},{
				header : "电话",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'phone',
				algin : 'left'
			}, {
				header : "传真",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'fax',
				align : 'left'
			}, {
				header : "邮箱",
				width : 4,
				sortable : true,
				dataIndex : 'email',
				algin : 'left'
			},{
				header : "地址",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'address',
				algin : 'left'
			},{
				header : "纬度",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'x',
				algin : 'left'
			},{
				header : "经度",
				width : 4,
				hidden : false,
				sortable : true,
				dataIndex : 'y',
				algin : 'left'
			}, {
				header : "状态",
				width : 4,
				sortable : true,
				dataIndex : 'state',
				algin : 'left',
				renderer:function(val){
					if(val==1)
					return "<font color=blue>启用</font>[<font color=red>禁用</font>]";
					return "<font color=red>禁用</font>[<font color=blue>启用</font>]";
				}
			}],
			frame : false,
			autoWidth : true,
			height : orgGrid.getComputedHeight(),
			animCollapse : false,
			tbar : [{
				text : '修改',
				iconCls : 'update',
				tooltip : '修改联系方式',
				handler : function() {
					var rec = grid.getSelectionModel().getSelected();
					if (!rec) {
						Ext.Msg.alert('提示', '请 选 择 要 修 改 的 记 录！');
					} else {
						new Ext.LxfsWindow({
							title:"修改联系方式",
							cz : "0",
							rec:rec
						});
					}
				}
			}, '-', '名称:', {
				xtype : "textfield",
				id : "cx_name",
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
					data : [ [ '', '全部' ], [ '1', '启用' ],[ '0', '禁用' ] ]
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
							companyname : Ext.getCmp("cx_name").getValue(),
							state : Ext.getCmp("cx_state").getValue()
						}
					});
				}
			}, '-', {
				text : '清空',
				tooltip : '清空查询条件',
				iconCls : 'tbar_synchronizeIcon',
				handler : function() {
					Ext.getCmp("cx_name").reset();
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
	   grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
			var store = grid.getStore();
			var record = store.getAt(rowIndex);
			var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
			if(fieldName=="state"){
			var msg = "是否确定要启用该联系方式";
			if(record.data['state']=="1"){
				msg = "是否确定要禁用该联系方式";
			}
				Ext.MessageBox.show({
		                title:'提示',
		                msg: msg,
		                buttons: Ext.Msg.YESNO  ,
		                fn: function(conf){
		                	if(conf=='yes'){
		                		Ext.getCmp('ext-form-delete').getForm().submit({
					                  url:'../../../lxfsController.do?xgzt',
					                  params:{"id":record.data['id'],
					                  "state":record.data['state']=="1"?"0":"1"},
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
		                }});;
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
