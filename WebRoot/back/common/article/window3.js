
Ext.onReady(function(){

var w = document.body.clientWidth;
var h = document.body.clientHeight;
    
Ext.ArticleckWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-ck",
    width:w,
    height:h,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
        ckId=this.yy;
        this.items=[
            {
                xtype:"form",
                title:"文章查看",
                id:"ext-form-ck",
                labelAlign:"right",
                layout:"column",
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
                        xtype:"hidden",
                        fieldLabel:"标题",
                        itemCls:'required-red',
                        id:"title",
                        value:this.title,
                        readOnly:true,
                        name:"title",
                        emptyText:' ',
                        anchor:"98%"}]
                    },  
                    {
                        layout:"form",
                        columnWidth:1,
                        labelWidth:55,
                        items:[{
                        xtype:"hidden",
                        fieldLabel:"作者",
                        itemCls:"required-red",
                        id:"author",
                        value:this.author,
                         readOnly:true,
                        name:"author",
                        anchor:"98%"}]
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
                             readOnly:true,
                            height:h-20,
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
              text:'关闭',
              iconCls:'cancel',
              hidden:this.view,
               handler:function(){
                  Ext.getCmp("ext-win-ck").destroy();
                }
            }
            ];
        Ext.ArticleckWindow.superclass.initComponent.call(this);
          Ext.getCmp('ext-form-ck').form.load({
            url:'../../../articleController.do?get',
            params:{'id':ckId},
            waitMsg:'加载中......',
            waitTitle:'文章加载',                
            success:function(form,action){
                 this.content=CKEDITOR.instances["content"].document.getBody().setHtml(Ext.getCmp("content").getValue()); 
            },
            failure:function(form,action){
               Ext.Msg.alert("提示",action.result.msg);
            }
          });
          this.show();
          CKEDITOR.config.readOnly = true;
		  var editor = CKEDITOR.instances['content'];   
		  if(editor) editor.destroy(true);
          var contentCKE=CKEDITOR.replace('content',{toolbar : 'MyToolbar',width:'100%',height:h-160.5},{customConfig:'../../../resource/ckeditor/myconfig.js'});
    }
});
});
