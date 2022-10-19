<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교직원 등록</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/staff_insert.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
$(document).ready(function() {
	
	$("#backBtn").on("click", function() {
		history.back();	
	});
	
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
	
	// 등록버튼
	$("#insertBtn").on("click", function() {
		
	  if($.trim($("#pw").val()).length < 8 || $.trim($("#pw").val()).length > 12){
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
			});
      } else if($.trim($("#cel").val()) == "") {
			makeAlert("알림", "휴대폰 번호는 필수입력 사항입니다.", function() {
				$("#cel").focus();
			});
      } else if(isNaN($("#cel").val())) {
			makeAlert("알림", "휴대폰번호 형식이 올바르지 않습니다.</br>숫자만 입력해주세요.", function() {
				$("#cel").val("");
				$("#cel").focus();
			});
      } else if($("#cel").val().length != 11) {
			makeAlert("알림", "휴대폰번호 형식이 올바르지 않습니다.</br>숫자만 입력해주세요.", function() {
				$("#cel").val("");
				$("#cel").focus();
			});
      } else if($("#idChk").val() != 1) {
				makeAlert("알림", "아이디 중복여부를 확인해주세요");
				$("#idChk").val("0");
      } else {
    	  
		    var params = $("#actionForm").serialize();
		    $.ajax({
		       url : "staffAction/insert", //경로
		       type : "POST", //전송방식
		       dateType : "json", //데이터 형태
		       data : params, //보낼 데이터
		       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
		    	   switch(res.msg) {
		    	   case "success" :
		    			$("#actionForm").attr("action", "staffInfoList");
		    			$("#actionForm").submit();		    		   
		    		   break;
		    	   case "fail" :
		    		   makeAlert("알림", "등록 실패");
		    		   break;
		    	   case "error" :
		    		   makeAlert("알림", "등록 중 문제 발생");
		    		   break;
		    	   } 
		       },
		       error : function(request,status,error) { //실패했을 때 함수 실행
		          console.log(request.responseText); //실패 상세내역
		       }
		    }); // ajax end
	   }
	}); // insertBtn
	
	
});	 // doc ready 
</script>
</head>
<body>
	<div class="bg"></div>
	<div class="p1">
		<div class="superuser_list_icon" id="backBtn" >
			<img class="backIcon" src="resources/images/kin/back.png" width=20px height=auto />
			<p class="superuser_list">돌아가기</p>
		</div>
		<p class="p2">교직원 등록</p>
		<form action="#" id="actionForm" method="post" >
			<!-- 아이디중복체크 했는지 안했는지 확인 -->
			<input type="hidden" id="idChk" value="0"/>		
		
			<input type="hidden" name="uNo" id="uNo" >
			<input type="hidden" name="kinNo" id="kinNo" value="${param.kinNo}" >

			<span class="focus">*</span>아이디 <br /> 
			<input type="text" class="box_search" name="id" id="id"
				 			   maxlength="12" minlength="8" placeholder="8자 이상 13자 미만" /> 
			<input type="button" class="boxBtn" value="아이디중복 확인" id="idChkBtn" ><br /> 
			<span class="focus">*</span>비밀번호<br /> 
			<input type="password" class="box" name="pw" id="pw"
					  		   	   maxlength="12" minlength="8" placeholder="8자 이상 13자 미만"/><br />
			<span class="focus">*</span>비밀번호 확인<br /> 
			<input type="password" class="box" id="pwChk"
				  				   placeholder="비밀번호를 한 번 더 입력해주세요" />
			<span class="focus">*</span>이름<br />
			<input type="text" class="box"  name="nm" id="nm" /><br />
			<span class="focus">*</span>휴대폰번호<br />
			<input type="text" class="box" name="cel" id="cel" 
							   maxlength="11" placeholder="숫자만 입력해주세요" /><br />
		</form>
		<div id="btn">
			<input type="button" class="sign" value="등 록" id="insertBtn"/>
		</div>
	</div>
</body>
</html>