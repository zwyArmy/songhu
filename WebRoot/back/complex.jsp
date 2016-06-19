<%@ page contentType="text/html;charset=UTF-8"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("GBK");
%>
<%@page import="com.weixin.core.vo.User" %>
<jsp:useBean id="com" scope="page" class="com.weixin.core.util.Tools" type="com.weixin.core.util.Tools"></jsp:useBean>
<%	String title="嵩湖环保服务网";
	User user = com.getSessionUser();	
	String GS_UserId;
	String GS_UserName;
	String GS_DeptId;
	String GS_DeptName;
	if(null==user){
		out.println("<script>alert('非法用户登录');</script>");
		return;
	}else{
		GS_UserId = user.getUserId();
		GS_UserName = user.getUserName();
		GS_DeptId = user.getDeptId();
		GS_DeptName = user.getDeptName();
	}
%>
<html>
<head>
  <title><%=title%></title>  
  <link rel="stylesheet" type="text/css" href="../resource/extjs/resources/css/ext-all.css" />
  <link rel="stylesheet" type="text/css" href="../resource/css/ext_icon.css" />
  <link rel="stylesheet" type="text/css" href="../resource/css/default.css" /> 
  <script type="text/javascript" src="../resource/extjs/adapter/ext/ext-base.js"></script>
  <script type="text/javascript" src="../resource/extjs/ext-all.js"></script>
  <script type="text/javascript" src="../resource/commonjs/ext-lang-zh_CN.js"></script>
  <script type="text/javascript" src="../resource/commonjs/complex.js"></script>
  <script type="text/javascript" src="../resource/commonjs/cook.js"></script>
  <script type="text/javascript" src="../resource/commonjs/extTabCloseMenu.js"></script>
  <script type="text/javascript" src="../resource/commonjs/patch_png_background.js"></script>
<script type="text/javascript">
try{
	var theme=GetCookie('theme');
	theme = (theme==null)?'default':theme;
	Ext.util.CSS.swapStyleSheet('theme', '../resource/theme/'+theme+'/resources/css/ext-all.css');
}catch(e){
}
var maintab;
var mytil;
var bread="";
Ext.BLANK_IMAGE_URL ='../resource/extjs/resources/images/default/s.gif';

if(window.screen){
	window.moveTo(0,0);
	window.resizeTo(screen.availWidth,screen.availHeight);
}

var GS_UserId = '<%=GS_UserId%>';
var GS_UserName = '<%=GS_UserName%>';
Ext.onReady(function(){	
var htip = document.body.clientHeight;
var wtip = document.body.clientWidth;
   Ext.QuickTips.init();
   //定义主窗口maintab        
	maintab = new Ext.TabPanel({
        region:'center',
        deferredRender:false,
        activeTab:0,
		//split:true,
		enableTabScroll:true,
		plugins: new Ext.ux.TabCloseMenu(),
        items:[{
            contentEl:'center1',
            title: '我的工作台',
			id:'tab-main',
            closable:false,
			iconCls: 'home',
            autoScroll:true
         }]
     })
     
 	var tree = new Ext.tree.TreePanel({
		id:'tree_menu',
        autoScroll:true,
        animate:true,
        containerScroll: true,
        root: new Ext.tree.AsyncTreeNode({
	        text: '<%=title%>',
	        draggable:false,
	        id:'001' 
		}),
        loader:new Ext.tree.TreeLoader({
        	dataUrl:'../menuController.do?findByNode',
        	listeners:{'beforeload': function(treeLoader, node){
        		treeLoader.baseParams = {fbh: node.id};
        	}}
        }),
        listeners:{'click':function(node){
        	bread="";
        	findParentNode(node);
        	bread = bread+node.attributes.text;
        	//Ext.getCmp('defTitle').setTitle(bread+node.attributes.text);
        }},
        rootVisible:false,
		collapsed:false,
		tbar:[{
                iconCls: 'icon-expand-all',
				tooltip: '展开',
                handler: function(){ tree.expandAll() ; },
                scope: this
            }, '-', {
                iconCls: 'icon-collapse-all',
                tooltip: '收起',
                handler: function(){ tree.collapseAll(); },
                scope: this
            }]
	});	
	   
	//定义网页视窗	  
    var viewport = new Ext.Viewport({
            layout:'border',                        //选择'border'样式
            items:[
                {              //定义框架“上方栏”
                	xtype:'panel',
                    region:'north',
                    id:'north-panel',
                    contentEl: 'north',
                    collapsible:true,
                    layout:'fit',
                    title:'<%=title%>',
					border:false
                },{              
                    region:'south',
                    contentEl: 'south',
					split:false,
					baseCls:'tbar',
                    collapsible: false,
					header:false,
					tbar: [
						{iconCls:'comments'},
						'欢迎您,<%=GS_UserName%>!&nbsp;&nbsp; 账户:<%=GS_UserId%>&nbsp;&nbsp;机构:<%=GS_DeptName%>',
						{xtype:"tbfill"},
						'Copyright&nbsp;&copy;&nbsp;2016&nbsp;&nbsp;&nbsp;zwyArmy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'						
					],
                    margins:'0 0 0 0'
                },			 
				{
					xtype:'panel',
                    region:'west',                  // 定义左导航栏
                    id:'west-panel',
					contentEl: 'west',
					title:'功能导航',
                    split:true,
                    width: 215,
                    minSize: 215,
                    maxSize: 500,
					iconCls: 'navi',
                    collapsible: true,
                    margins:'0 0 0 5',
	                layout:'fit',
	                items:[tree]
                },
                {                                //  添加‘主窗口’ 
					xtype:'panel',   
                    region:'center', 
                    id:'defTitle', 
					iconCls: 'tux',
                    title:'<%=title%>',
	                layout:'fit',
	                items:[maintab]
                } 
             ]
        });
        
        document.getElementById("worktop").src = "./blank.html";

   		maintab.on("beforetabchange",function(t,n,c){
   		     if(n.id == 'tab-main')
   		     	Ext.getCmp('defTitle').setTitle('<%=title%>');
   		     else
   		     	Ext.getCmp('defTitle').setTitle(n.bread);  
         });
       
 });


