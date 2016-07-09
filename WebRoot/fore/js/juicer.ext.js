/**
**使用模板的一些扩展
**引用juicer之后才可以使用
**/

//设置模版的变量符号，不跟el表达式冲突
juicer.set({'tag::interpolateOpen': '&{','tag::noneencodeOpen': '&&{'});

//分页方法
/**
** 模版页面的试用方法
** &&{page,total,pagecount,getlistFunc|pagingFun}
**/
var pagingFun = function(page,total,pagecount,getlistFunc,shortNav){
	if(parseInt(total,10)==0) return "";
	var numOfPage = 10;
	getlistFunc = getlistFunc || "getlist";
	shortNav = shortNav || false;
	page = page || 1;
	var nextpage = parseInt(page,10) + 1;
	var prepage = parseInt(page,10) - 1;
	var lastpage = Math.ceil(parseInt(total,10)/parseInt(pagecount,10));
	var info = "<div class=\"paginate\"> ";//"第"+page+"页/共"+lastpage+"页&nbsp;&nbsp;&nbsp;共"+total+"行/每页"+pagecount+"行";
	var link1 = "";
	var linkNum = "";
	var link2 = "";
	if(!shortNav){
		if(parseInt(page,10)==1 || parseInt(total,10)==0){
			link1 = '<span class="first"><a href="javascript:'+getlistFunc+'(1)">《 首页</a></span> <span class="prev"><a href="javascript:'+getlistFunc+'(1)">《</a></span> ';
		}else{
			link1 = '<span class="first"><a href="javascript:'+getlistFunc+'(1)">《 首页</a></span> <span class="prev"><a href="javascript:'+getlistFunc+'('+prepage+')">《</a></span> ';
		}
		//写页数
		if(parseInt(lastpage,10)<=parseInt(numOfPage,10)){
			for(var row=1; row<=parseInt(lastpage,10); row++){
				var active = "";
				if(row==page){
					active = "active";
				}
				linkNum = linkNum + '<span class="'+active+'"><a href="javascript:'+getlistFunc+'('+row+')">'+row+'</a></span>';
			}
		}else{
			if(parseInt(lastpage,10)-parseInt(page,10)+1 < parseInt(numOfPage,10)){
				var _startpageNum = parseInt(lastpage,10) - parseInt(numOfPage,10) + 1;
				for(var row=parseInt(_startpageNum,10); row<=parseInt(lastpage,10); row++){
					var active = "";
					if(row==page){
						active = "active";
					}
					linkNum = linkNum + '<span class="'+active+'"><a href="javascript:'+getlistFunc+'('+row+')">'+row+'</a></span>';
				}
			}else{
				var _startpageNum = parseInt(page,10) - Math.floor(numOfPage/2);
	        	var _endPageNum = parseInt(_startpageNum,10) + parseInt(numOfPage,10);
	        	
	        	if(parseInt(page,10)<=Math.floor(numOfPage/2)){
	    			_startpageNum = 1;
	    			_endPageNum = numOfPage;
	    		}
				for(var row=parseInt(_startpageNum,10); row<=parseInt(_endPageNum,10); row++){
					var active = "";
					if(row==page){
						active = "active";
					}
					linkNum = linkNum + '<span class="'+active+'"><a href="javascript:'+getlistFunc+'('+row+')">'+row+'</a></span>';
				}
			}
		}
		if(lastpage==1 || parseInt(page,10)==lastpage || parseInt(total,10)==0){
			link2 = ' <span class="next"><a href="javascript:'+getlistFunc+'('+lastpage+')">》</a></span> <span class="last"><a href="javascript:'+getlistFunc+'('+lastpage+')">尾页 》</a></span> ';
		}else{
			link2 = ' <span class="next"><a href="javascript:'+getlistFunc+'('+nextpage+')">》</a></span> <span class="last"><a href="javascript:'+getlistFunc+'('+lastpage+')">尾页 》</a></span> ';
		}
	}else{
		if(parseInt(page,10)==1 || parseInt(total,10)==0){
			link1 = '<span class="prev"><a href="javascript:'+getlistFunc+'(1)">《</a></span> ';
		}else{
			link1 = '<span class="prev"><a href="javascript:'+getlistFunc+'('+prepage+')">《</a></span> ';
		}
		
		linkNum = linkNum + "<span style=\"width:120px;top:-12px;\">第"+page+"页/共"+lastpage+"页</span>"
		
		if(lastpage==1 || parseInt(page,10)==lastpage || parseInt(total,10)==0){
			link2 = ' <span class="next"><a href="javascript:'+getlistFunc+'('+lastpage+')">》</a></span> ';
		}else{
			link2 = ' <span class="next"><a href="javascript:'+getlistFunc+'('+nextpage+')">》</a></span> ';
		}
	}
	var link =  link1 + linkNum + link2 ;
	
	return info+link +"</div>";
}
//分页方法注册
juicer.register('pagingFun',pagingFun);

