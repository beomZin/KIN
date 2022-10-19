<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>원장 회원정보</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/mypage.css" rel="stylesheet" type="text/css" />
<style>
.bottom {
height: 114px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	console.log("dfasfdsaf");
	$("#cs").on("click", function() {
		location.href = "csList";
	}); // cs 이동

	$("#write").on("click", function() {
		location.href = "writeBrd";
	}); //작성내역 이동
	
	$("#uInfoUpdate").on("click", function() {
		location.href = "uInfoUpdate";
	}); // uInfoUpdate 이동
	
	$("#staff").on("click", function() {
		// 승인완료 상태
		if("${data.APPV}" == "0") {
			$("#kinForm").attr("action", "staffInfoList");
			$("#kinForm").submit();	 
		} else {
		// 승인대기, 승인거부 상태
			makeAlert("알림", "승인상태가 완료일 때 이용 가능합니다.")
		}
			
	}); // 교직원목록 이동

	$("#delBtn").on("click", function() {

		makePopup({
			title : "알림",
			contents : "정말 탈퇴하시겠습니까?",
			buttons : [{
				name : "탈퇴",
				func:function() {
					
					var params = $("#actionForm").serialize();
					
					$.ajax({
						
						url : "uAction/delete",   
						type : "POST", 
						dateType : "json",
						data : params,
						success : function() {
							$("#actionForm").attr("action", "logout");
			    			$("#actionForm").submit();		
					    	 
					       },
					       error : function(request,status,error) { 
					          console.log(request.responseText); 
					       }
					}); // ajax end
					
					closePopup();
				}
			},{
				name : "취소"
			}]
		}) // makePopup end
	}); // 탈퇴버튼
}); // doc ready
</script>
</head>
<body>
<c:import url="/header"></c:import>
    <div class="bg">
        <div class="mypage">
            <span class="GBN">홈 > 회원정보</span>
            <h1>회원정보</h1>
        <div class="userInfo">
        	<table class="tUser">
        		<tr>
        			<th>닉네임</th>
        			<td>${data.NICK}</td>
        		</tr>
        		<tr>
        			<th>아이디</th>
        			<td>${data.ID}</td>
        		</tr>
        		<tr>
        			<th>지역구</th>
        			<td>${data.DIS_NM}</td>
        		</tr>
        	</table>
        </div>
        <div class="userInfo">
        	<form action="#" id="kinForm" method="post"  >
		 		<input type="hidden" name="kinNo" id="kinNo" value="${data.KIN_NO}"  >        	
        	</form>
        	<form action="#" id="actionForm" method="post"  >
		 		<input type="hidden" name="uNo" id="uNo" value="${data.U_NO}"  >        	
        	</form>
        	
        	<table class="tUser">
	        <c:choose>
	        	<c:when test="${data.APPV eq 0}">
	         		<tr>
	        			<th>유치원명</th>
	        			<td>${data.KIN_NM}</td>
	        		</tr>
	        		<tr>
	        			<th>사용자 유형</th>
	        			<td>${data.CODE_NM}</td>
	        		</tr>
	        	</c:when>
	        	<c:when test="${data.APPV eq 1}">
	         		<tr>
	        			<th>승인상태</th>
	        			<td>미승인</td>
	        		</tr>
	        		<tr>
	        			<th>거절사유</th>
	        			<td>${data.NEG_CON}</td>
	        		</tr>
	        	</c:when>
				<c:otherwise>
         		<tr>
        			<th>승인상태</th>
        			<td>첨부서류 검토중</td>
        		</tr>
        		<tr>
        			<th>유치원명</th>
        			<td>${data.KIN_NM}</td>
        		</tr>
        		<tr>
        			<th>신청일자</th>
        			<td>${data.REG_DT}</td>
        		</tr>
				</c:otherwise>		        		
	        </c:choose>
        	</table>
        </div>
        <div class="userAdd" id="staff">교직원 관리</div>
        <div class="set">
            <div class="set_div" id="cs" >
                <img src="resources/images/kin/inquiry.png" class="set_ico">
                <div class="set_title">고객센터</div>
            </div>
            <div class="set_div" id="write">
                <img src="resources/images/kin/write_list.png" class="set_ico">
                <div class="set_title">작성내역 조회</div>
            </div>
            <div class="set_div" id="uInfoUpdate">
                <img src="resources/images/kin/edit.png" class="set_ico">
                <div class="set_title" >회원정보 수정</div>
            </div>
        </div>
        </div>
    </div>
<div class="bottom">
        <span class="drop" id="delBtn">탈퇴하기</span> 
</div>
</body>
</html>