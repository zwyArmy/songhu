<%@ page contentType="text/html; charset=UTF-8" %>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../../ext3.2/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../../resource/css/common.css" />
<script type="text/javascript" src="../../ext3.2/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../ext3.2/ext-all.js"></script>
<script type="text/javascript" src="../../ext3.2/src/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="../../script/mytools.js"></script>
<script type="text/javascript" src="../../script/cook.js"></script>
<script type="text/javascript" src="window.js"></script>
<script type="text/javascript" src="../../script/theme.js"></script>
</head>
<script language="javascript">

Ext.BLANK_IMAGE_URL="../../ext3.2/resources/images/default/s.gif";
Ext.onReady(function(){
var orgGrid=Ext.get("grid-example");


var form_delete = new Ext.FormPanel({
      id:'ext-form-delete',
      hidden:true,
      renderTo:"grid-example"
})

var reader = new Ext.data.JsonReader({root: 'root',totalProperty: 'totalProperty',
  fields: [
			{name: 'eventid'},
			{name: 'userid'}, 
			{name: 'account'},   
			{name: 'username'},       
			{name: 'description'},       
			{name: 'activetime'},       
			{name: 'requestpath'},       
			{name: 'methodname'},      
			{name: 'costtime'},      
			{name: 'department'}
         ]
      });
store = new Ext.data.Store({
        url : '/Event/find.do',
        reader: reader,
        listeners:{'beforeload':function(sto, opt){
			sto.baseParams = {
					start:0, 
					limit:30,
					'event.activetime':Ext.getCmp('cx_activetime').getRawValue(),
					'event.activetime1':Ext.getCmp('cx_activetime1').getRawValue(),
					'event.account':Ext.getCmp('cx_account').getValue(),
					'event.username':Ext.getCmp('cx_username').getValue(),
					'event.description':Ext.getCmp('cx_description').getValue()		
			}
        }}
      }); 
      
var grid = new Ext.grid.GridPanel({
    store: store,
    sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask:({msg :'数据正在加载中……'}), 
    columns: [
        new Ext.grid.RowNumberer(),
		 {header: "激活时间",  width: 5,hidden: false, sortable: true, dataIndex: 'activetime',align:'left'},
         {header: "登录账户",  width: 3, sortable: true, dataIndex: 'account',align:'left'},                    
         {header: "姓名", width: 5, sortable: true, dataIndex: 'username',align:'left'},                     
         {header: "所属部门", width: 10, sortable: true, dataIndex: 'department',align:'left'},                      
         {header: "耗时(毫秒)", width: 3, sortable: true, dataIndex: 'costtime',align:'left'},                      
         {header: "描述信息", width: 15, sortable: true, dataIndex: 'description',align:'left'},                            
         {header: "请求路径", width: 5, sortable: true, dataIndex: 'requestpath',align:'left'} 
    ],
    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
    frame:false,
    autoWidth: true,
    height:orgGrid.getComputedHeight(),
    animCollapse: false,
    iconCls: 'icon-grid',
    tbar:[
		{text:'删除',iconCls:'delete', tooltip:'删除记录',
		   handler:function(){
		         var rec = grid.getSelectionModel().getSelected();
		if(!rec){
			Ext.Msg.alert('提示','请 选 择 要 删 除 的 记 录！');
		}else{
		    Ext.MessageBox.show({
		               title:'提示',
		               msg: '是否确定要删除该条记录？ ',
		               buttons: Ext.Msg.YESNO  ,
		               fn: function(conf){
		                 if(conf=='yes'){
							Ext.getCmp('ext-form-delete').getForm().submit({
					                  url:'/Event/delete.do',
					                  params:{"event.eventid":rec.data['eventid']},
								      method:'post',
								      waitMsg:'数据处理中..',
							          success:function(form,action){		                              
								              Ext.MessageBox.show({
													title:'提示',
													msg: action.result.msg,
													buttons: Ext.Msg.OK ,
													fn: function(){
													    store.load();
													},
													nimEl: 'elId',
													icon: Ext.MessageBox.WARNING
											  }); 					                       
									  },
								      failure:function(form,action){
								               Ext.Msg.alert("提示",action.result.msg);
								      }
								}) 
			           		}
			          }
			   })
		   	}
		}},
		'-',
		{text:'清空',iconCls:'rotate', tooltip:'清空记录',
		   handler:function(){
		    Ext.MessageBox.show({
		               title:'提示',
		               msg: '是否确定要清空记录？ ',
		               buttons: Ext.Msg.YESNO  ,
		               fn: function(conf){
		                 if(conf=='yes'){
							Ext.getCmp('ext-form-delete').getForm().submit({
					                  url:'/Event/deleteAll.do',
								      method:'post',
								      waitMsg:'数据处理中..',
							          success:function(form,action){		                              
								              Ext.MessageBox.show({
													title:'提示',
													msg: action.result.msg,
													buttons: Ext.Msg.OK ,
													fn: function(){
													    store.load();
													},
													nimEl: 'elId',
													icon: Ext.MessageBox.WARNING
											  }); 					                       
									  },
								      failure:function(form,action){
								               Ext.Msg.alert("提示",action.result.msg);
								      }
								}) 
			           		}
			          }
			   })
		}},
	    '->',
	    {
			xtype:"datefield",				
			id:"cx_activetime",
			format:'Y-m-d',
			emptyText : '开始日期'
		},
		'-',
	    {
			xtype:"datefield",				
			id:"cx_activetime1",
			format:'Y-m-d',
			emptyText : '结束日期'
		},
		'-',
	    {
			xtype:"textfield",				
			id:"cx_account",
			emptyText : '登录账户'
		},
		'-',	
	    {
			xtype:"textfield",				
			id:"cx_username",
			emptyText : '姓名'
		},
		'-',	
	    {
			xtype:"textfield",				
			id:"cx_description",
			emptyText : '描述'
		},
	    {text:'查询',iconCls:'search', tooltip:'查询',
	          handler:function(){
	          		 store.load();
	    }}
    ],
	bbar: new Ext.PagingToolbar({
        pageSize: 30,
        store: store,
        displayInfo: true,
        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
        emptyMsg: "没有记录"
	}),
	buttonAlign:'left',
	renderTo:'grid-example'
});

store.load();

var vp=new Ext.Viewport({
    layout: 'fit',
    items: grid
});

});
</script>
<body>
	<div id="grid-example" style="width:100%; height:100%"></div> 
</body>
</html>

