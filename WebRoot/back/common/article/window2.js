Ext.onReady(function() {

	var w = document.body.clientWidth;
	var h = document.body.clientHeight;

	Ext.ArticleWindow2 = Ext.extend(Ext.Window, {
		xtype : "window",
		title : "",
		id : "ext-win-article2",
		width : w,
		height : h,
		modal : true,
		closable : false,
		resizable : false,
		initComponent : function() {
			tt = this.articleId;
			this.items = [{
				xtype : "form",
				title : "发表文章",
				id : "ext-form-article2",
				labelAlign : "right",
				layout : "column",
				fileUpload: true,
				height : h,
				frame : true,
				items : [{
					xtype : "hidden",
					id : "id",
					value : this.id,
					name : "id",
					anchor : "98%"
				}, {
					xtype : "hidden",
					id : "state",
					value : this.state,
					name : "state",
					anchor : "98%"
				}, {
					xtype : "hidden",
					id : "isPhoto",
					value : this.isPhoto,
					name : "isPhoto",
					anchor : "98%"
				}, {
					xtype : "hidden",
					id : "columnId",
					value : this.columnId,
					name : "columnId",
					anchor : "98%"

				}, {
					layout : "form",
					columnWidth : 1,
					labelWidth : 55,
					items : [{
						xtype : "textfield",
						fieldLabel : "标题",
						itemCls : 'required-red',
						id : "title",
						emptyText : ' ',
						value : this.title,
						name : "title",
						emptyText : ' ',
						anchor : "100%"
					}]
				}, {
					layout : "form",
					columnWidth : 1,
					labelWidth : 55,
					items : [{
						xtype : "textfield",
						fieldLabel : "概要",
						itemCls : 'required-red',
						id : "summary",
						emptyText : ' ',
						value : this.summary,
						name : "summary",
						emptyText : ' ',
						anchor : "100%"
					}]
				}, {
					layout : "form",
					columnWidth : 0.4,
					labelWidth : 55,
					items : [{
						xtype : "textfield",
						fieldLabel : "作者",
						itemCls : "required-red",
						emptyText : ' ',
						allowBlank : false,
						id : "author",
						value : this.author,
						name : "author",
						anchor : "100%"
					}]
				}, {
					layout : "form",
					columnWidth : 0.4,
					labelWidth : 55,
					items : [{
						xtype : "datetimefield",
						fieldLabel : "发布时间",
						itemCls : "required-red",
						format: 'Y-m-d H:i:s',
						id : "publishTime",
						value : this.cz==1?new Date():"",
						name : "publishTime",
						anchor : "100%"
					}]
				}, {
					layout : "form",
					columnWidth : 0.2,
					labelWidth : 55,
					items : [{
							xtype:'combo',
							fieldLabel : '是否置顶',
							id : 'isTop1',
							hiddenName : 'isTop',
							store : new Ext.data.SimpleStore({
												fields: ['DM', 'DMMC'],
												data : [
													['1', '否'],
												   	['0', '是']
												]
											}),
							mode : 'local',
							triggerAction : 'all',
							valueField : 'DM',
							displayField : 'DMMC',
							value : '1',
							emptyText : '请选择...',
							allowBlank : false,
							forceSelection : true,
							editable : false,
							typeAhead : true,
							anchor : "100%"
					}]
				}, {
					layout : "form",
					columnWidth : 1,
					labelWidth : 55,
					items : [{
						xtype : "textarea",
						fieldLabel : "文章",
						itemCls : "required-red",
						id : "content",
						name : "content",
						height : h - 350,
						anchor : "98%"
					}]
				}, {
					xtype : "hidden",
					id : "cz",
					value : this.cz
				}, {
					xtype : "hidden",
					id : "sjc"
				}
				]
			}];
			this.buttons = [
					{
						text : '上传附件',
						iconCls : 'add',
						id:'appendix',
						handler : function() {
							var id2;
							if(Ext.getCmp('cz').getValue()=='1'){
								id2 = new Date().getTime();
								Ext.getCmp('sjc').setValue(id2);
							}else{
								id2 = Ext.getCmp('id').getValue();
							}
							var columnId = Ext.getCmp('columnId').getValue();
							new Ext.Appendix({title:"添加附件",article2:id2,columnId2:columnId,cz1:Ext.getCmp('cz').getValue()});
						}
					},
				{
				text : '发表',
				hidden : this.view,
				iconCls : 'accept',
				handler : function() {
					Ext.getCmp("content").setValue(CKEDITOR.instances["content"].document.getBody().getHtml());
					if (checknull("title,author,content", "标题,作者,文章")) {
						Ext.getCmp('ext-form-article2').getForm().submit({
							url : '../../../articleController.do?save',
							method : 'post',
							waitMsg : '数据处理中..',
							success : function(form, action) {
								Ext.MessageBox.show({
									title : '提示',
									msg : action.result.msg,
									buttons : Ext.Msg.OK,
									fn : function() {
										Ext.getCmp("ext-win-article2").destroy();
										store.load();
									},
									animEl : 'elId',
									icon : Ext.MessageBox.WARNING
								});
							},
							failure : function(form, action) {
								Ext.Msg.alert("提示", action.result.msg);

							}
						});
					}

				}
			}, {
				text : '取消',
				iconCls : 'cancel',
				handler : function() {
						Ext.Ajax.request({     
						       url:'../../../articleController.do?deleteAppendix2'
						      });
					Ext.getCmp('ext-win-article2').destroy();
					store.load();
				}
			}];
			Ext.ArticleWindow2.superclass.initComponent.call(this);
			if (this.cz == '0') {
				Ext.getCmp('ext-form-article2').form.load({
					url : '../../../articleController.do?get',
					params : {'id' : tt},
					waitMsg : '加载中......',
					waitTitle : '文章加载',
					success : function(form, action) {
						CKEDITOR.instances["content"].document.getBody().setHtml(Ext.getCmp("content").getValue());
						Ext.getCmp("state").setValue("0");
						Ext.getCmp('publishTime').setValue(new Date(action.result.data.publishTime));
					},
					failure : function(form, action) {
						Ext.Msg.alert("提示", action.result.msg);
					}
				});
		        Ext.getCmp('ext-form-article2').getForm().loadRecord(this.rec);   
			}
			this.show();
			CKEDITOR.config.readOnly = false;
			var editor = CKEDITOR.instances['content'];   
			if(editor) editor.destroy(true);
			var contentCKE = CKEDITOR.replace('content', {toolbar : 'Full',width:'100%',height : h - 258}, {customConfig : '../../../resource/ckeditor/config.js'});
			CKFinder.setupCKEditor(contentCKE,"../../../resource/ckfinder/");
		}
	});
});
