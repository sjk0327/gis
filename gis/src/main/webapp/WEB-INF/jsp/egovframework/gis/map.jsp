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
	#serchBarHiddenText {
		position : absolute;
		left : 18px;
		top : 30px;
		padding-top : 10px;
		padding-left : 6px;
		z-index:10000; 
		color : white;
		display : none;
	}
	#serchBarHiddenText.menu-on {
		display : inline-block;
	}
	
	#serchBar {
		position : absolute;
		left : 18px;
		top : 30px;
		background-color:#8E69FF; 
		width:210px;
		height:40px; 
		z-index:9999; 
		margin:0 0 0 0; 
		padding-top : 0px;
		display : flex;
		transform: scale(1,1);
 		transition: transform 300ms;
	}
	#serchBar.menu-on {
		transform: scale(0.3,1) translateX(-242px);;
  		transition: transform 300ms;
		
	}
	
	#searchDetail {
		width : 10%;
		height : 40px;
		box-sizing: border-box;
		flex : 1;
		padding-top : 6px;
		padding-left : 6px;
	}
	#searchDetail:hover {
		cursor : pointer;
	}
	
	#searchDetail.menu-on {
		display : none;
	}
	
	#searchKeyword {
		width : 60%;
		height : 40px;
		padding-top : 7px;
		box-sizing: border-box;
		flex : 1;
	}
	#searchKeyword.menu-on {
		display : none;
	}
	
	#searchBtn {
		width : 15%;
		height : 40px;
		box-sizing: border-box;
		flex : 1;
		padding-top : 6px;
		padding-left : 6px;
	}
	#searchBtn:hover {
		cursor : pointer;
	}
	#searchBtn.menu-on {
		display : none;
	}
	
	#searchHideBtn {
		position : absolute;
		left : 228px;
		top : 30px;
		width : 40px;
		height:40px; 
		background-color : #000A66;
		text-align : center;
		z-index:9999; 
  		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);

	}
	#searchHideBtn.menu-on {
		transform: translateX(-146px) rotate(0.5turn);
  		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);
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
		width:210px;
		height:40px;
		float : left;
 		transition: transform 300ms;
 		display : inline-block;
	}
	#layerBarTop.menu-on {
		transform: scale(0.3,1) translateX(-242px);
  		transition: transform 300ms;
	}
	
	#layerHideBtn {
		float : left;
		left : 228px;
		top : 90px;
		width : 40px;
		height:40px; 
		background-color : #000A66;
		text-align : center;
		display : inline-block;
  		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);
	}
	#layerHideBtn.menu-on {
		transform: translateX(-146px) rotate(0.5turn);
  		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);
	}
	
	#layerBarBody {
		background-color:#C0C0C0; 
		width:250px;
		height:360px;
		display : block;
 		transition: transform 300ms;
	}
	#layerBarBody.menu-on {
		transform: scale(0,0);
  		transition: transform 300ms;
	}
	
	#layerBarHeadText {
		position : absolute;
		left : 18px;
		top : 90px;
		padding-top : 10px;
		padding-left : 6px;
		color : white;
		z-index:10000; 
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
    
    #drawingBarHiddenText {
		position : absolute;
		left : 18px;
		bottom:10px; 
		padding-top : 10px;
		padding-left : 6px;
		z-index:10000; 
		color : white;
		display : none;
	}
	#drawingBarHiddenText.menu-on {
		display : inline-block;
	}
    #drawingBar {
		position : absolute;
		background-color:#808080; 
		left : 18px;
		bottom:10px; 
		width:413px;
		height:40px; 
		z-index:9999;
		transition: transform 300ms;
	}
	#drawingBar.menu-on {
		transform: scale(0.2,1) translateX(-820px);;
  		transition: transform 300ms;
	}
	
	#drawingList {
		float: left;
		width : 413px;
	}
	#drawingList.menu-on {
		display : none;
	}
	
	#drawingUl {
		list-style : none;
		padding-left : 0;
		margin : 0 0 0 0; 
	}
	.drawingLi{
		float: left;
		width : 40px;
		padding-top : 3px; 
		text-align : center;
		font-size : 9pt;
		color : white;
		border-right : 1px solid #FFFFFF;
	}
	.drawingLi:hover, #drawingLiText:hover, .drawingLi.selected, #drawingLiText.selected {
		cursor : pointer;
  		transition: 0.3s;
  		background-color: #4B33D4;
  		font-size : 10pt;
		font-weight : bold;
	}
	#drawingLiText {
		float: left;
		width : 120px;
		padding-top : 3px; 
		padding-left : 7px;	
		font-size : 9pt;
		color : white;
		border-right : 1px solid #FFFFFF;
	}
	.drawingLiImg {
		width:16px;
		height:16px;
	}
	#selectDrawTypeText {
		float : left;
		padding-left : 7px;		
	}
	#textMarker {
		width:70px; 
		float : right;
		margin-top : -12px;
		margin-right : 7px;
	}
	#drawingHideBtn {
		position : absolute;
		left : 430px;
		bottom:10px; 
		width : 40px;
		z-index:9999;
		background-color : #000A66;
		text-align : center;
		padding-top : 3px; 
		padding-bottom : 3px; 
		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);
	}
	#drawingHideBtn.menu-on {
		transform: translateX(-328px) rotate(0.5turn);
  		transition: transform 300ms cubic-bezier(0.4, 0, 0.2, 1);
	}
	
	.hideBtn:hover {
		cursor : pointer;
	}
	.layerLi label:hover, input:hover {
		cursor : pointer;
	}
	#measureBar {
		position : absolute;
		right : 16px;
		top : 300px;
		width : 30px;
		height : 120px;
		z-index:9999;
		background-color : white;
		opacity : 0.6;
		padding-top : 7px;	
	}

	#measureLength {
		text-align : center;
	}
</style>

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
		<div id="map" style="z-index:0;"></div>
		<div id="measureBar">
			<div id="measureLength" onclick="measureLength();"><image src="/images/egovframework/gis/length.png" style="width:20px;height:20px;"></image></div>
		</div>
		
		
<script src="js/gisMain.js"></script>
</body>
</html>