<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유치원 상세정보</title>
<c:import url="/cmn"></c:import>
<link href="resources/script/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" />
<style type="text/css">
table {
	display: inline-table;
	border-collapse: collapse;
	color: #262626;
	margin-top: 20px;
	width:950px;
	text-align: center;
	font-size:14px;
}

th, td {
	border-left: 1px solid #f1f1f1;
	border-bottom: 1px solid #f1f1f1;
}

tr {
	height: 40px;
}

thead {
	font-weight: bold;
}

.b {
	font-weight: bold;
}

thead tr:nth-child(1) {
	height: 40px;
	text-align: left;
	font-size: 16.8px;
	border-bottom: 2px solid #262626;
	background-color: #fff;
}

th {
	border-left: none;
}

.td_1st {
	border-left: none;
}

.p {
   display: block;
   width: 1100px;
   font-family: 맑은고딕, "Malgun Gothic", dotum, gulim, sans-serif;
   text-align: left;
   margin: 0 auto;
   position: relative;
   min-height: 700px;
}

.title {
   height: 30px;
   line-height: 30px;
   margin: 20px 20px 20px 60px;
   color: #262626;
   font-size: 22.4px;
   font-weight: bold;
   letter-spacing: -.05em;
   display: inline-block;
}

.kin_name {
	font-size: 22.4px;
	font-weight: bold;
}

.tb_s {
	width: 400px;
	margin-top: 0px;
	text-indent: 10px;
	text-align: left;
}

.tb_s thead {
	height:0px;
}


.tb_l td {
	text-align: left;
	padding-left: 10px;
}

.tb_sub {
	margin-top: 20px;
}

.tb_sub thead {
	height:0px;
}

.review_head {
	width: 950px;
	margin: 0px auto;
	font-size: 0;
	border-bottom: 1px solid #262626;
}

.reviewer {
	width: 200px;
	height: 20px;
	font-size: 16.8px;
	margin-bottom: 10px;
}

.rate {
	display: inline-block;
	width: 60px;
	font-size: 15.4px;
}

.date {
	display: inline-block;
	width: 120px;
	font-size: 15.4px;
}

#map {
	float:right;
	width: 550px;
	height: 400px;
}


.GBN {
   opacity: 0.6;
   letter-spacing: -.1em;
   font-size: 12px;
   position : absolute;
   right: 5%;
   top: 10px;
}

.tReview {
	margin-bottom: 20px;
}

.tReview th {
	text-align: center;
}

.tReview td {
	border-right: none;
	border-left: none;
}


.tReview td:nth-child(2) {
	padding: 10px;
	white-space: pre-wrap;
	text-align: left;
}


.boxBtn {
	line-height: 30px;
	height: 30px;
	width: 75px;
	border: 1px solid #fff;
	border-radius: 5px;
	color: #262626;
	font-size: 12px;
	text-align: center;
	margin: 0 auto;
	display: block;
}

.boxBtn:hover {
	border: 1px solid #8F8EBF;
	color: #262626;
	cursor: pointer;
	box-shadow: 1px 1px 4px 1px #f1f1f1;
}

.repHead, .reply {
	background: #FFFFFF;
	padding: 10px 0px 10px 10px;
	border: 1px solid #f1f1f1;
	border-radius: 5px;
	width: 950px;
	background: #FFFFFF;
	padding: 10px 0px 10px 10px;
	border: 1px solid #f1f1f1;
	border-radius: 5px;
	width: 950px;
	position: relative;
	box-shadow: 1px 1px 4px 1px #f1f1f1;
}

.repHead {
	height: 20px;
	margin-top: 20px;
}

.reply {
	height: 100px;
	margin-top: 5px;
}

.repCont {
	width: 90%;
	height: 95px;
	border: none;
	resize: none;
	font-size: 14px;
	font-family: 맑은고딕, "Malgun Gothic", dotum, gulim, sans-serif;
}

.repCont:focus {
	outline: none;
}

.replyBtn {
	margin-top: 5px;
	display: block;
	line-height: 30px;
	height: 30px;
	width: 75px;
	border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	color: #f1f1f1;
	border-radius: 5px;
	font-size: 15.4px;
	font-weight: bold;
	text-align: center;
	top: calc(100% - 45px);
	right: calc(1%);
	position: absolute;
}

.replyBtn:hover {
	border: 1px solid #4F4D8C;
	background-color: #e1e1fb;
	color: #262626;
	cursor: pointer;
}

