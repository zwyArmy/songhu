
Ext.onReady(function(){

Ext.OperatorWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"操作人员维护信息",
	id:"ext-win-operator",
	width:400,
	height:270,
	modal:true,
	closable:true,
	resizable:false,
	initComponent: function(){
		this.items=[
			{
				xtype:"form",
				title:"",
				id:"ext-form-operator",
				labelWidth:80,
				labelAlign:"right",
				layout:"form",
				height:205,
				frame:true,
				items:[
					{
						xtype:"textfield",
						fieldLabel:"人员代码",
						id:"dmCzy",
						value:this.dmCzy,
						readOnly:this.cz=='0',
						name:"dmCzy",
						anchor:"98%"
					},	
					{
						xtype:"textfield",
						fieldLabel:"人员姓名",
						id:"xmCzy",
						name:"xmCzy",
						anchor:"98%"
					},
					{
						xtype:'treecombo',
						fieldLabel:"所属机构",
						id: 'bmmc',
						width:250,
						tplId:'tree_tpl',
						rootVisible:true,
						root:{
				            nodeType: 'async',
				            id:deptid,
				            text:dept,
				            expanded:true
				      	},
				      	loader:new Ext.tree.TreeLoader({
				            dataUrl:'../../../departController.do?findByParent',
				            listeners:{'beforeload':function(treeLoader, node){
				            	treeLoader.baseParams = {id: node.id};            
				            }}                                  
				        }),
						listeners:{'select':function(){
							Ext.getCmp('dmBm').setValue(this.getHiddenValue());
						}},
						value:dept,
						anchor : "98%"
				    },	
					{
						xtype:"numberfield",
						fieldLabel:"手机号码",
						id:"lxdh",
						name:"lxdh",
						anchor:"98%"
					},
					{
						xtype:"textfield",
						fieldLabel:"初始化密码",
						inputType:'password',
						id:"kl",
						name:"kl",
						anchor:"98%"
					},
					{
						xtype:"hidden",
						id:"cz",
						value:this.cz
					},
					{
						xtype:"hidden",
						id:"dmBm",
						name:"dmBm",
						value:deptid
					}
				]
			}
		]
		this.buttons=[
			{
			  text:'保存',
			  iconCls:'accept',
			  handler:function(){
			  		if(checknull("dmCzy,xmCzy,dmBm","人员代码,人员姓名,所属机构")){			  	        
	                       Ext.getCmp('ext-form-operator').getForm().submit({
	                                      url:'../../../operatorController.do?save',
				                          method:'post',
				                          waitMsg:'数据处理中..',
			                              success:function(form,action){		                              
							                     Ext.MessageBox.show({
														title:'提示',
														msg: action.result.msg,
														buttons: Ext.Msg.OK ,
														fn: function(){	
															var deptid1 = Ext.getCmp('dmBm').getValue();
			                                   				Ext.getCmp('ext-win-operator').destroy();
													        store.load({params:{'dmBm':deptid1}});
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
			},
			{
			  text:'取消',
			  iconCls:'cancel',
			  handler:function(){
			    Ext.getCmp('ext-win-operator').destroy();
			  }
			}
			]
		Ext.OperatorWindow.superclass.initComponent.call(this);
		this.show();
		if(this.cz=='0')
			Ext.getCmp('ext-form-operator').getForm().loadRecord(this.rec);
	}
})

})