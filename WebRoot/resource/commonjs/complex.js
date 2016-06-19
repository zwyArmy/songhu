/**
 * 首页部分JS
 */
Ext.onReady(function() {
	var mainMenu = new Ext.menu.Menu({
				id : 'mainMenu',
				items : [{
							text : '修改密码',
							iconCls : 'full',
							handler : function(){
								passwordWindow.show();
							}
						},{
							text : '系统帮助',
							iconCls : 'help',
							handler : help
						}]
			});

	var configButton = new Ext.Button({
				text : '首选项',
				iconCls : 'config2Icon',
				iconAlign : 'left',
				scale : 'medium',
				width : 50,
				tooltip : '<span style="font-size:12px">首选项设置</span>',
				pressed : true,
				renderTo : 'configDiv',
				menu : mainMenu
			});

	var closeButton = new Ext.Button({
				text: '注销',
				iconCls : 'cancel_48Icon',
				iconAlign : 'left',
				scale : 'medium',
				width : 30,
				tooltip : '<span style="font-size:12px">切换用户,安全退出系统</span>',
				pressed : true,
				arrowAlign : 'right',
				renderTo : 'closeDiv',
				handler : function() {
					logout();
				}
			});
	
	var passwordFormPanel = new Ext.form.FormPanel({
		id : 'passwordFormPanel',
		name : 'passwordFormPanel',
		defaultType : 'textfield',
		labelAlign : 'right',
		labelWidth : 65,
		frame : true,
		bodyStyle : 'padding:5 5 0',
		items : [{
					fieldLabel : '人员名称',
					name : 'username',
					id : 'username',
					value: GS_UserName,
					readOnly : true,
					anchor : '99%'
				}, {
					fieldLabel : '登录帐户',
					name : 'account',
					id : 'account',
					value: GS_UserId,
					readOnly : true,
					anchor : '99%'
				}, {
					fieldLabel : '旧密码',
					name : 'kl',
					id : 'kl',
					inputType : 'password',
					allowBlank : false,
					anchor : '99%'
				}, {
					fieldLabel : '新密码',
					name : 'password',
					id : 'password',
					inputType : 'password',
					allowBlank : false,
					anchor : '99%'
				}, {
					fieldLabel : '确认新密码',
					name : 'password1',
					id : 'password1',
					inputType : 'password',
					allowBlank : false,
					anchor : '99%'
				}]
	});
	
	var passwordWindow = new Ext.Window({
				title : '<span class="commoncss">修改登录密码</span>',
				closable : true,
				width : 400,
				height : 250,
				closeAction : 'hide',
				iconCls : 'bugIcon',
				collapsible : true,
				titleCollapse : true,
				border : true,
				maximizable : false,
				resizable : false,
				modal : true,
				animCollapse : true,
				animateTarget : Ext.getBody(),
				// border:false,
				plain : true,
				layout : 'fit',
				items : [passwordFormPanel],
				buttons : [{
					text : '保存',
					iconCls : 'acceptIcon',
					handler : updatePassword
				}, {
					text : '取消',
					iconCls : 'deleteIcon',
					handler : function() {
						passwordFormPanel.form.reset();
						passwordWindow.hide();
					}
				}]
		
		
	})
	
	function updatePassword() {
		if (!passwordFormPanel.form.isValid()) {
			return;
		}
		password1 = Ext.getCmp('password1').getValue();
		password = Ext.getCmp('password').getValue();
		if (password1 != password) {
			Ext.Msg.alert('提示', '两次输入的密码不匹配,请重新输入!');
			Ext.getCmp('password').setValue('');
			Ext.getCmp('password1').setValue('');
			return;
		}
		passwordFormPanel.form.submit({
					url : '../operatorController.do?updatePwd',
					waitTitle : '提示',
					method : 'POST',
					waitMsg : '正在处理数据,请稍候...',
					success : function(form, action) {
						passwordWindow.hide();
						form.reset();
						Ext.MessageBox.alert('提示', action.result.msg);
					},
					failure : function(form, action) {
						var msg = action.result.msg;
						Ext.MessageBox.alert('提示', '新密码保存失败:<br>' + msg);
					}
				});
	}

});
