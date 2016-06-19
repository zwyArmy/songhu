/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.onReady(function() {
Ext.ux.TreeCombo = Ext.extend(Ext.form.ComboBox, {  
    constructor : function(cfg) {  
        cfg = cfg || {};  
        Ext.ux.TreeCombo.superclass.constructor.call(this, Ext.apply({  
            maxHeight : 300,  
            editable : false,  
            mode : 'local',  
            triggerAction : 'all',  
            rootVisible : false,  
            selectMode : 'all'  
        }, cfg));  
    },  
    store : new Ext.data.SimpleStore({  
        fields : [],  
        data : [[]]  
    }),  
    // 重写onViewClick，使展开树结点是不关闭下拉框��  
    onViewClick : function(doFocus) {  
        var index = this.view.getSelectedIndexes()[0], s = this.store, r = s.getAt(index);  
        if (r) {  
            this.onSelect(r, index);  
        }  
        if (doFocus !== false) {  
            this.el.focus();  
        }  
    },  
    tree : null,  
    // 隐藏值
    hiddenValue : null,  
    getHiddenValue : function() {  
    	if(!this.hiddenValue){
    		return this.hiddenValue;
    	}
    	
    	var _hval=this.hiddenValue.split(',');
   		var _res='';
   		for(var i=0,len=_hval.length;i<len;i++){
   			if(_hval[i]!=''&&_hval[i]!='0'){
   				if(this.isYH){
   					_res+="'"+_hval[i]+"',";
   				}else{
   					_res+=_hval[i]+",";
   				}
   			}
   		}
   		_res= _res.substr(0,_res.length-1);
    
        return _res;  
    },  
    setHiddenValue : function(code, dispText) {  
        this.setValue(code);  
        Ext.form.ComboBox.superclass.setValue.call(this, dispText);  
        this.hiddenValue = code;  
    },  
    initComponent : function() {  
        var _this = this;  
        var tplRandomId = 'deptcombo_' + Math.floor(Math.random() * 1000) + this.tplId  
        this.tpl = "<div style='height:" + _this.maxHeight + "px' id='" + tplRandomId + "'></div>"  
        this.tree = new Ext.tree.TreePanel({  
            border : false,  
            enableDD : false,  
            enableDrag : false,  
            rootVisible : _this.rootVisible || false,  
            autoScroll : true,  
            trackMouseOver : true,  
            height : _this.maxHeight,  
            lines : true,  
            singleExpand : true,  
            root : _this.root,  
            loader : _this.loader  
        });  
        this.tree.on('click', function(node) {  
            if ((_this.selectMode == 'leaf' && node.leaf == true) || _this.selectMode == 'all') {  
                // if (node.parentNode && node.parentNode.attributes.id != '000000') {  
                var dispText = node.text;  
                var code = node.id;  
                //while (node.parentNode && node.parentNode.attributes.id != '000000') {  
                //    if (node.parentNode.text != dispText) {  
                //        dispText = node.parentNode.text + dispText;  
                //    }  
                //    node = node.parentNode;  
                //}  
                _this.setHiddenValue(code, dispText);  
                _this.collapse();
                _this.fireEvent('select',this);
            }  
        });  
        this.on('expand', function() {  
            this.tree.render(tplRandomId);  
        }); 
        Ext.ux.TreeCombo.superclass.initComponent.call(this);  
    }  
})  
Ext.reg("treecombo", Ext.ux.TreeCombo);  
});