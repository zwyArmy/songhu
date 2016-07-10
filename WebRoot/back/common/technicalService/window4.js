
Ext.onReady(function(){
Ext.ArticleckWindow4=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-move",
    width:400,
    height:150,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
    	moveId= this.moveId;
        this.items=[
            {
                xtype:"form",
                title:"移动栏目",
                id:"ext-form-move",
                labelAlign:"right",
                layout:"column",
                height:450,
                frame:true,
                items:[
                {
                    xtype:"hidden",
                    id:"id",
                    value:this.moveId,
                    name:"id",
                    anchor:"98%"
                    
                },
                {
                    xtype:"hidden",
                    id:"columnId",
                    value:this.columnId,
                    name:"columnId",
                    anchor:"98%"
                    
                },
                {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:100,
                      items:[
                          {
                  
                             xtype:"treecombo",
                             fieldLabel:"移动栏目",
                             emptyText : '请选择...',
                             id:"columnid1",
                             rootVisible:false,
  							 autoScroll:true,
  					         animate:true,
  					         containerScroll: true,
  							 anchor:"100%",
  							 root:new Ext.tree.AsyncTreeNode({
  						     text: '',
  						     draggable:false,
  						     id:'0' 
  							}),
  							 loader:new Ext.tree.TreeLoader({
  							 dataUrl:'../../../menuController.do?findByNode2',
  							 listeners:{'beforeload':function(treeLoader, node){
  							 treeLoader.baseParams = {parentId: node.id};
  							 }
  							 }                                  
  							 }),
  							 listeners:{'select':function(){
  								 if(this.getHiddenValue()=='02'||this.getHiddenValue()=='03'||this.getHiddenValue()=='04'||this.getHiddenValue()=='07'||this.getHiddenValue()=='11'){
  									Ext.Msg.alert("提示", "请选择子栏目!");
  									Ext.getCmp('columnid1').reset();
  								 }else{
  									Ext.getCmp('columnId').setValue(this.getHiddenValue());
  								 }
  					        }}
                          }
                      ]  
                  },{
					layout : "form",
					columnWidth : 1,
					labelWidth : 100,
					items : [ {
						fieldLabel : "<font color=red>*</font>是否保留原文章",
						id : 's_isPersist',
						xtype : "combo",
						value : this.isPersist,
						editable : false,
						emptyText : '请选择...',
						store : new Ext.data.SimpleStore({
							fields : [ 'value', 'text' ],
							data : [ [ '1', '是' ], [ '0', '否' ]]
						}),
						mode : 'local',
						triggerAction : 'all',
						valueField : 'value',
						displayField : 'text',
						anchor : "98%"
					} ]
				}
                ]
            }
        ];
        this.buttons=[
			{
				text : '保存',
				hidden : this.view,
				iconCls : 'accept',
				handler : function() {
					if(!checknull("s_isPersist","是否保留原文章")){
						return ;
					}
						Ext.getCmp('ext-form-move').getForm().submit({
							url : '../../../articleController.do?moveColumn&isPersist='+Ext.getCmp('s_isPersist').getValue(),
							method : 'post',
							waitMsg : '数据处理中..',
							success : function(form, action) {
								Ext.MessageBox.show({
									title : '提示',
									msg : action.result.msg,
									buttons : Ext.Msg.OK,
									fn : function() {
										Ext.getCmp("ext-win-move").destroy();
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
			},
            {
              text:'关闭',
              iconCls:'cancel',
              hidden:this.view,
               handler:function(){
                  Ext.getCmp("ext-win-move").destroy();
                }
            }
            ];
          Ext.ArticleckWindow4.superclass.initComponent.call(this);
          Ext.getCmp('columnid1').setValue(this.mc);
          this.show();      
    }
});
});
