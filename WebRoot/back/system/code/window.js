
Ext.onReady(function(){

Ext.CodeFWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"",
	id:"ext-win-CodeF",
	width:300,
	height:180,
	modal:true,
	closable:true,
	resizable:false,
	initComponent: function(){
		this.items=[
            {
                xtype:"form",
                title:"",
                id:"ext-form-CodeF",
                labelAlign:"left",
                layout:"column",
                height:180,
                width:280,
                frame:true,
                items:[
                {
                    xtype:"hidden",
                    id:"id",
                    value:"",
                    name:"id",
                    anchor:"98%"
                    
                },
                {
                    xtype:"hidden",
                    id:"flag",
                    value:this.flag
                    
                },  
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[{
                        xtype:"textfield",
                        fieldLabel:"名称",
                        itemCls:"required-red",
                        allowBlank : false,
                        id:"dmmc",
                        name:"dmmc",
                        anchor:"98%"}]
                 },
                 {
                   layout:"form",
                   columnWidth:1,
                   labelWidth:66,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"代码",
                        itemCls:"required-red",
                        readOnly: this.cz=='0',
                        listeners:{'focus' : function(tfd){if(Ext.getCmp('cz').getValue()=='0'){tfd.blur();}}},
                        allowBlank : true,
                        id:"zldm",
                        name:"zldm",
                        anchor:"98%"}]
                 },
                 {
                            xtype:"hidden",
                            id:"cz",
                            value:this.cz
                 }
             ]
        }
      ];
		
		this.buttons=[
			{
			  text:'保存',
			  handler:function(){
	                  if(Ext.getCmp("flag").getValue() == "insertZldm"){
	                     Ext.getCmp('ext-form-CodeF').getForm().submit({
                                          url:'../../../codeController.do?insertZldm',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: action.result.msg,
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                            Ext.getCmp("ext-win-CodeF").destroy();
                                                            store.load();
                                                        },
                                                        animEl: 'elId',
                                                        icon: Ext.MessageBox.WARNING
                                                }); 
                                           },
                                          failure:function(form,action){
                                               Ext.Msg.alert("提示",action.result.msg);
                                               
                                          }
                           });
	                          
				        }else if(Ext.getCmp("flag").getValue() == "updateZldm"){         
	                       Ext.getCmp('ext-form-CodeF').getForm().submit({
                                          url:'../../../codeController.do?updateZldm',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: action.result.msg,
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                            Ext.getCmp("ext-win-CodeF").destroy();
                                                            store.load();
                                                        },
                                                        animEl: 'elId',
                                                        icon: Ext.MessageBox.WARNING
                                                }); 
                                           },
                                          failure:function(form,action){
                                               Ext.Msg.alert("提示",action.result.msg);
                                               
                                          }
                           });  
				        }
			  }
			},
			{
			  text:'关闭',
			  handler:function(){
			    Ext.getCmp('ext-win-CodeF').destroy();
			}
		  }
	    ];
		Ext.CodeFWindow.superclass.initComponent.call(this);
		this.show();
		if(this.cz=='0')
            {
                Ext.getCmp('zldm').addClass("x-item-disabled");
                Ext.getCmp('ext-form-CodeF').getForm().loadRecord(this.rec);
            }
	}
});
});