<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
	color: #262626;
}

.logo {
	display: inline-block;
	width: 250px;
	height: 60px;
	left: calc(50% - 300px);
	padding: 50px;
}

.p_info {
	width: 500px;
	height: 500px;
	line-height: 50px;
	font-size: 16.8px;
	color: #262626;
	font-weight: bold;
	position: absolute;
	left: calc(50% - 250px);
	text-align: left;
}

.p_one {
	position: absolute;
	margin-left: 50px;
	display: inline-block;
}

.p_two {
	position: absolute;
	margin-left: 250px;
	display: inline-block;
}

.id {
	display: inline-block;
	height: 50px;
	width: 50px;
	margin-left: 80px;
	font-size: 40px;
	font-weight: bold;
	line-height: 50px;
}


.btn1, .btn2 {
	display:inline-block;
	margin-top: 50px;
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
	margin : 0px 80px 0px 60px;
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
	// 로그인 버튼
	$("#loginBtn").on("click", function() {
		location.href = "loginU";
	});
	
	// 비밀번호 찾기 버튼
	$("#findBtn").on("click", function() {
		location.href = "findPw";
	});
	
	var id = "${param.user_id}";
	var x = "**";
	var id_r = id.substring(0,2) + x + id.substring(4);
	$(".id").html(id_r);
}); // document ready End
</script>
</head>
<body>
<div class="bg"></div>
<div class="p">
	<div class="logo">
		 <a href="kinMain"><img src= "resources/images/kin/logo_dark.png" width=250px height=auto /></a>
	</div>
	
	<div class="p_info">
		<input type="hidden" id="user_id" value="${param.user_id}">
		<div class="p_one">가입하신 아이디는</div><br>
		<div class="id"></div>
		<div class="p_two">입니다.</div><br>
		<div class="btn1" id="loginBtn">로그인 페이지</div>
		<div class="btn2" id="findBtn">비밀번호 찾기</div>
	</div>
</div>
</body>
</html>