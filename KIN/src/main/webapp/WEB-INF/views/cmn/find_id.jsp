<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	// 입력창 엔터
	$("#actionForm").on("keypress", "input",  function() {
		// 엔터키 눌렸을 때
		if(event.keyCode == 13) {
			$("#findBtn").click();
			return false;
		}
	});
	
	// 로그인 페이지 버튼
	$("#loginBtn").on("click", function() {
		location.href = "loginU";
	});
	
	// ID 찾기 버튼
	$("#findBtn").on("click", function() {
		// 이름 입력창 빈칸
		if($.trim($("#nm").val()) == "") {
			makeAlert("알림", "이름을 입력해주세요.", function() {
				$("#nm").focus();
			});
		// 휴대폰 번호 입력창 빈칸
		} else if($.trim($("#cel").val()) == "") {
			makeAlert("알림", "휴대폰번호를 입력해주세요.", function() {
				$("#cel").focus();
			});
		// 휴대폰 번호 글자수
		} else if($.trim($("#cel").val().length) < 11) {
			makeAlert("알림", "휴대폰번호가 정확하지 않습니다.<br>다시 확인해주세요.", function(){
				$("#cel").focus();
			})
		} else {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				url : "findIdAjax",
				type : "POST",
				dataType : "json",
				data : params,
				success : function(res) {
					if(res.msg == "success") {
						$("#user_id").val(res.user_id);
						$("#actionForm").attr("action", "findId_r")
						$("#actionForm").submit();
					} else {
						makeAlert("알림", "일치하는 회원정보가 없습니다.<br>다시 확인해주세요.")
					}
				},
				error : function(request, status, error) {
					console.log(request.responseText);
				}
			});
		}
	});
	
	// 이름 입력창 특수문자, 숫자, 공백 혀용 X
	$("#nm").on("keyup", function() {
		var nm = $(this).val();
		$(this).val(nm.replace(/[~!@#$%^&*()_+|<>?:;{}`\-\=\\\,.'"\[\]/0-9" "]/gi,""));
	});
	
	// 휴대폰번호 입력창 숫자만 허용
	$("#cel").on("keyup", function() {
		var cel = $(this).val();
		$(this).val(cel.replace(/[^0-9]/gi, ""));
	});
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
		<form action="#" id="actionForm" method="post">
			<input type="hidden" name="user_id" id="user_id">
			이름 <br/>
			<input type="text" class="box" name="nm" id="nm"/><br/>
			휴대폰번호 <br/>
			<input type="text" class="box" name="cel" id="cel" placeholder="숫자만 입력해주세요."/><br/>
		</form>
		<div class="btn1" id="loginBtn">로그인 페이지</div>
		<div class="btn2" id="findBtn">아이디 찾기</div>
	</div>
</div>
</body>
</html>