/* * * * * * * * 错误报告窗体*
 * 
 */
Ext.WrongTell=Ext.extend(Ext.Window ,{
	xtype:"window",
    title:"提示",
    id:"ext-win-Wrong",
    width:400,
    height:300,
    modal:true,
    closable:false,
    resizable:false,
    initComponent: function(){
	    this.items=[
		  {
                xtype:"form",
                title:"",
                id:"ext-form-Wrong",
                labelAlign:"left",
                layout:"column",
                height:290,
                width:400,
                frame:true,
                items:[
                	 {
	                    layout : "form",
						columnWidth :1,
						labelWidth : 55,
						items : [{
	                            xtype:"label",
	                            id:"bel",
	                            text:'操作失败，请与系统管理员联系！ ',
	                            style:'{font-size: 150%; margin-top:5px;margin-bottom:5px;color: red; }',
	                            anchor:"98%"
	                           }]
	                 },
                	 {
	                    layout : "form",
						columnWidth :1,
						labelWidth : 55,
						items : [{
	                            xtype:"textarea",
	                            fieldLabel:"错误描述",
	                            readOnly:true,
	                            id:"wmsg",
	                            name:"wmsg",
	                            value:this.wmsg,
	                            height:180,
	                            anchor:"95%"
	                           }]
	                 }
                  ]
                	
		  }]
		  this.buttons=[
			  {
                  text:'关闭',
                  handler:function(){
                    Ext.getCmp('ext-win-Wrong').destroy();
                  }
               }]
     Ext.WrongTell.superclass.initComponent.call(this);
	 this.show();
    }
})



/* * * * * * * * 加载Form数据 * * * * * * */
Ext.form.CheckBoxGroupEx=Ext.extend(Ext.form.CheckboxGroup,{   
    //在inputValue中找到定义的内容后，设置到items里的各个checkbox中   
    setValue : function(value){  
        this.items.each(function(f){  
            if(value.indexOf(f.inputValue) != -1){  
                f.setValue(true);  
            }else{  
                f.setValue(false);  
            }  
        });  
    },  
    //以value1,value2的形式拼接group内的值  
    getValue : function(){  
        var re = "";  
        this.items.each(function(f){  
            if(f.getValue() == true){  
                re += f.inputValue + ",";  
            }  
        });  
        return re.substr(0,re.length - 1);  
    },  
    //在Field类中定义的getName方法不符合CheckBoxGroup中默认的定义，因此需要重写该方法使其可以被BasicForm找到  
    getName : function(){  
        return this.name;  
    }  
}); 
Ext.reg('checkboxgroupex',Ext.form.CheckBoxGroupEx);


function LoadFormData(eva){
	for(key in eva){
		if(!Ext.isEmpty(Ext.getCmp(key))){
				Ext.getCmp(key).setValue(eva[key]);
		}		
		if(!Ext.isEmpty(Ext.getCmp(key+"1"))){
				if(Ext.getCmp(key+"1").isXType('combo'))
					Ext.getCmp(key+"1").setValue(eva[key]);				
		}		
	}	
}


/* * * * * * * * 验证字段是否为空 * * * * * * */
function checknull(field,cnfield){
    var ary=field.split(",");
    var ary2=cnfield.split(",");
    for(var i=0;i<ary.length;i++){
	   if(Ext.getCmp(ary[i]).getValue()==""){ 
		 Ext.MessageBox.alert('提示', ary2[i]+" 不能为空!");
         Ext.getCmp(ary[i]).focus();
		return false;
		}
		if(Ext.getCmp(ary[i]).isXType('numberfield')){
			if(Ext.getCmp(ary[i]).getValue()==0){
		 		Ext.MessageBox.alert('提示', ary2[i]+" 不能为空!");
         		Ext.getCmp(ary[i]).focus();
				return false;			
			}
		}
		if(Ext.getCmp(ary[i]).isXType('radiogroup')){
			if(Ext.isEmpty(Ext.getCmp(ary[i]).getValue())){
		 		Ext.MessageBox.alert('提示', ary2[i]+" 不能为空!");
         		Ext.getCmp(ary[i]).focus();
				return false;			
			}
		}
	}
	return true;
}

/* * * * * * * * GUID（全球唯一标识） * * * * * * */
function S4() 
{   
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);   
}    
function NewGuid() 
{   
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());   
}
/////四舍五入
function round(v,e){
var t=1;
for(;e>0;t*=10,e--);
for(;e<0;t/=10,e++);
return Math.round(v*t)/t;
}

function LTrim(str)
{
 //空格,\r,\n,\t
    var whitespace = new String(" \t\n\r");
 //生成一个新的字符串
    var s = new String(str);
 //判断如果目标字符串中从左第一个字符有上面四个之一则进入
    if (whitespace.indexOf(s.charAt(0)) != -1)
    {
        var j=0, i = s.length;
        while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
        {
  //找到弟一个不是上面四个之一且不大于目标字符串的总长度,的字符的位置
            j++;
        }
        s = s.substring(j, i);
    }
    return s;
}
//原理同上
function RTrim(str)
{
    var whitespace = new String(" \t\n\r");
    var s = new String(str);
 
    if (whitespace.indexOf(s.charAt(s.length-1)) != -1)
    {
        var i = s.length - 1;
        while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
        {
            i--;
        }
        s = s.substring(0, i+1);
    }
    return s;
}
 
