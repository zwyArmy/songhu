
Ext.onReady(function(){

	Ext.ColumnWindow=Ext.extend(Ext.Window ,{
	    xtype:"window",
		title:"栏目信息",
		id:"ext-win-column",
		width:400,
		height:310,
		modal:true,
		closable:true,
		resizable:false,
		initComponent: function(){
			this.items=[
				{
					xtype:"form",
					title:"",
					id:"ext-form-column",
					labelWidth:80,
					labelAlign:"left",
					layout:"form",
					height:310,
					frame:true,
					items:[
						{
							xtype:"textfield",
							fieldLabel:"栏目名称",
							id:"colName",
							name:"colName",
							anchor:"98%"
						},
						{
							xtype:"textfield",
							fieldLabel : '栏目id',
							readOnly:this.cz=='0',
							id:"id",
							name:"id",
							anchor : "98%"
						},
						{
							xtype:"numberfield",
							fieldLabel : '排序',
							id:"sort",
							name:"sort",
							anchor : "98%"
						},
						{
							xtype:"textfield",
							fieldLabel : '栏目链接',
							id:"link",
							name:"link",
							anchor : "98%"
						},
						{
							xtype:"textarea",
							fieldLabel : '描述',
							id:"description",
							name:"description",
							anchor : "98%"
						},
						{
							xtype:"textfield",
							readOnly:true,
							fieldLabel : '上级 ',
							id:"parentId",
							value:this.parentId
						},
						{       
							xtype:"combo",
		                    fieldLabel:"状态",
		                    itemCls:"required-red",
		                    allowBlank : false,
		                    id:"tz",
		                    hiddenName:'enabled',
		                    triggerAction:'all',
		                    editable:false,
		                    typeAhead:false,
		                    mode:'local',
		                    store: new Ext.data.ArrayStore({
		                        	fields:['txt','val'],
		                        	data:[['不显示',0],['显示',1]]
		                    }),
		                    valueField:'val',
		                    displayField:'txt',
		                    value:1,
		                    anchor:"97.5%"
                       },
                       {
							xtype:"textfield",
							hidden:true,
							id:"lmdm1",
							name:"lmdm1",
							anchor : "98%"
						},
						{
							xtype:"textfield",
							hidden:true,
							id:"lmdm2",
							name:"lmdm2",
							anchor : "98%"
						},
						{
							xtype:"hidden",
							id:"cz",
							value:this.cz
						}
					]
				}
			]
			this.buttons=[
				{
				  text:'保存',
				  iconCls:'accept',
				  handler:function(){
		                Ext.getCmp('ext-form-column').getForm().submit({
		                                      url:'../../../columnController.do?save',
					                          method:'post',
					                          waitMsg:'数据处理中..',
				                              success:function(form,action){		                              
								                     Ext.MessageBox.show({
															title:'提示',
															msg: action.result.msg,
															buttons: Ext.Msg.OK ,
															fn: function(){	
				                                   				Ext.getCmp('ext-win-column').destroy();
														        store.load();
														        tree.root.reload();
																tree.expandPath(path);
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
				},
				{
				  text:'关闭',
				  iconCls:'cancel',
				  handler:function(){
				    Ext.getCmp('ext-win-column').destroy();
				  }
				}
				]
			Ext.ColumnWindow.superclass.initComponent.call(this);
			this.show();
			if(this.cz=='0')
				Ext.getCmp('ext-form-column').getForm().loadRecord(this.rec);
		}
	})

})