Ext.onReady(function() {
	var h = document.body.clientHeight;
	Ext.XyrzWindow = Ext.extend(Ext.Window, {
		xtype : "window",
		title : "",
		id : "ext-win-xyrz",
		width : 600,
		height : 400,
		modal : true,
		closable : true,
		autoScroll: true,
		resizable : false,
		initComponent : function() {
			var rec ="";
			var path = "";
			if(this.cz!='1'){
				rec = this.rec;
				path = this.rec.data['path'];
			}
			this.items = [ {
				xtype : "form",
				title : "",
				id : "ext-form-xyrz",
				labelAlign : "right",
				layout : "column",
				fileUpload : true,
				height : 335,
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
					items : [ {
						xtype : "textfield",
						fieldLabel : "证书",
						id:"myUpload",
						name : "myUpload",
						inputType : "file",
						anchor : "98%"
					} ]
				},{
					layout : "form",
					columnWidth : 1,
					labelWidth : 66,
					items : [ {  
						xtype:'textfield',
			        	fieldLabel:'', 
			        	width:'100%',
			        	height:150,
			        	style:'background-size: contain;width:auto!important;height:auto!important;background-image:url(../../../tyxh/xyrz/'+path+');background-repeat: no-repeat;',
			        	readOnly:true ,
			        	listeners:{'focus':function(tfd){
				               tfd.blur();
			                 }}    
		        	} ]
				},{
					layout : "form",
					columnWidth : 1,
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
					columnWidth : 0.5,
					labelWidth : 66,
					items : [ {
		                  
                        xtype:"combo",
                        fieldLabel:"<font color=red>*</font>类型",
                        id:"type1",
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
						listeners:{'select':function(){
							Ext.getCmp('type').setValue(Ext.getCmp('type1').getValue());
							}},
						valueField : 'id',
						displayField : 'dmmc',
						emptyText : '请选择...',
						allowBlank : false,
						forceSelection : true,
						editable : false,
						typeAhead : true,
                        anchor:"98%"
                    } ]
				},{
					layout : "form",
					columnWidth : 0.5,
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
					} ]
				}, {
						layout : "form",
						columnWidth : 1,
						labelWidth : 66,
						items : [ {
							xtype : "textarea",
							fieldLabel : "详细介绍",
							height:90,
							id : "description",
							name : "description",
							anchor : "98%"
						} ]
					},{
					xtype : "hidden",
					id : "cz",
					value : this.cz
				},{
					xtype : "hidden",
					id : "type",
					name : "type",
					anchor : "98%"

				}]
			} ];
			this.buttons = [ {
				text : '保存',
				iconCls : 'accept',
				handler : function() {
					Ext.getCmp('ext-form-xyrz').getForm().submit({
						url : '../../../xyrzController.do?save',
						method : 'post',
						waitMsg : '数据处理中..',
						success : function(form, action) {
							Ext.MessageBox.show({
								title : '提示',
								msg : action.result.msg,
								buttons : Ext.Msg.OK,
								fn : function() {
									Ext.getCmp('ext-win-xyrz').destroy();
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
					Ext.getCmp('ext-win-xyrz').destroy();
				}
			} ];
			Ext.XyrzWindow.superclass.initComponent.call(this);
			if(this.cz=='0'){
			   Ext.getCmp('ext-form-xyrz').getForm().loadRecord(this.rec); 
			   Ext.getCmp('type1').setValue(this.rec.data['typeName']);
			}
			this.show();

		}
	});
});