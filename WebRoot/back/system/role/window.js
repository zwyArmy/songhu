
Ext.onReady(function(){

	Ext.RoleWindow=Ext.extend(Ext.Window ,{
	    xtype:"window",
		title:"岗位信息",
		id:"ext-win-role",
		width:400,
		height:250,
		modal:true,
		closable:true,
		resizable:false,
		initComponent: function(){
			this.items=[
				{
					xtype:"form",
					title:"",
					id:"ext-form-role",
					labelWidth:80,
					labelAlign:"left",
					layout:"form",
					height:220,
					frame:true,
					items:[
						{
							xtype:"textfield",
							fieldLabel:"岗位名称",
							id:"mcGw",
							name:"mcGw",
							anchor:"98%"
						},
						{
							xtype:'treecombo',
							fieldLabel:"所属机构",
							id: 'mcBm',
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
							xtype:'combo',
							fieldLabel : '岗位类型',
							id : 'lx1',
							hiddenName : 'lx',
							store : new Ext.data.SimpleStore({
										fields: ['DM', 'DMMC'],
										data : [
											['1', '业务岗位'],
										   	['2', '管理岗位']
										]
									}),
							mode : 'local',
							triggerAction : 'all',
							valueField : 'DM',
							displayField : 'DMMC',
							value : '1',
							emptyText : '请选择...',
							allowBlank : false,
							forceSelection : true,
							editable : false,
							typeAhead : true,
							anchor : "98%"
						},
						{
							xtype:'combo',
							fieldLabel : '岗位属性',
							id : 'sx1',
							hiddenName : 'sx',
							store : new Ext.data.SimpleStore({
										fields: ['DM', 'DMMC'],
										data : [
											['1', '普通'],
										   	['2', '公共']
										]
									}),
							mode : 'local',
							readOnly: rl!='3',
							triggerAction : 'all',
							valueField : 'DM',
							displayField : 'DMMC',
							value : '1',
							emptyText : '请选择...',
							allowBlank : false,
							forceSelection : true,
							editable : false,
							typeAhead : true,
							anchor : "98%"
						},
						{
							xtype:'combo',
							fieldLabel : '岗位状态',
							id : 'locked1',
							hiddenName : 'locked',
							store : new Ext.data.SimpleStore({
										fields: ['DM', 'DMMC'],
										data : [
											['0', '激活'],
										   	['1', '锁定']
										]
									}),
							mode : 'local',
							triggerAction : 'all',
							valueField : 'DM',
							displayField : 'DMMC',
							value : '0',
							emptyText : '请选择...',
							allowBlank : false,
							forceSelection : true,
							editable : false,
							typeAhead : true,
							anchor : "98%"
						},
						{
							xtype:"textfield",
							fieldLabel : '备注',
							id:"bz",
							name:"bz",
							anchor : "98%"
						},
						{
							xtype:"hidden",
							id:"dmGw",
							name:"dmGw",
							value:this.dmGw
						},
						{
							xtype:"hidden",
							id:"dmBm",
							name:"dmBm",
							value:deptid
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
				    if(checknull("mcGw,dmBm","岗位名称,所属机构")){
		                Ext.getCmp('ext-form-role').getForm().submit({
		                                      url:'../../../roleController.do?save',
					                          method:'post',
					                          waitMsg:'数据处理中..',
				                              success:function(form,action){		                              
								                     Ext.MessageBox.show({
															title:'提示',
															msg: action.result.msg,
															buttons: Ext.Msg.OK ,
															fn: function(){	
																var deptid1 = Ext.getCmp('dmBm').getValue();
				                                   				Ext.getCmp('ext-win-role').destroy();
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
				  text:'关闭',
				  iconCls:'cancel',
				  handler:function(){
				    Ext.getCmp('ext-win-role').destroy();
				  }
				}
				]
			Ext.RoleWindow.superclass.initComponent.call(this);
			this.show();
			if(this.cz=='0')
				Ext.getCmp('ext-form-role').getForm().loadRecord(this.rec);
		}
	})

})