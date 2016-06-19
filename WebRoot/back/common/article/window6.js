
Ext.onReady(function(){

Ext.UploadWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-multiupload",
	width : 650,
	height : 300,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
		this.items = [{
			xtype : "form",
			id : "ext-form-multiupload",
			labelAlign : "right",
			layout : "column",
			fileUpload : true,
			height : 235,
			frame : true,
			items : [{  
		                  xtype:'uploadPanel',  
		                  border : false,  
		                  fileSize : 1024*50,//限制文件大小  
		                  uploadUrl : '../../../articleController.do?multiupload&articleId='+this.article4+'&columnId='+this.columnId4,  
		                  flashUrl : '../../../resource/commonjs/upload/swfupload.swf',  
		                  filePostName : 'myUpload', //后台接收参数  
		                  fileTypes : '*.*',//可上传文件类型  
		                  file_types_description: "Web Image Files",
		                  postParams : {savePath:'upload\\'} //上传文件存放目录  
		              } 
		    ]}
		];
		this.buttons = [{
			text : '关闭',
			iconCls : 'cancel',
			handler : function() {
				 Ext.getCmp('ext-win-multiupload').destroy();
                 store2.load();
			}
		} ];
		Ext.UploadWindow.superclass.initComponent.call(this);
		this.show();
    }
});
});
