<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보수정</title>
<c:import url="/cmn" ></c:import>
<link href="resources/css/kin/update_su.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.attFile_re {
	display: none;
}
</style>
<!-- file데이터 전송을 위해 form.js 스크립트 추가  -->
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#backBtn").on("click", function() {
		history.back();
	});
	
	// 수정불가영역
	$("#id").prop("readonly", true);
	$("#idChk").prop("readonly", true);
	$("#kinAddr").prop("readonly", true);
	
	// 지역구 설정
	$("#select_box").val($("#selectDis").val()).prop("selected", true);
	
	// 유치원 주소 검색
	$("#searchBtn").on("click", function() {
		if($.trim($("#kinNm").val()) != null && $.trim($("#kinNm").val()) != "") {
			$("#searchTxt").val($("#kinNm").val());
			$("#addrChk").val("1");
			popup();
		} else {
			makeAlert("알림", "유치원명을 입력해주세요.", function() {
				$("#kinNm").focus();
			})
		}
	});
	
	$("#updateBtn").on("click", function() {
		
		// 유치원명 수정시 설정
	//	if($("#oldKinNm").val() != $("#kinNm").val()) {
		//	$("#addrChk").val("0");
	//	}
		
	  	// 지역구 선택값 보관
	  	if($("#select_box").val() != "0") {
	  		$("#disNo").val($("#select_box").val());
	  	}
		
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
      } else if($("#oldKinNm").val() != $("#kinNm").val()) {
    	  $("#addrChk").val("0");
    	  makeAlert("알림", "유치원명이 변경되었습니다.<br> 다시 주소검색을 해주세요.");
      } else if($.trim($("#kinNm").val()) == "") {
    	  	makeAlert("알림", "유치원명을 검색해주세요.", function() {
    	  		$("#kinNm").val("");
    	  		$("#kinNm").focus();
    	  	});
      } else if($("#addrChk").val() != "1") {
    	  	makeAlert("알림", "주소 검색을 이용해주세요.", function() {
    		 	$("#addrChk").val("0"); 
    	  });
      } else if($("#att_nm").val() == "" && $(".attFile").val() == "") {
    	  makeAlert("알림", "증빙서류를 첨부해주세요.", function() {
    		 	$(".attFile").focus(); 
    	  });
      } else {
    	  
    	  	$("#actionForm").attr("action", "fileUploadAjax");
    	  	
    	  	var form = $("#actionForm");
    	  	
    	  	form.ajaxForm({
    	  		success: function(res) {
    	  			if(res.result == "SUCCESS") {
	    	  			if(res.fileName.length > 0) {
		    	  			$("#attNm").val(res.fileName[0]);
	    	  			}
	    	  			
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
							    		   location.href = "uInfo";
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
    	  			} else {
    	  				makeAlert("알림", "파일 업로드 중<br> 문제가 발생했습니다.");
    	  			}
    	  		},
    	  		error : function() {
    	  			makeAlert("알림", "파일 업로드 중<br> 에러가 발생했습니다");
    	  		}
    	  	});
    	  
    	  	form.submit();
	   }
	}); // 수정버튼
	
	$("#attBtn").on("click", function() {
		$(".attFile_y").remove();
		$("#attNm").val("");
		$(".attFile_re").show();
	});
}); // doc ready 

