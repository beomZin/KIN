<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판 - 문화생활</title>

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
	margin: 10px 20px 20px 60px;
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

.t th {
	font-size: 16.8px;
	height: 50px;
	line-height: 50px;
}

.t td {
	font-size: 15.4px;
	height: 40px;
	line-height: 40px;
	border-top: 1px solid #f1f1f1;
	cursor: pointer;
}

.t tbody tr:hover {
	background-color: #e1e1fb;
}

.t tr td:nth-child(2) {
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
	height: 150px;
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

.boxBtn, .boxBtn_m {
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

.boxBtn {
	margin-right: 5px;
}

.boxBtn:hover {
	border: 1px solid #4F4D8C;
	background-color: #e1e1fb;
	color: #262626;
}

.boxBtn_m:hover {
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
	
	// 게시판 목록 버튼
	$(".boxBtn_m").on("click", function() {
		$("#searchForm").attr("action", "brdMain");
		$("#searchForm").submit();
	});
	
	// 페이징 버튼
	$(".paging").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#schGbn").val($("#oldGbn").val());
		$("#schText").val($("#oldText").val());
		
		reloadList();
	});
	
	// 게시글 클릭시 - 게시판 상세
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#schGbn").val($("#oldGbn").val());
		$("#schText").val($("#oldText").val());
		
		$("#searchForm").attr("action", "brdDetail")
		$("#searchForm").submit();
	});
	
	// 글쓰기 버튼
	$(".boxBtn").on("click", function() {
		if("${sNick}" != "") {
			$("#searchForm").attr("action", "brdInsert");
			$("#searchForm").submit();
		} else {
			makeAlert("알림", "글을 작성하려면 닉네임이 필요합니다.<br> 회원정보에서 닉네임을 설정해주세요.");
		}
	});
}); // document ready End

function reloadList() {
	
	var params = $("#searchForm").serialize();
	
	$.ajax({
		url : "brdListAjax",
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
		html += "<td>" + data.NO + "</td>";
		html += "<td>";
		
		var title = data.TITLE;
		title = title.replace(/&lt;/gi, "<");
		title = title.replace(/&gt;/gi, ">");
		
		html += title;
		if(typeof(data.ATT_NM) != "undefined") { // 첨부파일 있으면
			html += "<span class=\"att\"></span>";
		}
		html += "</td>";
		html += "<td>" + data.NICK;
		if("${sNo}" == data.U_NO) {
			html += " <img alt=\"작성자_로그인유저\" src=\"resources/images/kin/me.png\" height=\"20\" width=\"20\">";
		}
		html += "</td>";
		html += "<td>" + data.REG_DT + "</td>";
		html += "<td>" + data.HIT + "</td>";
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

    <c:import url="/header"></c:import>
    
    <div class="p">
		<span class="GBN">홈 > 게시판 > 문화생활</span><br/>
		<div class="title">문화생활</div>
		  	<div class="search_b_wrap">
		  		<form action="#" id="searchForm" method="POST">
		  			<input type="hidden" name="no" id="no">
		  			<input type="hidden" name="cateNo" value="1">
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
			<input type="button" class="boxBtn" value="글쓰기" />
			<input type="button" class="boxBtn_m" value="게시판 목록" />
		</div>
		<table class="t">
			<colgroup>
				<col width="50" />
				<col width="500" />
				<col width="250" />
				<col width="100" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>	
					<th>제목</th>		
					<th>닉네임</th>			
					<th>작성일자</th>			
					<th>조회수</th>			
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	  	<div class="paging"></div>	
   </div>
   <div class="bottom"></div>
</body>
</html>