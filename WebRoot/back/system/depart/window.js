
Ext.onReady(function(){

	Ext.RoleWindow=Ext.extend(Ext.Window ,{
	    xtype:"window",
		title:"机构信息",
		id:"ext-win-dept",
		width:400,
		height:360,
		modal:true,
		closable:true,
		resizable:false,
		initComponent: function(){
			this.items=[
				{
					xtype:"form",
					title:"",
					id:"ext-form-dept",
					labelWidth:80,
					labelAlign:"left",
					layout:"form",
	                fileUpload: true,
					height:320,
					frame:true,
					items:[
					    {
					    	xtype:"panel",
					    	height:30,
					    	html:"<font color=red>注意：大图标180*50px,小图标30*30px,图片格式为png</font>"					    	
					    },
						{
							xtype:"textfield",
							fieldLabel : '机构编码',
							id:"deptid",
							name:"deptid",
							readOnly: this.cz=='0',
							anchor : "98%"
						},
						{
							xtype:"textfield",
							fieldLabel:"机构名称",
							id:"deptname",
							name:"deptname",
							anchor:"98%"
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
							fieldLabel : '邮箱',
							id:"email",
							name:"email",
							anchor : "98%"
						},
						{
							xtype:"textfield",
							fieldLabel : '电话',
							id:"phone",
							name:"phone",
							anchor : "98%"
						},
                        {
                
                            xtype:"textfield",
                            fieldLabel:"大图标",
                            name:"myUpload",
                            inputType:"file",
                            anchor:"98%"
                        },
                        {
                
                            xtype:"textfield",
                            fieldLabel:"小图标",
                            name:"myUpload1",
                            inputType:"file",
                            anchor:"98%"
                        },
						{
							xtype:"hidden",
							id:"parentdeptid",
							value:this.parentdeptid
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
		                Ext.getCmp('ext-form-dept').getForm().submit({
		                                      url:'../../../departController.do?save',
					                          method:'post',
					                          waitMsg:'数据处理中..',
				                              success:function(form,action){		                              
								                     Ext.MessageBox.show({
															title:'提示',
															msg: action.result.msg,
															buttons: Ext.Msg.OK ,
															fn: function(){	
				                                   				Ext.getCmp('ext-win-dept').destroy();
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
				    Ext.getCmp('ext-win-dept').destroy();
				  }
				}
				]
			Ext.RoleWindow.superclass.initComponent.call(this);
			this.show();
			if(this.cz=='0')
				Ext.getCmp('ext-form-dept').getForm().loadRecord(this.rec);
		}
	})

})