<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	User user = com.getSessionUser();
	String rl = user.getRigthLevel(); 
	String G_DeptName = user.getDeptName();
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
</head>
<script language="javascript">

Ext.BLANK_IMAGE_URL="../../../resource/extjs/resources/images/default/s.gif";
var store;
var tree;
var deptid=0;
var dept="";
var path;
Ext.onReady(function(){
	var form_delete = new Ext.FormPanel({
	      id:'ext-form-delete',
	      hidden:true,
	      renderTo: Ext.getBody()
	})
 	tree = new Ext.tree.TreePanel({
		id:'tree_menu',
        autoScroll:true,
        animate:true,
        containerScroll: true,
        root: new Ext.tree.AsyncTreeNode({
	       	text:'嵩湖环保服务网',
	        draggable:false,
	        expanded:true,
	        id: '0'
		}),
        loader:new Ext.tree.TreeLoader({
        	dataUrl:'../../../columnController.do?findByParent',
        	listeners:{'beforeload': function(treeLoader, node){
        		treeLoader.baseParams = {id: node.id};
        	}}
        }),
        rootVisible:true,
		collapsed:false
	});	


	tree.on('click', function(node) {
				path = node.getPath('id');
				deptid = node.attributes.id;
				dept = node.attributes.text;
				store.load({params:{'parentId':deptid,start:0,limit:30}});
				grid.setTitle("栏目-"+dept);
			});

	store = new Ext.data.Store({
        url : '../../../columnController.do?find',
        reader: new Ext.data.JsonReader({
				totalProperty : 'totalProperty',
				root : 'root',
				fields: [
					{name : 'id'}, 
					{name : 'colName'},
					{name : 'parentId'}, 
					{name : 'sort'},
					{name : 'enabled'},
					{name : 'description'},
					{name : 'link'},
					{name : 'lmdm1'},
					{name : 'lmdm2'}
				]
		}),
        listeners:{'beforeload':function(sto, opt){
			sto.baseParams = {
					start:0, 
					limit:30,
					'parentId':deptid	
			}
        }}
      });

	var sm=new Ext.grid.CheckboxSelectionModel({onHdMouseDown:hd});
	var grid = new Ext.grid.GridPanel({
		title:"栏目--"+dept,
	    iconCls: 'award_star_silver_3Icon',
	    store: store,
		loadMask:({msg :'数据正在加载中……'}), 
	    columns: [
	       	new Ext.grid.RowNumberer(),
	         sm,	 
	         {header: "排序",  width: 50,fixed:true, sortable: true, dataIndex: 'sort',align:'right'}, 
			 {header: "栏目编号",  width: 10, sortable: true, dataIndex: 'id',align:'center'},                   
	         {header: "栏目名称", width: 30, sortable: true, dataIndex: 'colName'},                      
	         {header: "描述", width: 30, sortable: true, dataIndex: 'description'} ,
	         {header: "链接", width: 30, sortable: true, dataIndex: 'link'},
	         {header: "一级类目代码", width: 30, hidden:true,sortable: true, dataIndex: 'lmdm1'},
	         {header: "二级类目代码", width: 30, hidden:true,sortable: true, dataIndex: 'lmdm2'},
	         {header: "是否显示", width: 10, sortable: true, dataIndex: 'enabled',align:'center',renderer:function(val){return val==1?"<font color=blue>显示</font>":"<font color=red>不显示</font>";}}                                  
	    ],
	    sm: sm,
	    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
	    frame:false,
	    animCollapse: false
	    <%if(rl.equals("3")){%>
	    ,tbar:[
	        {text:'添加',iconCls:'add', tooltip:'新增栏目信息',
	          handler:function(){
	              if(dept=="")
	              	Ext.Msg.alert('提示','请选择左侧的栏目！');
	              else
	              	new Ext.ColumnWindow({title:"新增栏目信息", cz:"1",parentId:deptid,rl2:'<%=rl%>'});
	        }},
	        '-',
	        {text:'修改',iconCls:'update', tooltip:'修改栏目信息',
	          handler:function(){
	          				var rec = grid.getSelectionModel().getSelected();
										if(!rec){
										    Ext.Msg.alert('提示','请选择要修改的记录！');
										 }else{
									        new Ext.ColumnWindow({title:"修改栏目信息", cz:"0",rec:rec,parentId:deptid,rl2:'<%=rl%>'});
	          					         }
	        }},
	        '-',
	        {text:'删除',iconCls:'delete', tooltip:'删除栏目信息',//hidden:true,
	        handler:function(){
	          	var recs = grid.getSelectionModel().getSelections();
    			if(recs.length>0){
	    			var arr="";
	    			for(var i=0,len=recs.length;i<len;i++){
	    				arr += recs[i].data['id']+",";
	    			}
	    			Ext.MessageBox.show({
					        title:'提示',
					        msg: '<span style="color:red">删除栏目信息,请慎重!<br>继续删除吗?</span>  ',
					        buttons: Ext.Msg.YESNO  ,
					        fn: function(conf){
					          if(conf=='yes'){
									form_delete.getForm().submit({
								              url:'../../../columnController.do?delete',
								              params:{gwList:arr},
										      method:'post',
										      waitMsg:'数据处理中..',
									          success:function(form,action){
									          		  store.load(); 
									          		  tree.root.reload();
													  tree.expandPath(path);			                       
											  },
										      failure:function(form,action){
										               Ext.Msg.alert("提示",action.result.msg);
										      }
									}) 
					    		}
					  		}
					})
	    		}else{
	    			Ext.Msg.alert("提示","请选择要删除的记录！");
	    		}
	        }},
	        
	        '->',
	        {text:'<span style="color:red">一级栏目不能超过九个，请慎重添加显示</span>'}
	    ]
	    <%}%>
		,bbar: new Ext.PagingToolbar({
	        pageSize: 30,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
		}),
		buttonAlign:'left'
	});
	function hd(e,t){
		  if(t.className == 'x-grid3-hd-checker'){
	            e.stopEvent();
	            var hd = Ext.fly(t.parentNode);
	            var isChecked = hd.hasClass('x-grid3-hd-checker-on');
	            if(isChecked){
	                hd.removeClass('x-grid3-hd-checker-on');
	                this.clearSelections();
	            }else{
	                hd.addClass('x-grid3-hd-checker-on');
	                this.selectAll();
	            }
	        }
			
	}
	
	store.load({params:{'parentId':deptid,start:0,limit:30}});

	new Ext.Viewport({
				layout : 'border',
				items : [{
							title : '<span class="commoncss">栏目信息</span>',
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
			});

});

</script>
<body>
</body>
</html>

