
Ext.onReady(function(){
Ext.Appendix=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-appendix",
    width:710,
    height:400,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
    	var article3 = this.article2;
    	var columnId3 = this.columnId2;
    	var cz2 = this.cz1;
    	store2 = new Ext.data.Store({
    		url:'../../../articleController.do?findAppendix',
    		reader:new Ext.data.JsonReader({
    			root:'root',
    			totalProperty:'totalProperty',
    			fields:[
    					{name:'articleId'},
    					{name:'id'},
    					{name:'filename'},
    					{name:'path'},
    					{name:'columnId'},
    					{name:'czsj'},
    					{name:'czry'}
    			]
    		}),
    		listeners:{'beforeload':function(sto,opt){
    			sto.baseParams = {
    				start:0,
    				limit:30,
    				articleId:article3
    		};
    		}
    	}
    	}
    	);
    	var grid2 = new Ext.grid.GridPanel({
    		store:store2,
    		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
    			loadMask:({msg:'数据正在加载中......'}),
    		columns: [
    			new Ext.grid.RowNumberer(),
    			{header: "编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
    			{header:"文件名称",width:15,sortable:true,dataIndex:'filename',algin:'left'},
    			{header:"路径",width:15,sortable:true,dataIndex:'path',algin:'left',hidden:true},
    			{header:"上传时间",width:8,sortable:true,dataIndex:'czsj',algin:'left',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
    			{header:"上传人",width:6,sortable:true,dataIndex:'czry',algin:'left'},
    			{header:"",width:4,sortable:true,dataIndex:'deleteAppendix',algin:'center',renderer:function(val){return "<font style='cursor:pointer;' color=blue>移除</font>";}}
    		],
    		frame:false,
    		autoWidth:true,
    		height:document.body.clientHeight-165,
    	    animCollapse: false,
    		tbar:[
    		{text:'添加文件',iconCls:'add', tooltip:'添加文件',
    		  handler:function(){
    	          new Ext.UploadWindow({article4:article3,columnId4:columnId3}); 		
    	        }},
    		'-',
    		{text:'删除所有',iconCls:'delete', tooltip:'删除所有',
    	          handler:function(){
    	        	  if(store2.getCount()!=0){
    	        	  var msg2;
    	        	  if(cz2==0){
    	        	  msg2 = '<font color=red>进行删除操作该文章将默认重新发表，请慎重选择。是否确定要删除所有附件？</font><br/><br/> ';
    	        	  }else{
    	        	  msg2 = '<font color=red>是否确定要删除所有附件？</font><br/><br/> ';	  
    	        	  }
    	        	  Ext.MessageBox.show({
			               title:'提示',
			               msg: msg2,
			               buttons: Ext.Msg.YESNO  ,
			               fn: function(conf){
			                 if(conf=='yes'){
								Ext.getCmp('ext-form-delete').getForm().submit({
						                  url:'../../../articleController.do?deleteAll',
						                  params:{"articleId":article3,"cz":cz2},
									      method:'post',
									      waitMsg:'数据处理中..',
								          success:function(form,action){	
                                         Ext.MessageBox.show({
												title:'提示',
												msg: action.result.msg,
												buttons: Ext.Msg.OK ,
												fn: function(){
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
			   });}else{
				   Ext.Msg.alert("提示","<font style='color:red'>无可删除附件!</font>");
			   }
    	        }}
    		],
    		bbar: new Ext.PagingToolbar({
    	        pageSize: 30,
    	        store: store2,
    	        displayInfo: true,
    	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
    	        emptyMsg: "没有记录"
    		}),
    		buttonAlign:'left',
    		viewConfig:{forceFit:true,templates:{cell:gridCopy}}
    	}
    	);
    	 grid2.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store2 = grid.getStore();
				var record = store2.getAt(rowIndex);
				var msg2 ;
				 if(cz2==0){
   	        	  msg2 = "<span style='cursor:pointer;color:red'>进行删除操作该文章将默认重新发表，请慎重选择。是否删除该附件<span>";
   	        	  }else{
   	        	  msg2 = "<span style='cursor:pointer;color:red'>是否删除该附件<span>";	  
   	        	  }
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
				if(fieldName=='deleteAppendix'){
					 Ext.MessageBox.show({
					       title:'提示',
					       msg: msg2,
					       buttons: Ext.Msg.YESNO  ,
					       fn: function(conf){
					            if(conf=='yes'){
					            	Ext.getCmp('ext-form-delete').getForm().submit({
						                  url:'../../../articleController.do?deleteAppendix',
						                  params:{"id":record.data['id'],"path":record.data['path'],"cz":cz2,"articleId":record.data['articleId']},
									      method:'post',
									      waitMsg:'数据处理中..',
								          success:function(form,action){	                              
									              Ext.MessageBox.show({
														title:'提示',
														msg: action.result.msg,
														buttons: Ext.Msg.OK ,
														fn: function(){
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
					   });
				}
	});
        this.items=[grid2];
        this.buttons=[
            {
              text:'关闭',
              iconCls:'cancel',
              hidden:this.view,
               handler:function(){
                  Ext.getCmp("ext-win-appendix").destroy();
                }
            }
            ];
          Ext.Appendix.superclass.initComponent.call(this);
          store2.load({params:{'articleId':article3,start:0,limit:30}});
          this.show();      
    }
});
});
