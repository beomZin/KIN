<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지도</title>
<c:import url="/cmn"></c:import>
<style>
.mid {
	width: 1100px;
	margin: 0 auto;
	position: relative;
	min-height: 700px;
}

.mid1 {
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1190px;
}

.mid1_1{
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 22.4px;
	height: 30px;
	line-height: 30px;
	width: 200px;
	color: #262626;
	font-weight : bold;
	float: left;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 3%;
}

.mid2 {
	margin-top : 10px;
	height : 50px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid3 {
	position: relative;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	border-top: 2px solid #262626;
}

.mid3_1 {
	padding-top : 15px;
	padding-bottom : 15px;
	display: inline-block;
	width : 200px;
	border : 3px solid #F1F1F1;
	font-size : 16.8px;
	font-weight: bold;
	text-align : center;
	border-radius: 5px;
	position: absolute;
	top:0px;
	left:-230px;
}

table {
	border-collapse: collapse;
	border: 1px solid #F1F1F1;
	font-size : 16.8px;
	margin: 20px auto 20px;
	background-color: #F1F1F1;
	font-weight: normal;
}

tr {
	height: 35px;
}

td:nth-child(2) {
	text-align: left;
	padding-left: 10px;
}

.mid3_1_btn {
	display : inline-block;
	width : 172px;
	border: 1px solid #4F4D8C;
	font-size : 16.8px;
	padding: 10px 0px 10px;
	background-color: #4F4D8C;
	color : #FFFFFF;
	border-radius: 5px;
}

.mid3_1_btn:hover {
	cursor : pointer;
}

.bottom {
	margin-top: 30px;
	background: #4b4a6e;
	height: 150px;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44694e80891ede312de6d526b4b7f5a0&libraries=services"></script>
<script>
$(document).ready(function () {
	
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1}),
		markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };
	
	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	//장소 검색 객체를 생성합니다
 	var ps = new kakao.maps.services.Places(map); 
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${param.dis}', function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    }  
	});
	
	// 마커 표시
	searchPlaces();
	
	// 지도에 idle 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', searchPlaces);
	
	// 카테고리 검색을 요청하는 함수입니다
	function searchPlaces() {
		var currCategory = "PS3"
		
	    if (!currCategory) {
	        return;
	    }
	    
		// 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
		 
	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	        displayPlaces(data);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

	    } else if (status === kakao.maps.services.Status.ERROR) {
	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	    }
	}
	
	// 지도에 마커를 표출하는 함수입니다
	function displayPlaces(places) {   

	    for ( var i=0; i<places.length; i++ ) {

	            // 마커를 생성하고 지도에 표시합니다
	            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x));

	            // 마커와 검색결과 항목을 클릭 했을 때
	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	            (function(marker, place) {
	                kakao.maps.event.addListener(marker, 'click', function() {
	                	// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	          	        infowindow.setContent('<div style="width:170px;text-align:center;padding:5px 0;font-size:12px;">' + place.place_name + '</div>');
	          	        infowindow.open(map, marker);
	                });
	            })(marker, places[i]);
	    }
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, order) {
	    var imageSrc = 'resources/images/kin/map_marker.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	    	imageSize = new kakao.maps.Size(49, 50),  // 마커 이미지의 크기
	        imgOptions =  {offset: new kakao.maps.Point(25, 50)},
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	
	
});
</script>
</head>
<body>
<c:import url="/header"></c:import>
    <div class="mid">
    	<div class="mid1">
    		<span class="GBN">홈 > 지도</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid1_1">지도에서 찾기</div>
    	</div>
    	<div class="mid3">
			<div id="map" style="width:1100px; height:800px;"></div>
    	</div>
    </div>
    <div class="bottom"></div>
</body>
</html>