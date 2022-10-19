<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 _ 고객센터</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<style type="text/css">

.logo {
	cursor : pointer;
}

.p {
	display: block;
	width: 1100px;
	font-family: 맑은고딕, "Malgun Gothic", dotum, gulim, sans-serif;
	text-align: center;
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
	display: block;
	text-align: left;
}

.t {
	border-collapse: collapse;
	width: 1000px;
	display: inline-table;
	vertical-align: top;
	margin-top: 5px;
	margin-bottom: 30px;
	border-top: 1px solid #f1f1f1;
}

th {
	font-size: 16.8px;
	height: 50px;
	line-height: 50px;
}

td {
	font-size: 15.4px;
	height: 40px;
	line-height: 40px;
	border-top: 1px solid #f1f1f1;
	cursor: pointer;
}

tbody tr:hover {
	background-color: #e1e1fb;
}

tr td:nth-child(1) {
	cursor: default;
}

tr td:nth-child(3) {
	text-align: left;
	text-indent: 10px;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 3%;
}

.re1 {
	margin-top : 5px;
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #b7b7b7;
    border-radius: 5px;
    color: #b7b7b7;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.re2 {
	margin-top : 5px;
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #6aa84f;
    border-radius: 5px;
    color: #6aa84f;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.mid1 {
	margin-top : 5px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	text-align: left;
}

.mid1_1, .mid1_2, .mid1_3 {
	margin : 5px 20px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 83px;
	color: #262626;
	font-weight : bold;
}

.mid1_1, .mid1_2, .mid1_3:hover {
	cursor: pointer;
}

.paging {
	font-size: 15.8px;
	height: 20px;
	line-height: 20px;
	font-weight: bold;
	text-align: center;
	margin: 0px auto 40px;
}

.prev, .next, .page, .page_on:hover {
	cursor : pointer;
}

.bottom {
	background: #4b4a6e;
	height: 180px;
}

.b_txt {
    width: 350px;
    height: 40px;
    border: none;
    padding : 0px;
    outline: 0;
    font-size: 15.4px;
    background-color: transparent;
}

.search_b_wrap {
	border: 1px solid #e1e1fb;
	height: 80px;
	font-size: 0;
	vertical-align: top;
	text-align: center;
}

.search_b {
	margin: 20px 0px;
    width: 400px;
    height: 40px;
    border: 1px solid #fff;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
    line-height: 40px;
    display: inline-block;
   	vertical-align: top;
   	background-color: #f1f1f1;
}

.select_b {
	border: 1px solid #fff;
    height: 42px;
    font-size: 15.4px;
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
    margin: 20px 0px;
    vertical-align: top;
    width: 100px;
    text-align: center;
    background-color: #f1f1f1;
}

.search_btn {
	margin: 21px 10px;
	height: 40px;
	width: 80px;
	display: inline-block;
	background-color: #4F4D8C;
	color: #f1f1f1;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    border-radius: 2px;
    line-height: 40px;
    cursor: pointer;
}

.boxBtn {
	display: inline-block;
	vertical-align: top;
	line-height: 30px;
	height: 40px;
	width: 100px;
	border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	border-radius: 5px;
	color: #f1f1f1;
	font-size: 15.4px;
	font-weight: bold;
	text-align: center;
	margin : 25px 0 10px 0;
	cursor: pointer;
}

.boxBtn:hover {
	border: 1px solid #4F4D8C;
	background-color: #e1e1fb;
	color: #262626;
}

.btnWrap {
	display: block;
    text-align: right;
    margin: 0 auto;
    width: 1000px;
}

.att {
	display: inline-block;
	vertical-align: middle;
	width: 18px;
	height: 18px;
	background-image: url('resources/images/attFile.png');
	background-size: cover;
}

</style>
<script type="text/javascript">

