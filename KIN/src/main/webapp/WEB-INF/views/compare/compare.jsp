<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유치원 한 눈에 비교하기</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/compare.css" rel="stylesheet" type="text/css" />
<link href="resources/script/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="resources/script/jqueryui/jquery-ui.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44694e80891ede312de6d526b4b7f5a0&libraries=services"></script>
<script type="text/javascript">
// 마커 좌표 보관
var markers = [];

// 유치원 주소 보관
var address = [];
    address.push('${kinA.KIN_ADDR}');
    address.push('${kinB.KIN_ADDR}');

// 유치원명 보관
var kinGbn = [];
kinGbn.push('${kinA.KIN_NM}');
kinGbn.push('${kinB.KIN_NM}');

$(document).ready(function() {
	$( "#tabs" ).tabs();

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

	// 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 지도 범위 설정
	var bounds = new kakao.maps.LatLngBounds();
	
	// 마커 아이콘 설정
	var imageSrc = 'resources/images/kin/map_marker.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(49, 50), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(25, 50)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
   // 주소 -> 좌표 번환 
    address.forEach(function(data, i) {
  	     // 주소로 좌표를 검색합니다
          geocoder.addressSearch(data, function(result, status) {
              // 정상적으로 검색이 완료됐으면 
               if (status === kakao.maps.services.Status.OK) {

                   var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
              }

              var positions = [
                  {
                      latlng: coords
                  }];

	          // 마커를 생성합니다
              var marker = new kakao.maps.Marker({
                  map: map, // 마커를 표시할 지도
                  position: positions[0].latlng, // 마커를 표시할 위치
                  image: markerImage, // 마커 이미지
				  title: kinGbn[i]
              });
              markers.push(marker);
              infoW(i, marker);
 	 	}); // geocoder end
   }); // forEach end

// 지도 범위 설정 
function setBounds() {
    var bounds = new kakao.maps.LatLngBounds();    

    var i;
    for (i = 0; i < markers.length; i++) {
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(markers[i].getPosition());
    }
        map.setBounds(bounds);
} // setBounds end

// 인포윈도우 + customOverlay
function infoW(i, marker)  {
	var iwContent = '<div style="font-weight:bold; padding:5px; border-radius: 3px; width:auto; background-color:white; position:relative; bottom:53px;">' + marker.getTitle() + '</div>';
	
	var customOverlay = new kakao.maps.CustomOverlay({
	    position: marker.getPosition(),
	    content: iwContent,
	    yAnchor: 1,
	    map: map
	});
	
	setBounds();
} // infoW end

}); // doc ready end
</script>
</head>
<body>
<c:import url="/header" ></c:import>
<!-- 유치원 간편비교  -->
<div class="p">
	<div class="title">유치원 한 눈에 비교하기</div>
	<span class="GBN">홈 > 즐겨찾기 > 유치원 한 눈에 비교하기</span><br/><br/><br/><br/>
	<form action="#" id="actionForm" method="post" >
		<!-- 비교대상 보관값 -->
		<input type="hidden" id="no" name="no" value="${param.kins}" />
		<!-- 요약 > 주소 디테일 수정 -->
		<input type="hidden" id="addrA" value="${kinA.KIN_ADDR}" />
		<input type="hidden" id="addrB" value="${kinB.KIN_ADDR}" />
	</form>
	
		<!-- Tabs -->
	<div id="tabs" class="ui-tabs ui-corner-all ui-widget ui-widget-content">
		<ul role="tablist" class="ui-tabs-nav ui-corner-all ui-helper-reset ui-helper-clearfix ui-widget-header">
         <li role="tab" tabindex="0" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab ui-tabs-active ui-state-active" aria-controls="tabs-1" aria-labelledby="ui-id-15" aria-selected="true" aria-expanded="true"><a href="#tabs-1" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-15">요약</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-2" aria-labelledby="ui-id-16" aria-selected="false" aria-expanded="false"><a href="#tabs-2" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-16">기본현황</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-3" aria-labelledby="ui-id-17" aria-selected="false" aria-expanded="false"><a href="#tabs-3" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-17">영유아/교직원</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-4" aria-labelledby="ui-id-18" aria-selected="false" aria-expanded="false"><a href="#tabs-4" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-18">교육/보육과정</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-5" aria-labelledby="ui-id-19" aria-selected="false" aria-expanded="false"><a href="#tabs-5" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-19">안전점검</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-6" aria-labelledby="ui-id-20" aria-selected="false" aria-expanded="false"><a href="#tabs-6" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-20">영양/환경위생</a></li>
      </ul>
			<!-- 요약 -->
			<div id="tabs-1" aria-labelledby="ui-id-15" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="false">
				<div class="tInfo">
				<table class="tBasic bs">
					<thead>
						<tr>
							<th>${kinA.KIN_NM}</th>
							<th>구분</th>
							<th>${kinB.KIN_NM}</th>
						</tr>	
					</thead>
					
					<tbody>
						<tr>
							<td>${kinA.E_TP}</td>
							<td>설립유형</td>
							<td>${kinB.E_TP}</td>
						</tr>
						<tr>
							<td>${kinA.E_DT}</td>
							<td>설립일</td>
							<td>${kinB.E_DT}</td>
						</tr>
						<tr>
							<td>${kinA.O_DT}</td>
							<td>개원일</td>
							<td>${kinB.O_DT}</td>
						</tr>
						<tr>
							<c:choose>
			      				<c:when test="${not empty kinA.HP}">
				      				<td><a href="${kinA.HP}"><img src="resources/images/kin/website.png" class="ico" title="${kin.HP}"></a></td>
			      				</c:when>
			      				<c:otherwise>
			      					<td>-</td>
			      				</c:otherwise>
			      			</c:choose>
							<td>홈페이지</td>
							<c:choose>
			      				<c:when test="${not empty kinB.HP}">
				      				<td><a href="${kinB.HP}"><img src="resources/images/kin/website.png" class="ico" title="${kin.HP}"></a></td>
			      				</c:when>
			      				<c:otherwise>
			      					<td>-</td>
			      				</c:otherwise>
			      			</c:choose>
						</tr>
						<tr>
							<td class="addrD" addr="${kinA.KIN_ADDR}">${kinA.KIN_ADDR}</td>
							<td>주소</td>
							<td class="addrD" addr="${kinB.KIN_ADDR}">${kinB.KIN_ADDR}</td>
						</tr>
						<tr>
							<td>${kinA.AVG}</td>
							<td>평균별점</td>
							<td>${kinB.AVG}</td>
						</tr>
					</tbody>
				</table>
				</div>
					<div id="map" ></div>
				</div>
			
			<!-- 기본현황 -->
			<div id="tabs-2" aria-labelledby="ui-id-16" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
			<div class="tInfo" id="basic">
				<table class="tBasic">
		      	<colgroup>
		      		<col width="330">
		      		<col width="*">
		      		<col width="330">
		      	</colgroup>
					<thead>
						<tr>
							<th>${kinA.KIN_NM}</th>
							<th>구분</th>
							<th>${kinB.KIN_NM}</th>
						</tr>	
					</thead>
					
					<tbody>
						<tr>
							<td>${infoA.EDU_OF}</td>
							<td>기관명</td>
							<td>${infoB.EDU_OF}</td>
						</tr>
						<tr>
							<td>${infoA.CLR_CNT}</td>
							<td>교실수</td>
							<td>${infoB.CLR_CNT}</td>
						</tr>
						<tr>
							<td>${infoA.SBUS_YN}</td>
							<td>통학차량</td>
							<td>${infoB.SBUS_YN}</td>
						</tr>
						<tr>
							<td>${infoA.ARCH_YR}</td>
							<td>건축년도</td>
							<td>${infoB.ARCH_YR}</td>
						</tr>
						<tr>
							<td>${infoA.BLDG_PV_AR}㎡</td>
							<td>건물전용면적</td>
							<td>${infoB.BLDG_PV_AR}㎡</td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			
			<!-- 영유아/교직원 -->
			<div id="tabs-3" aria-labelledby="ui-id-17" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
				<div class="tInfo" id="staff">
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="9" class="tTitle">교직원 현황</th>
							</tr>
							<tr>
								<th rowspan="2">구분</th>
								<th rowspan="2" class="a" >총 교직원 수</th>
								<th colspan="3" class="a" >직위별 교원</th>
								<th colspan="3" class="a" >유치원 교사 자격</th>
								<th rowspan="2" class="a" >평균 근속연수</th>
							</tr>
							<tr>
								<th class="a" >교사</th>
								<th class="a">특수교사</th>
								<th class="a">보건교사</th>
								<th class="a">1급 정교사</th>
								<th class="a">2급 정교사</th>
								<th class="a">준교사</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${staffA.SUM_TCNT}</td>
								<td>${staffA.T_CNT}</td>
								<td>${staffA.SPET_CNT}</td>
								<td>${staffA.HTT_CNT}</td>
								<td>${staffA.SRT_1GR_QLF_CNT}</td>
								<td>${staffA.SRT_2GR_QLF_CNT}</td>
								<td>${staffA.JRT_QLF_CNT}</td>
								<td>${avgA.AVG_YR}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${staffB.SUM_TCNT}</td>
								<td>${staffB.T_CNT}</td>
								<td>${staffB.SPET_CNT}</td>
								<td>${staffB.HTT_CNT}</td>
								<td>${staffB.SRT_1GR_QLF_CNT}</td>
								<td>${staffB.SRT_2GR_QLF_CNT}</td>
								<td>${staffB.JRT_QLF_CNT}</td>
								<td>${avgB.AVG_YR}</td>
							</tr>
						</tbody>
					</table>
					
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="4" class="tTitle">학급별 유아수</th>
							</tr>
							<tr>
								<th rowspan="2">구분</th>
								<th colspan="3" class="a" >학급별</th>
							</tr>
							<tr>
								<th class="a" >만 3세 교실</th>
								<th class="a">만 4세 교실</th>
								<th class="a">만 5세 교실</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${avgPPA.AGE3_AVG}</td>
								<td>${avgPPA.AGE3_AVG}</td>
								<td>${avgPPA.AGE3_AVG}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${avgPPA.AGE3_AVG}</td>
								<td>${avgPPA.AGE3_AVG}</td>
								<td>${avgPPA.AGE3_AVG}</td>
							</tr>
						</tbody>
					</table>
				</div>				
			</div>
			
			<!-- 교육/보육과정  (EDU)-->
			<div id="tabs-4" aria-labelledby="ui-id-18" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
				<div class="tInfo" id="staff">
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="5" class="tTitle">수업일수 및 비용</th>
							</tr>
							<tr>
								<th>구분</th>
								<th class="a" >수업일수 평균</th>
								<th class="a" >만 3세 수업일수</th>
								<th class="a" >만 4세 수업일수</th>
								<th class="a" >만 5세 수업일수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${eduA.LSN_CNT_AVG}</td>
								<td>${eduA.AGE3_LSN_CNT}</td>
								<td>${eduA.AGE4_LSN_CNT}</td>
								<td>${eduA.AGE5_LSN_CNT}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${eduB.LSN_CNT_AVG}</td>
								<td>${eduB.AGE3_LSN_CNT}</td>
								<td>${eduB.AGE4_LSN_CNT}</td>
								<td>${eduB.AGE5_LSN_CNT}</td>
							</tr>
						</tbody>
					</table>
					
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="9" class="tTitle">방과후 과정</th>
							</tr>
							<tr>
							
								<th rowspan="2">구분</th>
								<th rowspan="2" class="a">방과후과정<br>수업일수</th>
								<th colspan="2" class="a" >기본</th>
							</tr>
							<tr>
								<th class="a">시작시간</th>
								<th class="a">종료시간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${eduA.AFT_LSN_CNT}</td>
								<td>${eduA.AFT_ST_TIME}</td>
								<td>${eduA.AFT_END_TIME}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${eduB.AFT_LSN_CNT}</td>
								<td>${eduB.AFT_ST_TIME}</td>
								<td>${eduB.AFT_END_TIME}</td>
							</tr>
						</tbody>
					</table>
				</div>				
			
			</div>
			
			<!-- 안전교육/안전점검 -->
			<div id="tabs-5" aria-labelledby="ui-id-19" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
				<div class="tInfo" id="staff">
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="4" class="tTitle">안전점검</th>
							</tr>
							<tr>
								<th>구분</th>
								<th class="a" >가스 점검여부</th>
								<th class="a" >소방안전 점검여부</th>
								<th class="a" >전기설비 점검여부</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${safeA.GAS_YN}</td>
								<td>${safeA.FIRE_YN}</td>
								<td>${safeA.ELEC_YN}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${safeB.GAS_YN}</td>
								<td>${safeB.FIRE_YN}</td>
								<td>${safeB.ELEC_YN}</td>
							</tr>
						</tbody>
					</table>
				</div>	
			</div>
			
			<!-- 영양/환경위생 -->
			<div id="tabs-6" aria-labelledby="ui-id-20" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
				<div class="tInfo" id="staff">
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="7" class="tTitle">급식 실시 현황</th>
							</tr>
							<tr>
								<th rowspan="2">구분</th>
								<th rowspan="2" class="a">운영방식</th>
								<th rowspan="2" class="a">영양교사</th>
								<th colspan="3" class="a">취사인력</th>
								<th rowspan="2" colspan="5" class="a">집단급식소 신고</th>
							</tr>
							<tr>
								<th class="a">취사부</th>
								<th class="a">조리사</th>
								<th class="a"> 계 </th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${dietA.ML_OPER_TP}</td>
								<td>${dietA.DIETT_YN}</td>
								<td>${dietA.CM_CNT}</td>
								<td>${dietA.CK_CNT}</td>
								<td>${dietA.SUM_CNT}</td>
								<td>${dietA.ML_DCLR_YN}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${dietB.ML_OPER_TP}</td>
								<td>${dietB.DIETT_YN}</td>
								<td>${dietB.CM_CNT}</td>
								<td>${dietB.CK_CNT}</td>
								<td>${dietB.SUM_CNT}</td>
								<td>${dietB.ML_DCLR_YN}</td>
							</tr>
						</tbody>
					</table>
					
					<table class="tStaff">
						<thead>
							<tr>
								<th colspan="4" class="tTitle">정기 소독</th>
							</tr>
							<tr>
								<th>구분</th>
								<th class="a" >실시여부</th>
								<th class="a" >점검결과</th>
								<th class="a" >점검일자</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>${kinA.KIN_NM}</th>
								<td>${saniA.DSNF_YN}</td>
								<td>${saniA.DSNF_CHK_RES}</td>
								<td>${saniA.DSNF_DT}</td>
							</tr>
							<tr>
								<th>${kinB.KIN_NM}</th>
								<td>${saniB.DSNF_YN}</td>
								<td>${saniB.DSNF_CHK_RES}</td>
								<td>${saniB.DSNF_DT}</td>
							</tr>
						</tbody>
					</table>
				</div>				
			</div>
	</div>
</div>
	<div class="bottom"></div>		
</body>
</html>