<%@ page contentType="text/html; charset=UTF-8" %>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<title>嵩湖环保服务网</title>
<link rel="stylesheet" type="text/css" href="../resource/extjs/resources/css/ext-all.css" /> 
<link rel="stylesheet" type="text/css" href="../resource/css/common.css" /> 
<link rel="stylesheet" type="text/css" href="../resource/css/ext_icon.css" /> 
<script type="text/javascript" src="../resource/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../resource/extjs/ext-all.js"></script>
<script language=JavaScript src="../resource/commonjs/cook.js"> </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script>
Ext.QuickTips.init();
Ext.form.Field.prototype.msgTarget = 'qtip';
Ext.BLANK_IMAGE_URL="../resource/extjs/resources/images/default/s.gif"; 
Ext.onReady(function() {
	var panel = new Ext.Panel({
		el : 'hello-tabs',
		autoTabs : true,
		deferredRender : false,
		border : false,
		items : {
			xtype : 'tabpanel',
			id : 'loginTabs',
			activeTab : 0,
			height : 180,
			border : false,
			items : [{
				title : "身份认证",
				xtype : 'form',
				id : 'loginForm',
				defaults : {
					width : 260
				},
				bodyStyle : 'padding:20 0 0 50',
				defaultType : 'textfield',
				labelWidth : 40,
				labelSeparator : '：',
				items : [{
							fieldLabel : '帐&nbsp;号',
							name : 'dmCzy',
							id : 'account',
							cls : 'user',
							blankText : '帐号不能为空,请输入!',
							maxLength : 30,
							maxLengthText : '账号的最大长度为30个字符',
							allowBlank : false,
							listeners : {
								specialkey : function(field, e) {
									if (e.getKey() == Ext.EventObject.ENTER) {
										Ext.getCmp('password').focus();
									}
								}
							}
						}, {
							fieldLabel : '密&nbsp;码',
							name : 'kl',
							id : 'password',
							cls : 'key',
							inputType : 'password',
							blankText : '密码不能为空,请输入!',
							maxLength : 20,
							maxLengthText : '密码的最大长度为20个字符',
							allowBlank : false,
							listeners : {
								specialkey : function(field, e) {
									if (e.getKey() == Ext.EventObject.ENTER) {
										login();
									}
								}
							}
						}]
			}, {
				title : '信息公告',
				contentEl : 'infoDiv',
				defaults : {
					width : 230
				}
			}, {
				title : '关于',
				contentEl : 'aboutDiv',
				defaults : {
					width : 230
				}
			}]
		}
	});

	var win = new Ext.Window({
		title : '嵩湖环保服务网',
		renderTo : Ext.getBody(),
		layout : 'fit',
		width : 460,
		height : 300,
		closeAction : 'hide',
		plain : true,
		modal : true,
		collapsible : false,
		titleCollapse : true,
		maximizable : false,
		draggable : false,
		closable : false,
		resizable : false,
		animateTarget : document.body,
		items : panel,
		buttons : [{
			text : '&nbsp;登录',
			iconCls : 'acceptIcon',
			handler : login
		}, {
			text : '&nbsp;重置',
			iconCls : 'tbar_synchronizeIcon',
			handler : function() {
						var account = Ext.getCmp('loginForm')
								.findById('account');
						Ext.getCmp('loginForm').form.reset();
						account.setValue('');
						account.focus();
					}
		}]
	});

	win.show();

	win.on('show', function() {
		setTimeout(function() {
					var account = Ext.getCmp('loginForm').findById('account');
					var password = Ext.getCmp('loginForm').findById('password');
					var c_account = GetCookie("usercode");
					account.setValue(c_account);
					if (Ext.isEmpty(c_account)) {
						account.focus();
					} else {
						password.focus();
					}
				}, 200);
	}, this);

	/**
	 * 提交登陆请求
	 */
	function login() {
		if (Ext.getCmp('loginForm').form.isValid()) {
			Ext.getCmp('loginForm').form.submit({
				url : '../loginController.do?login',
				waitTitle : '提示',
				method : 'POST',
				waitMsg : '正在验证您的身份,请稍候.....',
				success : function(form, action) {
					SetCookie('usercode',action.result.attributes.userId);
			        document.location="complex.jsp";
				},
				failure : function(form, action) {
					var errmsg = action.result.msg;
					Ext.Msg.alert('提示', errmsg);
				}
			});
		}
	}

});

</script>

</head>

<body>
	<div id="hello-win" class="x-hidden">
	<div id="hello-tabs"><img border="0" width="450" height="70"
		src="../resource/image/login_banner.png" />
	</div>
	</div>
	<div id="aboutDiv" class="x-hidden"
		style='color: black; padding-left: 10px; padding-top: 10px; font-size: 12px'>
	嵩湖环保服信息服务网<br>
	<br>
	<br>
	Copyright&nbsp;&copy;&nbsp;2016&nbsp;&nbsp;&nbsp;zwyArmy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div id="infoDiv" class="x-hidden"
		style='color: black; padding-left: 10px; padding-top: 10px; font-size: 12px'>
	公告<br>
	
	
	</div>	
</body>

</html>
                                                             