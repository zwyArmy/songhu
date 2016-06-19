
Ext.onReady(function(){

Ext.MemberWindow=Ext.extend(Ext.Window ,{
    xtype:"window",
	title:"用户明细",
	id:"ext-win-member",
	width:500,
	height:210,
	modal:true,
	closable:false,
	resizable:false,
	initComponent: function(){
		this.items=[
            {
                xtype:"form",
                title:"",
                id:"ext-form-member",
                labelAlign:"right",
                layout:"column",
                height:210,
                width:500,
                frame:true,
                items:[
                {
                    xtype:"hidden",
                    id:"id",
                    value:"",
                    name:"id",
                    anchor:"98%"
                    
                },
                {
                    xtype:"hidden",
                    id:"cz",
                    value:this.cz
                    
                },
                {
                    xtype:"hidden",
                    id:"password",
                    value:this.password,
                    name:"password",
                    anchor:"98%"
                    
                },
                {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[{
                        xtype:"textfield",
                        fieldLabel:"姓名",
                        readOnly:true,
                        itemCls:'required-red',
                        id:"name",
                        emptyText:' ',
                        allowBlank : false,
                        value:this.name,
                        name:"name",
                        anchor:"98%"}]
                 }, 
                 {
                   layout:"form",
                   columnWidth:1,
                   labelWidth:66,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"地址",
                        readOnly:true,
                        itemCls:"required-red",
                        emptyText:' ',
                        allowBlank : true,
                        id:"address",
                        value:this.address,
                        name:"address",
                        anchor:"98%"}]
                 },
                 {
                   layout:"form",
                   columnWidth:1,
                   labelWidth:66,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"邮箱",
                        readOnly:true,
                        itemCls:"required-red",
                        emptyText:' ',
                        allowBlank : false,
                        id:"email",
                        value:this.email,
                        name:"email",
                        anchor:"98%"}]
                 },
                 {
                   layout:"form",
                   columnWidth:1,
                   labelWidth:66,
                   items:[{
                        xtype:"textfield",
                        fieldLabel:"电话",
                        readOnly:true,
                        itemCls:"required-red",
                        emptyText:' ',
                        allowBlank : true,
                        id:"phone",
                        value:this.phone,
                        name:"phone",
                        anchor:"98%"}]
                 },
                 {
                    layout:"form",
                    columnWidth:1,
                    labelWidth:66,
                    items:[{
                        xtype:"combo",
                        fieldLabel:"状态",
                        itemCls:"required-red",
                        allowBlank : false,
                        id:"tz",
                        readOnly:true,
                        hiddenName:'state',
                        triggerAction:'all',
                        editable:false,
                        typeAhead:false,
                        mode:'local',
                        store: new Ext.data.ArrayStore({
                        	fields:['txt','val'],
                        	data:[['未验证邮箱',0],['已验证邮箱',1]]
                        }),
                        valueField:'val',
                        displayField:'txt',
                        value:1,
                        anchor:"98%"}]
                }
             ]
        }
      ]
		
		this.buttons=[
			{
			  text:'关闭',
			  handler:function(){
			    Ext.getCmp('ext-win-member').destroy();
			}
		  }
	    ]
		Ext.MemberWindow.superclass.initComponent.call(this);
		this.show();
			if(this.cz=="00")
				{
				   Ext.getCmp('ext-form-member').getForm().loadRecord(this.rec);
				}
				
	  }
})
})