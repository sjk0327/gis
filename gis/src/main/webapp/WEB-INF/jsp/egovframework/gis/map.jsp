<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://openlayers.org/en/v3.20.1/css/ol.css" type="text/css">
<script src="https://openlayers.org/en/v3.20.1/build/ol.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	#searchKeyword {
		height : 20px;
		margin-left : 30px;
		margin-bottom : 20px;
	
	
	}
</style>

<title>map</title>
</head>
<body>
		
		
		<div id="serchBar" style="position:absolute; left:18px; top:80px; background-color:#8E69FF; width:250px;height:40px; z-index:9999;">
			<input id="searchKeyword" type="text">
			<a id="searchBtn"><image src="/images/egovframework/gis/searchBtn.png" style="width:30px;height:30px;"></image></a>
				
		</div>
		<div id="map" style="z-index:0;">
				
		</div>
<script src="js/gisMain.js"></script>
</body>
</html>