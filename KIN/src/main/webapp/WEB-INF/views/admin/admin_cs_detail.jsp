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
<title>관리자 페이지 _ 고객센터 상세페이지</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<!-- CKEditor -->
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

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
	margin: 15px 5px;
    vertical-align: top;
    text-align: center;
    display: inline-block;
    border-radius: 5px;
    font-size: 22.4px;
    width: 200px;
    height: 30px;
    line-height: 30px;
    font-weight: bold;
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
	height : 50px;
	background : #FFFFFF;
	border-bottom : 3px solid #F1F1F1;
	vertical-align : top;
	margin-top : 15px;
	width : 1100px;
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

.mid3_3 {
	width : 100px;
}

.mid3_4 {
	width : 180px;
}


.mid3_3, .mid3_4 {
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

.mid3_2 {
	margin-top : 5px;
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 550px;
	color: #262626;
	font-weight : bold;
}

.mid4 {
	margin-top : 15px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	min-height: 300px;
}

.mid4_b {
	background : #FFFFFF;
	vertical-align : top;
	width : 1000px;
	margin : 30px auto;
}

.wrap {
	text-align: right;
	width : 1100px;
	height: 40px;
}

.mid5 {
	display: inline-block;
	margin : 20px 0 40px;
	background : #FFFFFF;
	vertical-align : top;
	width: 1100px;
	border-top : 3px solid #F1F1F1;
}

.mid5_a {
	display: inline-block;
	background : #FFFFFF;
	padding: 10px 0px 10px 10px;
	border : 3px solid #E1E1E1;
	border-radius : 5px;
	vertical-align : top;
	width: 70%;
	height : 455px;
	position : relative;
	margin-top: 30px;
}

.mid5_b {
	display: none;
	background : #FFFFFF;
	padding: 10px 0px 10px 10px;
	border : 3px solid #E1E1E1;
	border-radius : 5px;
	vertical-align : top;
	width: 70%;
	min-height : 300px;
	position : relative;
	margin-top: 30px;
}

.mid5_c {
	display: none;
	background : #FFFFFF;
	padding: 10px 0px 10px 10px;
	border : 3px solid #E1E1E1;
	border-radius : 5px;
	vertical-align : top;
	width: 70%;
	min-height : 300px;
	position : relative;
	margin-top: 30px;
}

textarea {
	width: 98.5%;
	height: 100%;
	border: none;
	resize: none;
	font-size: 14px;
}

textarea:focus {
	outline: none;
}

.mid5_2, .mid5_3, .mid5_4 {
	margin-top : 30px;
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

.mid5_2 {
	margin-right : 50px;
}

.mid5_3 {
	margin-right : 30px;
}

.mid5_2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid5_3:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid5_4:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.insert {
	display: inline-block;
	margin-left: 50px;
}

.update_a {
	display: none;
	margin-left: 50px;
}

.update_b {
	display: none;
	margin-left: 50px;
}

.bottom {
	background: #4b4a6e;
	height: 180px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	// CKEDITOR
	CKEDITOR.replace("rep_con", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		width : "98.5%",
		height : 350
	});
	
	// 제목, 내용 < and > 설정
	var title = "${data.TITLE}";
	var con = "${data.CON}";
	
	title = title.replace(/&lt;/gi, "<");
	title = title.replace(/&gt;/gi, ">");
	con = con.replace(/&lt;/gi, "<");
	con = con.replace(/&gt;/gi, ">");
	
	$(".mid3_2").html(title);
	$(".mid4_b").html(con);
	
	// 답변내용이 존재한다면
	if("${data.REP_CON}" != "") {
		$(".mid5_a").hide();
		$(".insert").hide();
		$(".update_b").hide();
		
		var rep_con = "${data.REP_CON}";
		rep_con = rep_con.replace(/&lt;/gi, "<");
		rep_con = rep_con.replace(/&gt;/gi, ">");
		$(".mid5_b").html(rep_con);
		$("#rep_con").val(rep_con);
		
		$(".mid5_b").show();
		$(".mid5_b").css("display","inline-block");
		$(".update_a").show();
		$(".update_a").css("display","inline-block");
	}
	
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
	
	// 목록 버튼
	$(".mid2_btn2").on("click", function() {
		$("#actionForm").attr("action", "adminCs");
		$("#actionForm").submit();
	});
	
	// 삭제 버튼
	$(".mid2_btn1").on("click", function() {
		makePopup({
			title : "알림",
			contents : "삭제 하시겠습니까?",
			buttons : [{
				name : "삭제",
				func : function() {
					var params = $("#actionForm").serialize();
					
					$.ajax({
						url : "ActionCsAjax", // 경로
						type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
						dataType : "json", // 데이터 형태
						data : params, // 보낼 데이터
						success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
							switch(res.msg) {
								case "success" :
									location.href = "adminCs";
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
		});
	});
	
	// 답변 등록 버튼
	$(".mid5_2").on("click", function() {
		
		$("#rep_con").val(CKEDITOR.instances['rep_con'].getData());
		
		if($.trim($("#rep_con").val()) == "") {
			makeAlert("알림", "답변 내용을 작성해주세요.", function() {
				CKEDITOR.instances['rep_con'].focus();
			});
		} else {
			adminCsAction("insert");
		}
	});
	
	// 답변 수정 버튼
	$(".update_a").on("click", ".mid5_3", function() {
		$(".mid5_b").hide();
		$(".mid5_a").show();
		CKEDITOR.instances['rep_con'].focus();
		$(".update_a").hide();
		$(".update_b").show();
		$(".update_b").css("display", "inline-block");
	});
	
	// 답변 수정 클릭 후 수정-취소 에서 수정 버튼
	$(".update_b").on("click", ".mid5_3", function() {
		
		$("#rep_con").val(CKEDITOR.instances['rep_con'].getData());
		
		if($.trim($("#rep_con").val()) == "") {
			makeAlert("알림", "답변 내용을 작성해주세요.", function() {
				CKEDITOR.instances['rep_con'].focus();
			})
		} else {
			adminCsAction("update");
		}
	});
	
	// 답변 수정 클릭 후 수정-취소 에서 취소 버튼
	$(".update_b").on("click", ".mid5_4", function() {
		CKEDITOR.instances['rep_con'].setData(rep_con);
		$(".mid5_a").hide();
		$(".mid5_b").show();
		$(".update_b").hide();
		$(".update_a").show();
	});
	
}); // document ready End

var msg = {
	"insert" : "등록",
	"update" : "수정"
}

function adminCsAction(flag) {
	
	// con의 <들을 웹문자로 변환
	$("#rep_con").val($("#rep_con").val().replace(/</gi, "&lt;"));
	// con의 >들을 웹문자로 변환
	$("#rep_con").val($("#rep_con").val().replace(/>/gi, "&gt;"));

	var params = $("#actionForm").serialize();

	$.ajax({
		url : "adminCsActionAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) { 
			switch(res.msg) {
				case "success" :
					$("#actionForm").attr("action", "adminCsDetail");
					$("#actionForm").submit();
				case "fail" :
					makeAlert("알림", msg[flag] + "에 실패했습니다.")
					break;
				case "exception" :
					makeAlert("알림", msg[flag] + " 중 문제가 발생했습니다.")
					break;
			}
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	}); 
};
</script>

</head>
<body>
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
    		<span class="GBN">홈 > 관리자 페이지 > 고객센터 > 글</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid2_1">고객센터</div>
			<div class="mid2_btn2">목 록</div>
			<div class="mid2_btn1">삭 제</div>
    	</div>
    	<div class="mid3">
    		<c:choose>
    			<c:when test="${empty data.REP_CON}">
		    		<div class = "re1">미답변</div>
    			</c:when>
    			<c:otherwise>
		    		<div class = "re2">답변완료</div>
    			</c:otherwise>
    		</c:choose>
			<div class = "mid3_2"></div>
			<div class = "mid3_3">${data.REG_DT}</div>
			<div class = "mid3_4">${data.ID} ( ${data.NICK} )</div>
    	</div>
    	<div class="mid4">
    		<c:if test="${!empty data.ATT_NM}">
    		<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
    		<c:set var="fileLength" value="${fn:length(data.ATT_NM)}"></c:set>
    		<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
    		<c:set var="fileName" value="${fn:substring(data.ATT_NM, 20, fileLength)}"></c:set>
    			<div class="wrap">
    				<a href="resources/upload/${data.ATT_NM}"
    				   download="${fileName}" style="color:grey">첨부파일 : ${fileName}</a>
    			</div>
    		</c:if>
    		<div class="mid4_b"></div>
    	</div>
    	<div class="mid5">
    		<form action="#" id="actionForm" method="POST">
    			<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="searchGbn" value="${param.searchGbn}">
				<input type="hidden" name="searchText" value="${param.searchText}">
				
    			<input type="hidden" name="no" value="${param.no}">
    			<input type="hidden" name="admin_no" value="${sNo}">
	    		<div class="mid5_a">
	    			<textarea name="rep_con" id="rep_con" placeholder="내용을 입력해주세요."></textarea>
	    		</div>
	    		<div class="insert">
	    			<div class="mid5_2">등 록</div>
	    		</div>
	  			<div class="mid5_b"></div>
	    		<div class="update_a">
	    			<div class="mid5_3">수 정</div>
	    		</div>
	    		<div class="update_b">
	    			<div class="mid5_4">취 소</div>
	    			<div class="mid5_3">수 정</div>
	    		</div>
	    	</form>
    	</div>
    </div>
	<div class="bottom"></div>
</body>
</html>