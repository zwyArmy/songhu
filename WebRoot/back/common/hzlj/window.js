Ext.onReady(function() {
	var h = document.body.clientHeight;
	Ext.HzljWindow = Ext.extend(Ext.Window, {
		xtype : "window",
		title : "",
		id : "ext-win-hzlj",
		width : 300,
		height : 150,
		modal : true,
		closable : true,
		autoScroll: false,
		resizable : false,
		initComponent : function() {
			this.items = [ {
				xtype : "form",
				title : "",
				id : "ext-form-hzlj",
				labelAlign : "right",
				layout : "column",
				fileUpload : true,
				height : 150,
				frame : true,
				items : [ {
					xtype : "hidden",
					id : "id",
					name : "id",
					anchor : "98%"

				},{
					layout : "form",
					columnWidth : 1,
					labelWidth : 66,
					items : [
					{
						xtype : "textfield",
						fieldLabel : "公司名",
						id : "companyname",
						name : "companyname",
						anchor : "98%"
					},{}]
				},{
					layout : "form",
					columnWidth : 1,
					labelWidth : 66,
					items : [ 
					{
						xtype : "textfield",
						fieldLabel : "地址",
						id : "linkaddress",
						name : "linkaddress",
						anchor : "98%"
					},{}]
				},{
					layout : "form",
					columnWidth : 1,
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
						//value:this.cz=='1'?'1':rec.data['state'],
						anchor : "98%"
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
					Ext.getCmp('ext-form-hzlj').getForm().submit({
						url : '../../../hzljController.do?save',
						method : 'post',
						waitMsg : '数据处理中..',
						success : function(form, action) {
							Ext.MessageBox.show({
								title : '提示',
								msg : action.result.msg,
								buttons : Ext.Msg.OK,
								fn : function() {
									Ext.getCmp('ext-win-hzlj').destroy();
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
					Ext.getCmp('ext-win-hzlj').destroy();
				}
			} ];
			Ext.HzljWindow.superclass.initComponent.call(this);
			if(this.cz=='0'){
			   Ext.getCmp('ext-form-hzlj').getForm().loadRecord(this.rec); 
			}
			this.show();

		}
	});
});