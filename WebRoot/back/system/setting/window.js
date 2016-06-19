
Ext.onReady(function(){
var w = document.body.clientWidth;
var h = document.body.clientHeight;
Ext.SettingWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"",
	id:"ext-win-Setting",
	width:w,
	height:h,
	modal:true,
	closable:true,
	resizable:false,
	initComponent: function(){
	   var Keyid = this.Keyid;
		this.items=[
            {
                xtype:"form",
                title:"",
                id:"ext-form-Setting",
                labelAlign:"left",
                layout:"column",
                height:h-65,
                frame:true,
                items:[
                {
                    layout:"form",
                    columnWidth:.5,
                    labelWidth:33,
                    items:[{
                        xtype:"textfield",
                        fieldLabel:"参数",
                        itemCls:'required-red',
                        readOnly:true,
                        id:"password",
                        emptyText:' ',
                        value:this.password,
                        name:"password",
                        anchor:"95%"}]
                 }, 
                 {
                   layout:"form",
                   columnWidth:.5,
                   labelWidth:33,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"说明",
                        itemCls:"required-red",
                        readOnly:true,
                        id:"description",
                        value:this.description,
                        name:"description",
                        anchor:"96%"}]
                 },
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:33,
                    items:[{
                        xtype:"htmleditor",
                        fieldLabel:"协议",
                        itemCls:"required-red",
                        emptyText:' ',
                         height:h-160,
                        allowBlank : false,
                        id:"value",
                        value:this.value,
                        name:"value",
                        anchor:"98%"}]
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
			  handler:function(){
	                     Ext.getCmp('ext-form-Setting').getForm().submit({
                                          url:'../../../settingController.do?save',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: action.result.msg,
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                            Ext.getCmp("ext-win-Setting").destroy();
                                                            store.load();
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
			  handler:function(){
			    Ext.getCmp('ext-win-Setting').destroy();
			}
		  }
	    ]
		Ext.SettingWindow.superclass.initComponent.call(this);
		this.show();
		 if (this.cz == '0') {
			Ext.getCmp('ext-form-Setting').form.load({
						url : '../../../settingController.do?get',
						params : {'key' :Keyid},
						waitMsg : '加载中......',
						waitTitle : '  ',
						success : function(form, action) {
							
						},
						failure : function(form, action) {
							Ext.Msg.alert("提示", action.result.msg);
						}
			});	
		}
	  }
})
})