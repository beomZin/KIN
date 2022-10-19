<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>괜찮아유 통합검색</title>
    <c:import url="/cmn"></c:import>
    <link href="resources/css/kin/search.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	reloadList()
	
	$("#actionForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			 $("#searchBtn").click();
			return false;
		}
	});
	
	// 검색 버튼
	$("#searchBtn").on("click", function() {
		
		reloadList();
		
	});
	
	// 유치원 상세보기
	$(".kin_tb tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "kinInfo");
		$("#actionForm").submit();
	});

	// 게시글 상세보기
	$(".brd_tb tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "brdDetail");
		$("#actionForm").submit();
	});
	
	// 유치원 더보기
	$("#kinMore").on("click", function() {
		location.href = "kinInfo";
	});
	
	// 게시판 더보기
	$(".lounge").on("click", function() {
		if("${sNo}" == null || "${sNo}" == "") {
			location.href = "brdLounge"
		} else if("${sDis}" != "") {
			location.href = "brdLounge"
		} else {
			makeAlert("알림", "회원님의 지역구 정보가 존재하지 않습니다.<br> 동네라운지 게시판 이용을 원하시면<br>회원정보에서 지역구를 설정해주세요.");
		}
	});
	
	$(".educate").on("click", function() {
		location.href = "brdEducate"
	});
	
	$(".culture").on("click", function() {
		location.href = "brdCulture"
	});
	
	$(".ask").on("click", function() {
		location.href = "brdAsk"
	});
	
			
});

function reloadList() {
    var params = $("#actionForm").serialize();
    $.ajax({
       url : "searchAjax", //경로
       type : "POST", //전송방식
       dateType : "json", //데이터 형태
       data : params, //보낼 데이터
       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
    		  $(".kin_emp_wrap").hide();
    		  $(".kin_list_wrap").hide();
    	   
    	   if(res.kinCnt != 0) {
    		   $(".kin_list_wrap").show();
    		   drawKinL(res.kinL); 
        	   drawKinR(res.kinR);   
    	  } else {
    		  $(".kin_emp_wrap").show();
    	  }
    	   
    	   if(res.dis == "0" || res.dis == "all") {
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

function drawKinL(kinL) {
	var html = "";
	
	for(var data of kinL) {
		html += "<tr no=\"" + data.KIN_NO + "\">";
        html += "<td>" + data.DIS_NM + "</td>";
        html += "<td>" + data.KIN_NM + "</td>";
        if(data.E_TP == "0") {
        	html += "<td><div class=\"etp0\">공립</div></td>";
        } else if(data.E_TP == "1") {
        	html += "<td><div class=\"etp1\">사립</div></td>";        	
        }
        html += "<td><img src=\"resources/images/kin/rate.png\" class=\"rate\"></td>";
        html += "<td>" + data.AVG + "</td>";
    	html += "</tr>";
	}
	
 	$("#kinTbL tbody").html(html);
}

function drawKinR(kinR) {
	var html = "";

	for(var data of kinR) {
		html += "<tr no=\"" + data.KIN_NO + "\">";
        html += "<td>" + data.DIS_NM + "</td>";
        html += "<td>" + data.KIN_NM + "</td>";
        if(data.E_TP == "0") {
        	html += "<td><div class=\"etp0\">공립</div></td>";
        } else if(data.E_TP == "1") {
        	html += "<td><div class=\"etp1\">사립</div></td>";        	
        }
        html += "<td><img src=\"resources/images/kin/rate.png\" class=\"rate\"></td>";
        html += "<td>" + data.AVG + "</td>";
    	html += "</tr>";
	}
 	
 	$("#kinTbR tbody").html(html);
}

function drawLounge(lounge) {
	var html = "";
	
	for(var data of lounge) {		
		html += "<tr no=\"" + data.NO + "\">";
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
		html += "<tr no=\"" + data.NO + "\">";
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
		html += "<tr no=\"" + data.NO + "\">";
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
		html += "<tr no=\"" + data.NO + "\">";
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
	<input type="hidden" id="oldTxt" value="${param.searchTxt}" />
    <div class="bg">
    	<div class="p">
        <span class="GBN">홈 > 통합 검색</span>
        <form action="#" id="actionForm" method="post">
        	<input type="hidden" name="no" id="no">
        	<input type="hidden" name="dis_no" value="${sDis}">
        	<input type="hidden" name="uNo" value="${sNo}">
	        <div class="search">
		        <div class="search_b_wrap">
				<select class="select_b" name="searchGbn" id="searchGbn">
		            <option value="0">전체</option>
		            <option value="1">유치원</option>
		            <option value="2">게시판</option>
		    	</select>
		    	<div class="search_b">
		            <input type ="text" class="b_txt" name="searchTxt" id="searchTxt" placeholder="괜찮은 아이들의 유치원 찾기" value="${param.ttSearch}">
		    	</div>
		    	<div class="search_btn" id="searchBtn">검색</div>
				</div>
	        </div>
		</form>
        <div class="kinder">
            <div class="kin_title">유치원</div>
	            <div class="kin_emp_wrap">
	            	<div class="kin_emp_txt">검색 결과가 존재하지 않습니다.</div>
	            </div>
	            <div class="kin_list_wrap">
	                <div class="kin_list">
	                    <table class="kin_tb t" id="kinTbL">
	                        <colgroup>
	                            <col width="75" />
	                            <col width="250" />
	                            <col width="50" />
	                            <col width="20" />                            
	                            <col width="55" />
	                         </colgroup>
	                        <tbody></tbody>
	                    </table>
	                </div>
	                <div class="kin_list">
	                    <table class="kin_tb t" id="kinTbR">
	                        <colgroup>
	                            <col width="75" />
	                            <col width="250" />
	                            <col width="50" />
	                            <col width="20" />                            
	                            <col width="55" />
	                         </colgroup>
	                        <tbody></tbody>
	                    </table>
	                </div>
	                <div class="kin_more" id="kinMore">더보기</div>
	            </div>
        	</div>
                <div class="board">
            <div class="brd_div" style="margin: 20px 20px 20px 8px;">
                <div class="brd_title lounge">동네라운지</div>
                <div class="brd_list">
                    <table class="brd_tb t" id="lounge">
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
                    <table class="brd_tb t" id="educate">
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
                    <table class="brd_tb t" id="culture">
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
                <div class="brd_title ask" >궁금해요!</div>
                <div class="brd_list">
                    <table class="brd_tb t" id="ask">
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