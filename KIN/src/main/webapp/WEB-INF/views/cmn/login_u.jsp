<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<c:import url="/cmn"></c:import>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  
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

.log_in {
	margin-top: 40px;
	width: 500px;
	height: 50px;
	line-height: 50px;
	border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	text-align: center;
	border-radius: 5px;
	color: #f1f1f1;
	cursor:pointer;
}

.log_in:hover {
	background-color: #6c69bc;
}

.log_menu {
	font-size: 14px;
	color: #959595;
	text-align: center;
}

.log_menu span {
	margin: 0 30px;
	cursor: pointer;
}

.kakao {
	margin-top: 5px;
	text-align: center;
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	// 이전화면 링크 보관
	if("${param.link}" != "") {
		$("#oldLink").val("${param.link}");
	}
	
	$("#actionForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			 $("#loginBtn").click();
			return false;
		}
	}); // 엔터 이벤트 처리
	
	$("#log_menu").on("click", "#regBtn", function () {
		makePopup({
			bg : true,
			bgClose : false,
			title : "회원가입",
			contents : "회원가입 유형을 선택해주세요",
			buttons : [{
				name : "원장",
				func:function() {
					// 사용자 유형 구분 (원장)
					$("#uTp").val("1");
					$("#uTpForm").submit();
					closePopup();
				}
			}, {
				name : "일반",
				func :function () {
					// 사용자 유형 구분 (일반)
					$("#uTp").val("3");
					$("#uTpForm").submit();
					closePopup();
				}
			}, {
				name : "취소"
			}]
			
		}); // uTp선택 팝업
		
	}); // 회원가입 페이지 이동
	
	$("#loginBtn").on("click", function() {
		if($.trim($("#id").val()) == "") {
			makeAlert("알림", "아이디를 입력하세요.", function() {
				$("#id").focus();
			})
		} else if($.trim($("#pw").val()) == "") {
			makeAlert("알림", "비밀번호를 입력하세요.", function() {
				$("#pw").focus();
			})
	 
		// ID 글자수
		}/* else if($.trim($("#id").val().length) < 6) {
			makeAlert("알림", "아이디 최소 글자수는 6글자입니다.<br>다시 확인해주세요.", function() {
				$("#id").focus();	
			});
		// PW 글자수
		} else if($.trim($("#pw").val().length) < 8) {
			makeAlert("알림", "비밀번호 최소 글자수는 8글자입니다.<br>다시 확인해주세요.", function() {
				$("#pw").focus();	
			});
		} */ else {
			var params = $("#actionForm").serialize();
			$.ajax({
		       url : "loginAjax", 
		       type : "POST", 
		       dateType : "json", 
		       data : params, 
		       success : function(res) {
		    	   if(res.msg == "success") {		   
			    		 $("#actionForm").attr("action", $("#link").val());
			    		 $("#actionForm").submit();
		    	   } else if(res.msg == "id_failed") {
						makeAlert("알림", "아이디가 존재하지 않습니다.<br> 아이디를 다시 확인해주세요.");
		    	   } else if(res.msg == "admin") {
		    			makeAlert("알림", "관리자는<br> 관리자 로그인 페이지로 로그인하세요.")
		    	   } else {
		    		  	makeAlert("알림", "비밀번호가 일치하지 않습니다.<br> 비밀번호를 다시 확인해주세요.")
		    	   }
		       },
		       error : function(request,status,error) { 
		          console.log(request.responseText); 
		       }
			}); // ajax
		}
	}); // loginBtn
	
	// ID 공백 허용 X
	$("#id").on("keyup", function() {
		var id = $(this).val();
		$(this).val(id.replace(/[" "]/gi, ""));
	});
	
	// PW 공백 허용 X
	$("#pw").on("keyup", function() {
		var pw = $(this).val();
		$(this).val(pw.replace(/[" "]/gi, ""));
	});
	
	// ID 찾기 버튼
	$("#findId").on("click", function() {
		location.href = "findId";
	});
	
	// PW 찾기 버튼
	$("#findPw").on("click", function() {
		location.href = "findPw";
	});
	
	// 카카오 로그인 버튼
	$("#kakao").on("click", function() {
		kakaoLogin();
	});
}); // doc ready

