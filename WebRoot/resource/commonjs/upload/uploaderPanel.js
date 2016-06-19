var keel={};

keel.UploadPanel = function(cfg){
	/*this.progressBar = new Ext.ProgressBar({
		text : '等待中 0 %',
		animate : true
	});*/
	this.width = 620;
	this.height = 220;
	Ext.apply(this,cfg);	
	this.gp = new Ext.grid.GridPanel({
		border :false,
		store: new Ext.data.Store({
			fields:['id','name','type','size','state','percent']
		}),
	    columns: [
	    	new Ext.grid.RowNumberer(),
	        {header: '文件名', width: 200, sortable: true,dataIndex: 'name'},
	        {header: '类型', width: 70, sortable: true,dataIndex: 'type'},
	        {header: '大小', width: 100, sortable: true,dataIndex: 'size',renderer:this.formatFileSize},
	        {header: '进度', width: 150, sortable: true,dataIndex: 'percent',renderer:this.formatMinProgressBar,scope:this}	        
	    ]			
	});
	this.setting = {
		upload_url : this.uploadUrl, 
		flash_url : this.flashUrl,
		file_size_limit : (1024*50) ,//上传文件体积上限，单位MB
		file_post_name : this.filePostName,
		file_types : this.fileTypes||"*.*",  //允许上传的文件类型 
        file_types_description : "All Files",  //文件类型描述
        file_upload_limit : "0",  //限定用户一次性最多上传多少个文件，在上传过程中，该数字会累加，如果设置为“0”，则表示没有限制 
        //file_queue_limit : "10",//上传队列数量限制，该项通常不需设置，会根据file_upload_limit自动赋值              
		post_params : this.postParams||{savePath:'upload\\'},
		use_query_string : true,
		debug : false,
		button_cursor : SWFUpload.CURSOR.HAND,
		button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
		custom_settings : {//自定义参数
			scope_handler : this
		},
		file_queued_handler : this.onFileQueued,
		swfupload_loaded_handler : function(){},// 当Flash控件成功加载后触发的事件处理函数
		file_dialog_start_handler : function(){},// 当文件选取对话框弹出前出发的事件处理函数
		file_dialog_complete_handler : function(){},//当文件选取对话框关闭后触发的事件处理
		upload_start_handler : this.onUploadStart,// 开始上传文件前触发的事件处理函数
		upload_success_handler : this.onUploadSuccess,// 文件上传成功后触发的事件处理函数 
		swfupload_loaded_handler : function(){},// 当Flash控件成功加载后触发的事件处理函数  
		upload_progress_handler : this.uploadProgress,
		upload_complete_handler : this.onUploadComplete,
		upload_error_handler : this.onUploadError,
		file_queue_error_handler : this.onFileError
	};
	keel.UploadPanel.superclass.constructor.call(this,{				
		tbar : [
			{text:'添加文件',iconCls:'add',ref:'../addBtn'},'-',
			{text:'上传',ref:'../uploadBtn',iconCls:'uploadIcon',handler:this.startUpload,scope:this},'-',
			{text:'停止上传',ref:'../stopBtn',iconCls:'delete',hidden:true,handler:this.stopUpload,scope:this,disabled:true},'-',
			{text:'删除所有',ref:'../deleteBtn',iconCls:'deleteIcon',handler:this.deleteAll,scope:this},'-'
		],
		//bbar : [this.progressBar],
		layout : 'fit',
		items : [this.gp],
		listeners : {
			'afterrender':function(){
				//this.resizeProgressBar();
				var em = this.getTopToolbar().get(0).el.child('em');
				var placeHolderId = Ext.id();
				em.setStyle({
					position : 'relative',
					display : 'block'
				});
				em.createChild({
					tag : 'div',
					id : placeHolderId
				});
				this.swfupload = new SWFUpload(Ext.apply(this.setting,{
					button_width : em.getWidth(),
					button_height : em.getHeight(),
					button_placeholder_id :placeHolderId
				}));
				this.swfupload.uploadStopped = false;
				Ext.get(this.swfupload.movieName).setStyle({
					position : 'absolute',
					top : 0,
					left : -2
				});				
			},
			scope : this,
			delay : 100
		}
	});
}
Ext.extend(keel.UploadPanel,Ext.Panel,{
	toggleBtn :function(bl){
		this.addBtn.setDisabled(bl);
		this.uploadBtn.setDisabled(bl);
		this.deleteBtn.setDisabled(bl);
		this.stopBtn.setDisabled(!bl);
	},
 	onUploadStart : function(file) {  
	   var post_params = this.settings.post_params;  
	   Ext.apply(post_params,{//处理中文参数问题
	   		//fileName : file.name,
	        fileName : encodeURIComponent(file.name)
	   });  
	   this.setPostParams(post_params);  
	},
	startUpload : function() {
		if (this.swfupload) {
			if (this.swfupload.getStats().files_queued > 0) {
				this.swfupload.uploadStopped = false;
				this.toggleBtn(true);
				this.swfupload.startUpload();
			}
		}
	},
	resizeProgressBar : function() {
		this.progressBar.setWidth(this.el.getWidth()-3);
	},
	formatFileSize : function(_v, celmeta, record) {
		return Ext.util.Format.fileSize(_v);
	},
	formatFileState : function(n){//文件状态
		/*
		QUEUED: -1,
		IN_PROGRESS : -2,
		ERROR: -3,
		COMPLETE : -4,
		CANCELLED: -5
		*/
		/*switch(n){
			case -1 : return '准备上传<br/>';
			break;
			case -2 : return '正在上传';
			break;
			case -3 : return '上传失败';
			break;
			case -4 : return '上传成功';
			break;
			case -5 : return '停止上传';
			break;
			default: return n;
		}*/
	},
	formatMinProgressBar : function(v){
		var progressBarTmp = this.getTplStr(v);
		return progressBarTmp;
	},
	getTplStr : function(v){
		var bgColor = "orange";
	    var borderColor = "#008000";
		return String.format(
			'<div>'+
				'<div style="border:1px solid {0};height:10px;width:{1}px;margin:4px 0px 1px 0px;float:left;">'+		
					'<div style="float:left;background:{2};width:{3}%;height:10px;"><div></div></div>'+
				'</div>'+
			'<div style="text-align:center;float:right;width:40px;margin:3px 0px 1px 0px;height:10px;font-size:12px;">{3}%</div>'+			
		'</div>', borderColor,(90),bgColor, v);
	},
	onUploadComplete : function(file) {
		if (this.getStats().files_queued > 0 && this.uploadStopped == false) {
			this.startUpload();
		}else{
			var me = this.customSettings.scope_handler;
			me.toggleBtn(false);
		}
	},
	onFileQueued : function(file) {
		var me = this.customSettings.scope_handler;
		var rec = new Ext.data.Record({
			id : file.id,
			name : file.name,
			size : file.size,
			type : file.type,
			state : file.filestatus,
			percent : 0
		})
		me.gp.getStore().add(rec);
	},
	onUploadSuccess : function(file, serverData) {
		//alert(serverData);
		var me = this.customSettings.scope_handler;
		if (Ext.util.JSON.decode(serverData).success) {
			var ds = me.gp.store;
			for(var i=0;i<ds.getCount();i++){
				var record =ds.getAt(i);
				if(record.get('id')==file.id){
					record.set('state', file.filestatus);
					record.commit();
				}
			}			
		}
	},
	uploadProgress : function(file, bytesComplete, totalBytes){//处理进度条
		var me = this.customSettings.scope_handler;
		var percent = Math.ceil((bytesComplete / totalBytes) * 100);
        //var processText = '<font color="green">'+percent+'%</font>';
       // me.progressBar.updateProgress(percent,processText);  
       	var ds = me.gp.store;
		for(var i=0;i<ds.getCount();i++){
			var record =ds.getAt(i);
			if(record.get('id')==file.id){
				record.set('percent', percent);
				record.commit();
			}
		}
	},
	onUploadError : function(file, errorCode, message) {
		/*var me = this.customSettings.scope_handler;
		switch (errorCode) {
			case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED :
				var percent = 0;
				var ds = me.gp.store;
				for(var i=0;i<ds.getCount();i++){
					var record =ds.getAt(i);
					if(record.get('id')==file.id){
						record.set('percent', percent);
						record.commit();
					}
				}
				break;
		}*/
	},
	onFileError : function(file,n){
		/*
		QUEUE_LIMIT_EXCEEDED            : -100,
	    FILE_EXCEEDS_SIZE_LIMIT         : -110,
	    ZERO_BYTE_FILE                  : -120,
	    INVALID_FILETYPE                : -130
	    */
		switch(n){
			case -100 : Ext.Msg.alert('提示','待上传文件列表数量已经最大，不能选择！');
			break;
			case -110 : Ext.Msg.alert('提示','文件大小超过限制，不能选择！');
			break;
			case -120 : Ext.Msg.alert('提示','该文件大小为0，不能选择！');
			break;
			case -130 : Ext.Msg.alert('提示','该文件类型不可以上传');
			break;
		}
	},
	stopUpload : function() {
		if (this.swfupload) {
			this.swfupload.uploadStopped = true;
			this.swfupload.stopUpload();
			this.toggleBtn(false);
		}
	},
	deleteAll : function(){
		var ds = this.gp.store;
		for(var i=0;i<ds.getCount();i++){
			var record =ds.getAt(i);
			var file_id = record.get('id');
			this.swfupload.cancelUpload(file_id,true);			
		}
		ds.removeAll();
		this.swfupload.uploadStopped = false;
	}
});
Ext.reg('uploadPanel',keel.UploadPanel);