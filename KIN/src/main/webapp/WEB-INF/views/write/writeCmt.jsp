<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성내역 조회</title>
<c:import url="/cmn"></c:import>
<style type="text/css">
.p {
	display: block;
	width: 1100px;
	font-family: 맑은고딕, "Malgun Gothic", dotum, gulim, sans-serif;
	margin: 0 auto;
	position: relative;
	min-height: 700px;
}

.title {
	height: 30px;
    line-height: 30px;
    margin: 20px 20px 0px 60px;
    color: #262626;
    font-size: 22.4px;
    font-weight: bold;
    letter-spacing: -.05em;
    display: block;
    text-align: left;
}

.t {
	border-collapse: collapse;
	width: 1100px;
	display: inline-table;
	vertical-align: top;
	margin-bottom: 30px;
	border-bottom: 1px solid #f1f1f1;
	margin-top : 40px;
}

.cmtList th {
	font-size: 16.8px;
	height: 50px;
	line-height: 50px;
	border-top: 1px solid #f1f1f1;
}

.cmtList td {
	font-size: 15.4px;
	height: 40px;
	line-height: 40px;
	border-top: 1px solid #f1f1f1;
}

.cmtList tbody tr:hover {
	background-color: #e1e1fb;
}

.cmtList tr td:nth-child(2) {
	text-align: left;
	text-indent: 10px;
}

.cmtList {
	text-align: center;
}

.empCmtList {
	text-align: center;
	height: 40px;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 3%;
}

.mid1 {
	margin-top : 5px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid1_1, .mid1_2, .mid1_3 {
	margin : 5px 20px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 83px;
	color: #262626;
	font-weight : bold;
}

.mid1_1, .mid1_2:hover {
	cursor: pointer;
}

.mid1_2 {
	border-bottom: 1px solid #262626;
}

.mid2 {
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
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
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	// 목록 조회
	reloadList();
	
	
	// 페이징 버튼
	$(".paging").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		reloadList();
	});
	
	// 게시글 클릭시 - 게시판 상세
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		$("#cateNo").val($(this).attr("cateNo"));
		
		$("#searchForm").attr("action", "brdDetail")
		$("#searchForm").submit();
	});
	
	$(".mid1_1").on("click", function() {
		location.href = "writeBrd";
	});
	
	$(".mid1_2").on("click", function() {
		location.href = "writeCmt";
	});
});

function reloadList() {
	
	var params = $("#searchForm").serialize();
	
	$.ajax({
		url : "writeCmtAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
				$(".empCmtList").hide();
				$(".cmtList").hide();

			if(res.cnt != 0) {				
				$(".cmtList").show();
				drawList(res.list);
				drawPaging(res.pd);
			} else {				
				$(".empCmtList").show();
				$(".paging").hide();
			}
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	});
} // function reloadList() End

function drawList(list) {
	
	var html = "";
	
	for(var data of list) {
		html += "<tr no=\"" + data.NO + "\" cateNo=\"" + data.CT_NO + "\">";
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
<c:import url="/header"></c:import>
<form action="#" id="searchForm" method="POST">
	<input type="hidden" name="no" id="no">
	<input type="hidden" name="user_no" value="${sNo}">
	<input type="hidden" name="cateNo" id="cateNo">
	<input type="hidden" name="page" id="page" value="1">
 </form>
	<div class="p">
		<div class="mid1">
	   		<div class = "mid1_1">작성한 글</div>
			<div class = "mid1_2">댓글단 글</div>
		</div>
		<div class="title">댓글단 글</div>
		<span class="GBN">홈 > 마이 페이지 > 작성내역조회 > 댓글단 글</span><br/>
		<table class="t empCmtList">
			<thead><tr><th>댓글단 글이 존재하지 않습니다.</th></tr></thead>
		</table>
		<table class="t cmtList">
			<colgroup> <!-- 전체 1100 -->
				<col width="100" />
				<col width="500" />
				<col width="200" />
				<col width="200" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>	
					<th>제목</th>
					<th>작성자</th>		
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