function findParentNode(node){
	var parentNode = node.parentNode;
	if(parentNode != null){
		bread =parentNode.attributes.text+">>"+bread;
		findParentNode(parentNode)
	}
}


function addTab(mid,mytil,myhtm){
	if(!Ext.getCmp('tab-'+mid)){   	  
		var tab= maintab.add({
	           	title: mytil,
				id:'tab-'+mid,
				bread:bread,
	           	iconCls: 'mytabs',
				autoScroll:true,
				autoTabs:true,
	           	closable:true
	     });
		tab.show();
		var frm = Ext.DomHelper.append(tab.body, {tag: 'div', id: 'test1'});
		frm.innerHTML=myhtm;
	}else{
		maintab.setActiveTab(Ext.getCmp('tab-'+mid));
	}
}	

function logout(){	
	Ext.Ajax.request({   
		url: '../loginController.do?logout',	   
		success: function (response, opts) {
			document.location="../back/login.jsp";
		}
	});
}
function help(){
  var myhtm="<iframe height=100% width=100% src='resource/help.html' frameborder=0 scrolling='yes' id=xtbz></iframe>";
  addTab("help","系统帮助",myhtm);
}

function showMessage(msg){
	Ext.Msg.alert('提示',msg);
}

function fullScreen(){
  window.opener = null;
  var win = window.open('complex.jsp','_blank','top=0,left=0,location=no,status=yes,menubar=no,toolbar=no,scrollbars=no,resizeable=yes,'
  			+'height='+(screen.availHeight-30)+',width='+screen.availWidth);
  self.close();
}

var mycheck=function(mid,mc,src){
	if(src!=""){
		 src = src.indexOf('?')>-1? src+"&cdbh="+mid:src+"?cdbh="+mid;
		 var myhtm="<iframe height=100% width=100% src="+src+" frameborder=0 scrolling='auto' id="+mc+"></iframe>";
		 addTab(mid, mc,myhtm);
	}
}
//消息提示框

var showbox = false;//是否已经显示提示框
MsgTip = function(){
    var msgCt;
    var pauseTime;
    function createBox(t, s){
        return ['<div class="msg">',
                '<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
                '<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc" style="font-size=12px;"><h3>', t, '</h3>', s, '</div></div></div>',
                '<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
                '</div>'].join('');
    }
    return {
        msg : function(title, message,autoHide,pauseTime,w,h){
        	if(!showbox){
	            msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div22',style:'position:absolute;width:250px;margin: '+h+' '+w+';z-index:20000;'}, true);
	            msgCt.alignTo(document, 't-t');
	            //给消息框增加一个关闭按钮
	           
	            var m = Ext.DomHelper.append(msgCt, {html:createBox(title, message)}, true);
	            m.slideIn('t');
	            if(!Ext.isEmpty(autoHide)&&autoHide==true){
	             if(Ext.isEmpty(pauseTime)){
	              pauseTime=5;
	             }
	              m.pause(pauseTime).ghost();
	            }
	            showbox = true;
            }
            setTimeout(function(){showbox=false;},pauseTime*1000);  
        },
        hide:function(v){
         var msg=Ext.get(v.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement);
         msg.ghost("tr", {remove:true});
         showbox = false;
        }
    };
}();

window.onbeforeunload = function(){
	var n=window.event.screenX - window.screenLeft;
	var b = n > document.documentElement.scrollWidth - 20;
	if( b && window.event.clientY<0 || window.event.altKey ){
		logout();
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=GBK"></head>

<body>
<!-- EXAMPLES -->
  <!-- <div id="themeTreeDiv" class="x-hidden"></div> -->
  <div id="previewDiv" class="x-hidden"></div>
  <div id="west" align="left" />
  <div id="north">
  <table border="0" cellpadding="0" cellspacing="0" width="100%"  
	height="50">
	<tr >
		<td style="padding-left:0px"><!-- <img class="IEPNG" src="../resource/image/logo.png" /> -->
		</td>
		<td style="padding-right:5px">
		  <table width="100%"   border="0" cellpadding="0" cellspacing="3" class="banner">
		    <tr align="right">
		    <td>
		      <table border="0" cellpadding="0" cellspacing="1">
		        <tr>
		          <td><div id = "themeDiv"></td> 
		          <td>&nbsp;</td>
		          <td><div id = "configDiv"></td> 
		          <td>&nbsp;</td>
		          <td><div id = "closeDiv"></td>
		        </tr>
		      </table>
		    </td>
		    </tr>
		  </table>
		</td>
	</tr>
</table>
</div>
<script>
	document.getElementById('north').style.background="url(../resource/image/banner_info.png)";
</script>
 <div id="center1">
   <iframe id="worktop" height="100%" width="100%" frameborder="0" scrolling="no" id="main"></iframe>
 </div>
 <div id="south" style="background-color:#FFFFFF" />
 </body>
</html>