$(document).ready(function() {
	$(".logo").on("click", function() {
		location.href = "kinMain";
	});
	
	// 회원 관리
	$(".mid1_1").on("click", function() {
		location.href = "adminPage"
	});
	
	// 게시판 관리
	$(".mid1_2").on("click", function() {
		location.href = "adminBrd"
	});
	
	// 고객센터
	$(".mid1_3").on("click", function() {
		location.href = "adminCs"
	});
	
	// 회원 관리 - 사용자 관리
	$(".mid2_1").on("click", function() {
		location.href = "adminPage"
	});
	
	// 회원 관리 - 원장 관리
	$(".mid2_2").on("click", function() {
		location.href = "adminSu"
	});
	
	// 회원 관리 - 교직원 관리
	$(".mid2_3").on("click", function() {
		location.href = "adminStaff"
	});
	
	// 검색 구분 설정
	if("${param.searchGbn}" != "") {
		$("#schGbn").val("${param.searchGbn}");
	} else {
		$("#oldGbn").val("0");
	}
	
	// 목록 조회
	reloadList();
	
	// 검색창 엔터
	$("#searchForm").on("keypress", "input", function() {
		// 엔터키가 눌렸을 때
		if(event.keyCode == 13) {
			$(".search_btn").click();
			return false;
		}
	});
	
	// 검색 버튼
	$(".search_btn").on("click", function() {
		$("#page").val("1");
		
		$("#oldGbn").val($("#schGbn").val());
		$("#oldText").val($("#schText").val());
		
		reloadList();
	});
	
	// 페이징 버튼
	$(".paging").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#schGbn").val($("#oldGbn").val());
		$("#schText").val($("#oldText").val());
		
		reloadList();
	});
	
	// 게시글 클릭시 (체크박스 부분 제외) - 고객센터 상세
	$("tbody").on("click", "tr td:not(:first-child)", function() {
		$("#no").val($(this).parent().attr("no"));
		
		$("#schGbn").val($("#oldGbn").val());
		$("#schText").val($("#oldText").val());
		
		$("#searchForm").attr("action", "adminCsDetail");
		$("#searchForm").submit();
	});
	
	// tbody 체크박스
	$("tbody").on("click", ".cb", function() {
		var arr = [];
		
		$("tbody .cb:checked").each(function() {
			arr.push($(this).val());
		});
		
		if(arr.length == $("tbody .cb").length) {
			$("thead .cb").prop("checked", true);
		} else {
			$("thead .cb").prop("checked", false);
		}
		
		$("#no").val(arr);
	});
	
	// thead 체크박스
	$("thead").on("click", ".cb", function() {
		if($(this).is(":checked")) {
			$("tbody .cb").prop("checked", true);
		} else {
			$("tbody .cb").prop("checked", false);
		}
		
		var arr = [];
		
		$("tbody .cb:checked").each(function() {
			arr.push($(this).val());
		});
		
		$("#no").val(arr);
	});
	
	// 삭제 버튼
	$(".boxBtn").on("click", function() {
		var arr = [];
		
		$("tbody .cb:checked").each(function() {
			arr.push($(this).val());
		});
		
		if(arr.length == "") {
			makeAlert("알림", "삭제할 게시글을 선택해주세요.");
		} else {
			makePopup({
				title : "알림",
				contents : "삭제 하시겠습니까?",
				buttons : [{
					name : "삭제",
					func:function() {
						// serialize() : 해당 내용물들 중 값 전달이 가능한 것들을 전송가능한 문자 형태로 전환.
						var params = $("#searchForm").serialize();
						
						$.ajax({
							url : "ActionCsAjax", // 경로
							type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
							dataType : "json", // 데이터 형태
							data : params, // 보낼 데이터
							success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
								switch(res.msg) {
									case "success" :
										reloadList();
										break;
									case "fail" :
										makeAlert("알림", "삭제에 실패했습니다.")
										break;
									case "exception" :
										makeAlert("알림", "삭제 중 문제가 발생했습니다.")
										break;
								}
							},
							error : function(request, status, error) { // 실패했을 때 함수 실행
								console.log(request.responseText); // 실패 상세 내역
							}
						});
						
						closePopup();
					}
				},{
					name : "취소"
				}]
			})
		}
	});
	
}); // document ready End

function reloadList() {
	
	// thead checkbox 초기화 설정
	$("thead .cb").prop("checked", false);
	
	var params = $("#searchForm").serialize();
	
	$.ajax({
		url : "adminCsListAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
			drawList(res.list);
			drawPaging(res.pd);
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	});
} // function reloadList() End

