<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유치원 정보</title>
<c:import url="/cmn"></c:import>
</head>
<style>
.bg {
    background-image: url("resources/images/kin/bg.jpg");
    background-repeat: no-repeat;
    background-position: bottom;
	text-align: center;
}

.p {
	background-color: #fff;
	width: 1100px;
	margin: 0 auto;
	display: block;
	min-height: 700px;
}

.mid {
	width: 1100px;
	margin: 0 auto;
	position: relative;
}

.mid1 {
	margin-top : 5px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid2_1{
	margin-top : 5px;
	margin-left : 30px;
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
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : relative;
	right: -45%;
    top: 30%;
}

.mid2 {
	height : 50px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	text-align: left;
}

.mid3 {
	margin-top : 20px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	display: inline-block;
	position: relative;
}

.mid3_1 {
	padding-top : 15px;
	padding-bottom : 15px;
	width : 250px;
	border : 3px solid #F1F1F1;
	font-size : 16.8px;
	font-weight: bold;
	text-align : center;
	background-color: #fff;
	vertical-align: top;
	display: inline-block;
	position: absolute;
	top: 0px;
    left: -260px;
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

.mid3_2 {
	display: inline-block;
	background : #FFFFFF;
	vertical-align : top;
	width : 1000px;
	text-align: left;
}

.mid3_2_r {
	height : 40px;
	line-height : 40px;
	border-bottom : 2px solid #262626;
	font-size: 16.8px;
}

.mid3_2_wrap {
	border-bottom : 2px solid #F1F1F1;
	display : block;
}
.mid3_2_h {
	margin : 10px;
}

.mid3_2_1a {
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #f1c232;
    border-radius: 5px;
    color: #f1c232;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.mid3_2_1b {
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #4285f4;
    border-radius: 5px;
    color: #4285f4;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.mid3_2_2, .mid3_3, .mid3_4, .mid3_5{
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid3_2_2 {
	width: 300px;
	text-indent: 10px;
	margin-left: 20px;
	cursor: pointer;
}

.mid3_3 {
	float : right;
	text-align : center;
}

.mid3_3:hover {
	cursor : pointer;
}

.mid3_4 {
	float : right;
	text-align : center;
	font-size : 22.4px;
	margin: 5px 5px;
}

.mid3_5 {
	float : right;
	text-align : center;
}

.mid3_2_b{
	font-size : 14px;
	width: 615px;
    margin-left: 105px;
    color: #828282;
}


.paging {
	font-size: 15.8px;
	letter-spacing: 10px;
	height: 20px;
	line-height: 20px;
	font-weight: bold;
	margin: 30px auto;
	text-align: center;
}

.prev, .next, #num:hover {
	cursor : pointer;
}

.rate {
	height: 30px;
	margin: 5px 5px;
}

.bookmark {
	height: 30px;
	margin: 5px 5px;
	background-color: #ffffff;
}

.bookmark:hover, .bookmark:focus {
	height: 30px;
	margin: 5px 5px;
  	background-color: #ff3333;
}

.bookmark_act {
	height: 30px;
	margin: 5px 5px;
	background-color: #ff3333;
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

.emp_res {
	font-size: 15.4px;
	font-weight: bold;
	text-align: center;
	padding: 20px; 0px;
	border-bottom: 2px solid #f1f1f1;
}

.paging_area {
    display: inline-block;
    min-width: 300px;
    text-align: center;
    height: 30px;
    margin: 20px;
    position: initial;
}

.bottom {
	background: #4b4a6e;
	height: 150px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	if("${param.searchGbn}" != "") {
		$("#searchGbn").val("${param.searchGbn}");
	} else {
		$("#oldGbn").val(0);
	}
	
	reloadList();
	
	$("#actionForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			 $("#searchBtn").click();
			return false;
		}
	});
	
	 // 체크박스 옵션 선택
	 $(".etp").on("click", function() {
	      $(".etp:checked").each(function() {	    	  
	      	$("#ttcb").prop("checked", false);
	      });
	      
	 });
	 
	 // 체크박스 전체 선택
	 $("#ttcb").on("click", function() {
		 $("#ttcb:checked").each(function () {			 
			 $(".etp").prop("checked", false);
		 });
		 
	 });
	
	// 검색 버튼
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		// 신규 상태 적용
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		reloadList();
	});
	   
	// 체크박스 검색
	$("#optBtn").on("click", function() {
		$("#page").val("1");
		
		// 신규 상태 적용
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		reloadList();
	});
	
	// 페이징 버튼
	$(".paging_area").on("click", "span", function() {
		
		// 기존 검색 상태 유지	
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#page").val($(this).attr("page"));
		
		reloadList();
	});
	
	// 상세보기
	$("#listBox").on("click", ".mid3_2_2", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "kinInfo");
		$("#actionForm").submit();
	});
	
	
	$("#listBox").on("click", "#bmIco", function() {
		
		if("${sNo}" == null || "${sNo}" == '') {
			location.href = "loginU"
		} else {
			
			$("#kinNo").val($(this).parent().attr("kinNo"));
		    
			   if($(this).attr("class") == "bookmark") {
			    	 
				     action("insert");

				     $(this).removeClass('bookmark');
	 		    	 $(this).addClass('bookmark_act');
	 		    	 
			    } else if ($(this).attr("class") == "bookmark_act"){
			    	// 삭제할 유치원 값
			 	   	$("#bmdel").val($("#kinNo").val());
			    	
			    	action("delete");
			    	
			    	$(this).removeClass('bookmark_act');
			    	$(this).addClass('bookmark');
			    }
		}
		   
	}); // bmIco onclick end
}); // doc.ready end

