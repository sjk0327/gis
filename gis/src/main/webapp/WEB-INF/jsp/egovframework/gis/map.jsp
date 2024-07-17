<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://openlayers.org/en/v3.20.1/css/ol.css" type="text/css">
<script src="https://openlayers.org/en/v3.20.1/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/gisMain.css" type="text/css">

<title>map</title>
</head>
<body>
		
		<div id="serchBarHiddenText">검색</div>
		<div id="serchBar">
			<div id="searchDetail"><a><image src="/images/egovframework/gis/navigationBtn.png" style="width:30px;height:30px;"></image></a></div>
			<div id="searchKeyword"><input type="text" style="width:120px;"></div>
			<div id="searchBtn"><a><image src="/images/egovframework/gis/searchBtn.png" style="width:30px;height:30px;"></image></a></div>
		</div>
		<div class="hideBtn" id="searchHideBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px; margin-top : 3px;"></image></a></div>
		
		<div id="layerBarHeadText">레이어</div>
		<div id="layerBar">
			<div id="layerBarTop"></div>
			<div class="hideBtn" id="layerHideBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px; margin-top : 3px;"></image></a></div>
			<div id="layerBarBody">
				<ul id="layerList">
				    <li> 레이어
				        <ul>
				            <li class="layerLi"><label for="checkbox1">
						        <input type="checkbox" id="checkbox1" name="checkbox1" value="value1" onchange="layerOnOff(this)">
						        시군구
						    	</label>
				    		</li>
				            <li class="layerLi"><label for="checkbox2">
						        <input type="checkbox" id="checkbox2" name="checkbox2" value="value2" onchange="layerOnOff(this)">
						        대학교
						    	</label>
				    		</li>
				        </ul>
				    </li>
				</ul>
			</div>	
		</div>
		<div id="drawingBarHiddenText">편집</div>
		<div id="drawingBar">
			<div id="drawingList">
			<ul id="drawingUl">
				<li class="drawingLi" onclick="drawClick(this,'Point')"><image class="drawingLiImg" src="/images/egovframework/gis/pointIcon.png"></image><br>점</li>
				<li class="drawingLi" onclick="drawClick(this,'LineString')"><image class="drawingLiImg" src="/images/egovframework/gis/lineIcon.png"></image><br>선</li>
				<li class="drawingLi" onclick="drawClick(this,'Polygon')"><image class="drawingLiImg" src="/images/egovframework/gis/polygonIcon.png"></image><br>면</li>
				<li class="drawingLi" onclick="drawClick(this,'Box')"><image class="drawingLiImg" src="/images/egovframework/gis/boxIcon.png"></image><br>상자</li>
				<li class="drawingLi" onclick="drawClick(this,'Square')"><image class="drawingLiImg" src="/images/egovframework/gis/squareIcon.png"></image><br>정각형</li>
				<li id="drawingLiText" onclick="drawClick(this,'Text')"><image class="drawingLiImg" style="margin-left:5px;"src="/images/egovframework/gis/textIcon.png"></image><br>글자<input id="textMarker"></li>
				<li class="drawingLi" onclick="drawClick(this,'Init')"><image class="drawingLiImg" src="/images/egovframework/gis/eraseIcon.png"></image><br>지우기</li>
				<li class="drawingLi"><image class="drawingLiImg" src="/images/egovframework/gis/infoIcon.png"></image><br>정보</li>
			</ul>
			</div>
		</div>
		<div class="hideBtn" id="drawingHideBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px;"></image></a></div>
		<div id="measureBar">
			<div id="measureLength" onclick="measureClick(this,'Length');"><image src="/images/egovframework/gis/length.png" style="width:21px;height:21px;"></image></div>
			<div id="measureArea" onclick="measureClick(this,'Area');"><image src="/images/egovframework/gis/area.png" style="width:20px;height:20px;"></image></div>
			<div id="measureInit" onclick="measureClick(this,'Init');"><image src="/images/egovframework/gis/init.png" style="width:22px;height:22px;"></image></div>
		</div>
		<div id="rotateMap"><img src="/images/egovframework/gis/compass.png" style="width:85px;height:85px;"></img></div>
		<div id="map" style="z-index:0;"></div>
<script src="js/gisMain.js"></script>
</body>
</html>