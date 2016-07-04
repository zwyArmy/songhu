<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
    String bhCd = request.getParameter("cdbh");
    String isPhoto = request.getParameter("isPhoto");
   	User user = com.getSessionUser();
   	String UserCode = user.getUserId();
   	String rl = user.getRigthLevel();
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
	<link rel="stylesheet" type="text/css" href="../../../resource/extjs/resources/css/ext-all.css" /> 
    <link rel="stylesheet" type="text/css" href="../../../resource/css/default.css" /> 
	<link rel="stylesheet" type="text/css" href="../../../resource/css/ext_icon.css" />
	<link rel="stylesheet" type="text/css" href="../../../resource/myux/datatimefield/css/Spinner.css" />
	<script type="text/javascript" src="../../../resource/extjs/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="../../../resource/extjs/ext-all.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/ext-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/cook.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/mytools.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/DateTimeField.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/Spinner.js"></script>
	<script type="text/javascript" src="../../../resource/myux/datatimefield/SpinnerField.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/treecombo.js"></script>
	<script type="text/javascript" src="window2.js"></script>
	<script type="text/javascript" src="window3.js"></script>
	<script type="text/javascript" src="window4.js"></script>
	<script type="text/javascript" src="window5.js"></script>
	<script type="text/javascript" src="window6.js"></script>
	<script type="text/javascript" src="../../../resource/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="../../../resource/ckfinder/ckfinder.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/upload/swfupload.js"></script>
    <script type="text/javascript" src="../../../resource/commonjs/upload/uploaderPanel.js"></script>
  </head>
