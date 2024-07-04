<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://openlayers.org/en/v3.20.1/css/ol.css" type="text/css">
<script src="https://openlayers.org/en/v3.20.1/build/ol.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	.ol-zoom {
	    left: unset;
	    right: 8px;
	}
	.ol-zoomslider {
	    left: unset;
	    right: 8px;
	}
	#serchBar {
		position : absolute;
		left : 18px;
		top : 30px;
		background-color:#8E69FF; 
		width:250px;
		height:40px; 
		z-index:9999; 
		margin:0 0 0 0; 
		padding-top : 0px;
		display : flex;
		
	}
	#searchDetail {
		width : 10%;
		height : 40px;
		box-sizing: border-box;
		flex : 1;
		padding-top : 6px;
		padding-left : 6px;
	}
	#searchKeyword {
		width : 60%;
		height : 40px;
		padding-top : 7px;
		box-sizing: border-box;
		flex : 1;
	}
	#searchBtn {
		width : 15%;
		height : 40px;
		box-sizing: border-box;
		flex : 1;
		padding-top : 6px;
		padding-left : 6px;
	}
	.hideBtn {
		width : 15%;
		background-color : #000A66;
		text-align : center;
		padding-top : 3px;

	}
	#layerBar {
		position : absolute;
		left : 18px;
		top:90px; 
		width:250px;
		height:400px; 
		z-index:9999;		
	}
	#layerBarTop {
		background-color:#8E69FF; 
		width:250px;
		height:40px;
		display : flex;
	}
	#layerBarBody {
		background-color:#C0C0C0; 
		width:250px;
		height:360px;
	}
	#layerHeadText {
		width:85%;
		flex : 1;
		padding-top : 10px;
		padding-left : 6px;
		color : white;
	}
	#layerList {
		margin : 0 0 0 0; 
		padding-top : 10px; 
		padding-left : 10px;
		list-style: none;
	}
	.layerLi {
        list-style: none; /* 목록 마커(아이콘) 숨기기 */
        padding-left: 0; /* 목록의 왼쪽 여백 제거 */
    }
    #drawingBar {
		position : absolute;
		background-color:#808080; 
		left : 18px;
		top:590px; 
		width:366px;
		height:40px; 
		z-index:9999;
	}
	#drawingList {
		float: left;
		width : 326px;
	}
	#drawingUl {
		list-style : none;
		padding-left : 0;
		margin : 0 0 0 0; 
	}
	.drawingLi {
		float: left;
		width : 40px;
		padding-top : 3px; 
		text-align : center;
		font-size : 9pt;
		color : white;
		border-right : 1px solid #FFFFFF;
	}
	.drawingLi:hover {
		cursor : pointer;
  		transition: 0.3s;
  		background-color: #4B33D4;
  		font-size : 10pt;
		font-weight : bold;
	
	}
	.drawingLiImg {
		width:16px;
		height:16px;
	}
	#hideDrawBtn {
		float: left;
		width : 40px;
		background-color : #000A66;
		text-align : center;
		padding-top : 3px; 
		padding-bottom : 3px; 
		z-index:9999;
	}
</style>

<title>map</title>
</head>
<body>
		
		
		<div id="serchBar">
			<div id="searchDetail"><a><image src="/images/egovframework/gis/navigationBtn.png" style="width:30px;height:30px;"></image></a></div>
			<div id="searchKeyword"><input type="text" style="width:120px;"></div>
			<div id="searchBtn"><a><image src="/images/egovframework/gis/searchBtn.png" style="width:30px;height:30px;"></image></a></div>
			<div class="hideBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px;"></image></a></div>
		</div>
		
		<div id="layerBar">
			<div id="layerBarTop">
				<div id="layerHeadText">레이어</div>
				<div class="hideBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px;"></image></a></div>
			</div>
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
		<div id="drawingBar">
			<div id="drawingList">
			<ul id="drawingUl">
				<li class="drawingLi"><a class="selectDrawType" onclick="drawClick('Point')"><image class="drawingLiImg" src="/images/egovframework/gis/pointIcon.png"></image><br>점</a></li>
				<li class="drawingLi"><a class="selectDrawType" onclick="drawClick('LineString')"><image class="drawingLiImg" src="/images/egovframework/gis/lineIcon.png"></image><br>선</a></li>
				<li class="drawingLi"><a class="selectDrawType" onclick="drawClick('Polygon')"><image class="drawingLiImg" src="/images/egovframework/gis/polygonIcon.png"></image><br>면</a></li>
				<li class="drawingLi"><a class="selectDrawType"><image class="drawingLiImg" src="/images/egovframework/gis/boxIcon.png"></image><br>상자</a></li>
				<li class="drawingLi"><a class="selectDrawType"><image class="drawingLiImg" src="/images/egovframework/gis/squareIcon.png"></image><br>정각형</a></li>
				<li class="drawingLi"><a class="selectDrawType"><image class="drawingLiImg" src="/images/egovframework/gis/textIcon.png"></image><br>글자</a></li>
				<li class="drawingLi"><a class="selectDrawType"><image class="drawingLiImg" src="/images/egovframework/gis/eraseIcon.png"></image><br>지우기</a></li>
				<li class="drawingLi"><a class="selectDrawType"><image class="drawingLiImg" src="/images/egovframework/gis/infoIcon.png"></image><br>정보</a></li>
			</ul>
			</div>
			<div id="hideDrawBtn"><a><image src="/images/egovframework/gis/backBtn.png" style="width:30px;height:30px;"></image></a></div>
		</div>
		<div id="map" style="z-index:0;">
				
		</div>
<script src="js/gisMain.js"></script>
</body>
</html>