var dateformat = function(str,format){
	if(str.length==8)
		return str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	else if(str.length==12)
		return str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2)+" "+str.substr(8,2)+":"+str.substr(10,2);
	else if(str.length==14)
		return str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2)+" "+str.substr(8,2)+":"+str.substr(10,2)+":"+str.substr(12,2);
	else
		return str;
}
juicer.register('dateformat',dateformat);


var  minute = 60 * 1000;// 1分钟
var hour = 60 * minute;// 1小时
var day = 24 * hour;// 1天
var month = 31 * day;// 月
var year = 12 * month;// 年
/**Js获取当前日期时间**/
function getCurDate(str){
    var myDate = new Date(str);
    var diff = myDate.getTime() - new Date().getTime();
	var r = (diff / year).toFixed(0);
	if (r>0) {
		return r + " 年";
	}
	r = (diff / month).toFixed(0);
	if (r>0) {
		return r + " 个月";
	}
	r = (diff / day).toFixed(0);
	if (r>0) {
		return r + " 天";
	}
	r = (diff / hour).toFixed(0);
	if (r>0) {
		r = (diff / hour).toFixed(0);
		return r + " 个小时";
	}
	else{
		return "<1小时";
	}
}
var dateformatsy = function(str){
	var date;
	if(str.length==8)
		date= str.substr(0,4)+"/"+str.substr(4,2)+"/"+str.substr(6,2);
	else if(str.length==12)
		date= str.substr(0,4)+"/"+str.substr(4,2)+"/"+str.substr(6,2)+" "+str.substr(8,2)+":"+str.substr(10,2);
	else if(str.length==14)
		date= str.substr(0,4)+"/"+str.substr(4,2)+"/"+str.substr(6,2)+" "+str.substr(8,2)+":"+str.substr(10,2)+":"+str.substr(12,2);
	else
		date =str;
	return getCurDate(date);
}
juicer.register('dateformatsy',dateformatsy);
/*js获取大小多少M*/
var sizeformat =function(size){
    var $i=0;
    size = size<<0;
     //当size 大于是1024字节时，开始循环，当循环到第4次时跳出；
    while(size>=1024){        
    size=size/1024;
    $i++;
    if($i==4)break;
    }

    //将Bytes,KB,MB,GB,TB定义成一维数组；

   var $units= ["Bytes","KB","MB","GB","TB"];
   var $newsize=Math.round(size,2);
    return $newsize+$units[$i];
}
juicer.register('sizeformat',sizeformat);

//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt)   
{ //author: meizz   
	var o = {   
	 "M+" : this.getMonth()+1,                 //月份   
	 "d+" : this.getDate(),                    //日   
	 "h+" : this.getHours(),                   //小时   
	 "m+" : this.getMinutes(),                 //分   
	 "s+" : this.getSeconds(),                 //秒   
	 "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	 "S"  : this.getMilliseconds()             //毫秒   
	};   
	if(/(y+)/.test(fmt))   
	 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	for(var k in o)   
	 if(new RegExp("("+ k +")").test(fmt))   
	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	return fmt;   
} ; 
var dateFormat = function(time) {
	var date = new Date(time);
	return date.Format("yyyy-MM-dd hh:mm:ss");
};
juicer.register('dateFormat',dateFormat);