function reloadList() {
    var params = $("#actionForm").serialize();
    $.ajax({
       url : "kinListAjax", //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
    	   drawCnt(res.cnt);
    	   drawList(res.list); 
    	   drawPaging(res.pd);
       },
       error : function(request, status, error) { //실패했을 때 함수 실행
          console.log(request.responseText); //실패 상세내역
       }
    });
}


function drawCnt(cnt) {
	var html = "";

	html += "<div class=\"mid3_2_r\">검색결과 \"" + cnt + "\" 건</div>"
	
	if(cnt == 0) {
		html += "<div class=\"emp_res\">검색 결과가 존재하지 않습니다.</div>"
	}

	$("#listCnt").html(html);
}

 function drawList(list) {
	var html = "";

	for(var data of list) {
		html += "<div class=\"mid3_2_wrap\">";
		html += "<div class=\"mid3_2_h\">";
   		if(data.E_TP == "0") {
			html += "<div class=\"mid3_2_1b\">공립</div>";   			
   		} else if(data.E_TP == "1") {
			html += "<div class=\"mid3_2_1a\">사립</div>";
   		}
   		html += "<div class=\"mid3_2_2\" no=\"" + data.KIN_NO + "\">" + data.KIN_NM + "</div>";
   		html += "<div class=\"mid3_3\" kinNo=\"" + data.KIN_NO + "\">";
   		if(data.U_NO == "${sNo}") {   			
	   		html += "<img alt=\"즐겨찾기\" src=\"resources/images/kin/bookmark.png\" class=\"bookmark_act\" id=\"bmIco\">";
   		} else if (data.U_NO != "${sNo}") {
	   		html += "<img alt=\"즐겨찾기\" src=\"resources/images/kin/bookmark.png\" class=\"bookmark\" id=\"bmIco\">";   			
   		}
   		html += "</div>";
   		html += "<div class=\"mid3_4\">" + data.AVG + "</div>";
   		html += "<div class=\"mid3_5\">";
   		html += "<img alt=\"평점\" src=\"resources/images/kin/rate.png\" class=\"rate\">";
   		html += "</div>";
    	html += "<div class=\"mid3_2_b\">" + data.E_DT + " · " + data.KIN_ADDR + "</div>";
	   	html += "</div>";
		html += "</div>";
	}
 	
 	$("#listBox").html(html);
}

