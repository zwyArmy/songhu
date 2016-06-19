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
			{name: 'sessionid'},
			{name: 'username'}, 
			{name: 'account'},   
			{name: 'createtime'},       
			{name: 'loginip'},       
			{name: 'userid'},       
			{name: 'explorer'},       
			{name: 'department'}
         ]
      });
store = new Ext.data.Store({
        url : '/Httpsession/find.do',
        reader: reader,
        listeners:{'beforeload':function(sto, opt){
			sto.baseParams = {
					start:0, 
					limit:30,
					'httpsession.account':Ext.getCmp('cx_account').getValue(),
					'httpsession.username':Ext.getCmp('cx_username').getValue()	
			}
        }}
      });      	
 
var grid = new Ext.grid.GridPanel({
    store: store,
    sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask:({msg :'数据正在加载中……'}), 
    columns: [
        new Ext.grid.RowNumberer(),
		 {header: "会话创建时间",  width: 5,hidden: false, sortable: true, dataIndex: 'createtime',align:'left'},
         {header: "登录账户",  width: 5, sortable: true, dataIndex: 'account',align:'left'},                    
         {header: "姓名", width: 5, sortable: true, dataIndex: 'username',align:'left'},                     
         {header: "所属部门", width: 10, sortable: true, dataIndex: 'department',align:'left'},                      
         {header: "客户端IP", width: 5, sortable: true, dataIndex: 'loginip',align:'left'},                      
         {header: "客户端浏览器", width: 5, sortable: true, dataIndex: 'explorer',align:'left'},                            
         {header: "会话ID", width: 10, sortable: true, dataIndex: 'sessionid',align:'left'} 
    ],
    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
    frame:false,
    autoWidth: true,
    height:orgGrid.getComputedHeight(),
    animCollapse: false,
    iconCls: 'icon-grid',
    tbar:[
    	'登录账户',	
	    {
			xtype:"textfield",				
			id:"cx_account"
		},
		'-',
    	'姓名',	
	    {
			xtype:"textfield",				
			id:"cx_username"
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