function kakaoLogin() {
	if(!Kakao.isInitialized()) {
		Kakao.init('dab488255a2b2f746d8ae25c7f77ee78');
		Kakao.isInitialized();
	}
	
		Kakao.Auth.loginForm({
			scope: "account_email",
			success: function (response) {
				Kakao.API.request({
					url: "/v2/user/me",
					success: function (res) {
						var k_email = res.kakao_account.email;
						console.log("k_email = ", k_email);
						
						$("#k_email").val(k_email);
						$("#email").val(k_email);
						
						var params = $("#actionForm").serialize();
						
						$.ajax({
					       url : "kakaoLoginAjax", 
					       type : "POST", 
					       dateType : "json", 
					       data : params, 
					       success : function(res) {
				    		  if(res.msg == "login") {
				    			  $("#actionForm").attr("action", $("#oldLink").val());
				    			  $("#actionForm").submit();
				    		  } else {
				    			  makePopup({
				    				  bgClose : false,
				    				  title : "알림",
				    				  contents : "일치하는 데이터가 없습니다. <br> 회원가입을 하시겠습니까?",
				    				  buttons : [{
				    					  name : "회원가입",
				    					  func : function() {
				    						  makePopup({
							    				  bgClose : false,
							    				  title : "회원가입",
							    				  contents : "카카오를 통한 회원가입유형은<br> 일반유형만 가능합니다. <br> 원장 회원가입은 취소버튼 클릭 후 <br>회원가입 글씨를 클릭해주세요.",
							    				  buttons : [{
							    					name : "일반",
							    					func : function() {
							    						// 유형(일반)
							    						$("#uTp").val("3");
							    						$("#uTpForm").attr("action", "reg_kakao");
							    						$("#uTpForm").submit();
							    						closePopup();
							    					}
							    				  }, {
							    					  name : "취소"
							    				  }]
							    			  });
				    						  closePopup();
				    					  }
				    				  }, {
				    					  name : "취소"
				    				  }]
				    			  });
				    		  }
					       },
					       error : function(request,status,error) { 
					          console.log(request.responseText); 
					       }
						}); // ajax
						
					},
					fail: function (error) {
						console.log(error);
					}
				})
			},
			fail: function (error) {
				console.log(error);
			}
		});
}
</script>
</head>
<body>
<!-- 이전 화면 링크 보관 -->
<input type="hidden" id="oldLink">
<!-- 사용자 유형 구분값 보관 -->
<form action="reg" method="post" id="uTpForm" >
	<input type="hidden" id="uTp" name="uTp" />
	<input type="hidden" id="email" name="email" />
</form>
	<div class="bg"></div>
	<div class="p">
		<div class="logo">
			 <a href="kinMain"><img src= "resources/images/kin/logo_dark.png" width=250px height=auto /></a>
		</div>
		
		<div class="p_info">
			<form action="loginAction" id="actionForm" method="post"  >
				<input type="hidden" name="link" id="link" value="${param.link}">
				<input type="hidden" name="k_email" id="k_email">
				아이디 <br/>
				<input type="text" class="box" name="id" id="id" /><br/>
				비밀번호 <br/>
				<input type="password" class="box" name="pw" id="pw"  /><br/>
			</form>
			<div class="log_in" id="loginBtn" >로그인</div>
			<div class="log_menu" id="log_menu">
				<span id="findId">ID찾기</span>
				<span id="findPw">PW찾기</span>
				<span id="regBtn">회원가입</span>
			</div>
			<div class="kakao" id="kakao">
				<img src="resources/images/kin/kakao_login_medium_wide.png" />
			</div>
		</div>
	</div>
</body>
</html>