.selStar {
	outline: none;
	border: none;
	width: 100px;
}

.ico {
	height: 32px;
	margin-top: 2px;
	cursor: pointer;
}

.crud_ico {
	margin: 10px;
	cursor: pointer;
}

.rate_ico {
	width: 100px;
}

.bottom {
	background: #4b4a6e;
	height: 150px;
}

</style>
<script type="text/javascript" src="resources/script/jqueryui/jquery-ui.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44694e80891ede312de6d526b4b7f5a0&libraries=services"></script>
<script type="text/javascript">
$(document).ready(function() {
   $("#tabs").tabs();
   
   reloadList();
   
   $("#addr").on("click", function() {
	   $("#addrForm").attr("action", "addrMap");
	   $("#addrForm").submit();
   }); 
   
   $("#insertBtn").on("click", function() {
		if($.trim($("#fbCon").val()) == "") {
			makeAlert("알림", "내용을 입력하세요", function() {
				$("#fbCon").focus();   
			});
		} else if($("#rate").val() == "0") {
			makeAlert("알림", "별점을 선택하세요", function() {
				$("#rate").focus();   
			});			
		} else {
			action("insert");
			$("#fbList tbody").empty();
			$("#page").val(1);
		}
	});
   
	// 목록의 수정버튼 클릭 시
	$("#fbList tbody").on("click", ".update_btn", function() {
		var fbNo = $(this).parent().parent().attr("fbNo");
		$("#fbNo").val(fbNo);
		
		// eq(인덱스번호) : 자식들중 인덱스 몇 번째인지 찾아서 취득
		var fbCon = $(this).parent().parent().children().eq(1).html();
		var rate = $(this).parent().parent().children().eq(0).children().attr("rate");
		
		fbCon = fbCon.replace(/&lt;/gi, "<");
		fbCon = fbCon.replace(/&gt;/gi, ">");
		
		$("#fbCon").val(fbCon);
		$("#rate").val(rate);
		
		// 등록버튼 감추기 + 수정,취소버튼 나타나기
		$("#insertBtn").hide();
		$("#updateBtn").show();
		
		// 작성영역에 포커스
		$("#fbCon").focus();
	});
	
	// 수정 영역의 수정버튼
	$("#updateBtn").on("click", function() {
		if($.trim($("#fbCon").val()) == "") {
			makeAlert("알림", "내용을 입력하세요", function() {
				$("#fbCon").focus();   
			});
		} else if($("#rate").val() == "0") {
			makeAlert("알림", "별점을 선택하세요", function() {
				$("#rate").focus();   
			});			
		} else {
			action("update");
			$("#fbList tbody").empty();
			$("#page").val(1);
		}
	});
	
   // 목록의 삭제버튼 클릭 시
	$("#fbList tbody").on("click", ".delete_btn", function() {
		
		var fbNo = $(this).parent().parent().attr("fbNo");
		
		makePopup({
			title: "알림",
			contents : "삭제하시겠습니까?",
			buttons : [{
				name: "삭제",
				func:function() {
						$("#fbNo").val(fbNo);
						action("delete");
						closePopup();
						$("#fbList tbody").empty();
						$("#page").val(1);
					}
				}, {
					name : "취소"
				}]
			});
	});
   
 //마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };  

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var imageSrc = 'resources/images/kin/map_marker.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(49, 50), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(25, 50)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${kin.KIN_ADDR}', function(result, status) {
		
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
	            content: '<div style="width:190px;text-align:center;padding:5px 0;">${kin.KIN_NM}</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	    
	}); // kakao api end
	
	$(".boxBtn").on("click", function() {
		
		$("#page").val($("#page").val() * 1 + 1);
		reloadList();
	});
}); // doc.ready end

function reloadList() {
	var params = $("#fbForm").serialize();
    $.ajax({
       url : "fbListAjax", //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
          drawList(res.fbList);
       
       // 등록버튼 나타나기 + 수정,취소버튼 감추기
		   $("#insertBtn").show();
		   $("#updateBtn").hide();
       },
       error : function(request, status, error) { //실패했을 때 함수 실행
          console.log(request.responseText); //실패 상세내역
       }
    });
}

