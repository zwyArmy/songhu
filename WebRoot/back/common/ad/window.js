
Ext.onReady(function(){

Ext.AdWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-Ad",
    width:400,
    height:250,
    modal:true,
    closable:true,
    resizable:false,
    initComponent: function(){
        var columnId = this.columnId;
        this.items=[
            {
                xtype:"form",
                title:"",
                id:"ext-form-Ad",
                labelAlign:"right",
                layout:"column",
                fileUpload: true,
                height:250,
                frame:true,
                items:[
                {
                    xtype:"hidden",
                    id:"id",
                    value:this.id,
                    name:"id",
                    anchor:"98%"
                    
                },
                {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[
                        {
                
                            xtype:"textfield",
                            readOnly:true,
                            fieldLabel:"栏目页面ID",
                            id:"columnId",
                            name:"columnId",
                            value:this.columnId,
                            anchor:"98%"
                        }]
                 },
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[
                        {
                
                            xtype:"textfield",
                            fieldLabel:"位置编码",
                            id:"posId",
                            name:"posId",
                            anchor:"98%"
                        }]
                 },
                {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[
                        {
                
                            xtype:"textfield",
                            fieldLabel:"位置说明",
                            id:"posDesc",
                            name:"posDesc",
                            anchor:"98%"
                        }]
                 },
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[
                        {
                
                            xtype:"textfield",
                            fieldLabel:"图片说明",
                            id:"picDesc",
                            name:"picDesc",
                            anchor:"98%"
                        }]
                 },
                 {
                     layout:"form",
                     columnWidth:1,
                     labelWidth:66,
                     items:[
                         {
                 
                             xtype:"textfield",
                             fieldLabel:"链接",
                             id:"url",
                             name:"url",
                             anchor:"98%"
                         }]
                  },
                  {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[
                        {
                
                            xtype:"textfield",
                            fieldLabel:"图片路径",
                            name:"myUpload",
                            inputType:"file",
                            anchor:"98%"
                        }]
                },
               {
                            xtype:"hidden",
                            id:"cz",
                            value:this.cz
               }, 
               {
                            xtype:"hidden",
                            id:"picPath"
               }
                ]
            }
        ]
        this.buttons=[
                {
                  text:'保存',
                  iconCls:'accept',
                  handler:function(){
                        Ext.getCmp('ext-form-Ad').getForm().submit({
                                              url:'../../../adController.do?save',
                                              method:'post',
                                              waitMsg:'数据处理中..',
                                              success:function(form,action){                                      
                                                     Ext.MessageBox.show({
                                                            title:'提示',
                                                            msg: action.result.msg,
                                                            buttons: Ext.Msg.OK ,
                                                            fn: function(){ 
                                                                Ext.getCmp('ext-win-Ad').destroy();
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
                  iconCls:'cancel',
                  handler:function(){
                    Ext.getCmp('ext-win-Ad').destroy();
                  }
                }
                ]
            Ext.AdWindow.superclass.initComponent.call(this);
            this.show();
            if(this.cz=='0')
            {
                Ext.getCmp('ext-form-Ad').getForm().loadRecord(this.rec);   
            }
              
 
    }
})


})
