<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입_카카오</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/reg.css" rel="stylesheet" type="text/css">
<style>
.attFile {
	height: 40px;
	line-height : 40px;
	width : 100%;
	margin : 15px 0px 20px;
	font-size: 16px;
	text-indent: 15px;
	border-radius: 5px;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	$("#logoBtn").on("click", function() {
		location.href = "kinMain";
	}); // 메인이동
	
	// 아이디중복체크
	$("#idChkBtn").on("click", function() {
	    var params = $("#actionForm").serialize();
	    $.ajax({
		   url : "idChkAjax", //경로
	       type : "POST", //전송방식
	       dateType : "json", //데이터 형태
	       data : params, //보낼 데이터
	       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
	    	   
 	  		   if($.trim($("#id").val()) == ""){
   					 makeAlert("알림", "아이디를 입력하세요", function() {
   						 $("#id").focus();
   					 });
   			   } else if($("#id").val().length < 8){
   					 makeAlert("알림", "아이디는 8글자 이상입니다.", function() {
   						 $("#id").focus();
   					 });
   			   } else if(res.cnt > 0) {
	    		   makeAlert("알림", "중복된 아이디 입니다.", function() {
					   $("#id").val("");
					   $("#id").focus();
	    		   });
	    	   } else {
	    		   makeAlert("알림", "사용가능한 아이디입니다.", function() {
		    		   $("#id").prop("readonly", true);
		    		   $("#idChk").val("1");
		    		   $("#pw").focus();
	    		   });
	    	   }
	       },
	       error : function(request,status,error) { 
	          console.log(request.responseText); 
	       }
	    }); // ajax end

	}); //idChkBtn
	
	  // 원장 + 일반 공통 필수 사항
	  $("#regBtn").on("click", function() {
		  if ($.trim($("#id").val()) == "") {
			  	makeAlert("알림", "아이디를 입력해주세요.", function() {
			  		$("#id").focus();
			  	});
		  } else if($("#idChk").val() != 1) {
				makeAlert("알림", "아이디 중복여부를 확인해주세요", function() {
					$("#idChk").val("0");
				});
		  } else if ($.trim($("#pw").val()).length < 8 || $.trim($("#pw").val()).length > 12){
		  		makeAlert("알림", "비밀번호는 8글자 이상 13글자 미만입니다.", function() {
					$("#pw").val("");
					$("#pw").focus();
				});
		  } else if($.trim($("#pwChk").val()) == ""){
				makeAlert("알림", "비밀번호를 다시 한 번 입력해주세요", function() {
					$("#pwChk").val("");
					$("#pwChk").focus();
				});
	      } else if($("#pwChk").val() != $("#pw").val()){
				makeAlert("알림", "비밀번호가 일치하지 않습니다.", function() {
					$("#pwChk").val("");
					$("#pwChk").focus();
				});
	      } else if($.trim($("#nm").val()) == "") {
	      		makeAlert("알림", "이름은 필수입력 사항입니다.", function() {
	      			$("#nm").focus();
	      		})
	      } else if($.trim($("#cel").val()) == "") {
	    	    makeAlert("알림", "휴대폰 번호는 필수입력 사항입니다.", function() {
	    	    	$("#cel").focus();
	    	    })
	      } else if(isNaN($("#cel").val())) {
	    	 	makeAlert("알림", "휴대폰번호 형식이 올바르지 않습니다.<br>숫자만 입력해주세요.", function() {
	    	 		$("#cel").val("");
	    	 		$("#cel").focus();
	    	 	})
	      } else if($("#cel").val().length != 11) {
	    	  	makeAlert("알림", "휴대폰번호 형식이 올바르지 않습니다.<br>다시 입력해주세요.", function() {
	    	  		$("#cel").val("");
	    	  		$("#cel").focus();
	    	  	})
	      } else {
	    	  
				var params = $("#actionForm").serialize();
				
				$.ajax({
					url : "uAction_kakao/insert", // 경로
					type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
					dataType : "json", // 데이터 형태
					data : params, // 보낼 데이터
					success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
						switch(res.msg) {
							case "success" :
								makeAlert("알림", "가입이 완료되었습니다.", function() {
									location.href = "loginU";
								});
								break;
							case "fail" :
								makeAlert("알림", "가입 중 문제가 발생했습니다.")
								break;
							case "exception" :
								makeAlert("알림", "문제가 발생했습니다.")
								break;
						}
					},
					error : function(requset, status, error) { // 실패했을 때 함수 실행
						console.log(request.responseText); // 실패 상세 내역
					}
				}); // ajax end
	      }
	  });
}); // doc ready
</script>
</head>
<body>
	<div class="bg"></div>
	<div class="p">
		<div class="logo" id="logoBtn">
			<img src="resources/images/kin/logo_dark.png" width=250px height=auto /><br />
		</div>
		<form action="#" id="actionForm" method="post">
			<input type="hidden" name="uTp" value="${param.uTp}" />

			<!-- 아이디중복 확인 했는지 안했는지 체크 -->
			<input type="hidden" id="idChk" value="0" />
			
			<span class="focus">*</span>아이디<br />
			<input type="text" class="box_search" id="id" name="id" maxlength="12" minlength="8" placeholder="8자 이상 13자 미만" /> 
			<input type="button" class="boxBtn" value="아이디중복 확인" id="idChkBtn"><br />
			<span class="focus">*</span>비밀번호 <br /> 
			<input type="password" class="box" id="pw" name="pw" maxlength="12" minlength="8" placeholder="8자 이상 13자 미만" /><br /> 
			<span class="focus">*</span>비밀번호 확인<br /> 
			<input type="password" class="box" id="pwChk" name="pwChk" placeholder="비밀번호를 한 번 더 입력해주세요" /><br /> 
			<span class="focus">*</span>이름<br /> 
			<input type="text" class="box" id="nm" name="nm" /><br /> 
			<span class="focus">*</span>이메일<br /> 
			<input type="email" class="box" id="email" name="email" value="${param.email}" readonly="readonly"/><br />
			<span class="focus">*</span>휴대폰 번호<br /> 
			<input type="text" class="box" id="cel" name="cel" maxlength="11" placeholder="숫자만 입력해주세요" /><br /> 
		</form>
		<input type="button" class="sign_up" value="가입하기" id="regBtn" />
	</div>
</body>
</html>