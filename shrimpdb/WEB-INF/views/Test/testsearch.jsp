<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/layouts/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:100%;height:500px;}
		p{margin-left:5px; font-size:14px;}
	</style>
	 <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Bx5e36ewcaWGFjSGHhDWcgVWuyhvb5Cx"></script>
<!--加载鼠标绘制工具-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
	<title>圆形区域搜索用户数据</title>
</head>
<body>
	<div id="allmap"></div>
	<p>请在地图上画圆，将会返回北京市地图上圆形覆盖范围内的用户数据检索结果(本示例是积水点数据)，并展示在地图上。此外也支持本地、bounds检索用户数据。</p>
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");            // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.274625,39.961627), 11);
	map.enableScrollWheelZoom();                            //启用滚轮放大缩小

	var local = new BMap.LocalSearch(map, {
		renderOptions:{map: map}
	});
	/*map.addEventListener("load", function() {
		var circle = new BMap.Circle(point, 5000, {
			fillColor: "blue",
			strokeWeight: 1,
			fillOpacity: 0.3,
			strokeOpacity: 0.3
		});		
		map.addOverlay(circle);
		localSearch.searchNearby('积水点', point, 5000, {
			customData: {
				geotableId: 91687
			}
		});
	});*/
	map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件

	var drawingManager = new BMapLib.DrawingManager(map, {
		isOpen: false, //是否开启绘制模式
		enableDrawingTool: true, //是否显示工具栏
		drawingToolOptions: {
			anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
			offset: new BMap.Size(5, 5), //偏离值
			scale: 0.8, //工具栏缩放比例
			drawingModes: [
				BMAP_DRAWING_POLYGON
			]
		}
	});
	var circle = null;
	drawingManager.addEventListener('polygoncomplete', function(e, overlay) {
	//	circlecomplete
	    map.clearOverlays();
		polygon = e;
		map.addOverlay(overlay);		
		var points = e.getPath();
		drawingManager.close();
		console.log(points);
		var range=e.getBounds();
		console.log(range);
	    local.searchInBounds("采样", range);		
	});
</script>
