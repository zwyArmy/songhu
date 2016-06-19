<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	User user = com.getSessionUser();
	String GS_DeptId = user.getDeptId();
	String GS_DeptName = user.getDeptName();
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="../../../resource/extjs/resources/css/ext-all.css" /> 
    <link rel="stylesheet" type="text/css" href="../../../resource/css/default.css" /> 
	<link rel="stylesheet" type="text/css" href="../../../resource/css/ext_icon.css" />
	<script type="text/javascript" src="../../../resource/extjs/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="../../../resource/extjs/ext-all.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/ext-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/cook.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/mytools.js"></script>
	<script type="text/javascript" src="../../../resource/commonjs/treecombo.js"></script>
	<script type="text/javascript" src="window.js"></script>
	<script type="text/javascript" src="window_grant.js"></script>
</head>
<script language="javascript">

Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var deptid='<%=GS_DeptId%>',dept='<%=GS_DeptName%>';
Ext.onReady(function(){
	var form_delete = new Ext.FormPanel({
	      id:'ext-form-delete',
	      hidden:true,
	      renderTo: Ext.getBody()
	})
 	var tree = new Ext.tree.TreePanel({
		id:'tree_menu',
        autoScroll:true,
        animate:true,
        containerScroll: true,
        root: new Ext.tree.AsyncTreeNode({
	        text: dept,
	        draggable:false,
	        expanded:true,
	        id: deptid
		}),
        loader:new Ext.tree.TreeLoader({
        	dataUrl:'../../../departController.do?findByParent',
        	listeners:{'beforeload': function(treeLoader, node){
        		treeLoader.baseParams = {id: node.id};
        	}}
        }),
        rootVisible:true,
		collapsed:false
	});	


	tree.on('click', function(node) {
				deptid = node.attributes.id;
				dept = node.attributes.text;
				store.load({params:{
					start:0, 
					limit:30,
					'dmCzy':Ext.getCmp("cx_dmCzy").getValue(),
					'xmCzy':Ext.getCmp("cx_xmCzy").getValue(),
					'dmBm':deptid}});
				grid.setTitle("人员信息-"+dept);
			});

	store = new Ext.data.Store({
	        url : '../../../operatorController.do?find',
	        reader: new Ext.data.JsonReader({
				root: 'root',
				totalProperty: 'totalProperty',
			  	fields: [		
						{name: 'dmCzy'},
						{name: 'xmCzy'},   
						{name: 'dmBm'},  
						{name: 'bmmc'},
						{name : 'sq'},
						{name : 'kl'},
						{name : 'lxdh'}
			         ]
		     })
	 }); 
	
	var grid = new Ext.grid.GridPanel({
		title:"人员信息-"+dept,
		iconCls: 'group',
	    store: store,
	    sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
			loadMask:({msg :'数据正在加载中……'}), 
	    columns: [
	        new Ext.grid.RowNumberer(),	
	       	{header: "授权", fixed:true, width: 40, menuDisabled:true, sortable: true, dataIndex: 'sq', align:'center',renderer:function(val){
	         			if(val=='0')
	         				return '<span style="cursor:pointer"><img src="../../../resource/image/ext/edit2.png"/></span>';
	         			else
	         				return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/edit1.png"/></span>'
	         		}
	         }, 
			 {header: "人员代码",  width: 5,hidden: false, sortable: true, dataIndex: 'dmCzy'},
	         {header: "人员姓名",  width: 5, sortable: true, dataIndex: 'xmCzy'},                  
	         {header: "手机号码", width: 5, sortable: true, dataIndex: 'lxdh'},                   
	         {header: "部门名称", width: 10, sortable: true, dataIndex: 'bmmc'}
	    ],
	    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
	    frame:false,
	    autoWidth: true,
	    animCollapse: false,
	    tbar:[
	        '-',
	        {text:'添加',iconCls:'add', tooltip:'添加操作人员信息',
	          handler:function(){
	           		new Ext.OperatorWindow({title:"新增操作人员信息", cz:"1"});
	        }},
	        '-',
	        {text:'修改',iconCls:'update', tooltip:'修改操作人员信息',
	          handler:function(){
	          		var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 修 改 的 表 单！');
					}else{
						new Ext.OperatorWindow({title:"修改操作人员信息", cz:"0",rec:rec});
	          		}
	        }},
	        '-',
	        {text:'删除',iconCls:'delete', tooltip:'删除操作人员信息',
	          handler:function(){
	                var rec = grid.getSelectionModel().getSelected();
					if(!rec){
						Ext.Msg.alert('提示','请 选 择 要 删 除 的 表 单！');
					}else{
					    Ext.MessageBox.show({
					               title:'提示',
					               msg: '<font color=red>将删除该人员及相关的记录!</font><br/><br/>是否确定要删除该人员信息？ ',
					               buttons: Ext.Msg.YESNO  ,
					               fn: function(conf){
					                 if(conf=='yes'){
										Ext.getCmp('ext-form-delete').getForm().submit({
								                  url:'../../../operatorController.do?delete',
								                  params:{"dmCzy":rec.data['dmCzy']},
											      method:'post',
											      waitMsg:'数据处理中..',
										          success:function(form,action){		                              
											              Ext.MessageBox.show({
																title:'提示',
																msg: action.result.msg,
																buttons: Ext.Msg.OK ,
																fn: function(){
																    store.load({params:{'dmBm':rec.data['dmBm']}});
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
	        }},
	        '->',
	        {
				xtype:"textfield",			
				id:"cx_dmCzy",
				emptyText : '请输入人员代码'
			},
	        '-',
	        {
				xtype:"textfield",			
				id:"cx_xmCzy",
				emptyText : '请输入人员姓名'
			},
	        {text:'查询',iconCls:'search', tooltip:'查询任务表单',
	          handler:function(){
	          		        store.load({params:{
				          		        start:0, 
										limit:30,
										'dmCzy':Ext.getCmp("cx_dmCzy").getValue(),
										'xmCzy':Ext.getCmp("cx_xmCzy").getValue(),
										'dmBm':deptid
				          		}});
	        }}
	    ],
		bbar: new Ext.PagingToolbar({
	        pageSize: 30,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
		}),
		buttonAlign:'left'
	});
	
	grid.on("cellclick", function(grid, rowIndex, columnIndex, e) {
				var store = grid.getStore();
				var record = store.getAt(rowIndex);
				var fieldName = grid.getColumnModel().getDataIndex(columnIndex);
				if (fieldName == 'sq' && columnIndex == 1) {
					new Ext.OperatorGrantWindow({czy:record.data['dmCzy'],bm:record.data['dmBm'],bmmc:record.data['bmmc']});
				}
	});	
    	
	store.load({params:{'dmBm':deptid,start:0,limit:30}});
	
	new Ext.Viewport({
				layout : 'border',
				items : [{
							title : '<span class="commoncss">组织机构</span>',
							iconCls : 'chart_organisationIcon',
							tools : [{
										id : 'refresh',
										handler : function() {
											tree.root.reload()
										}
									}],
							collapsible : true,
							width : 250,
							minSize : 160,
							maxSize : 350,
							split : true,
							region : 'west',
							autoScroll : true,
							layout:'fit',
							items : [tree]
						}, {
							region : 'center',
							layout : 'fit',
							border : false,
							items : [grid]
						}]
			});;





});
</script>
<body>
</body>
</html>

