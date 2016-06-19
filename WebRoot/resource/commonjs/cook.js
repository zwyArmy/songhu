function getCookieVal (offset) { 
var endstr = document.cookie.indexOf (";", offset); 
if (endstr == -1) 
endstr = document.cookie.length; 
return unescape(document.cookie.substring(offset, endstr)); 
} 
function FixCookieDate (date) { 
var base = new Date(0); 
var skew = base.getTime(); // dawn of (Unix) time - should be 0 
if (skew > 0) // Except on the Mac - ahead of its time 
date.setTime (date.getTime() - skew); 
} 
/**
功能：保存cookies函数 
参数：name，cookie名字；value，值
*/
function SetCookie(name,value){
    var Days = 60;   //cookie 将被保存两个月
    var exp  = new Date();  //获得当前时间
    exp.setTime(exp.getTime() + Days*24*60*60*1000);  //换成毫秒
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
} 

/**
功能：获取cookies函数 
参数：name，cookie名字
*/
function GetCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null)
  return unescape(arr[2]); 
    return null;

} 
/**
功能：删除cookies函数 
参数：name，cookie名字
*/

function DelCookie(name){
    var exp = new Date();  //当前时间
    exp.setTime(exp.getTime() - 1);
    var cval=GetCookie(name);
    if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}
