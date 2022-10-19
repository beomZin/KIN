<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 _ 게시글 상세페이지</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<style>    

.logo {
	cursor : pointer;
}

.mid {
	width: 1100px;
	margin: 0 auto;
	position: relative;
	min-height: 700px;
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

.mid2 {
	height : 50px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid2_1{
	margin : 15px 5px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 22.4px;
	width: 200px;
	height: 30px;
	line-height: 30px;
	font-weight : bold;
	color: #262626;
}

.mid2_btn1, .mid2_btn2 {
	margin-top : 15px;
	float: right;
    display: inline-block;
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
    vertical-align : top;
}

.mid2_btn1 {
	margin-right : 10px;
}

.mid2_btn1:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid2_btn2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 1.5%;
}

.mid3 {
	margin-top : 20px;
	padding-bottom : 10px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	border-bottom : 3px solid #F1F1F1;
}

.mid3_1 {
	margin-top : 5px;
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 600px;
	color: #262626;
	font-weight : bold;
}

.mid3_2 {
	width: 100px;
	margin-right: 20px;
}

.mid3_3 {
	width : 100px;
}

.mid3_4 {
	width : 180px;
}

.mid3_2, .mid3_3, .mid3_4 {
	margin-top : 5px;
	float: right;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 14px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid4 {
	margin-top : 15px;
	padding-bottom : 20px;
	background : #FFFFFF;
	width : 1100px;
	border-bottom : 3px solid #F1F1F1;
	min-height: 400px;
}

.mid4_b {
	background : #FFFFFF;
	vertical-align : top;
	width : 1000px;
	margin : 30px auto;
}

.wrap {
	text-align : right;
	width : 1100px;
	height : 40px;
}

.mid6 {
	background : #f9f9f9;
	padding-bottom : 10px;
	border-bottom : 3px solid #EEEEEE;
	vertical-align : top;
	width: 100%;
	border-radius: 5px;
}

.mid6_1, .mid6_2, .mid6_3, .mid6_4{
	margin : 5px 5px;
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 14px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid6_1 {
	width : 250px;
	margin-left : 30px;
	font-weight : bold;
}

.me {
	display: inline-block;
    width: 45px;
    height: 20px;
    border: 1px solid grey;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 20px;
}

.mid6_2, .mid6_3, .mid6_4 {
	float : right;
}

.mid6_2 {
	cursor: pointer;
}

.mid6_3 {
	visibility: hidden;
}


.mid6_h {
	background : #f9f9f9;
	vertical-align : top;
	width: 100%;
	border-radius: 5px;
}

.mid6_b {
	border-radius: 5px;
	background : #f9f9f9;
	vertical-align : top;
	width : 800px;
	margin : 0px auto;
	min-height: 85px;
}

.mid7 {
	margin-bottom : 40px;
	background : #FFFFFF;
	width: 100%;
}

.bottom {
	background: #4b4a6e;
	height: 180px;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	
	// 제목, 내용 < and > 설정
	var title = "${dataBrd.TITLE}"
	var con = "${dataBrd.CON}"
	
	title = title.replace(/&lt;/gi, "<");
	title = title.replace(/&gt;/gi, ">");
	con = con.replace(/&lt;/gi, "<");
	con = con.replace(/&gt;/gi, ">");
	
	$(".mid3_1").html(title);
	$(".mid4_b").html(con);
	
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
	
	// 댓글 조회
	reloadList();
	
	// 삭제 버튼
	$(".mid2_btn1").on("click", function() {
		makePopup({
			title : "알림",
			contents : "삭제 하시겠습니까?",
			buttons : [{
				name : "삭제",
				func:function() {
					// serialize() : 해당 내용물들 중 값 전달이 가능한 것들을 전송가능한 문자 형태로 전환.
					var params = $("#actionForm").serialize();
					
					$.ajax({
						url : "ActionBrdAjax", // 경로
						type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
						dataType : "json", // 데이터 형태
						data : params, // 보낼 데이터
						success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
							switch(res.msg) {
								case "success" :
									location.href = "adminBrd";
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
	});
	
	// 목록 버튼
	$(".mid2_btn2").on("click", function() {
		$("#actionForm").attr("action", "adminBrd");
		$("#actionForm").submit();
	});
	
	// 댓글 삭제
	$(".cmt_area").on("click", "#img", function() {
		
		$("#cmt_no").val($(this).attr("cmt_no"));
		
		makePopup({
			title : "알람",
			contents : "삭제 하시겠습니까?",
			buttons : [{
				name : "삭제",
				func : function() {
					
					var params = $("#actionForm").serialize();
					
					$.ajax({
						url : "ActionCmtAjax/delete", // 경로
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
			}, {
				name : "취소"
			}]
		});
	});
}); // document ready End

function reloadList() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "adminCmtListAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
			drawCmt(res.listCmt);
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	});
};


function drawCmt(list) {
	 
	var html = "";
	
	for (var data of list) {
		html += "<div class=\"mid6\">";
		html += "<div class=\"mid6_h\" cmt_no=\"" + data.CMT_NO + "\">";
		html += "<div class=\"mid6_1\">" + data.NICK;
		if("${dataBrd.U_NO}" == data.U_NO) {
			html += " <div class=\"me\" style=\"color:grey\">작성자</div>";
		}
		html += "</div>";
		html += "<div class=\"mid6_2\">";
		html += "<img alt=\"삭제\" src=\"resources/images/kin/delete.png\" height=\"20\" id=\"img\" cmt_no=\"" + data.CMT_NO + "\">";
		html += "</div>";
		html += "<div class=\"mid6_3\">";
		html += "<img alt=\"수정\" src=\"resources/images/kin/update.png\" height=\"20\">";
		html += "</div>";
		html += "<div class=\"mid6_4\">" + data.REG_DT + "</div>";
		html += "</div>";
		html += "<div class=\"mid6_b\">";
		
		var cmt_con = data.CON;
		cmt_con = cmt_con.replace(/&lt;/gi, "<");
		cmt_con = cmt_con.replace(/&gt;/gi, ">");
		
		html += "" + cmt_con + "";
		html += "</div>";
		html += "</div>";
	}
	
	$(".cmt_area").html(html);
}
</script>
    
</head>
<body>
	<form action="#" id="actionForm" method="POST">
		<input type="hidden" name="cmt_no" id="cmt_no">
		<input type="hidden" name="no" value="${dataBrd.NO}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="searchGbn" value="${param.searchGbn}">
		<input type="hidden" name="searchText" value="${param.searchText}">
	</form>
    <div class="head">
        <div class="logo">
            <img src="resources/images/kin/logo_white.png" height="55px" id="logo">
        </div>
    </div>
    
    <div class="mid">
    	<div class="mid1">
    		<div class = "mid1_1">회원 관리</div>
			<div class = "mid1_2">게시판 관리</div>
			<div class = "mid1_3">고객센터</div>
			<span class="GBN">홈 > 관리자 페이지 > 게시판 관리 > 게시글</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid2_1">${dataBrd.CT_NM}</div>
	    	<div class ="mid2_btn2">목 록</div>
	    	<div class ="mid2_btn1">삭 제</div>
    	</div>
    	<div class="mid3">
    		<div class="mid3_1"></div>
    		<div class="mid3_2">조회 ${dataBrd.HIT}</div>
    		<div class="mid3_3">${dataBrd.REG_DT}</div>
    		<div class="mid3_4">${dataBrd.NICK}</div>	
    	</div>
    	<div class="mid4">
   			<c:if test="${!empty dataBrd.ATT_NM}">
	    	<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
	    	<c:set var="fileLength" value="${fn:length(dataBrd.ATT_NM)}"></c:set>
	    	<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
	    	<c:set var="fileName" value="${fn:substring(dataBrd.ATT_NM, 20, fileLength)}"></c:set>
	    		<div class="wrap">
		    			<a href="resources/upload/${dataBrd.ATT_NM}" 
		    			   download="${fileName}" style="color:grey">첨부파일 : ${fileName}</a>
	    		</div>
	    	</c:if>
    		<div class="mid4_b"></div>
    	</div>
		<div class="mid7"></div>
    	<div class="cmt_area"></div>
    	<div class="mid7"></div>
    </div>
    <div class="bottom"></div>
</body>
</html>