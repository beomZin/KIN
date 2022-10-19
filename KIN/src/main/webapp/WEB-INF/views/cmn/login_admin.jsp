<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
	margin: 0 auto;
	font-size: 0;
	text-align: center
}

.bg {
	width: 100%;
	height: 100%;
	background-color: #8F8EBF;
	position: absolute;
	top: 0px;
	left: 0px;
	z-index: 5;
	opacity: 0.4;
}

.p {
	display: inline-block;
	vertical-align: top;
	width: 600px;
	height: 600px;
	background-color: #f5f6f7;
	position: absolute;
	top: calc(50% - 300px);
	left: calc(50% - 300px);
	z-index: 10;
}

.logo {
	display: inline-block;
	width: 250px;
	height: 60px;
	left: calc(50% - 300px);
	padding: 50px;
	cursor: pointer;
}

.p_info {
	width: 500px;
	height: 500px;
	line-height: 60px;
	font-size: 16.8px;
	color: #262626;
	font-weight: bold;
	position: absolute;
	left: calc(50% - 250px);
	text-align: left;
}

.box {
	width: 500px;
	height: 50px;
	border: 1px solid #f1f1f1;
	border-radius: 5px;
	outline:0;
	font-size: 16px;
	text-indent: 20px;
}

.box:hover {
	border: 1px solid #6c69bc; 
}

.log_in {
	margin-top: 50px;
	width: 500px;
	height: 50px;
	line-height: 50px;
	border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	text-align: center;
	border-radius: 5px;
	color: #f1f1f1;
	cursor: pointer;
}

.log_in:hover {
	background-color: #6c69bc;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	// 로고 클릭
	$(".logo").on("click", function() {
		location.href = "kinMain";
	});
	
	$("#actionForm").on("keypress", "input", function() {
		// 엔터키가 눌렸을 때
		if(event.keyCode == 13) {
			$(".log_in").click();
			return false;
		}
	});
	
	$(".log_in").on("click", function() {
		if($.trim($("#id").val()) == "") {
			makeAlert("알림", "아이디를 입력하세요.", function() {
				$("#id").focus();
			})
		} else if($.trim($("#pw").val()) == "") {
			makeAlert("알림", "비밀번호를 입력하세요.", function() {
				$("#pw").focus();
			})
		} else {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				url : "loginAdminAjax", // 경로
				type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
				dataType : "json", // 데이터 형태
				data : params, // 보낼 데이터
				success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
					if(res.msg == "success") {
						if(res.u_tp == "0") {
							location.href = "adminPage";
						} else {
							makeAlert("알림", "관리자가 아닙니다. <br> 아이디를 다시 확인해주세요.")
						}
					} else if(res.msg == "id_failed") {
						makeAlert("알림", "아이디가 존재하지 않습니다.<br> 아이디를 다시 확인해주세요.");
					} else {
						makeAlert("알림", "비밀번호가 일치하지 않습니다. <br> 비밀번호를 다시 확인해주세요.")
					}
				},
				error : function(request, status, error) { // 실패했을 때 함수 실행
					console.log(request.responseText); // 실패 상세 내역
				}
			});
		}
	});
});
</script>
</head>
<body>
	<div class="bg"></div>
	<div class="p">
		<div class="logo">
			<img src= "resources/images/kin/logo_dark.png" width=250px height=auto />
		</div>
		<div class="p_info">
			<form action="#" id="actionForm">
				아이디 <br/>
				<input type="text" class="box" name="id" id="id" /><br/>
				비밀번호 <br/>
				<input type="password" class="box" name="pw" id="pw" autocomplete="off" /><br/>
				<div class="log_in">로그인</div>
			</form>
		</div>
	</div>
</body>
</html>