
Ext.onReady(function(){
Ext.Appendix2=Ext.extend(Ext.Window ,{
    xtype:"window",
    title:"",
    id:"ext-win-appendix2",
    width:710,
    height:400,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
    	var article7 = this.article6;
    	store3 = new Ext.data.Store({
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
    				'articleId':article7
    		};
    		}
    	}
    	}
    	);
    	var grid3 = new Ext.grid.GridPanel({
    		store:store3,
    		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
    			loadMask:({msg:'数据正在加载中......'}),
    		columns: [
    			new Ext.grid.RowNumberer(),
    			{header: "编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
    			{header:"文件名称",width:15,sortable:true,dataIndex:'filename',algin:'left'},
    			{header:"路径",width:15,sortable:true,dataIndex:'path',algin:'left',hidden:true},
    			{header:"上传时间",width:8,sortable:true,dataIndex:'czsj',algin:'left',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
    			{header:"上传人",width:6,sortable:true,dataIndex:'czry',algin:'left'},
    			{header:"",width:4,sortable:true,dataIndex:'download',algin:'center',renderer:function(val){return "<font style='cursor:pointer;' color=blue>下载</font>";}}
    		],
    		frame:false,
    		autoWidth:true,
    		height:document.body.clientHeight-165,
    	    animCollapse: false,
    		bbar: new Ext.PagingToolbar({
    	        pageSize: 30,
    	        store: store3,
    	        displayInfo: true,
    	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
    	        emptyMsg: "没有记录"
    		}),
    		buttonAlign:'left',
    		viewConfig:{forceFit:true,templates:{cell:gridCopy}}
    	}
    	);
    	 grid3.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store3 = grid.getStore();
				var record = store3.getAt(rowIndex);
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
				if(fieldName=='download'){
					window.location=encodeURI('../../../articleController.do?download2&id='+record.data['id'],"UTF-8");
				}
	});
        this.items=[grid3];
        this.buttons=[
            {
              text:'关闭',
              iconCls:'cancel',
              hidden:this.view,
               handler:function(){
                  Ext.getCmp("ext-win-appendix2").destroy();
                }
            }
            ];
          Ext.Appendix2.superclass.initComponent.call(this);
          store3.load({params:{'articleId':article7,start:0,limit:30}});
          this.show();      
    }
});
});