function drawList(fbList) {
	var html = "";
	
	for(var data of fbList) {		
		html += "<tr fbNo=\"" + data.FB_NO + "\">";
		html += "<td>"
		if(data.RATE == "1") {
			html += "<img rate=\"1\" class=\"rate_ico\" src=\"resources/images/kin/score1.png\" height=\"20px\">"
		} else if (data.RATE == "2") {
			html += "<img rate=\"2\" class=\"rate_ico\" src=\"resources/images/kin/score2.png\" height=\"20px\">"
		} else if (data.RATE == "3") {
			html += "<img rate=\"3\" class=\"rate_ico\" src=\"resources/images/kin/score3.png\" height=\"20px\">"
		} else if (data.RATE == "4") {
			html += "<img rate=\"4\" class=\"rate_ico\" src=\"resources/images/kin/score4.png\" height=\"20px\">"
		} else if (data.RATE == "5") {
			html += "<img rate=\"5\" class=\"rate_ico\" src=\"resources/images/kin/score5.png\" height=\"20px\">"
		}
		html += "</td>";
		html += "<td>" + data.CON + "</td>";
		html += "<td>" + data.NICK + "</td>";
		html += "<td>" + data.REG_DT + "</td>";
		html += "<td>"
		if(data.U_NO == "${sNo}") {			
			html += "<img class=\"crud_ico update_btn\" src=\"resources/images/kin/write.png\" height=\"20px\">"
				  + "<img class=\"crud_ico delete_btn\" src=\"resources/images/kin/delete.png\" height=\"20px\">"
		}
		html +=	"</td>";
		html += "</tr>";
	}
	
	$("#fbList tbody").append(html);
}

var msg = {
		"insert" : "등록",
		"update" : "수정",
		"delete" : "삭제"
}

