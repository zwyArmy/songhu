
Ext.onReady(function(){
	var childList = "";
	Ext.RoleGrantWindow=Ext.extend(Ext.Window ,{
	    xtype:"window",
		title:"岗位授权",
		id:"ext-win-rolegrant",
		closeAction : 'close',
		closable : true,
		width : 400,
		height : document.body.clientHeight - 6,
		layout:'fit',
		modal:true,
		closable:true,
		resizable:false,
		initComponent: function(){
			this.items=[
				{
					xtype:"tabpanel",
					activeTab:0,
					items:[
						{
							xtype:"panel",
	    					iconCls: 'award_star_silver_3Icon',
							title:"权限授权",
						 	layout:'fit',
							items:[
								{
									xtype:'treepanel',
									id:'ext-tp-rolegrant',								
							        //useArrows:true,
							        autoScroll:true,
							        animate:false,
							        enableDD:false,
							        containerScroll: true,
							        rootVisible: false,
							        frame: false,
									anchor:'98%',
									tbar:[{
							                iconCls: 'accept',
											text: '保存',
							                handler: function(){	
							                	findCheckedChildNode(Ext.getCmp('ext-tp-rolegrant').root);	
								        		Ext.getCmp('ext-form-rolegrant').getForm().submit({
								                    url:'../../../roleController.do?updateGwqx',
								                    params:{
								                    	qx:childList, 
								                    	gw:Ext.getCmp('gw').getValue()
								                    },
								              		method:'post',
								              		waitMsg:'数据处理中..',
								                	success:function(form,action){
								                		Ext.Msg.alert("提示",action.result.msg);
										                Ext.getCmp('ext-tp-rolegrant').root.reload();
										                Ext.getCmp('ext-tp-rolegrant').expandAll();
										                childList = "";
										                store.load();
								           			},
								              		failure:function(form,action){
								                   		Ext.Msg.alert("提示",action.result.msg);
								                   		childList = "";
								              		}
												})
							                },
							                scope: this
							            }, '-', {
							                iconCls: 'icon-expand-all',
											text: '展开',
							                handler: function(){ Ext.getCmp('ext-tp-rolegrant').expandAll(); },
							                scope: this
							            }, '-', {
							                iconCls: 'icon-collapse-all',
							                text: '收缩',
							                handler: function(){ Ext.getCmp('ext-tp-rolegrant').collapseAll(); },
							                scope: this
							            }],
							        root: {
							            nodeType: 'async',
							            id:"###"
							        },
							        loader:new Ext.tree.TreeLoader({
							            dataUrl:'../../../menuController.do?findByGrant',
							            listeners:{'beforeload':function(treeLoader, node){
							            	treeLoader.baseParams = {fbh: node.id, gw:Ext.getCmp('gw').getValue()};            
							            }}                                  
							        }),
							        listeners:{'checkchange':function(node, checked){
											if (node.hasChildNodes()) {
												node.eachChild(function(child) {
													if(!child.attributes.complete){
														child.ui.toggleCheck(checked);
														child.attributes.checked = checked;
														child.fireEvent('checkchange', child, checked);//递归调用
													}
												});
											}		
							        }}								
								},
								{
									xtype:'hidden',
									id:'gw',
									value:this.gw
								},
								{
									xtype:'form',
									hidden:true,
									id:'ext-form-rolegrant'
								
								}
							]
						},	
						{
							xtype:"panel",
        					iconCls:'group',
							autoScroll:true,
							title:"选择人员",
							layout:'fit',
							items:[
								{
									xtype:'treepanel',
									id:'ext-tp-operatorgrant',								
							        //useArrows:true,
							        autoScroll:true,
							        animate:false,
							        enableDD:false,
							        containerScroll: true,
							        rootVisible: true,
							        frame: false,
									anchor:'98%',
									tbar:[{
							                iconCls: 'accept',
											text: '保存',
							                handler: function(){	
							                	findCheckedChildNode(Ext.getCmp('ext-tp-operatorgrant').root);						                       	
								        		Ext.getCmp('ext-form-rolegrant').getForm().submit({
								                    url:'../../../roleController.do?updateCzrygw',
								                    params:{
								                    	czyList:childList, 
								                    	'gw':Ext.getCmp('gw').getValue()
								                    },
								              		method:'post',
								              		waitMsg:'数据处理中..',
								                	success:function(form,action){
								                		Ext.Msg.alert("提示",action.result.msg);
										                Ext.getCmp('ext-tp-operatorgrant').root.reload();
										                Ext.getCmp('ext-tp-operatorgrant').expandAll();
										                childList = "";
										                store.load();
														Ext.getCmp('ext-win-rolegrant').destroy();
								           			},
								              		failure:function(form,action){
								                   		Ext.Msg.alert("提示",action.result.msg);
								      				    Ext.getCmp('ext-win-rolegrant').destroy();
								                   		childList = "";
								              		}
												})
							                },
							                scope: this
							            }],
							        root: {
							            nodeType: 'async',
							            text: this.bmmc,
							            id: this.bm,
							            expanded:true
							        },
							        loader:new Ext.tree.TreeLoader({
							            dataUrl:'../../../menuController.do?findCzryForGw',
							            listeners:{'beforeload':function(treeLoader, node){
							            	treeLoader.baseParams = {fbh: node.id, gw:Ext.getCmp('gw').getValue()};            
							            }}                                  
							        })							
								}
							]
						}
					]
				}
			]
			this.buttons=[
				{
				  text:'关闭',
			  	  iconCls:'cancel',
				  handler:function(){
				  Ext.getCmp('ext-win-rolegrant').destroy();
				  }
				}
				]
			Ext.RoleGrantWindow.superclass.initComponent.call(this);
			this.show();
			Ext.getCmp('ext-tp-rolegrant').expandAll();
		}
	})


	function findCheckedChildNode(node){
		node.eachChild(function(child){
			if(child.attributes.checked)
				childList += child.id + ",";
				//checkedChild.push(child.id);
			findCheckedChildNode(child);
		});
	}

})