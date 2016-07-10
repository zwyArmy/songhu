<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>

  <!--百度地图容器-->
  <div style="min-width:540px;min-height:560px;border:#ccc solid 1px;" id="dituContent"></div>
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
    }
    
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(118.160544,24.496615);//定义一个中心点坐标
        map.centerAndZoom(point,17);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
        
    }
    
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
	map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
    }
    
    //标注点数组
    var markerArr = [{title:"厦门湖里区云顶中路2777号市政大厦24层",content:"电话:0592-5172555",point:"118.160526|24.496673",isOpen:1,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}}
		 ,
		 {title:"仙福建游县枫亭镇经济开发园区",content:"电话:0592-5172555",point:"119.1857190000|25.4775290000",isOpen:1,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}},
		 {title:"福建省莆田市仙游县鲤城街道迎勋路86号",content:"电话:0592-5172555",point:"118.7083980000|25.3641680000",isOpen:1,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}},
		 {title:"福建省宁德市霞浦县三沙镇陇头工业园区",content:"电话:0592-5172555",point:"120.1260880000|26.9373920000",isOpen:1,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}},

		 {title:"甘肃省金昌市金川区宝林里公路总段家属院14栋",content:"电话:0592-5172555",point:"102.2173750000|38.5310990000",isOpen:1,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}}
		 
		 ];
    //创建marker
    function addMarker(){
        for(var i=markerArr.length - 1;i>=0;i--){
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0,p1);
			var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point,{icon:iconImg});
			var iw = createInfoWindow(i);
			var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
			marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                        borderColor:"#808080",
                        color:"#333",
                        cursor:"pointer"
            });
            markerArr[i].marker = marker;
			(function(){
				var index = i;
				var _iw = createInfoWindow(i);
				var _marker = marker;
				_marker.addEventListener("click",function(){
				    this.openInfoWindow(_iw);
			    });
			    _iw.addEventListener("open",function(){
				    _marker.getLabel().hide();
			    })
			    _iw.addEventListener("close",function(){
				    _marker.getLabel().show();
			    })
				label.addEventListener("click",function(){
				    _marker.openInfoWindow(_iw);
			    })
				if(!!json.isOpen){
					label.hide();
					_marker.openInfoWindow(_iw);
				}
			    _marker.myClick = function(){
			    	if(!!json.isOpen){
						label.hide();
						_marker.openInfoWindow(_iw);
					}
			    }
			})()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i){
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json){
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
        return icon;
    }
    var old = 0;
    function planeToIndex(index){
    	var json = markerArr[index];
    	var ojson = markerArr[old];
		var second = 1;
		var interval = 1000;
		old = index;
    	if(undefined === json) return ;
    	var x =  json.point.split("|")[0];
        var y = json.point.split("|")[1];;
    	var ox =  ojson.point.split("|")[0];
        var oy = ojson.point.split("|")[1];;
    	//console.log(ox,oy)
    	
    	setTimeout(function(){
    		map.centerAndZoom(new BMap.Point(ox,oy),11);   
    	}, (second++) * interval);
    	
    	
    	
    	setTimeout(function(){
    		map.centerAndZoom(new BMap.Point(ox,oy),6);   
    	}, (second++) * interval);
      	
    	setTimeout(function(){
    		map.panTo(new BMap.Point(x,y));   //两秒后移动到广州
    		markerArr[index].marker.myClick();

    	}, (second ++) * interval);
      	
    	//map.centerAndZoom(new BMap.Point(116.4035,39.915),8); 
    	setTimeout(function(){
    		map.centerAndZoom(new BMap.Point(x,y),8); 
    		
    	}, (second++) * interval);  //2秒后放大到14级
    	//map.centerAndZoom(new BMap.Point(116.4035,39.915),8); 
    	setTimeout(function(){
    		map.centerAndZoom(new BMap.Point(x,y),14); 
    		
    	}, (second++) * interval);  //2秒后放大到14级
    	

    }
    initMap();//创建和初始化地图
</script>