function drawList(list) {
	
	var html = "";
	
	for(var data of list) {
		html += "<tr no=\"" + data.NO + "\">";
		html += "<td><input type=\"checkbox\" class=\"cb\" name=\"no\" value=\"" + data.NO + "\"></td>";
		html += "<td>" + data.NO + "</td>";
		html += "<td>";
		
		var title = data.TITLE;
		title = title.replace(/&lt;/gi, "<");
		title = title.replace(/&gt;/gi, ">");
		
		html += title;
		if(typeof(data.ATT_NM) != "undefined") { // 첨부파일 있으면
			html += "<span class=\"att\"></span>"
		}
		html += "</td>";
		html += "<td>" + data.NICK + "</td>";
		html += "<td>" + data.REG_DT + "</td>";
		html += "<td>";
		if(data.ADMIN_NO != null) {
			html += "<div class=\"re2\">답변완료</div>";
		} else {
			html += "<div class=\"re1\">미답변</div>";
		}
		html += "</td>";
		html += "</tr>";
	}
	
	$("tbody").html(html);
}// function drawList End

function drawPaging(pd) {
	var html = "";
	
	// 처음
	html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
	
	// 이전
	if($("#page").val() == "1") {
		html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
	} else {
		// 문자 * 1 = 숫자
		html += "<span class=\"page_btn page_prev\" page=\"" + ($("#page").val() * 1 - 1)  + "\">이전</span>";
	}
	
	// 페이지
	for(var i = pd.startP ; i <= pd.endP ; i++) {
		if($("#page").val() * 1 == i) {
			// 현재 페이지	
			html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
		} else {
			// 다른페이지
			html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
		}
	}
	
	// 다음
	if($("#page").val() * 1 == pd.maxP) {
		// 현재 페이지가 마지막 페이지라면
		html += "<span class=\"page_btn page_next\" page=\"" + pd.maxP + "\">다음</span>";
	} else {
		html += "<span class=\"page_btn page_next\" page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>";
	}
	
	// 마지막
	html += "<span class=\"page_btn page_last\" page=\"" + pd.maxP + "\">마지막</span>";
	
	$(".paging").html(html);
}

</script>
   
</head>

<body>
<!-- 기존 검색 데이터 유지용 -->
<input type="hidden" id="oldGbn" value="${param.oldGbn}">
<input type="hidden" id="oldText" value="${param.oldText}">

    <div class="head">
        <div class="logo" >
            <img src="resources/images/kin/logo_white.png" height="55px" id="logo">
        </div>
    </div>
    
    <div class="p">
		<div class="mid1">
		  	<div class = "mid1_1">회원 관리</div>
			<div class = "mid1_2">게시판 관리</div>
			<div class = "mid1_3">고객센터</div>	
		</div>
		<div class="title">고객센터</div>
		<span class="GBN">홈 > 관리자 페이지 > 고객센터</span><br/>
		  	<div class="search_b_wrap">
		  		<form action="#" id="searchForm" method="POST">
		  			<input type="hidden" name="no" id="no">
		  			<input type="hidden" name="page" id="page" value="1">
				<select class="select_b" name="searchGbn" id="schGbn">
		            <option value="0">전체</option>
		            <option value="1">제목</option>
		            <option value="2">내용</option>
		            <option value="3">작성자</option>
		    	</select>
		    	<div class="search_b">
		           	<input type ="text" class="b_txt" name="searchText" id="schText" 
		           	       placeholder="게시글 검색" value="${param.searchText}">
		    	</div>
		    	<div class="search_btn" id="searchBtn">검색</div>
		   	</form>
		</div>
		<div class="btnWrap">
			<input type="button" class="boxBtn" value="삭 제" />
		</div>
		<table class="t">
			<colgroup>
				<col width="50" />
				<col width="100" />
				<col width="400" />
				<col width="150" />
				<col width="150" />
				<col width="150" />
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="cb"></th>
					<th>번호</th>	
					<th>제목</th>			
					<th>작성자</th>			
					<th>작성일자</th>			
					<th>답변여부</th>		
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	  	<div class="paging"></div>	
   </div>
   <div class="bottom"></div>
</body>
</html>