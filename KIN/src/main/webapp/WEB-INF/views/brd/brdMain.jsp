<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 메인</title>
    <c:import url="/cmn"></c:import>
    <link href="resources/css/kin/brdMain.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// 검색 구분 설정
	if("${param.searchGbn}" != "") {
		$("#schGbn").val("${param.searchGbn}");
	} else {
		$("#oldGbn").val("0");
	}
	
	// 검색창 엔터
	$("#actionForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			 $("#searchBtn").click();
			return false;
		}
	});
	
	// 모든 게시판 목록 조회
	reloadList();
	
	// 검색 버튼
	$("#searchBtn").on("click", function() {
		
		$("#oldGbn").val($("#schGbn").val());
		$("#oldText").val($("#schText").val());
		
		reloadList();
	});
	
	// 게시글 상세보기
	$(".brd_tb tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		$("#cateNo").val($(this).attr("cateNo"));
		
		$("#schGbn").val($("#oldGbn").val());
		$("#schText").val($("#oldText").val());
		
		$("#actionForm").attr("action", "brdDetail");
		$("#actionForm").submit();
	});
	
	// 카테고리 이동
	$(".lounge").on("click", function() {
		if("${sDis}" != "") {
			$("#actionForm").attr("action", "brdLounge");
			$("#actionForm").submit();
		} else {
			makeAlert("알림", "회원님의 지역구 정보가 존재하지 않습니다.<br> 동네라운지 게시판 이용을 원하시면<br>회원정보에서 지역구를 설정해주세요.");
		}
	});
	
	$(".educate").on("click", function() {
		$("#actionForm").attr("action", "brdEducate");
		$("#actionForm").submit();
	});
	
	$(".culture").on("click", function() {
		$("#actionForm").attr("action", "brdCulture");
		$("#actionForm").submit();
	});
	
	$(".ask").on("click", function() {
		$("#actionForm").attr("action", "brdAsk");
		$("#actionForm").submit();
	});
});

function reloadList() {
    var params = $("#actionForm").serialize();
    $.ajax({
       url : "brdMainAjax", //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
    	   if(res.dis == "0" || res.admin == "0") {
	    	   drawLounge(res.lounge);
	    	   drawEducate(res.educate);
	    	   drawCulture(res.culture);
	    	   drawAsk(res.ask);
    	   } else {
    		   drawEducate(res.educate);
    		   drawCulture(res.culture);
    		   drawAsk(res.ask);
    	   }
       },
       error : function(request, status, error) { //실패했을 때 함수 실행
          console.log(request.responseText); //실패 상세내역
       }
    });
}

function drawLounge(lounge) {
	var html = "";
	
	for(var data of lounge) {		
		html += "<tr no=\"" + data.NO + "\" cateNo=\"" + data.CT_NO + "\">";
		html += "<td>" + data.NO + "</td>";
	    html += "<td>" + data.TITLE + "</td>";
	    html += "<td>" + data.NICK + "</td>";
		html += "</tr>";
	}
	
	$("#lounge tbody").html(html);
}

function drawEducate(educate) {
	var html = "";
	
	for(var data of educate) {		
		html += "<tr no=\"" + data.NO + "\" cateNo=\"" + data.CT_NO + "\">";
		html += "<td>" + data.NO + "</td>";
	    html += "<td>" + data.TITLE + "</td>";
	    html += "<td>" + data.NICK + "</td>";
		html += "</tr>";
	}
	
	$("#educate tbody").html(html);
}

function drawCulture(culture) {
	var html = "";
	
	for(var data of culture) {		
		html += "<tr no=\"" + data.NO + "\" cateNo=\"" + data.CT_NO + "\">";
		html += "<td>" + data.NO + "</td>";
	    html += "<td>" + data.TITLE + "</td>";
	    html += "<td>" + data.NICK + "</td>";
		html += "</tr>";
	}
	
	$("#culture tbody").html(html);
}

function drawAsk(ask) {
	var html = "";
	
	for(var data of ask) {		
		html += "<tr no=\"" + data.NO + "\" cateNo=\"" + data.CT_NO + "\">";
		html += "<td>" + data.NO + "</td>";
	    html += "<td>" + data.TITLE + "</td>";
	    html += "<td>" + data.NICK + "</td>";
		html += "</tr>";
	}
	
	$("#ask tbody").html(html);
}
</script>
</head>
<body>
<c:import url="/header"></c:import>
<input type="hidden" id="oldGbn" value="${param.searchGbn}" />
<input type="hidden" id="oldText" value="${param.searchTxt}" />
<div class="bg">
	<div class="p">
   		<span class="GBN">홈 > 게시판</span><br/>
   		<form action="#" id="actionForm" method="post">
			<input type="hidden" name="user_no" value="${sNo}">
    		<input type="hidden" name="no" id="no">
    		<input type="hidden" name="cateNo" id="cateNo">
     		<div class="search">
	      		<div class="search_b_wrap">
					<select class="select_b" name="searchGbn" id="schGbn">
		           		<option value="0">전체</option>
		           		<option value="1">제목</option>
		           		<option value="2">내용</option>
		           		<option value="3">작성자</option>
		   			</select>
		   			<div class="search_b">
		            	<input type ="text" class="b_txt" name="searchText" id="schText" 
		            		   placeholder="게시판 검색" value="${param.searchText}">
		   			</div>
		   			<div class="search_btn" id="searchBtn">검색</div>
				</div>
     		</div>
    	</form>
    	<div class="board">
        	<div class="brd_div" style="margin: 20px 20px 20px 8px;">
          		<div class="brd_title lounge">동네라운지</div>
          		<div class="brd_list">
              		<table class="brd_tb" id="lounge">
              			<colgroup>
	              			<col width="40">
	              			<col width="150">
	              			<col width="80">
              			</colgroup>
                  		<tbody></tbody>
              		</table>
          			<div class="brd_more lounge">∨</div>
          		</div>
      		</div>
      		<div class="brd_div" style="margin: 20px 0px 20px 20px;">
	            <div class="brd_title educate">육아교육</div>
	            <div class="brd_list">
                	<table class="brd_tb" id="educate">
              	    	<colgroup>
			              	<col width="40">
			              	<col width="150">
			              	<col width="80">
              			</colgroup>
                  		<tbody></tbody>
              		</table>
          			<div class="brd_more educate">∨</div>
          		</div>
      		</div>
      		<div class="brd_div" style="margin: 0px 20px 0px 8px;">
          		<div class="brd_title culture">문화생활</div>
          		<div class="brd_list">
              		<table class="brd_tb" id="culture">
              			<colgroup>
              				<col width="40">
			              	<col width="150">
			              	<col width="80">
              			</colgroup>
                  		<tbody></tbody>
              		</table>
          			<div class="brd_more culture">∨</div>
          		</div>
      		</div>
      		<div class="brd_div" style="margin: 0px 0px 0px 20px;">
	            <div class="brd_title ask">궁금해요!</div>
	          	<div class="brd_list">
              		<table class="brd_tb" id="ask">
              			<colgroup>
			              	<col width="40">
			              	<col width="150">
			              	<col width="80">
             			 </colgroup>
                  		<tbody></tbody>
              		</table>
        			<div class="brd_more ask">∨</div>
          		</div>
      		</div>
  		</div>
 	</div>
</div>
<div class="bottom"></div>
</body>
</html>