<script language="javascript">
Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var rl = '<%=rl%>';
var bhCd = '<%=bhCd%>';
Ext.onReady(function(){
	//CKEDITOR.on('instanceReady', CKinstanceReady);
	var orgGrid=Ext.get("grid-example");
	var form_delete = new Ext.FormPanel({
		id:'ext-form-delete',
		hidden:true,
		//renderTo:Ext.getBody()
		renderTo:"grid-example"
}
);
	store = new Ext.data.Store({
		url:'../../../articleController.do?find',
		reader:new Ext.data.JsonReader({
			root:'root',
			totalProperty:'totalProperty',
			fields:[
					{name:'id'},
					{name:'title'},
					{name:'author'},
					{name:'columnId'},
				 	{name:'createTime'},
					{name:'publishTime'},
					{name:'creator'},
					{name:'isTop'},
					{name:'state'},
					{name:'content'},
					{name:'wordPath'},
					{name:'views'},
					{name:'auditTime'},
					{name:'summary'},
					{name:'auditor'}
			]
		}),
		listeners:{'beforeload':function(sto,opt){
			sto.baseParams = {
				start:0,
				limit:30,
				columnId:'<%=bhCd%>'
		}
		}
	}}
	);
	var grid = new Ext.grid.GridPanel({
		store:store,
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
			loadMask:({msg:'数据正在加载中......'}),
		columns: [
			new Ext.grid.RowNumberer(),
			{header:"查看",width:40,fixed:true,menuDisabled:true,sortable:false,algin:'center',dataIndex:'ck',renderer:function(){
			return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/page.png"/></span>';
			}},
			{header: "文章编号",  width: 5,hidden: true, sortable: true, dataIndex: 'id'},
			{header:"标题",width:30,hidden:false,sortable:true,dataIndex:'title',align:'left'},
			{header:"创建人",width:8,sortable:true,dataIndex:'creator',algin:'left'},
			{header:"创建时间",width:8,sortable:true,dataIndex:'createTime',algin:'center',renderer:function(val){return new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"审核人员",width:8,sortable:true,dataIndex:'auditor',algin:'left',hidden: true},
			{header:"审核时间",width:8,sortable:true,dataIndex:'auditTime',hidden: true,algin:'center',renderer:function(val){ return val==null?'':new Date(val).dateFormat('Y-m-d H:i');}},
			{header:"状态",width:8,sortable:true,hidden: true,dataIndex:'state',algin:'left',renderer:function(val){
			switch(val)
			{
			    case '0':
			    return "<font color=blue>未审核</font>";break;
			    case '1':
			    return "<font color=green>审核通过</font>";break;
			    case '3':
			    return "<font color=red>审核未通过</font>";break;
			}}},
			{header:"是否置顶",width:8,sortable:true,dataIndex:'isTop',algin:'center',renderer:function(val){
			switch(val)
			{
			    case '0':
			    return "<font color=red>是</font>&nbsp;&nbsp;<span style='cursor:pointer;color:blue'>[取消置顶]<span>";break;
			    case '1':
			    return "<font color=green>否</font>&nbsp;&nbsp;<span style='cursor:pointer;color:red'>[设置置顶]<span>";break;
			}}},
		  {header:"移动栏目",width:80,fixed:true,menuDisabled:true,sortable:false,algin:'center',dataIndex:'isMove',renderer:function(){
			return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/edit.png"/></span>';
			}}
		],
		frame:false,
		autoWidth:true,
		height:orgGrid.getComputedHeight(),
	    animCollapse: false,
		tbar:[
		{text:'发表',iconCls:'add', tooltip:'发表文章',
		  handler:function(){
	           		new Ext.ArticleWindow2({title:"", cz:"1",isPhoto:'<%=isPhoto%>',view:false,columnId:'<%=bhCd%>',author:'嵩湖环保服务网'});
	        }},
		'-',
		{text:'修改',iconCls:'update', tooltip:'修改文章',
	          handler:function(){
	          		var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 修 改 的 记 录！');
					}
					else if((rec.data['creator']=='<%=UserCode%>'&&rec.data['state']!='1')||rl=='3')
					{
	
						new Ext.ArticleWindow2({title:"", cz:"0",view:false,articleId:rec.data['id'],rec:rec});
					}
					else if(rec.data['creator']!='<%=UserCode%>')
					{
						Ext.Msg.alert('提示','发表人非当前登录用户不能修改！');
	          		}
	          		else if(rec.data['state']=='1')
	          		{
	          		    Ext.Msg.alert('提示','发表人的文章审核已通过不可修改！');
	          		}
	        }},
		'-',
		{text:'删除',iconCls:'delete', tooltip:'删除文章',
		handler:function(){
	                var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 文 章！');
					}
					else if(rec.data['creator']=='<%=UserCode%>'||rl=='3'){
					    Ext.MessageBox.show({
					               title:'提示',
					               msg: '<font color=red>是否确定要删除该篇文章？</font><br/><br/> ',
					               buttons: Ext.Msg.YESNO  ,
					               fn: function(conf){
					                 if(conf=='yes'){
										Ext.getCmp('ext-form-delete').getForm().submit({
								                  url:'../../../articleController.do?delete',
								                  params:{"id":rec.data['id']},
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
														animEl: 'elId',
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
	          		else if(rec.data['creator']!='<%=UserCode%>')
					{
						Ext.Msg.alert('提示','发表人非当前登录用户不能删除！');
	          		}
	        }},
		'-',
		'标题:',
		{
			xtype:"textfield",
			id:"cx_title",
			width:100
		},
		'-',
		{text:'查询',iconCls:'search', tooltip:'查询文章',
	          handler:function(){
	          		store.load({params:{title:Ext.getCmp("cx_title").getValue()}});
		}},
		'-',
		{
			text:'清空',
			tooltip:'清空查询条件',
			iconCls:'tbar_synchronizeIcon',
			handler:function(){
				Ext.getCmp("cx_title").reset();
			}
		}
		
		],
		bbar: new Ext.PagingToolbar({
	        pageSize: 30,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
		}),
		buttonAlign:'left',
		renderTo:'grid-example',
		viewConfig:{forceFit:true,templates:{cell:gridCopy}}
	}
	);
   grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store = grid.getStore();
				var record = store.getAt(rowIndex);
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
			   	if(fieldName=='ck'){
					new Ext.ArticleckWindow({yy:record.data['id'],view:false});
				}else if(fieldName=='isTop'){
					 var isTop = record.data['isTop'];
				     var msg = isTop=='1'?'<font style="color:#15428B;font-weight:bold;text-align:center;">是否确定要将该篇文章置顶？</font>':'<font style="color:#15428B;font-weight:bold;text-align:center;">是否确定要取消该篇文章置顶？</font>';
					 Ext.MessageBox.show({
					       title:'提示',
					       msg: msg,
					       buttons: Ext.Msg.YESNO  ,
					       fn: function(conf){
					            if(conf=='yes'){
										Ext.getCmp('ext-form-delete').getForm().submit({
								                  url:'../../../articleController.do?update',
								                  params:{"id":record.data['id'],"isTop":isTop=='1'?'0':'1'},
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
														animEl: 'elId',
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
				if(fieldName=='isMove'){
				Ext.Ajax.request({
				url:'../../../menuController.do?get',
				params:{"bhCd":record.data['columnId']},
				success:function(response,opts){
				var respText = Ext.util.JSON.decode(response.responseText);
				new Ext.ArticleckWindow4({moveId:record.data['id'],mc:respText.data['mc']});
				},
				failure: function(resp,opts) {   
                             var respText = Ext.util.JSON.decode(resp.responseText);   
                             Ext.Msg.alert('错误', respText.error);   
                      }  
				});
				}
	});
	store.load({params:{'columnId':'<%=bhCd%>',start:0,limit:30}});
	new Ext.Viewport({
				layout : 'fit',
				deferHeight:true,
				region:'center',
				border:false,
				items : [grid]
			});
});
</script>
  <body>
  	<div id="grid-example" style="width:100%;height:100%"></div>
  </body>
</html>
