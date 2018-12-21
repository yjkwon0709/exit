<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
	<title>Map</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><base>
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
	
	<!-- <link rel="stylesheet" href="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/css/ol.css" type="text/css"> -->
    <style>
    	li{list-style:none;}
	  #mapMenuLeft {visibility: hidden; height: 100%; width: 300px; margin:0; padding: 0; position: absolute; background-color: white; z-index: 1000;}
	  
	  #mapMenuLeftBtnC {float: right;}
	  #mapMenuLeftBtnO {margin:0; padding: 0; position: absolute; z-index: 999;}
      
      .map { height: 900px;  width: 1200px; margin: 0;padding: 0; position: absolute; z-index: 1;}
      .mapBtn li {list-style:none; margin-left: 5px; float: left; background-color: yellow;}
      .mapBtn {position: absolute; z-index: 100; margin: 0; padding: 0; top: 20px; right: 100px;}
      
      body {margin:0; padding:0; height: 100%; width: 100%; overflow-x: hidden; overflow-y: hidden; float: right;}
    </style>
    <script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
  </head>
  <body>
	  
    <div id="map" class="map">
    	<button id="mapMenuLeftBtnO">열기</button>
    	<div id="mapMenuLeft">
    		<button id="mapMenuLeftBtnC">접기</button>
    		<ul>
    			<li><a>맵 정보</a></li>
    			<li><a>데이터 보기</a></li>
    		</ul>
    	</div>
    	 <ul class="mapBtn">
	   		<li><button id="mapReset">초기화</button></li>
	   		<li><button id="mapInitLoc">초기위치</button></li>
	   		<li><button id="mapSelectAtr">속성조회</button></li>
	   		<li><button id="mapEditLoc">위치정보수정</button></li>
	   		<li><button id="mapInputLoc">위치정보입력</button></li>
	   	</ul>
    </div>
   
	<script type="text/javascript">
		$(document).ready(function(){
			document.getElementById("mapInitLoc").addEventListener("click", function(e) {
				map.getView().setZoom(7); map.getView().setCenter(ol.proj.fromLonLat([126.956764, 37.540705]));
			});
			
			document.getElementById("mapMenuLeftBtnO").addEventListener("click", function(e) {
				document.getElementById("mapMenuLeft").style.visibility="visible";
			});
			document.getElementById("mapMenuLeftBtnC").addEventListener("click", function(e) {
				document.getElementById("mapMenuLeft").style.visibility="hidden";
			});
			
		});
		
		var mapReset;		//초기화
		var mapInitLoc;		//초기위치로 이동
		var mapSelectAtr;	//속성조회
		var mapEditLoc;		//
		var mapInputLoc;	//
		var mapFullSc;		//전체화면
		
		// controller
		var fullScCnt;
		var zmSlCnt;
		var zmCnt;
		
		var map;
		var view;
		var bounds;			
		var initLoc;		//초기위치

		//init setting
		bounds = [13871821.078174168, 3910406.967935773, 14689242.146545349, 4685005.20686589];
		
		view = new ol.View({
			center: ol.proj.fromLonLat([126.956764, 37.540705]),
			//extent : bounds,
			maxZoom : 19,
			zoom : 7
		})
		
		fullScCnt = new ol.control.FullScreen();
		zmCnt = new ol.control.Zoom();
		
		fullScCnt.element.style.cssText="top: 20px; right: 20px; position: absolute;";
		fullScCnt.element.firstElementChild.innerHTML="전체보기";
		
		zmCnt.element.style.cssText="top: 20px; left: 20px; position: absolute;";
		map = new ol.Map({
			target: 'map',
			renderer: 'canvas',
			layers: [
				new ol.layer.Tile({
					source: new ol.source.OSM()
				})
			],
			view : view,
			controlls: []
		});
		
		map.addControl(fullScCnt);
		map.addControl(zmCnt);
		mapFullSc = document.getElementById("mapFullSc");
		
		
	</script>


</html>