/*
webapp 폴더에 있는 녀석들은 따로 비즈니스 로직이 없어도 가상의 결과물을 만들어 직접적으로 뷰를 살펴 볼 수 있다
=> Controller를 통하지 않아도 바로 결과물을 볼 수 있지만, 서버에 올릴 시 보안에는 취약하다.

WEB-INF 폴더의 경우에는 브라우저에서 직접적으로 접근이 불가한 경로이다.
=> Controller를 통해야만 접근이 가능하며, 사용자가 직접 접근이 불가하여 보안성이 높다.
*/
var map = null;

document.addEventListener('DOMContentLoaded', function(){
	
	map = new ol.Map({
		target:'map',
		layers : [
			new ol.layer.Tile({
				source : new ol.source.OSM()
			})
		],
		
		view : new ol.View({
			center : new ol.proj.fromLonLat([126.969652,37.553836]),
			zoom : 8
		})
	});
	const newDiv = document.createElement('div');
	newDiv.style.position="absolute";
	newDiv.style.width="100px";
	newDiv.style.height="300px";
	newDiv.style.backgroundColor="red";
	document.body.appendChild(newDiv);
});