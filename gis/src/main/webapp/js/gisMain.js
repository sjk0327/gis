/*
webapp 폴더에 있는 녀석들은 따로 비즈니스 로직이 없어도 가상의 결과물을 만들어 직접적으로 뷰를 살펴 볼 수 있다
=> Controller를 통하지 않아도 바로 결과물을 볼 수 있지만, 서버에 올릴 시 보안에는 취약하다.

WEB-INF 폴더의 경우에는 브라우저에서 직접적으로 접근이 불가한 경로이다.
=> Controller를 통해야만 접근이 가능하며, 사용자가 직접 접근이 불가하여 보안성이 높다.
*/
var map = null;
var draw = null;
var source = null;
var vector = null;

document.addEventListener('DOMContentLoaded', function(){
	
	map = new ol.Map({
		target:'map',
		layers : [
			/*세계지도*/
			new ol.layer.Tile({
				source : new ol.source.OSM()
			}),
			/*시군구*/
			new ol.layer.Tile({
				source : new ol.source.TileWMS({
					url : 'http://192.168.0.2:8080/geoserver/cite/wms',
					params : {
						'SRS' : 'EPSG:5186',
						'LAYERS' : 'cite:al_d002_11_20240121'
					},
					serverType : 'geoserver'
				}),
				visible : false
			}),
			/*대학교*/
			new ol.layer.Tile({
				source : new ol.source.TileWMS({
					url : 'http://192.168.0.2:8080/geoserver/cite/wms',
					params : {
						'SRS' : 'EPSG:5186',
						'LAYERS' : 'cite:xsdb_uv_poi_tm'
					},
					serverType : 'geoserver'
				}),
				visible : false
			})
		],
		
		controls: ol.control.defaults().extend([
        	new ol.control.ZoomSlider()
    	]),
    	keyboardEventTarget: document,

		view : new ol.View({
			center : new ol.proj.fromLonLat([126.969652,37.553836]),
			zoom : 8
		})
	});
	
	//그리기 객체
	source = new ol.source.Vector({
		wrapX : false
	});
	vector = new ol.layer.Vector({
		title : 'vector',
		source : source
	});
	
	map.addLayer(vector);
});

function layerOnOff(checkElement) {
	let num = Number(checkElement.getAttribute("id").substring(8));
	const layerArray = map.getLayers().getArray();
	const checkYN = checkElement.checked;
	layerArray[num].setVisible(checkYN);
}

function drawClick(drawType) {
	map.removeInteraction(draw);
	addInteraction(drawType);
}

function addInteraction(drawType) {
	draw = new ol.interaction.Draw({
		source : source,
		type : drawType
	});
	map.addInteraction(draw);
	
}
