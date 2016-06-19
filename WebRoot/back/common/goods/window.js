Ext.onReady(function() {
	var h = document.body.clientHeight;
	Ext.GoodsWindow = Ext.extend(Ext.Window, {
		xtype : "window",
		title : "",
		id : "ext-win-goods",
		width : 600,
		height : 300,
		modal : true,
		closable : true,
		autoScroll: false,
		resizable : false,
		initComponent : function() {
			var rec ="";
			var picture = "";
			if(this.cz!='1'){
				rec = this.rec;
				picture = this.rec.data['picture'];
			}
			this.items = [ {
				xtype : "form",
				title : "",
				id : "ext-form-goods",
				labelAlign : "right",
				layout : "column",
				fileUpload : true,
				height : 300,
				frame : true,
				items : [ {
					xtype : "hidden",
					id : "id",
					name : "id",
					anchor : "98%"

				},{
					layout : "form",
					columnWidth : .6,
					labelWidth : 66,
					items : [ 
					{
						xtype : "textfield",
						fieldLabel : "<font color=red>*</font>名称",
						id : "name",
						name : "name",
						anchor : "98%"
					},{}]
				},{
					layout : "form",
					columnWidth : .4,
					labelWidth : 40,
					items : [ 
					{
						xtype : "textfield",
						fieldLabel : "<font color=red>*</font>单价",
						id : "price",
						name : "price",
						anchor : "98%"
					},{}]
				},{
					layout : "form",
					columnWidth : 0.6,
					labelWidth : 66,
					items : [ {
						fieldLabel : "状态",
						id : 'state1',
						hiddenName:'state',
						xtype : "combo",
						editable : false,
						emptyText : '请选择...',
						store : new Ext.data.SimpleStore({
							fields : [ 'value', 'text' ],
							data : [ [ '1', '启用' ], [ '0', '禁用' ] ]
						}),
						mode : 'local',
						triggerAction : 'all',
						valueField : 'value',
						displayField : 'text',
						value:this.cz=='1'?'1':rec.data['state'],
						anchor : "98%"
					},{
						xtype : "textarea",
						fieldLabel : "描述",
						height:150,
						id : "description",
						name : "description",
						anchor : "98%"
					} ]
				},{
					layout : "form",
					columnWidth : 0.4,
					labelWidth : 40,
					items : [ {
						xtype : "textfield",
						fieldLabel : "图片",
						id:"myUpload",
						name : "myUpload",
						inputType : "file",
						anchor : "98%"
					}, {  
						xtype:'textfield',
			        	fieldLabel:'', 
			        	width:150,
			        	height:150,
			        	style:'background-size: contain;width:auto!important;height:auto!important;background-image:url(../../../tyxh/goods/'+picture+');background-repeat: no-repeat;',
			        	readOnly:true ,
			        	listeners:{'focus':function(tfd){
				               tfd.blur();
			                 }}    
		        	} ]
				},{
					xtype : "hidden",
					id : "cz",
					value : this.cz
				}]
			} ];
			this.buttons = [ {
				text : '保存',
				iconCls : 'accept',
				handler : function() {
					Ext.getCmp('ext-form-goods').getForm().submit({
						url : '../../../mallGoodsController.do?save',
						method : 'post',
						waitMsg : '数据处理中..',
						success : function(form, action) {
							Ext.MessageBox.show({
								title : '提示',
								msg : action.result.msg,
								buttons : Ext.Msg.OK,
								fn : function() {
									Ext.getCmp('ext-win-goods').destroy();
							        store.load();
								},
								animEl : 'elId',
								icon : Ext.MessageBox.WARNING
							});
						},
						failure : function(form, action) {
							Ext.Msg.alert("提示", action.result.msg);
						}
					});
				}
			}, {
				text : '关闭',
				iconCls : 'cancel',
				handler : function() {
					Ext.getCmp('ext-win-goods').destroy();
				}
			} ];
			Ext.GoodsWindow.superclass.initComponent.call(this);
			if(this.cz=='0'){
			   Ext.getCmp('ext-form-goods').getForm().loadRecord(this.rec); 
			}
			this.show();

		}
	});
});