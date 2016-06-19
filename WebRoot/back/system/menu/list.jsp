<%@ page contentType="text/html; charset=UTF-8"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../../ext3.2/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../../resource/css/common.css" />
<link rel="stylesheet" type="text/css" href="../../ext3.2/examples/ux/treegrid/treegrid.css" rel="stylesheet" />
<script type="text/javascript" src="../../ext3.2/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../ext3.2/ext-all.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGridSorter.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGridColumnResizer.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGridNodeUI.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGridLoader.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGridColumns.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/treegrid/TreeGrid.js"></script>
<script type="text/javascript" src="../../ext3.2/examples/ux/CheckColumn.js"></script>
<script type="text/javascript" src="../../script/cook.js"></script>
<script type="text/javascript" src="../../script/theme.js"></script>
</head>
<script language="javascript">

Ext.BLANK_IMAGE_URL="../../ext3.2/resources/images/default/s.gif";
Ext.onReady(function(){
Ext.QuickTips.init();
var orgGrid=Ext.get("grid-example");

var form_tree = new Ext.FormPanel({
      id:'ext-form-del',
      hidden:true,
      renderTo:"grid-example"
})

var tree = new Ext.ux.tree.TreeGrid({
    //title: '系统菜单维护',
    enableSort : false,
    autoClear:true,
    autoScroll:true,
    shadow:true,
    tbar:[
    		{
    			text:'展开',
                iconCls: 'icon-expand-all',
				tooltip: '展开',
                handler: function(){ tree.expandAll() ; },
                scope: this
            }, '-', {
    			text:'收起',
                iconCls: 'icon-collapse-all',
                tooltip: '收起',
                handler: function(){ tree.collapseAll(); },
                scope: this
            }, '-', {
    			text:'刷新',
                iconCls: 'refresh',
                tooltip: '刷新',
                handler: function(){ tree.getRootNode().reload(); },
                scope: this
            }
    ],
    columns:[{
        header: '菜单名称',
        width: 300,
        dataIndex: 'mc'
    },{
        header: '页面地址',
        width: 200,
        dataIndex: 'click'
    },{
        header: '权限类别',
        width: 100,
        dataIndex: 'lb'
    },{
        header: '是否外部系统',
        width: 50,
        dataIndex: 'external'
    },{
        header: '外部系统名称',
        width: 100,
        dataIndex: 'mcSys'
    },{
        header: '启用',
        width: 100,
        dataIndex: 'enabled'
    }],
    listeners:{
    	beforeload :function(node){this.loader.dataUrl="/Menu/findByParent.do?fbh="+node.id;}
    	//load :function(node){this.root.firstChild.expand();}
    	//dblclick:function(node){if(node.id.substring(0,2)=='01') new Ext.ReadWindow({bh:node.id});}   	
    	}
});
new Ext.Viewport({
        layout:'fit',
		deferHeight:true,
        items:tree
}) 
    var menu = new Ext.menu.Menu({
        items:[
        	{text:'添加根节点',iconCls:'add',aid:101,handler:menuhdle},
            {text:'添加子节点',iconCls:'add',aid:102,handler:menuhdle},
            {text:'修改节点',iconCls:'update',aid:103,handler:menuhdle},
            {text:'删除节点',iconCls:'delete',aid:104,handler:menuhdle}
        ]
    });
    var menu_root = new Ext.menu.Menu({
        items:[
            {text:'添加子节点',iconCls:'add',aid:102,handler:menuhdle}
        ]
    });
    tree.on('contextmenu', function(node,e){
    	e.preventDefault();
    	if(node.attributes.fbh.indexOf("###")<0)
    		menu.showAt(e.getXY());
    	else
    	    menu_root.showAt(e.getXY());
    })   
var node_sel=new Ext.tree.TreeNode();
    function menuhdle(itm,e){
    	e.preventDefault();
		node_sel = tree.getSelectionModel().getSelectedNode();
    	switch(itm.aid) {
    	case 101: //添加根节点 
    	   if(node_sel){
			    var path = node_sel.getPath('id');
	    		new Ext.MenuWindow({title:'新增根节点菜单',opFlag:'1',path:path,fbh:node_sel.attributes.fbh});
    	   }else{
    	        Ext.Msg.alert("提示","请选择要添加的菜单节点! ");
    	   }	
    	   break;
    	case 102: //添加子节点
    	   if(node_sel){ 
			    var path = node_sel.getPath('id');
	    	    new Ext.MenuWindow({title:'新增子节点菜单',opFlag:'1',path:path,fbh:node_sel.id});
    	   }else{
    	        Ext.Msg.alert("提示","请选择要添加的菜单节点! ");
    	   } 
    	   break;
    	case 103: //修改节点
    	   if(node_sel){
				var path = node_sel.getPath('id');
	    	    new Ext.MenuWindow({title:'修改菜单信息',opFlag:'2',path:path,bhCd:node_sel.id});
    	   }else{
    	        Ext.Msg.alert("提示","请选择要添加的菜单节点! ");
    	   }
    	   break;
        case 104: //删除节点
           if(node_sel){
           		var path = node_sel.parentNode?node_sel.parentNode.getPath('id'):"";
                Ext.MessageBox.show({
						   title:'提示',
						   msg: '是否确定要删除该菜单节点？ ',
						   buttons: Ext.Msg.YESNO  ,
						   fn: function(conf){
						  	   if(conf=='yes'){
								  Ext.getCmp('ext-form-del').getForm().submit({
                                      url:'/Menu/delete.do',
                                      params:{"menu.bhCd":node_sel.id,path:path},
			                          method:'post',
			                          waitMsg:'数据处理中..',
		                              success:function(form,action){
									        node_sel.destroy();
									        tree.getRootNode().reload();
									        tree.expandPath(action.result.path);					                       
					                   },
			                          failure:function(form,action){
			                               Ext.Msg.alert("提示",action.result.msg);
			                          }
			                      })
								}
							}
				})
           }else{
                Ext.Msg.alert("提示","请选择要删除的记录!");
           }
    	    break;	 
    	}
    }
    
    
Ext.MenuWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"菜单",
	id:"ext-win-menu",
	modal:true,
	width:400,
	height:280,
	initComponent: function(){
		this.items=[
			{
				xtype:"form",
				title:"",
				id:"ext-form-menu",
				labelWidth:100,
				labelAlign:"left",
				layout:"form",
				labelWidth:60,
				height:260,
				frame:true,
				items:[
					{
						xtype:"textfield",
						fieldLabel:"菜单名称",
						id:"mc",
						name:"menu.mc",
						anchor:"95%"
					},
					{
						xtype:"textfield",
						fieldLabel:"排序",
						id:"xh",
						name:"menu.xh",
						anchor:"95%"
					},
					{
						xtype:"textfield",
						fieldLabel:"模块地址",
						id:"click",
						name:"menu.click",
						anchor:"95%"
					},
					{
						xtype:"combo",
						fieldLabel:"外部系统",
						store: new Ext.data.Store({
                               baseParams : {sql:"select '*' dm, '===否===' dmmc from dual union select dm,dmmc from g_dm where zldm='WBXT'"},
                               url : "/Combo/combofind.do",
                               reader : new Ext.data.JsonReader({root: 'root',
                               fields: [
       		                              {name: 'DMMC'},
			                              {name: 'DM'}
                                       ]
                               }),
				              autoLoad:true,
				              listeners:{'load':function(){
				              	Ext.getCmp('lb').getStore().load();
				              }}
                         }),
						displayField:'DMMC',
				        id: 'dmSys',
				        hiddenName:'menu.dmSys',
						editable:false,
		                typeAhead: true,
			            valueField :'DM',
						disabledClass:'x-item-disabledzzz',
		                mode: 'local',
		                triggerAction: 'all',
		                value:this.sdl,
		                emptyText:'请选择',
		                selectOnFocus:true,
						anchor:'95%'
					},
					{
						xtype:"textfield",
						fieldLabel:"功能地址",
						id:"sysUrl",
						name:"menu.sysUrl",
						anchor:"95%"
					},
					{
						xtype:"combo",
						fieldLabel:"权限类别",
						store: new Ext.data.Store({
                               baseParams : {sql1:"select '*' dm, '===无===' dmmc from dual union select dm,dmmc from g_dm where zldm='QXLB'"},
                               url : "/Combo/combofind1.do",
                               reader : new Ext.data.JsonReader({root: 'root',
                               fields: [
       		                              {name: 'DMMC'},
			                              {name: 'DM'}
                                       ]
                               }),
				              listeners:{'load':function(){	 
				              		if(Ext.getCmp('opFlag').getValue()=="2")
										Ext.getCmp('ext-form-menu').form.load({
										          url : '/Menu/get.do',
										          params:{'menu.bhCd':Ext.getCmp('bhCd').getValue()},
										          waitMsg: '正在载入数据...',
										          waitTitle : '提示',
										          success : function(){
										          	   
										          },
										          failure : function() {
										          	Ext.Msg.alert("提示",'载入失败');
										          }
										});
				              }}
                         }),
						displayField:'DMMC',
				        id: 'lb',
				        hiddenName:'menu.lb',
						editable:false,
		                typeAhead: true,
			            valueField :'DM',
						disabledClass:'x-item-disabledzzz',
		                mode: 'local',
		                triggerAction: 'all',
		                value:this.sdl,
		                emptyText:'请选择',
		                selectOnFocus:true,
						anchor:'95%'
					},
					{
						fieldLabel:"启用",
						itemCls: 'required-red',
						id:"enabled",
						hiddenName:"menu.enabled",
						xtype:'combo',
						triggerAction:'all',
						editable:false,
						typeAhead:false,
						mode:'local',
						store:new Ext.data.ArrayStore({
									fields:['txt','val'],
									data:[['启用',1],['关闭',0]]
						}),
						valueField:'val',
						emptyText:'请选择是否使用',
						value:1,								
						displayField:'txt',
						anchor:"95%"
					},
					{
						xtype:"hidden",
						id:"bhCd",
						name:"menu.bhCd",
						value:this.bhCd
					},
					{
						xtype:"hidden",
						id:"fbh",
						name:"menu.fbh",
						value:this.fbh
					},
					{
						xtype:"hidden",
						id:"opFlag",
						value:this.opFlag
					},
					{
						xtype:"hidden",
						id:"path",
						value:this.path
					}
				]
			}
		]
		this.buttons=[
		    {
			  text:'保存',
			  handler:function(){
			    if(Ext.isEmpty(Ext.getCmp("mc").getValue())){
			       Ext.Msg.alert("提示","名称不能为空!");
			    }else{
			        Ext.getCmp('ext-form-menu').getForm().submit({
                                      url:'/Menu/save.do',
			                          method:'post',
			                          waitMsg:'数据处理中...',
		                              success:function(form,action){		                              
			                     			Ext.MessageBox.show({
											          title:'提示',
												       msg: action.result.msg,
												       buttons: Ext.Msg.OK ,
												       fn: function(){
									                     	node_sel.destroy();
									                     	Ext.getCmp('ext-win-menu').destroy();
									                     	tree.getRootNode().reload();
									                     	tree.expandPath(action.result.path);
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
			},
			{
			  text:'关闭',
			  handler:function(){
			    Ext.getCmp('ext-win-menu').destroy();
			  }
			}
			]
		Ext.MenuWindow.superclass.initComponent.call(this);	
		this.show();
	}
})    

});    
</script>
	<body>
		<div id="grid-example" style="width: 100%; height: 100%"></div>
	</body>
</html>
