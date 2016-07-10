
Ext.onReady(function(){

var w = document.body.clientWidth;
var h = document.body.clientHeight;
    
Ext.ArticleWindow3=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-111",
    width:w,
    height:h,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
        var qq=this.articleID2;
        var rec = this.rec;
        this.items=[
            {
                xtype:"form",
                title:"文章审核",
                id:"ext-form-111",
                labelAlign:"right",
                layout:"column",
				fileUpload: true,
                height:h-65,
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
                    xtype:"hidden",
                    id:"state",
                    value:this.state,
                    name:"state",
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
                        labelWidth:55,
                        items:[
                        {
                        xtype:"textfield",
                        fieldLabel:"标题",
                        itemCls:'required-red',
                        id:"title",
                        value:this.title,
                        name:"title",
                        emptyText:' ',
                        anchor:"100%"}]
                    },  
                    {
                        layout:"form",
                        columnWidth:0.5,
                        labelWidth:55,
                        items:[{
                        xtype:"textfield",
                        fieldLabel:"作者",
                        itemCls:"required-red",
                        id:"author",
                        value:this.author,
                        readOnly:true,
                        name:"author",
                        anchor:"100%"}]
                    }, 
                    {
                        layout:"form",
                        columnWidth:0.5,
                        labelWidth:55,
                        items:[{
                            xtype:"datefield",
                            fieldLabel:"发布时间",
                            id:"publishTime",
                            format:'Y-m-d H:i:s',
                            name:"publishTime",
                            readOnly:true,
                            anchor:"100%"}]
                    }, 
                   {
                        layout:"form",
                        columnWidth:1,
                        labelWidth:55,
                        items:[
                        {
                            xtype:"textarea",
                            fieldLabel:"文章",
                            itemCls:"required-red",
                            id:"content",
                            name:"content",
                            readOnly:false,
                            height:h-280,
                            anchor:"98%"
                        }
                        ]
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
              text:'附件下载',
              id:"FJXZ",
              iconCls:'accept',
              handler:function(){
            	  new Ext.Appendix2({article6:qq});
              }
            },
            {
              text:'同意',
              hidden:this.view,
              iconCls:'accept',
              handler:function(){
                Ext.getCmp("content").setValue(CKEDITOR.instances["content"].document.getBody().getHtml());
                Ext.getCmp("cz").setValue("0");
                   Ext.getCmp("state").setValue("1"); 
                           Ext.getCmp('ext-form-111').getForm().submit({
                                          url:'../../../articleController.do?save',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: "审核通过！ ",
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                   Ext.getCmp("ext-win-111").destroy();
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
            },
            {
              text:'不同意',
              iconCls:'cancel',
              hidden:this.view,
              handler:function(){
                Ext.getCmp("content").setValue(CKEDITOR.instances["content"].document.getBody().getHtml());
                Ext.getCmp("cz").setValue("0");
                   Ext.getCmp("state").setValue("3");  
                           Ext.getCmp('ext-form-111').getForm().submit({
                                          url:'../../../articleController.do?save',
                                          method:'post',
                                          waitMsg:'数据处理中..',
                                          success:function(form,action){ 
                                                 Ext.MessageBox.show({
                                                        title:'提示',
                                                        msg: "审核未通过！ ",
                                                        buttons: Ext.Msg.OK ,
                                                        fn: function(){ 
                                                   Ext.getCmp("ext-win-111").destroy();
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
               hidden:this.view,
               handler:function(){
                  Ext.getCmp("ext-win-111").destroy();
                }
            }
            ];
          Ext.ArticleWindow3.superclass.initComponent.call(this);
          if(this.cz=="00")
          {
        
         CKEDITOR.on('instanceReady', function (e) { 
             Ext.getCmp('ext-form-111').form.load({
                url:'../../../articleController.do?get',
                params:{'id':qq},
                waitMsg:'加载中......',
                waitTitle:'文章加载',                
                success:function(form,action){
			         CKEDITOR.instances["content"].document.getBody().setHtml(Ext.getCmp("content").getValue());
			         Ext.getCmp('publishTime').setValue(new Date(action.result.data.publishTime));
                },
                failure:function(form,action){
                   Ext.Msg.alert("提示",action.result.msg);
                }
              });});
          }
          this.show();
          CKEDITOR.config.readOnly = false;
          var editor = CKEDITOR.instances['content'];   
		  if(editor) editor.destroy(true);
		  var contentCKE=CKEDITOR.replace('content',{toolbar : 'Full',width:'100%',height : h - 248},{customConfig:'../../../resource/ckeditor/config.js'});
    }
});

});
