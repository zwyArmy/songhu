
Ext.onReady(function(){
	var gwList = "";
	Ext.OperatorGrantWindow=Ext.extend(Ext.Window ,{
	    xtype:"window",
		title:"人员授权",
		id:"ext-win-operatorgrant",
	    iconCls: 'group-link',
		closeAction : 'close',
		closable : true,
		width : 400,
		height : 450,
		layout:'fit',
		modal:true,
		closable:true,
		resizable:false,
		initComponent: function(){
			this.items=[
				{
					xtype:'treepanel',
					id:'ext-tp-operatorgrant',
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
				        		Ext.getCmp('ext-form-operatorgrant').getForm().submit({
				                    url:'../../../roleController.do?updateCzrygw',
				                    params:{
				                    	gwList:gwList, 
				                    	czy:Ext.getCmp('czy').getValue()
				                    },
				              		method:'post',
				              		waitMsg:'数据处理中..',
				                	success:function(form,action){
				                		Ext.Msg.alert("提示",action.result.msg);
						                Ext.getCmp('ext-tp-operatorgrant').root.reload();
						                Ext.getCmp('ext-tp-operatorgrant').expandAll();
						                gwList = "";
						                var deptid3 = Ext.getCmp('dmBm').getValue();
						                store.load({params:{'dmBm':deptid3}});
						                Ext.getCmp('ext-win-operatorgrant').destroy();
				           			},
				              		failure:function(form,action){
				                   		Ext.Msg.alert("提示",action.result.msg);
				                   		Ext.getCmp('ext-win-operatorgrant').destroy();
				                   		gwList = "";
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
			            dataUrl:'../../../menuController.do?findGwForCzry',
			            listeners:{'beforeload':function(treeLoader, node){
			            	Ext.getCmp('dmBm').setValue(node.id);
			            	treeLoader.baseParams = {fbh: node.id, czy:Ext.getCmp('czy').getValue()};            
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
					id:'czy',
					value:this.czy
				},
				{
					xtype:"hidden",
					id:"dmBm",
					name:"dmBm",
					value:deptid
				},
				{
					xtype:'form',
					hidden:true,
					id:'ext-form-operatorgrant'
				
				}
			]
			this.buttons=[
				{
				  text:'关闭',
			  	  iconCls:'cancel',
				  handler:function(){
				    Ext.getCmp('ext-win-operatorgrant').destroy();
				  }
				}
				]
			Ext.OperatorGrantWindow.superclass.initComponent.call(this);
			this.show();
			Ext.getCmp('ext-tp-operatorgrant').expandAll();
		}
	})


	function findCheckedChildNode(node){
		node.eachChild(function(child){
			if(child.attributes.checked)
				gwList += child.id + ",";
			findCheckedChildNode(child);
		});
	}

})