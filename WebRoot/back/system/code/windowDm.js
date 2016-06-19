
Ext.onReady(function(){

Ext.CodeWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"",
	id:"ext-win-code",
	width:300,
	height:250,
	modal:true,
	closable:true,
	resizable:false,
	initComponent: function(){
		this.items=[
            {
                xtype:"form",
                title:"",
                id:"ext-form-code",
                labelAlign:"left",
                layout:"column",
                height:250,
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
                        readOnly: this.cz=='0',
                         listeners:{'focus' : function(tfd){
                        if(Ext.getCmp('cz').getValue()=='0'){tfd.blur();}}},
                        itemCls:"required-red",
                        allowBlank : false,
                        id:"dm",
                        name:"dm",
                        anchor:"98%"}]
                 },
                 {
                   layout:"form",
                   columnWidth:1,
                   labelWidth:66,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"父代码",
                        readOnly: this.cz=='0',
                        listeners:{'focus' : function(tfd){if(Ext.getCmp('cz').getValue()=='0'){tfd.blur();}}
                        },
                        itemCls:"required-red",
                        allowBlank : true,
                        id:"zldm",
                        value:this.zldm,
                        name:"zldm",
                        anchor:"98%"}]
                 },
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[{
                        xtype:"textfield",
                        fieldLabel:"扩展",
                        allowBlank : true,
                        id:"kz",
                        name:"kz",
                        anchor:"98%"}]
                 },{       
                	 layout:"form",
                     columnWidth:1,
                     labelWidth:66,
                     items:[{
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
	                    anchor:"98%"
                     }]
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
	                  if(Ext.getCmp("flag").getValue() == "insert"){
	                     Ext.getCmp('ext-form-code').getForm().submit({
                                          url:'../../../codeController.do?insert',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: action.result.msg,
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                            Ext.getCmp("ext-win-code").destroy();
                                                            store2.load();
                                                        },
                                                        animEl: 'elId',
                                                        icon: Ext.MessageBox.WARNING
                                                }); 
                                           },
                                          failure:function(form,action){
                                               Ext.Msg.alert("提示",action.result.msg);
                                               
                                          }
                           });
	                          
				        }else if(Ext.getCmp("flag").getValue() == "update"){         
	                       Ext.getCmp('ext-form-code').getForm().submit({
                                          url:'../../../codeController.do?update',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: action.result.msg,
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                            Ext.getCmp("ext-win-code").destroy();
                                                            store2.load();
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
			    Ext.getCmp('ext-win-code').destroy();
			}
		  }
	    ];
		Ext.CodeWindow.superclass.initComponent.call(this);
		this.show();
		if(this.cz=='0')
            {
                Ext.getCmp('dm').addClass("x-item-disabled");
                Ext.getCmp('zldm').addClass("x-item-disabled");
                Ext.getCmp('ext-form-code').getForm().loadRecord(this.rec);   
            }
	}
});
});