function popup() {
	var html = "";
	
	html += "<form id=\"popupForm\">";
	html += "<input type=\"hidden\" name=\"page\" id=\"page\" value=\"1\" />";
	html += "<input type=\"hidden\" name=\"searchGbn\" value=\"0\" />";
	html += "<input type=\"hidden\" name=\"searchTxt\" value=\"" + $("#kinNm").val() + "\" />";
	html += "<input type=\"hidden\" name=\"uTp\" id=\"uTp\" value=\"1\" />";
	html += "<table class=\"popT\">";
	html += "<thead>";
	html += "<tr>";
	html += "<th>유치원명</th>";
	html += "<th>주소</th>";
	html += "</tr>";
	html += "<tr>";
	html += "<td colspan=\"2\"><span class =\"info\">검색 결과가 존재하지 않습니다.</span></th>";
	html += "</tr>";
	html += "</thead>";
	html += "<tbody id=\"searchTxt\"></tbody>";
	html += "</table>";
	html += "</form>";
	
	makePopup({
		width: 800,
		height: 600,
		bg : true,
		bgClose: false,
		title: "유치원 주소검색",
		contents: html,
		contentsEvent: function() {
			var params = $("#popupForm").serialize();
			
			$.ajax({
		       url : "kinListAjax", 
		       type : "POST",
		       dateType : "json", 
		       data : params,
		       success : function(res) {
		    	   
		    	   if(res.cnt > 0) {
			    	   drawList(res.list);
		       	   } else {
		    		   $(".info").show();
		    	   }
		    	   
		       },
		       error : function(request,status,error) { //실패했을 때 함수 실행
		          console.log(request.responseText); //실패 상세내역
		       }
	    	}); // ajax end
	    	
	    	$("#popupForm #searchTxt").on("click", "tr", function() {
	    		$(this).css({backgroundColor: "#e1e1fb"});
	    		$("#no").val($(this).attr("kinNo"));
	    		$("#kinNm").val($(this).attr("kinNm"));
	    		$("#kinAddr").val($(this).attr("kinAddr"));
	    	});
		}
	})
}

function drawList(list) {
	var html = "";
	
	for(data of list) {
		html += "<tr kinAddr=\"" + data.KIN_ADDR + "\" kinNm=\"" + data.KIN_NM + "\" kinNo=\""+ data.KIN_NO +"\">";
		html += "<td>" + data.KIN_NM + "</td>";
		html += "<td>" + data.KIN_ADDR + "</td>";
		html += "</tr>";
	}
	
	$("#popupForm #searchTxt").html(html);
}
</script>
</head>
<body>
	<div class="p1">
		<div class="mypage_back_icon" id="backBtn">
			<img src="resources/images/kin/back.png" width=20px height=auto class="backIco"/>
			<p class="mypage_back">돌아가기</p>
		</div>
		<p class="p2">회원정보 수정</p>
		<form action="#" id="actionForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="uTp" name="uTp" value="1" />
			<input type="hidden" id="kinNo" name="kinNo" />
			<input type="hidden" id="uNo" name="uNo" value="${sNo}" />
			<input type="hidden" id="attNm" name="attNm" value="${data.ATT_NM}" />
			<!-- 기존 지역구번호 -->
			<input type="hidden" id="selectDis" value="${data.DIS_NO}">
			<!-- 수정된 지역구번호 -->
			<input type="hidden" id="disNo" name="disNo">
			<!-- 주소변경시 주소검색 체크 -->
			<input type="hidden" id="addrChk" value="1">
			<!-- 기존 유치원명 -->
			<input type="hidden" id="oldKinNm" value="${data.KIN_NM}">
			
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
			<span class="focus">*</span>유치원명 <br /> 
			<input type="text" class="box_search" id="kinNm" value="${data.KIN_NM}" /> 
			<input type="button" class="boxBtn" value="검색" id="searchBtn"><br />
			유치원 주소<br />
			<input type="text" class="box" id="kinAddr" value="${data.KIN_ADDR}" /><br />
			<span class="focus">*</span>증빙 서류<br /> 
			<div class="attFile_y">
				<c:set var="fileLength" value="${fn:length(data.ATT_NM)}"></c:set>
				<c:set var="fileName" value="${fn:substring(data.ATT_NM, 20, fileLength)}"></c:set>
				<input type="text" class="box_search" id="att_nm" value="${data.ATT_NM}" />
				<input type="button" class="boxBtn" value="삭제" id="attBtn"><br> 
			</div>
			<div class="attFile_re">
				<input type="file" name="attFile" class="attFile">			
			</div>
			지역구<br>
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
		<span class="focus_info"> * 기입하신 유치원 정보와 유치원 설립 인허가증, 고유번호증 등 증빙서류가 일치하지 않을 시 교직원
			등록이 불가합니다. 정확한 정보를 기입하셨는지 다시 한 번 확인해주세요. </span><br />
		<div class="btnWrap">
			<input type="button" class="updateBtn" value="수정" id="updateBtn"/> 
		</div>
	</div>
</body>
</html>