function Trim(str)
{
    return LTrim(RTrim(str));
}


////////EXT 月份选择控件/////////
Ext.ux.MonthPickerPlugin = function() {   
    var picker;   
    var oldDateDefaults;   
  
    this.init = function(pk) {   
        picker = pk;   
        picker.onTriggerClick = picker.onTriggerClick.createSequence(onClick);   
        picker.getValue = picker.getValue.createInterceptor(setDefaultMonthDay).createSequence(restoreDefaultMonthDay);   
        picker.beforeBlur = picker.beforeBlur.createInterceptor(setDefaultMonthDay).createSequence(restoreDefaultMonthDay);   
    };   
  
    function setDefaultMonthDay() {   
        oldDateDefaults = Date.defaults.d;   
        Date.defaults.d = 1;   
        return true;   
    }   
  
    function restoreDefaultMonthDay(ret) {   
        Date.defaults.d = oldDateDefaults;   
        return ret;   
    }   
  
    function onClick(e, el, opt) {   
        var p = picker.menu.picker;   
        p.activeDate = p.activeDate.getFirstDateOfMonth();   
        if (p.value) {   
            p.value = p.value.getFirstDateOfMonth();   
        }   
  
        p.showMonthPicker();   
           
        if (!p.disabled) {   
            p.monthPicker.stopFx();   
            p.monthPicker.show();   
   // if you want to click,you can the dblclick event change click   
            p.mun(p.monthPicker, 'click', p.onMonthClick, p);   
            //p.mun(p.monthPicker, 'click', p.onMonthDblClick, p);   
            p.onMonthClick = p.onMonthClick.createSequence(pickerClick);   
            //p.onMonthDblClick = p.onMonthDblClick.createSequence(pickerDblclick);   
            p.mon(p.monthPicker, 'click', p.onMonthClick, p);   
            //p.mon(p.monthPicker, 'click', p.onMonthDblClick, p);   
        }   
    }   
  
    function pickerClick(e, t) {   
        var el = new Ext.Element(t);   
        if (el.is('button.x-date-mp-cancel')) {   
            picker.menu.hide();   
        } else if(el.is('button.x-date-mp-ok')) {   
            var p = picker.menu.picker;   
            p.setValue(p.activeDate);   
            p.fireEvent('select', p, p.value);   
        }   
    }   
  
    function pickerDblclick(e, t) {   
        var el = new Ext.Element(t);   
        if (el.parent()   
            && (el.parent().is('td.x-date-mp-month')   
            || el.parent().is('td.x-date-mp-year'))) {   
  
            var p = picker.menu.picker;   
            p.setValue(p.activeDate);   
            p.fireEvent('select', p, p.value);   
        }   
    }   
};   
  
Ext.preg('monthPickerPlugin', Ext.ux.MonthPickerPlugin);


///////////保留小数后两位///////////
function changeTwoDecimal(x)
{
var f_x = parseFloat(x);
if (isNaN(f_x))
{
//alert('function:changeTwoDecimal->parameter error');
return "0.00";
}
var f_x = Math.round(x*100)/100;
var s_x = f_x.toString();
var pos_decimal = s_x.indexOf('.');
if (pos_decimal < 0)
{
pos_decimal = s_x.length;
s_x += '.';
}
while (s_x.length <= pos_decimal + 2)
{
s_x += '0';
}
return s_x;
}


/* * * * * * * * GUID（全球唯一标识） * * * * * * */
function S4() 
{   
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);   
}    
function NewGuid() 
{   
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());   
}

function NewGuid$() 
{   
   return (S4()+S4()+S4()+S4()+S4()+S4()+S4()+S4());   
}

Ext.onReady(function(){   
    Ext.Ajax.timeout = 300000;
    Ext.QuickTips.init();  
  
    Ext.Ajax.on('requestcomplete',checkUserSessionStatus, this);    
    function checkUserSessionStatus(conn,response,options){ 
    	try{
	    	if(typeof(eval(response.getResponseHeader))=="function"){   
		        var sessionStatus = response.getResponseHeader("sessionstatus");  
		        if(typeof(sessionStatus) != "undefined"){    
		            Ext.Msg.alert('提示', '会话超时,请求已被强制重定向到了登录页面... ', function(btn, text){  
					    if (btn == 'ok'){  
					        getRootWin().location.href="/index.jsp";  
					    }  
		             });  
		         }   
	         }
         }catch(e){
         } 
    };  
//其它代码......  
}) 

function getRootWin(){  
	var win = window;  
	while (win != win.parent){  
		win = win.parent;  
	}  
	return win;  
} 





//grid 表格中的单元复制

var gridCopy=new Ext.Template(
         '<td class="x-grid3-col x-grid3-cell x-grid3-td-{id} x-selectable {css}" style="{style}" tabIndex="0" {cellAttr}>',
         '<div class="x-grid3-cell-inner x-grid3-col-{id}" {attr}>{value}</div>',
         '</td>'
    );



//打开纳税人信息tab
function openNsrxx(nsrsbh,nsrmc){
    nsrmc = (nsrmc==""?nsrsbh:nsrmc);
	var myhtm="<iframe height=100% width=100% src='ssfx/nsrxx/list.jsp?nsrsbh="+nsrsbh+"'></iframe>";
	parent.addTab(nsrsbh,nsrmc,myhtm);
}
