<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
	text-align: center;
}

.p_one {
	margin: 25px auto;
	display: inline-block;
	font-size:22.4px;
	font-weight: bold;
	text-align: center;
	left: calc(22%);
}

.btn1, .btn2 {
	display:inline-block;
	margin-top: 30px;
	height: 50px;
	width: 150px;
	line-height: 50px;
	border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	text-align: center;
	border-radius: 5px;
	color: #f1f1f1;
}

.btn1 {
	margin-right : 80px;
}

.btn1:hover {
	background-color: #6c69bc;
	cursor: pointer;
}

.btn2:hover {
	background-color: #6c69bc;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$(".logo").on("click", function() {
		location.href = "kinMain";
	});
	
	// 로그인 페이지 버튼
	$("#loginBtn").on("click", function() {
		location.href = "loginU";
	});
	
	// 아이디 찾기 버튼
	$("#findBtn").on("click", function() {
		location.href = "findId";
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
			<div class="p_one">회원가입시 기입한 이메일로<br>임시비밀번호를 보냈습니다.<br>
			                   이메일을 확인해주세요.</div><br>
			<div class="btn1" id="loginBtn">로그인 페이지</div>
			<div class="btn2" id="findBtn">아이디 찾기</div>
		</div>
	</div>
</body>
</html>