function drawPaging(pd) {
	var html = "";
	
	html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
	// 이전
	if($("#page").val() == "1") {
		html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
	} else {
		html += "<span class=\"page_btn page_prev\" page=\"" + ($("#page").val() * 1 - 1) + "\">이전</span>";
	}
	
	for(var i = pd.startP; i <= pd.endP; i++) {
		if($("#page").val() * 1 == i) { // 현재페이지
			html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
		} else { // 다른 페이지
			html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
		}
		
	}
	
	if($("#page").val() * 1 == pd.maxP) { // 현재페이지가 마지막 페이지라면
		html += "<span class=\"page_btn page_next\" page=\"" + pd.maxP + "\">다음</span>";	
	} else {
		html += "<span class=\"page_btn page_next\" page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>";
	}
	html += "<span class=\"page_btn page_last\" page=\"" + pd.maxP + "\">마지막</span>";
	
	$(".paging_area").html(html);
}

var msg = {
		"insert" : "등록",
		"delete" : "삭제"
}

function action(flag) {
	
	// JavaScript Object에서의 [] : 해당 키값으로 내용을 불러오거나 넣을 수 있다.
	// 							 Java의 Map에서 get, put역할
	var params = $("#bmAddForm").serialize();
    $.ajax({
       url : "bmAction/" + flag, //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 res에 받고 함수 실행
    	   switch(res.msg) {
    	   case "success":
    		   
    		   // 목록 재조회
    		   switch(flag) {
    		   case "insert" :
    			   	break;
    		   case "delete" :
    			   	break;		   
    		   }
    		   
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
<body>
	<c:import url="/header"></c:import>
	<input type="hidden" id="oldGbn" value="${param.searchGbn}" />
	<input type="hidden" id="oldTxt" value="${param.searchTxt}" />
    <div class="bg">
    <div class="p">
    	<div class="mid1">
    		<span class="GBN">홈 > 유치원 정보</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid2_1">유치원 정보 조회</div>
	    		</div>
    <div class="mid">
	    <form action="#" id="bmAddForm" method="post">
	    	<input type="hidden" name="uNo" id="uNo" value="${sNo}">
	    	<input type="hidden" name="kinNo" id="kinNo">
	    	<input type="hidden" name="del" id="bmdel"/>
	    </form>
    	<form action="#" id="actionForm" method="post">
    		<input type="hidden" name="no" id="no">
    		<input type="hidden" name="uNo" id="uNo" value="${sNo}">
    		<input type="hidden" name="page" id="page" value="${page}">	
    	<div class="search_b_wrap">
			<select class="select_b" name="searchGbn" id="searchGbn">
	            <option value="0">유치원</option>
	            <option value="1">주소</option>
	    	</select>
	    	<div class="search_b">
	            <input type ="text" class="b_txt" name="searchTxt" id="searchTxt" value="${param.searchTxt}" placeholder="유치원 검색">
	    	</div>
	    	<div class="search_btn" id="searchBtn">검색</div>
    	<div class="mid3">
    	  <div class="mid3_1">조건별 검색
	    		<table>
	    			<colgroup>
	    				<col width="10" />
	    				<col width="150" />
	    			</colgroup>
	    			<tbody>
	    				<tr>
	    					<td><input type="radio" id="ttcb" class="cb" value="0" checked/></td>
	    					<td>전체</td>
	    				</tr>
	    				<tr>
	    					<td><input type="radio" name="etp" class="cb etp" value="1"/></td>
	    					<td>공립</td>
	    				</tr>
	    				<tr>
	    					<td><input type="radio" name="etp" class="cb etp" value="2"/></td>
	    					<td>사립</td>
	    				</tr>
	    				<tr>
	    					<td><input type="checkbox" name="aft" class="cb opt" value="3"/></td>
	    					<td>방과후</td>
	    				</tr>
	    				<tr>
	    					<td><input type="checkbox" name="spe" class="cb opt" value="4"/></td>
	    					<td>특수학급</td>
	    				</tr>
	    				<tr>
	    					<td><input type="checkbox" name="sbus" class="cb opt" value="5"/></td>
	    					<td>통학차량 운행</td>
	    				</tr>
	    			</tbody>
	    		</table>
    			<div class="mid3_1_btn" id="optBtn">선택한 조건으로 검색</div>
    			</div>    		
		</div>
    	</div>
    		</form>
    		<div class="mid3_2" id="listCnt"></div>
    		<div class="mid3_2" id="listBox"></div>
	    			<div class="paging_area"></div>
				</div>		
    		</div>
    	</div>
    <div class="bottom"></div>
</body>
</html>