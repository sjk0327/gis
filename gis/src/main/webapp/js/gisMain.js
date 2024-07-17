/*
webapp 폴더에 있는 녀석들은 따로 비즈니스 로직이 없어도 가상의 결과물을 만들어 직접적으로 뷰를 살펴 볼 수 있다
=> Controller를 통하지 않아도 바로 결과물을 볼 수 있지만, 서버에 올릴 시 보안에는 취약하다.

WEB-INF 폴더의 경우에는 브라우저에서 직접적으로 접근이 불가한 경로이다.
=> Controller를 통해야만 접근이 가능하며, 사용자가 직접 접근이 불가하여 보안성이 높다.
*/
var map = null;
var draw = null;
var source = null;
var measureSource = null;
var vector = null;
var measureVector = null;

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
	//측정 그리기 객체
	measureSource = new ol.source.Vector({
		wrapX : false
	});
	vector = new ol.layer.Vector({
		title : 'vector',
		source : source
	});
	measureVector = new ol.layer.Vector({
		title : 'vector',
		source : measureSource
	});
	
	map.addLayer(vector);
	map.addLayer(measureVector);
	mapRotate();
});

document.getElementById("searchHideBtn").addEventListener("click", (e) => {
    document.getElementById("serchBarHiddenText").classList.toggle("menu-on");
    document.getElementById("serchBar").classList.toggle("menu-on");
    document.getElementById("searchDetail").classList.toggle("menu-on");
    document.getElementById("searchKeyword").classList.toggle("menu-on");
    document.getElementById("searchBtn").classList.toggle("menu-on");
    document.getElementById("searchHideBtn").classList.toggle("menu-on");
});
document.getElementById("layerHideBtn").addEventListener("click", (e) => {
    document.getElementById("layerBarBody").classList.toggle("menu-on");
    document.getElementById("layerBarTop").classList.toggle("menu-on");
    document.getElementById("layerHideBtn").classList.toggle("menu-on");

});
document.getElementById("drawingHideBtn").addEventListener("click", (e) => {
	document.getElementById("drawingBarHiddenText").classList.toggle("menu-on");
    document.getElementById("drawingBar").classList.toggle("menu-on");
    document.getElementById("drawingList").classList.toggle("menu-on");
    document.getElementById("drawingHideBtn").classList.toggle("menu-on");

});


function layerOnOff(checkElement) {
	let num = Number(checkElement.getAttribute("id").substring(8));
	const layerArray = map.getLayers().getArray();
	const checkYN = checkElement.checked;
	layerArray[num].setVisible(checkYN);
}

function drawClick(drawElement, drawType) {

  Array.prototype.slice.call(document.querySelectorAll('#drawingUl li')).forEach(function(element){
    element.classList.remove('selected');
  });
  map.removeInteraction(draw);
  
  if(drawType == 'Init') {drawInit(); return;}
  else {
	drawElement.classList.add('selected'); 
	addInteraction(drawType);
  }
}

function drawInit() {

	var features = source.getFeatures();
	for(var i=0;i<features.length;i++) {
		source.removeFeature(features[i]);
	}
	document.getElementById("textMarker").value="";
}

function addInteraction(drawType) {
	if(drawType == 'Box' || drawType == 'Square') {
		draw = new ol.interaction.Draw({
			source : source,
			type : 'Circle',
			geometryFunction : drawType == 'Box'?ol.interaction.Draw.createBox():ol.interaction.Draw.createRegularPolygon(5)
		});	
	}else if(drawType == 'Text'){
		document.getElementById("textMarker").focus();
		draw = new ol.interaction.Draw({
			source : source,
			type : 'Point'
		});
		
		draw.on('drawend', function(event) {
		  var textStyle = new ol.style.Style({
			text : new ol.style.Text({text :document.getElementById("textMarker").value})
			})	
		  event.feature.setStyle(textStyle);
		});
		
	}else {
		draw = new ol.interaction.Draw({
			source : source,
			type : drawType
		});	
	}
	map.addInteraction(draw);
}

var sketch; //라인스트링 이벤트 시 geometry객체를 담을 변수
var measureTooltipElement;//draw 이벤트가 진행 중일 때 담을 거리 값 element
var measureTooltip; //툴팁 위치

function measureClick(measureElement,type){
	map.removeInteraction(draw);
	Array.prototype.slice.call(document.querySelectorAll('#measureBar div')).forEach(function(element){
    element.classList.remove('selected');
	  });
  	map.removeInteraction(draw);
  
  	if(type == 'Init') {measureInit(); return;}
  	else {
		measureElement.classList.add('selected'); 
		measure(type);
  	}
}

