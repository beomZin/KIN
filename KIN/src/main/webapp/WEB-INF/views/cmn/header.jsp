<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상단바</title>

<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<style>
.bm_tb {
	width: 280px;
	margin: 5px 0px;
	color: #262626;
}

.bm_tb td {
	border-bottom: 1px solid #fbfbfb;
	height: 40px;
	font-size: 14px;
	line-height: 13px;
}

.bm_tb td:nth-child(1) {
	text-indent: 7px;
}

.kin_nm {
	text-align: left;
}

.del_ico {
	width: 20px;
	position: relative;
	left: 20px;
	cursor: pointer;
}

#kin {
	cursor: pointer;	
}

.bm_move {
	width: 80px;
    font-size: 12px;
    display: inline-block;
    position: relative;
    left: 70%;
    cursor: pointer;
}

</style>
<script>
$(document).ready(function() {
	
	$("#login").on("click", function() {
		location.href = "loginU"
	});
	
	$("#logout").on("click", function() {
		if("${sKa}" != "") {
			Kakao.init('dab488255a2b2f746d8ae25c7f77ee78');
			Kakao.isInitialized();			
			kakaoLogout();
		}
		location.href = "logout";
	});
	
	$("#ttSearchForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			 $("#searchIco").click();
			return false;
		}
	});
	
	$("#searchIco").on("click", function() {
		
		$("#ttSearchForm").attr("action", "search");
		$("#ttSearchForm").submit();
	});
	
	$(".menu_l").on("click", function() {
		$("#link").val($(this).attr("link"));
		
		$("#menuForm").attr("action", $("#link").val());
		$("#menuForm").submit();	
	});
	
	
	$("#bmTb tbody").on("click", "#kin", function() {
		$("#bmNo").val($(this).parent().parent().attr("bmNo"));
		
		$("#bmForm").attr("action", "kinInfo");
		$("#bmForm").submit();
	});
	
	$("#bmTb tbody").on("click", "#delIco", function() {
		
		$("#bmNo").val($(this).parent().parent().attr("bmNo"));
	   // 삭제할 유치원 값
	   $("#chkdel").val($("#bmNo").val());

		 var params = $("#bmForm").serialize();
		    $.ajax({
		       url : "bmAction/delete", //경로
		       type : "POST", //전송방식
		       dateType : "json", //데이터 형태
		       data : params, //보낼 데이터
		       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
		    	   switch(res.msg) {
		    	   case "success":
		    		   bmFunction();
		    		   reloadList();
		    		   break;
		    	   case "fail":
		    		   alert("삭제에 실패하였습니다.");
		    		   break;
		    	   case "error":
		    		   alert("삭제 중 문제가 발생하였습니다.");
		    		   break;
		    	   }
		       },
		       error : function(request, status, error) { //실패했을 때 함수 실행
		          console.log(request.responseText); //실패 상세내역
		       }
		    });
	});

	$(".bm_move").on("click", function() {
		location.href = "bm";
	});
	
});

function bmFunction() {

  document.getElementById("bmDropdown").classList.toggle("show");
  
  var params = $("#bmForm").serialize();
  
  $.ajax({
     url : "bmAjax", //경로
     type : "POST", //전송방식s
     dateType : "json", //데이터 형태
     data : params, //보낼 데이터
     success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
    	 drawBMList(res.bmlist); 
     },
     error : function(request, status, error) { //실패했을 때 함수 실행
        console.log(request.responseText); //실패 상세내역
     }
  });
  
}

window.onclick = function(event) {
  if (!event.target.matches('.bookmark')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

function drawBMList(bmlist) {
	var html = "";
	var num = 0;
	
	for(var data of bmlist) {
		num += 1;
		
		html += "<tr bmNo=\"" + data.KIN_NO + "\">";
		html += "<td>" + num + "</td>";
		html += "<td><div id=\"kin\" class=\"kin_nm\">" + data.KIN_NM + "</div></td>";
		html += "<td><img alt=\"삭제\" src=\"resources/images/kin/delete.png\" class=\"del_ico\" id=\"delIco\"><td>";
		html += "</tr>";
		
	}
	
 	$("#bmTb tbody").html(html);
}

function kakaoLogout() {
	Kakao.API.request({
		url: "/v1/user/unlink"
	});
	Kakao.Auth.logout();
}
</script>
</head>
<body>
    <div class="head">
        <div class="logo">
            <a href="kinMain"><img src="resources/images/kin/logo_white.png" height="55px"></a>
        </div>
    </div>
    <div class="menu_wrap">
    <form action="#" id="menuForm" method="post">
    	<input type="hidden" name="link" id="link">
        <div class="menu_l" link="kinList">유치원 정보</div>
        <div class="menu_l" link="kinMap">지도</div>
        <div class="menu_l" link="brdMain">게시판</div>
    </form>
    <form action="#" id="bmForm" method="post">
    <input type="hidden" id="uNo" name="uNo"/>
   	<input type="hidden" name="del" id="chkdel"/>
    <input type="hidden" id="bmNo" name="no"/>
    <input type="hidden" id="h_page" name="bmpage" value="1"/>
        <c:if test="${!empty sId}">
        <div class="menu_r">
        <img src="resources/images/kin/bookmark.png" class="bookmark" onclick="bmFunction()">
        	<div id="bmDropdown" class="dropdown-content">
    			<div class="bm_title">즐겨찾기</div>
    			<div class="bm_move">목록으로 이동</div>
    			<table class="bm_tb" id="bmTb">
    				<colgroup>
    					<col width="30"/>
    					<col width="200"/>
    					<col width="50"/>    					
    				</colgroup>
    				<tbody></tbody>
    			</table>
  			</div>
        </div>
        </c:if>
     </form>
        <c:choose>
	       	<c:when test="${empty sId}">
	       		<div class="login" id="login">로그인</div>
	       	</c:when>
	       	<c:otherwise>
	       		<div class="login" id="logout">로그아웃</div>
	       		<c:if test="${sTp eq 0}">
			        <div class="profile"><a href="adminPage">관리자 페이지</a></div>
	       		</c:if>
	       		<c:if test="${sTp ne 0}">
			        <div class="profile"><a href="uInfo">회원정보</a></div>
	       		</c:if>
	       	</c:otherwise>
        </c:choose>
        <form action="#" id="ttSearchForm" method="post">
        <div class="search_wrap">
            <input type ="text" id="txt" class="txt" name="ttSearch" placeholder="괜찮은 아이들의 유치원 찾기">
            <div class="menu_r" id="searchIco">
                <img src="resources/images/kin/search_ico.png" class="search_ico">
            </div>
        </div>
        <select class="select_box">
            <option value="0">전체</option>
            <option value="1">유치원</option>
            <option value="2">게시글</option>
        </select>
        </form>
    </div>
</body>
</html>