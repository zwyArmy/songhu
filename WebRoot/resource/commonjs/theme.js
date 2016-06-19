try{
	var theme=GetCookie('theme');
	theme = (theme===null)?'default':theme;
	Ext.util.CSS.swapStyleSheet('theme', '../../../resource/theme/'+theme+'/resources/css/ext-all.css');
}catch(e){
}