<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보수정</title>
<c:import url="/cmn" ></c:import>
<link href="resources/css/kin/update_u.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
$(document).ready(function() {	
	
	$("#backBtn").on("click", function() {
		history.back();
	});

	// 수정불가영역
	$("#id").prop("readonly", true);
	$("#idChk").prop("readonly", true);	
	
	// 지역구 선택
	$("#select_box").val($("#selectDis").val()).prop("selected",true);
	
	$("#updateBtn").on("click", function() {
		if($.trim($("#pw").val()) != "" && $.trim($("#pw").val()).length < 8 || $.trim($("#pw").val()).length > 12){
			makeAlert("알림", "비밀번호는 8글자 이상 13글자 미만입니다.", function() {
				$("#pw").val("");
				$("#pw").focus();
			});
	  } else if($.trim($("#pw").val()) != "" && $.trim($("#pwChk").val()) == ""){
			makeAlert("알림", "비밀번호를 다시 한 번 입력해주세요", function() {
				$("#pwChk").val("");
				$("#pwChk").focus();
			});
      } else if($.trim($("#pw").val()) != "" && $("#pwChk").val() != $("#pw").val()){
			makeAlert("알림", "비밀번호가 일치하지 않습니다.", function() {
				$("#pwChk").val("");
				$("#pwChk").focus();
			});
      } else if($.trim($("#nm").val()) == "") {
			makeAlert("알림", "이름은 필수입력 사항입니다.", function() {
				$("#nm").focus();
			});
      } else if($.trim($("#email").val()) == "") {
    	  	makeAlert("알림", "이메일은 필수입력 사항입니다.", function() {
    	  		$("#email").focus();
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
      }  else {
			// 지역구 수정 시
			$("#disNo").val($("#select_box").val());

		    var params = $("#actionForm").serialize();
		    $.ajax({
		       url : "uAction/update", //경로
		       type : "POST", //전송방식
		       dateType : "json", //데이터 형태
		       data : params, //보낼 데이터
		       success : function(res) { //성공했을 때 결과를 result에 받고 함수 실행
		    	   switch(res.msg) {
		    	   case "success" :
		    			   makeAlert("알림", "수정이 완료되었습니다.", function() { 
				    		   $("#actionForm").attr("action", "uInfo");
				    		   $("#actionForm").submit();
		    			   });
		    		   break;
		    	   case "fail" :
		    		   makeAlert("알림", "수정에 실패했습니다.");
		    		   break;
		    	   case "error" :
		    		   makeAlert("알림", "수정 중 문제가 발생했습니다.");
		    		   break;
		    	   case "email_Y" :
		    		   makeAlert("알림", "이미 존재하는 이메일입니다.<br> 수정에 실패하였습니다.")
		    	   } 
		       },
		       error : function(request,status,error) { //실패했을 때 함수 실행
		          console.log(request.responseText); //실패 상세내역
		       }
		    }); // ajax end
	   }
	}); // updateBtn
	
}); // doc ready

</script>
</head>
<body>
	<div class="p1">
		<div class="mypage_back_icon" id="backBtn">
			<img src="resources/images/kin/back.png" width=20px height=auto class="backIco"/>
			<p class="mypage_back">돌아가기</p>
		</div>
		<p class="p2">회원정보 수정</p>
		<form action="#" id="actionForm" method="post">
			<input type="hidden" id="uTp" name="uTp" value="3" />
			<!-- 기존지역구번호 보관 -->
			<input type="hidden" id="selectDis" name="selectDis" value="${data.DIS_NO}" />
			<!-- 수정지역구번호 보관 -->
			<input type="hidden" id="disNo" name="disNo" />
			<input type="hidden" id="uNo" name="uNo" value="${sNo}" />
			
			<span class="focus">*</span>아이디 수정 불가<br />
			<input type="text" class="box_search" id="id" name="id" maxlength="12" minlength="8" value="${data.ID}" /> 
			<input type="button" class="boxBtn" value="아이디중복 확인" id="idChkBtn"><br />
			<span class="focus">*</span>비밀번호 <br /> 
			<input type="password" class="box" id="pw" name="pw" maxlength="12" minlength="8" placeholder="8자 이상 13자 미만" /><br /> 
			<span class="focus">*</span>비밀번호 확인<br /> 
			<input type="password" class="box" id="pwChk" name="pwChk" placeholder="비밀번호를 한 번 더 입력해주세요" /><br /> 
			닉네임<br /> 
			<input type="text" class="box" id="nick" name="nick" maxlength="12"	placeholder="13자 미만" value="${data.NICK}" /><br /> 
			<span class="focus">*</span>이름<br />
			<input type="text" class="box" id="nm" name="nm" value="${data.NM}"/><br /> 
			이메일<br /> 
			<input type="email" class="box" id="email" name="email" value="${data.EMAIL}" /><br /> 
			<span class="focus">*</span>휴대폰 번호<br /> 
			<input type="text" class="box" id="cel" name="cel" maxlength="11" placeholder="숫자만 입력해주세요" value="${data.CEL}" /><br />
			지역구<br /> 
			<select class="box" id="select_box">
				<option value="0">지역구 선택</option>
				<option value="1">중구</option>
				<option value="2">영등포구</option>
				<option value="3">중랑구</option>
				<option value="4">은평구</option>
				<option value="5">금천구</option>
				<option value="6">동작구</option>
				<option value="7">강남구</option>
				<option value="8">종로구</option>
				<option value="9">용산구</option>
				<option value="10">광진구</option>
				<option value="11">양천구</option>
				<option value="12">관악구</option>
				<option value="13">서대문구</option>
				<option value="14">마포구</option>
				<option value="15">성동구</option>
				<option value="16">강북구</option>
				<option value="17">서초구</option>
				<option value="18">송파구</option>
				<option value="19">강동구</option>
				<option value="20">성북구</option>
				<option value="21">도봉구</option>
				<option value="22">노원구</option>
				<option value="23">강서구</option>
				<option value="24">구로구</option>
				<option value="25">동대문구</option>
			</select>
		</form>
		
		<div class="btnWrap">
			<input type="button" class="updateBtn" value="수정" id="updateBtn" /> 
		</div>
	</div>
</body>
</html>