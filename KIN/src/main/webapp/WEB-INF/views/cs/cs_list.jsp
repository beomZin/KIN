<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객센터 문의 목록</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/cs_list.css" rel="stylesheet" type="text/css">
<style type="text/css">
#insertBtn {
	margin-right: 5px;
}
</style>

<script type="text/javascript" >
$(document).ready(function() {
	reloadList();
	
	$(".paging_area").on("click", "span", function() {
		
		$("#page").val($(this).attr("page"));
		
		reloadList();
	}); // paging
	
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").attr("action", "csDetail");
		$("#actionForm").submit();
	}); // detail 이동
	
	$("#insertBtn").on("click", function() {
		$("#actionForm").attr("action", "brdInsert");
		$("#actionForm").submit();
	}); // 글쓰기 공통 페이지로 이동 
	
	// 뒤로가기
	$("#backBtn").on("click", function() {
		location.href = "uInfo"
	}); 
	
	
	
}); // doc ready

function reloadList() {
    var params = $("#actionForm").serialize();
    $.ajax({
       url : "csListAjax", //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 res에 받아서 보내줌
    	   drawList(res.list); 
       	   drawPaging(res.pd);
       },
       error : function(request, status, error) { //실패했을 때 함수 실행
          console.log(request.responseText); //실패 상세내역
       }
    }); // ajax end
}// reload end

function drawList(list) {
	var html = "";
	
	for(var data of list) {
		html += "<tr no=\"" + data.NO + "\">";
		html += "<td>" + data.ADMIN_NO + "</td>";		
		html += "<td>" + data.TITLE + "</td>";	
		html += "<td>" + data.REG_DT + "</td>";		
		html += "</tr>";
	}
	
	$("tbody").html(html);
} // drawList


function drawPaging(pd) {
	var html = "";
	
	      html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
	   if($("#page").val() == "1") {
	      html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
	   } else {
	      html += "<span class=\"page_btn page_prev\" page=\"" + ($("#page").val() * 1 - 1) + "\">이전</span>";
	   }
	   
	   for(var i = pd.startP ; i <= pd.endP ; i++) {
		  if($("#page").val()*1 == i) { 
			   html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
		  } else {
			   html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
		  }
	   }
		  
		  if($("#page").val()*1 == pd.maxP) { 
			   html += "<span class=\"page_btn page_next\" page=\"" + pd.maxP + "\">다음</span>";
		  } else {
			   html += "<span class=\"page_btn page_next\" page=\"" + ($("#page").val()*1 + 1) + "\">다음</span>";
		  }
		  
		   html += "<span class=\"page_btn page_last\" page=\"" + pd.maxP + "\">마지막</span>";
	   
	   $(".paging_area").html(html);
} // drawPaging 
</script>
</head>
<body>
<c:import url="/header"></c:import>
<div class="p">
	<div class="title">고객센터</div>
	<span class="GBN">홈 > 회원정보 > 고객센터</span><br/>
	<div class="btnWrap">
		<input type="button" class="boxBtn" value="문의하기" id="insertBtn" />
		<input type="button" class="boxBtn" value="돌아가기" id="backBtn" />
	</div>
	
	<form action="#" method="post" id="actionForm" >
		<input type="hidden" name="no" id="no" >
		<input type="hidden" name="user_no" value="${sNo}" >
		<input type="hidden" name="cateNo" value="4">
		<input type="hidden" name="page" id="page" value="${page}" >
	</form>
	
	<table class="t">
		<colgroup>
			<col width="300" />
			<col width="500" />
			<col width="300" />
		</colgroup>
	<thead>
		<tr>
			<th>답변여부</th>			
			<th>제목</th>			
			<th>등록일자</th>			
		</tr>
	</thead>
	<tbody></tbody>
	</table>
<div class="paging_area"></div>
</div>
<div class="bottom"></div>
</body>
</html>