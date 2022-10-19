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
$(document).ready(function() {
	//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
	
	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var imageSrc = 'resources/images/kin/map_marker.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(49, 50), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(25, 50)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${param.kinAddr}', function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	        	map: map,
	            position: coords,
	        	image: markerImage // 마커이미지 설정 
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:170px;text-align:center;padding:5px 0;font-size:12px;">${param.kinNm}</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	    
	});
	
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