function measure(type) {
	
	draw = new ol.interaction.Draw({
        source: measureSource,
        type: type == 'Area'?'Polygon':'LineString',
        style: new ol.style.Style({
            fill: new ol.style.Fill({
                color: 'rgba(255, 255, 255, 0.2)',
            }),
            stroke: new ol.style.Stroke({
                color: 'rgba(0, 0, 0, 0.5)',
                lineDash: [10, 10],
                width: 2,
            }),
            image: new ol.style.Circle({
                radius: 5
            }),
        }),
    })
    map.addInteraction(draw);
    createMeasureTooltip();
	
    var listener;
    draw.on('drawstart', function(evt) {
        console.log(evt)
        sketch = evt.feature;

		let tooltipCoord = evt.coordinate;
        listener = sketch.getGeometry().on('change', function(evt) {
            const geom = evt.target;
            let output;
            if (geom.getType()=='Polygon') {
	        	output = formatArea(geom);
	        	tooltipCoord = geom.getInteriorPoint().getCoordinates();
	      	} else if (geom.getType()=='LineString') {
            	output = formatLength(geom);
            	tooltipCoord = geom.getLastCoordinate();
            }
            measureTooltipElement.innerHTML = output;
           	measureTooltip.setPosition(tooltipCoord);
        })
    })

    draw.on('drawend', function() {
        measureTooltipElement.className = 'ol-tooptip ol-tooltip-static';
        measureTooltip.setOffset([0, -7]);

        //unset sketch
        sketch = null;
        measureTooltipElement = null;
        createMeasureTooltip();
        new ol.Observable(listener)
    })
	
}

function createMeasureTooltip() {
    if (measureTooltipElement) {
        measureTooltipElement.parentNode.removeChild(measureTooltipElement);
    }
    measureTooltipElement = document.createElement('div');
    measureTooltipElement.className = 'ol-tooltip ol-tooltip-measure';
    measureTooltip = new ol.Overlay({
        element: measureTooltipElement,
        offset: [0, -15],
        positioning: 'bottom-center',
    });
    map.addOverlay(measureTooltip);
}

function formatLength(line) {
    /*openlayers 버전3에서는 sphere.getLength가 없음..측정값이 비슷할지는 확인해봐야할듯*/
	var sphere = new ol.Sphere(6378137);
	var lineCoordinates= line.getCoordinates();
	var proj = map.getView().getProjection();
	var start = ol.proj.transform(lineCoordinates[0], proj, 'EPSG:4326');
	var end = ol.proj.transform(lineCoordinates[1], proj, 'EPSG:4326');

    var length = sphere.haversineDistance(start,end);
				
    var output;
    if (length > 100) {
        output = Math.round((length / 1000) * 100) / 100 + ' ' + 'km';
    } else {
        output = Math.round(length * 100) / 100 + ' ' + 'm';
    }

    return output;
};

function formatArea(polygon) {
	var sphere = new ol.Sphere(6378137);
	var proj = map.getView().getProjection();
	var polygonClone = (polygon.clone().transform(proj, 'EPSG:4326'));
	var polygonCoordinates= polygonClone.getLinearRing(0).getCoordinates();
	var area = Math.abs(sphere.geodesicArea(polygonCoordinates));
	
	let output;
	if(isNaN(area) == true) {
		output = 0 + ' ' + 'm<sup>2</sup>';
	} else if (area > 10000) {
		output = Math.round((area / 1000000) * 100) / 100 + ' ' + 'km<sup>2</sup>';
	} else {
		output = Math.round(area * 100) / 100 + ' ' + 'm<sup>2</sup>';
	}
	return output;

};

function measureInit() {

	var features = measureSource.getFeatures();
	for(var i=0;i<features.length;i++) {
		measureSource.removeFeature(features[i]);
	}
	map.getOverlays().clear();
}

function mapRotate(){
  
  $('#rotateMap').draggable({
    handle: 'img',
    opacity: 0.001,
    helper: 'clone',
    drag: function(event) {
      var pw = document.getElementById('rotateMap'),
        pwBox = pw.getBoundingClientRect(),
        center_x = (pwBox.left + pwBox.right) / 2,
        center_y = (pwBox.top + pwBox.bottom) / 2,
        mouse_x = event.pageX,
        mouse_y = event.pageY,
        radians = Math.atan2(mouse_x - center_x, mouse_y - center_y),
        degree = Math.round(-radians * (180 / Math.PI)) + 180;
      radians = degree*Math.PI/180;
      map.getView().setRotation(radians);
      var e = document.getElementById('rotateMap');
      if(e){e.style.transform = "rotate(" + degree + "deg)"};
    }
  });
 }