function action(flag) {
	$("#fbCon").val($("#fbCon").val().replace(/</gi, "&lt;"))
	$("#fbCon").val($("#fbCon").val().replace(/</gi, "&gt;"))
	
	// JavaScript Object에서의 [] : 해당 키값으로 내용을 불러오거나 넣을 수 있다.
	// 							 Java의 Map에서 get, put역할
	var params = $("#fbActionForm").serialize();
    $.ajax({
       url : "fbAction/" + flag, //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 res에 받고 함수 실행
    	   switch(res.msg) {
    	   case "success":
    		// 내용 초기화
    		   $("#fbNo").val("");
    		   $("#fbCon").val("");
    		   $("#rate").val("0");
    		   
    		   // 목록 재조회
    		   switch(flag) {
    		   case "insert" :
    		   case "delete" :
    			// 내용 초기화
        		   $("#fbNo").val("");
        		   $("#fbCon").val("");
        		   $("#rate").val("0");
    			   
    			   	break;
    			   	
    		   case "update" :
    			   
    			// 내용 초기화
        		   $("#fbNo").val("");
        		   $("#fbCon").val("");
        		   $("#rate").val("0");
    			// 등록버튼 나타나기 + 수정,취소버튼 감추기
        		   $("#insertBtn").show();
        		   $("#updateBtn").hide();
    			   
    			   break;		   
    		   }
    		   
    		   reloadList();
    		   
    		   break;
    	   case "fail":
    		   makeAlert("알림", msg[flag] + "에 실패하였습니다.");
    		   break;
    	   case "error":
    		   makeAlert("알림", msg[flag] + " 중 문제가 발생하였습니다.");
    		   break;
    	   }
       },
       error : function(request, status, error) { //실패했을 때 함수 실행
          console.log(request.responseText); //실패 상세내역
       }
    }); // Ajax End
} // action Function End
</script>
</head>
<body>
<c:import url="/header"></c:import>
<div class="p">
   <div class="title">유치원 상세정보</div>
   <span class="GBN">홈 > 유치원 정보 조회 > 상세정보</span>
      <!-- Tabs -->
   <div id="tabs" class="ui-tabs ui-corner-all ui-widget ui-widget-content">
      <ul role="tablist" class="ui-tabs-nav ui-corner-all ui-helper-reset ui-helper-clearfix ui-widget-header">
         <li role="tab" tabindex="0" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab ui-tabs-active ui-state-active" aria-controls="tabs-1" aria-labelledby="ui-id-15" aria-selected="true" aria-expanded="true"><a href="#tabs-1" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-15">요약</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-2" aria-labelledby="ui-id-16" aria-selected="false" aria-expanded="false"><a href="#tabs-2" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-16">기본현황</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-3" aria-labelledby="ui-id-17" aria-selected="false" aria-expanded="false"><a href="#tabs-3" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-17">영유아/교직원</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-4" aria-labelledby="ui-id-18" aria-selected="false" aria-expanded="false"><a href="#tabs-4" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-18">교육/보육과정</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-5" aria-labelledby="ui-id-19" aria-selected="false" aria-expanded="false"><a href="#tabs-5" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-19">안전점검</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-6" aria-labelledby="ui-id-20" aria-selected="false" aria-expanded="false"><a href="#tabs-6" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-20">영양/환경위생</a></li>
         <li role="tab" tabindex="-1" class="ui-tabs-tab ui-corner-top ui-state-default ui-tab" aria-controls="tabs-8" aria-labelledby="ui-id-22" aria-selected="false" aria-expanded="false"><a href="#tabs-8" role="presentation" tabindex="-1" class="ui-tabs-anchor" id="ui-id-22">후기</a></li>
      </ul>
      <div id="tabs-1" aria-labelledby="ui-id-15" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="false">
      	 <div class="kin_name">${kin.KIN_NM}</div>
      	<form action="#" id="addrForm" method="post">
      		<input type="hidden" name="no" id="no" value="${kin.KIN_NO}">   
      		<input type="hidden" name="kinAddr" id="kinAddr" value="${kin.KIN_ADDR}">  
      		<input type="hidden" name="kinNm" id="kinNm" value="${kin.KIN_NM}">  
      	</form>
      	<table class="tb_s">
      	<colgroup>
      		<col width="200">
      		<col width="*">
      	</colgroup>
      		<thead>
      			<tr>
      			<th colspan="2"></th>
      			</tr>
      		</thead>
      		<tbody>
	      		<tr>
	      			<td class="td_1st b">설립유형</td>
	      			<td>${kin.E_TP}</td>
	      		</tr>
	      		<tr>
	      			<td class="td_1st b">설립일</td>
	      			<td>${kin.E_DT}</td>
	      		</tr>
	      		<tr>
	      			<td class="td_1st b">개원일</td>
	      			<td>${kin.O_DT}</td>
	      		</tr>
	      		<tr>
	      			<td class="td_1st b">홈페이지</td>
	      			<c:choose>
	      				<c:when test="${not empty kin.HP}">
		      				<td><a href="${kin.HP}"><img src="resources/images/kin/website.png" class="ico" title="${kin.HP}"></a></td>
	      				</c:when>
	      				<c:otherwise>
	      					<td>-</td>
	      				</c:otherwise>
	      			</c:choose>
	      		</tr>
	      		<tr>
	      			<td class="td_1st b">주소</td>
	      			<td><img src="resources/images/kin/map_link.png" class="ico" id="addr" title="${kin.KIN_ADDR}"></td>
	      		</tr>
	      		<tr>
	      			<td class="td_1st b">평균별점</td>
	      			<td>${kin.AVG}</td>
	      		</tr>
      		</tbody>
      	</table>
      	<div id="map"></div>
      </div>
      <div id="tabs-2" aria-labelledby="ui-id-16" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
	      <div class="kin_name">${kin.KIN_NM}</div>
	      <table class="tb_l">
	      <colgroup>
	      	<col width="200">
	      	<col width="*">
	      	<col width="200">
	      	<col width="*">
	      </colgroup>
	      		<thead>
	      			<tr>
	      			<th colspan="4">기본현황</th>
	      			</tr>
	      		</thead>
	      		<tbody>
		      		<tr>
		      			<td class="td_1st b">기관명</td>
		      			<td colspan="3">${info.EDU_OF}</td>
		      		</tr>
		      		<tr>
		      			<td class="td_1st b">설립유형</td>
		      			<td colspan="3">${kin.E_TP}</td>
		      		</tr>
		      		<tr>
		      			<td class="td_1st b">교실수</td>
		      			<td>${info.CLR_CNT}</td>
		      			<td class="b">통학차량 운영여부</td>
		      			<td>${info.SBUS_YN}</td>
		      		</tr>
	      		</tbody>
	      	</table>
	      	<table class="tb_l">
	      	<colgroup>
		      	<col width="200">
		      	<col width="*">
		      	<col width="200">
		      	<col width="*">
	        </colgroup>
	      	   <thead>
	      			<tr>
	      				<th colspan="4">건물현황</th>
	      			</tr>
	      		</thead>
	      		<tbody>
	      			<tr>
	      				<td class="td_1st b">건축년도</td>
	      				<td>${info.ARCH_YR}</td>
	      				<td class="b">건물층수</td>
	      				<td>${info.BLDG_FLR_CNT}</td>
	      			</tr>
	      			<tr>
	      				<td class="td_1st b">건물 전용 면적(㎡)</td>
	      				<td>${info.BLDG_PV_AR}</td>
	      				<td class="b">대지 총 면적(㎡)</td>
	      				<td>${info.GRO_T_AR}</td>
	      			</tr>
	      		</tbody>
	      	</table>
      </div>
      <div id="tabs-3" aria-labelledby="ui-id-17" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
   	  	<div class="kin_name">${kin.KIN_NM}</div>
    		<table>
    		   <thead>
	      			<tr>
	      			<th colspan="8">연령별 학급 현황</th>
	      			</tr>
	      			<tr>
	      				<td rowspan="2" class="td_1st">인가<br/>총 정원</td>
		      			<td rowspan="2">총 현원</td>
		      			<td colspan="5">연령별 학급 현황</td>
		      			<td rowspan="2">특수학급</td>
	      			</tr>
	      			<tr>
	      				<td>구분</td>
	      				<td>만 3세 반</td>
	      				<td>만 4세 반</td>
	      				<td>만 5세 반</td>
	      				<td>혼합반</td>
	      			</tr>
	      		</thead>
	      		<tbody>
	      			<tr>
	      				<td rowspan="3" class="td_1st">${pp.APPR_CNT}</td>
	      				<td	rowspan="3">${pp.SUM_PP}</td>
	      				<td class="b">학급수</td>
	      				<td>${pp.AGE3_CL_CNT}</td>
	      				<td>${pp.AGE4_CL_CNT}</td>
	      				<td>${pp.AGE5_CL_CNT}</td>
	      				<td>${pp.MIX_CL_CNT}</td>
	      				<td>${pp.SPE_CL_CNT}</td>
	      			</tr>
	      			
	      			<tr>
	      				<td class="b">현원</td>
	      				<td>${pp.AGE3_PP_CNT}</td>
	      				<td>${pp.AGE4_PP_CNT}</td>
	      				<td>${pp.AGE5_PP_CNT}</td>
	      				<td>${pp.MIX_PP_CNT}</td>
	      				<td>${pp.SPE_PP_CNT}</td>
	      			</tr>
	      		</tbody>
    		</table>
    		<table>
	      		<thead>
	      			<tr>
	      			<th colspan="13">교직원 현황</th>
	      			</tr>
		      		<tr>
		      			<td rowspan="2" class="td_1st">총<br/>교직원 수<br/>(명)</td>
		      			<td colspan="7">직위별 교원</td>
		      			<td rowspan="2">사무<br/>직원</td>
		      			<td colspan="4">유치원 교사 자격</td>
		      		</tr>
		      		<tr>
		      			<td>원장</td>
		      			<td>원감</td>
		      			<td>수석<br/>교사</td>
		      			<td>교사</td>
		      			<td>특수<br/>교사</td>
		      			<td>보건<br/>교사</td>
		      			<td>영양<br/>교사</td>
		      			<td>수석<br/>교사</td>
		      			<td>1급<br/>정교사</td>
		      			<td>2급<br/>정교사</td>
		      			<td>준교사</td>
		      		</tr>
	      		</thead>
	      		<tbody>
		      		<tr>
		      			<td>${staff.SUM_TCNT}</td>
		      			<td>${staff.SU_CNT}</td>
		      			<td>${staff.ASSD_CNT}</td>
		      			<td>${staff.HEADT_CNT}</td>
		      			<td>${staff.T_CNT}</td>
		      			<td>${staff.SPET_CNT}</td>
		      			<td>${staff.HTT_CNT}</td>
		      			<td>${staff.DIETT_CNT}</td>
		      			<td>${staff.OF_CNT}</td>
		      			<td>${staff.HEADT_QLF_CNT}</td>
		      			<td>${staff.SRT_1GR_QLF_CNT}</td>
		      			<td>${staff.SRT_2GR_QLF_CNT}</td>
		      			<td>${staff.JRT_QLF_CNT}</td>
		      		</tr>
	      		</tbody>
	      	</table>        
    		<table>
	      		<thead>
	      			<tr>
	      			<th colspan="6">교사의 현 기관 근속연수</th>
	      			</tr>
		      		<tr>
		      			<td class="td_1st">연수</td>
		      			<td>1년 미만</td>
		      			<td>1 ~ 2년</td>
		      			<td>2 ~ 4년</td>
		      			<td>4 ~ 6년</td>
		      			<td>6년 이상</td>
		      		</tr>
	      		</thead>
	      		<tbody>
		      		<tr>
		      			<td class="td_1st b">수(명)</td>
		      			<td>${staff.TCNT_UNDER1}</td>
		      			<td>${staff.TCNT_OVER1_UNDER2}</td>
		      			<td>${staff.TCNT_OVER2_UNDER4}</td>
		      			<td>${staff.TCNT_OVER4_UNDER6}</td>
		      			<td>${staff.TCNT_OVER6}</td>
		      		</tr>
	      		</tbody>
	      	</table>
      </div>
      <div id="tabs-4" aria-labelledby="ui-id-18" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
      <div class="kin_name">${kin.KIN_NM}</div>
      <table class="tb_l">
      <colgroup>
      <col width="300">
      <col width="*">
      </colgroup>
      	<thead>
      		<tr>
	      		<th colspan="2">교육과정 운영시간</th>
	      	</tr>
      	</thead>
      	<tbody>
      		<tr>
      			<td class="td_1st b">3-5세 누리과정 운영시간</td>
      			<td>${edu.OPER_TIME}</td>
      		</tr>
      	</tbody>
      </table>
      <table>
      	<thead>
      		<tr>
	      		<th colspan="2">방과후 과정 운영 현황</th>
	      	</tr>
      		<tr>
      			<td class="td_1st">시작시간</td>
      			<td>종료시간</td>
      		</tr>
      	</thead>
      	<tbody>
      		<tr>
      			<td class="td_1st">${edu.AFT_ST_TIME}</td>
      			<td>${edu.AFT_END_TIME}</td>
      		</tr>
      	</tbody>
      </table>
      <table class="tb_sub">
      	<thead>
      		<tr>
      			<th colspan="10"></th>
      		</tr>
      		<tr>
      			<td colspan="3" class="td_1st">학급편성(학급)</td>
      			<td colspan="3">참여유아 수(명)</td>
      			<td colspan="4">교직원 수(명)</td>
      		</tr>
      		<tr>
      			<td class="td_1st">독립<br/>편성</td>
      			<td>오후<br/>재편성</td>
      			<td>계</td>
      			<td>독립<br/>편성</td>
      			<td>오후<br/>재편성</td>
      			<td>계</td>
      			<td>정규교원</td>
      			<td>기간제교원</td>
      			<td>전담사</td>
      			<td>계</td>
      		</tr>
      	</thead>
      	<tbody>
      		<tr>
      			<td class="td_1st">${edu.IND_CL_CNT}</td>
      			<td>${edu.RARR_CL_CNT}</td>
      			<td>${edu.SUM_CL_CNT}</td>
      			<td>${edu.IND_PP_CNT}</td>
      			<td>${edu.RARR_PP_CNT}</td>
      			<td>${edu.SUM_PP_CNT}</td>
      			<td>${edu.FTT_CNT}</td>
      			<td>${edu.PTT_CNT}</td>
      			<td>${edu.INS_CNT}</td>
      			<td>${edu.SUM_TCNT}</td>
      		</tr>
      	</tbody>
      </table>
      <table>
      	<thead>
      		<tr>
	      		<th colspan="6">유치원 교육과정 및 방과후 과정 수업일수</th>
	      	</tr>
      		<tr>
      			<td class="td_1st">만 3세</td>
      			<td>만 4세</td>
      			<td>만 5세 이상</td>
      			<td>혼합연령</td>
      			<td>특수학급</td>
      			<td>방과후과정</td>
      		</tr>
      	</thead>
      	<tbody>
      		<tr>
      			<td class="td_1st">${edu.AGE3_LSN_CNT}</td>
      			<td>${edu.AGE4_LSN_CNT}</td>
      			<td>${edu.AGE5_LSN_CNT}</td>
      			<td>${edu.MIX_LSN_CNT}</td>
      			<td>${edu.SPE_LSN_CNT}</td>
      			<td>${edu.AFT_LSN_CNT}</td>
      		</tr>
      	</tbody>
      </table>
      </div>
      <div id="tabs-5" aria-labelledby="ui-id-19" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
	      <div class="kin_name">${kin.KIN_NM}</div>	
	      	<table class="tb_l">
	      	<colgroup>
	      		<col width="200">
	      		<col width="*">
	      		<col width="200">
	      		<col width="*">
	      	</colgroup>
	      		<thead>
	      			<tr>
	      				<th colspan="3">안전점검 실시 현황<th>
	      			</tr>
	      		</thead>
	      		<tbody>
	      			<tr>
	      				<td class="td_1st b">가스 점검 여부</td>
	      				<td>${safe.GAS_YN}</td>
	      				<td class="b">점검일자</td>
	      				<td>${safe.GAS_DT}</td>
	      			</tr>
	      			<tr>
	      				<td class="td_1st b">소방안전 점검 여부</td>
	      				<td>${safe.FIRE_YN}</td>
	      				<td class="b">점검일자</td>
	      				<td>${safe.FIRE_DT}</td>
	      			</tr>
	      			<tr>
	      				<td class="td_1st b">전기설비 점검 여부</td>
	      				<td>${safe.ELEC_YN}</td>
	      				<td class="b">점검일자</td>
	      				<td>${safe.ELEC_DT}</td>
	      			</tr>
	      		</tbody>
	      	</table>
	      	<table class="tb_l">
	      	<colgroup>
	      		<col width="200">
	      		<col width="*">
	      		<col width="200">
	      		<col width="*">
	      	</colgroup>
	      		<thead>
	      			<tr>
	      				<th colspan="3">소방대피 훈련 여부<th>
	      			</tr>
	      		</thead>
	      		<tbody>
	      			<tr>
	      				<td class="td_1st b">훈련 여부</td>
	      				<td>${safe.EVA_YN}</td>
	      				<td class="b">훈련일자</td>
	      				<td>${safe.EVA_DT}</td>
	      			</tr>
	      		</tbody>
	      	</table>
	      	<table>
	      		<thead>
	      			<tr>
	      				<th colspan="4">CCTV 설치 현황</th>
	      			</tr>
	      			<tr>
	      				<td class="td_1st">CCTV 설치여부</td>
	      				<td>총 설치수</td>
	      				<td>건물 밖</td>
	      				<td>건물 안</td>
	      		</thead>
	      		<tbody>
	      			<tr>
	      				<td class="td_1st">${safe.CCTV_YN}</td>
	      				<td>${safe.CCTV_CNT}</td>
	      				<td>${safe.CCTV_OUT_CNT}</td>
	      				<td>${safe.CCTV_IN_CNT}</td>
	      			</tr>
	      		</tbody>
	      	</table>
      	  </div>
      <div id="tabs-6" aria-labelledby="ui-id-20" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
	      <div class="kin_name">${kin.KIN_NM}</div>
	      <table>
	      	<thead>
	      		<tr>
	      			<th colspan="11">급식실시 현황</th>
	      		</tr>
	      		<tr>
	      			<td colspan="2" class="td_1st">급식 운영방식</td>
	      			<td colspan="2">급식인원(명)</td>
	      			<td colspan="6">급식담당인력(명)</td>
	      			<td rowspan="3">집단급식소<br/>신고여부</td>
	      		</tr>
	      		<tr>
	      			<td rowspan="2" class="td_1st">운영방식</td>
	      			<td rowspan="2">업체명</td>
	      			<td rowspan="2">전체<br/>유아수</td>
	      			<td rowspan="2">급식<br/>유아수</td>
	      			<td colspan="3">영양(교)사</td>
	      			<td colspan="3">취사인력</td>
	      		</tr>
	      		<tr>
	      			<td>배치여부</td>
	      			<td>단독배치</td>
	      			<td>공동배치</td>
	      			<td>조리사</td>
	      			<td>취사부<br/>(조리인력)</td>
	      			<td>계</td>
	      		</tr>
	      	</thead>
	      	<tbody>
	      		<tr>
	      			<td class="td_1st">${diet.ML_OPER_TP}</td>
	      			<td>${diet.CONTR_NM}</td>
	      			<td>${diet.PP_CNT}</td>
	      			<td>${diet.ML_PP_CNT}</td>
	      			<td>${diet.DIETT_YN}</td>
	      			<td>${diet.IND_DIETT_CNT}</td>
	      			<td>${diet.CO_DIETT_CNT}</td>
	      			<td>${diet.CK_CNT}</td>
	      			<td>${diet.CM_CNT}</td>
	      			<td>${diet.SUM_CNT}</td>
	      			<td>${diet.ML_DCLR_YN}</td>
	      		</tr>
	      	</tbody>
	      </table>
	      <table>
	      	<thead>
	      		<tr>
	      			<th colspan="6">위생 관리 현황</th>
	      		</tr>
	      		<tr>
	      			<td colspan="2" class="td_1st">수질</td>
	      			<td colspan="2">공기질</td>
	      			<td colspan="2">미세먼지</td>
	      			<td colspan="2">조도</td>
	      		</tr>
	      		<tr>
	      			<td class="td_1st">검사여부</td>
	      			<td>검사결과</td>
	      			<td>점검일자</td>
	      			<td>점검결과</td>
	      			<td>검사일자</td>
	      			<td>검사결과</td>
	      			<td>검사일자</td>
	      			<td>검사결과</td>
	      		</tr>
	      	</thead>
	      	<tbody>
	      		<tr>
	      			<td class="td_1st">${sani.UNWT_CHK_YN}</td>
	      			<td>${sani.UNWT_CHK_RES}</td>
	      			<td>${sani.AIR_DT}</td>
	      			<td>${sani.AIR_CHK_RES}</td>
	      			<td>${sani.MIC_DT}</td>
	      			<td>${sani.MIC_CHK_RES}</td>
	      			<td>${sani.ILMN_DT}</td>
	      			<td>${sani.ILMN_CHK_RES}</td>
	      			
	      		</tr>
	      	</tbody>
	      </table>
	      <table>
	      	<thead>
	      		<tr>
	      			<th colspan="3">정기 소독관리 현황</th>
	      		</tr>
	      		<tr>
	      			<td class="td_1st">의무대상시설여부</td>
	      			<td>점검일자</td>
	      			<td>점검결과</td>
	      		</tr>
	      	</thead>
	      	<tbody>
	      		<tr>
	      			<td class="td_1st">${sani.DSNF_FCL_YN}</td>
	      			<td>${sani.DSNF_DT}</td>
	      			<td>${sani.DSNF_CHK_RES}</td>
	      		</tr>
	      	</tbody>
	      </table>
	      </div>
      <div id="tabs-8" aria-labelledby="ui-id-22" role="tabpanel" class="ui-tabs-panel ui-corner-bottom ui-widget-content" aria-hidden="true" style="display: none;">
	      <div class="kin_name" style="margin-bottom : 20px">${kin.KIN_NM}</div>
	      <form action="#" id="fbForm" method="post">
      		<input type="hidden" name="no" id="no" value="${kin.KIN_NO}">
      		<input type="hidden" name="uNo" id="uNo" value="${sNo}">
      		<input type="hidden" name="page" id="page" value="1">
      	  </form>
	      <div class="review_wrap" id="basic">
				<table class="tReview" id="fbList">
						<colgroup>
							<col width="120" />
							<col width="*" />
							<col width="150" />
							<col width="100" />
							<col width="90" />
						</colgroup>
						<thead>
						<tr>
							<th>별점</th>
							<th>내용</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>&nbsp;</th>
						</tr>	
					</thead>
					<tbody></tbody>
				</table>
				<div class="boxBtn">더보기</div>
				<c:if test="${!empty sNo}">
				<form action="#" id="fbActionForm">
					<input type="hidden" name="no" id="no" value="${kin.KIN_NO}">
					<input type="hidden" name="fbNo" id="fbNo">
					<input type="hidden" name="uNo" value="${sNo}">
					<div class="repHead"> 
						<select class="selStar" name="rate" id="rate">
							<option value="0" selected>별점</option>
							<option value="1">★</option>
							<option value="2">★★</option>
							<option value="3">★★★</option>
							<option value="4">★★★★</option>
							<option value="5">★★★★★</option>
						</select>
					</div>
					<div class="reply">
						<textarea class="repCont" id="fbCon" name="fbCon" placeholder="후기를 입력해주세요."></textarea>
						<div class="replyBtn" id="insertBtn">등록</div>
						<div class="replyBtn" id="updateBtn">수정</div>
					</div>
				</form>
				</c:if>
				</div>
			</div>
   </div>
</div>
<div class="bottom"></div>
</body>
</html>