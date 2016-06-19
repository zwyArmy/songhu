<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	User user = com.getSessionUser();
   	String rl = user.getRigthLevel();
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
var deptid='<%=GS_DeptId%>',dept='<%=GS_DeptName%>',rl='<%=rl%>';
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
	        id:deptid
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
				store.load({params:{'dmBm':deptid,start:0,limit:30}});
				grid.setTitle("岗位信息-"+dept);
			});

	store = new Ext.data.Store({
        url : '../../../roleController.do?find',
        reader: new Ext.data.JsonReader({
				totalProperty : 'totalProperty',
				root : 'root',
				fields: [
					{name : 'dmGw'}, 
					{name : 'mcGw'},
					{name : 'locked'}, 
					{name : 'lx'},
					{name : 'sx'},
					{name : 'dmBm'},
					{name : 'mcBm'},
					{name : 'sq'},
					{name : 'bz'}
				]
		})
      });

	var sm=new Ext.grid.CheckboxSelectionModel({onHdMouseDown:hd});
	var grid = new Ext.grid.GridPanel({
		title:"岗位信息-"+dept,
	    iconCls: 'award_star_silver_3Icon',
	    store: store,
		loadMask:({msg :'数据正在加载中……'}), 
	    columns: [
	        new Ext.grid.RowNumberer(),
	        sm,	
	       	{header: "授权", fixed:true, width: 40, menuDisabled:true, sortable: true, dataIndex: 'sq', align:'center',renderer:function(val){
	         			if(val=='0')
	         				return '<span style="cursor:pointer"><img src="../../../resource/image/ext/edit2.png"/></span>';
	         			else
	         				return '<span style="cursor:pointer;"><img src="../../../resource/image/ext/edit1.png"/></span>'
	         		}
	         }, 
			 {header: "岗位名称",  width: 10, sortable: true, dataIndex: 'mcGw'},
	         {header: "岗位类型",  width: 5, sortable: true, dataIndex: 'lx', align:'center', renderer:function(val){
			        	switch(val){
			        		case '1':
			        			return "<font color=green>业务岗位</font>";
			        		case '2':
			        			return "<font color=blue>管理岗位</font>";
			        		case '3':
			        			return "<font color=red>系统内置</font>";
			        	}
	         					
	         }}, 
	         {header: "岗位属性",  width: 5, sortable: true, dataIndex: 'sx', align:'center', renderer:function(val){
			        	switch(val){
			        		case '1':
			        			return "<font color=blue>普通</font>";
			        		case '2':
			        			return "<font color=red>公共</font>";
			        	}
	         					
	         }},                                       
	         {header: "所属机构", width: 10, sortable: true, dataIndex: 'mcBm'},                      
	         {header: "岗位状态", width: 5, sortable: true, dataIndex: 'locked', align:'center',renderer:function(val){return val=='0'?'<font color=green>激活</font>':'<font color=red>锁定</font>'}},                                    
	         {header: "备注", width: 10, sortable: true, dataIndex: 'bz'}                                     
	         
	    ],
	    sm: sm,
	    viewConfig: {forceFit:true,templates:{cell:gridCopy}},
	    frame:false,
	    animCollapse: false,
	    tbar:[
	        {text:'添加',iconCls:'add', tooltip:'新增岗位信息',
	          handler:function(){
	              new Ext.RoleWindow({title:"新增岗位信息", cz:"1"});
	        }},
	        '-',
	        {text:'修改',iconCls:'update', tooltip:'修改岗位信息',
	          handler:function(){
	          				var rec = grid.getSelectionModel().getSelected();
										if(!rec){
										    Ext.Msg.alert('提示','请选择要修改的记录！');
										 }else{
										 	if(rec.data['lx']=='3')
										 		Ext.Msg.alert('提示','系统内置岗位不允许修改！');
										 	else
									        new Ext.RoleWindow({title:"修改岗位信息", cz:"0",rec:rec});
	          					         }
	        }},
	        '-',
	        {text:'删除',iconCls:'delete', tooltip:'删除岗位信息',
	          handler:function(){
	          	var recs = grid.getSelectionModel().getSelections();
    			if(recs.length>0){
	    			var arr="";
	    			for(var i=0,len=recs.length;i<len;i++){
	    				if(recs[i].data['lx']!='3'){
	    					arr += recs[i].data['dmGw']+",";
	    				}
	    			}
	    			Ext.MessageBox.show({
					        title:'提示',
					        msg: '<span style="color:red">删除岗位将同时删除和岗位相关的权限信息,请慎重.</span><br>继续删除吗? ',
					        buttons: Ext.Msg.YESNO  ,
					        fn: function(conf){
					          if(conf=='yes'){
									form_delete.getForm().submit({
								              url:'../../../roleController.do?delete', 
								              params:{gwList:arr},
										      method:'post',
										      waitMsg:'数据处理中..',
									          success:function(form,action){
									          		 store.load({params:{'dmBm':deptid}});			                       
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
	        {
				xtype:"textfield",				
				id:"cx_mcGw",
				emptyText : '请输入岗位名称'
			},
	        {text:'查询',iconCls:'search', tooltip:'查询',
	          handler:function(){
	          		        store.load({params:{
				          		        start:0, 
										limit:30,
										'mcGw':Ext.getCmp('cx_mcGw').getValue(),
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
				if (fieldName == 'sq' && columnIndex == 2) {
					new Ext.RoleGrantWindow({gw:record.data['dmGw'],bm:record.data['dmBm'],bmmc:record.data['mcBm']});
				}
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
			});

});

</script>
<body>
</body>
</html>

