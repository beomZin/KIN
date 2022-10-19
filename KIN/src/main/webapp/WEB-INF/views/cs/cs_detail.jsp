<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객센터 문의글 상세보기</title>
<c:import url="/cmn" ></c:import>
<link href="resources/css/kin/cs_detail.css" rel="stylesheet" type="text/css" >
<style type="text/css">
.wrap {
	text-align : right;
	line-height: 40px;
	width : 880px;
	margin : 0 auto 10px;
	height : 40px;
}

#updateBtn, #deleteBtn, #backBtn {
	margin: 35px 0 25px 0;
    display: inline-block;
    line-height: 30px;
    height: 32px;
    width: 77px;
    border: 1px solid #8F8EBF;
    background-color: #4F4D8C;
    color: #f1f1f1;
    border-radius: 5px;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align: top;
    padding: 0px;
}

#updateBtn, #deleteBtn {
	margin-right: 5px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	// 돌아가기
	$("#backBtn").on("click", function() {
		$("#actionForm").attr("action", "csList");
		$("#actionForm").submit();
	});
	
	// 수정
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "brdUpdate");
		$("#actionForm").submit();
	});
	
	// 삭제
	$("#deleteBtn").on("click", function() {
		makePopup({
			title : "알림",
			contents : "삭제 하세겠습니까?",
			buttons : [{
				name : "삭제",
				func : function() {
					var params = $("#actionForm").serialize();
					
					$.ajax({
						url : "ActionCsAjax",
						type : "POST",
						dataType : "json",
						data : params,
						success : function(res) {
							switch(res.msg) {
								case "success" :
									$("#actionForm").attr("action", "csList");
									$("#actionForm").submit();
									break;
								case "fail" :
									makeAlert("알림", "수정에 실패했습니다.");
									break;
								case "exception" :
									makeAlert("알림", "수정 중 문제가 발생했습니다.");
									break;
							}
						},
						error : function(request, status, error) {
							console.log(request.responseText);
						}
					});
					
					closePopup();
				}
			}, {
				name : "취소"
			}]
		})
	});
}); // documetn ready End
</script>
</head>
<body>
<c:import url="/header"></c:import>
<!-- 문의 상세 -->
<div class="header"></div>
<div class="p">
	<div class="title">문의 상세페이지</div>
	<span class="GBN">홈 > 회원정보 > 고객센터 > 문의 상세페이지</span><br/>
	<div class="btnWrap">
		<!-- 이미 답변이 완료된 문의글은 수정 제한 -->
		<input type="button" class="boxBtn" value="수 정" id="updateBtn"/>
		<input type="button" class="boxBtn" value="삭 제" id="deleteBtn"/>
		<input type="button" class="boxBtn" value="목 록" id="backBtn"/>
	</div>
	
	<form action="#" id="actionForm" method="POST">
		<input type="hidden" name="no" value="${param.no}">
		<input type="hidden" name="cateNo" value="${param.cateNo}">
		<input type="hidden" name="page" value="${param.page}">
	</form>
	
	<div class="inqWrap">
		<div class="inqHead">
			<div class="inqTitle">${data.TITLE}</div>
			<div class="inqDate">${data.REG_DT}</div>
		</div>
		<c:choose>
			<c:when test="${!empty data.ATT_NM}">
				<c:set var="fileLength" value="${fn:length(data.ATT_NM)}"></c:set>
				<c:set var="fileName" value="${fn:substring(data.ATT_NM, 20, fileLength)}"></c:set>
				<div class="wrap">
					<a href="resources/upload/${data.ATT_NM}"
					   download="${fileName}" style="color:grey">첨부파일 : ${fileName}</a>
				</div>
			</c:when>
		</c:choose>
		<div class="inqCont">${data.CON}</div>
	</div>
	<div class="inqWrap">
		<c:choose>
			<c:when test="${empty data.ADMIN_NO}">
				<div class="inqCont" >
담당자가 문의 내용을 확인 중입니다.
잠시만 기다려주세요.
				</div>
			</c:when>
			<c:otherwise>
				<div class="inqHead">
					<div class="inqDate">${data.REP_DT}</div>
				</div>
				<div class="inqCont" >${data.REP_CON}</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div class="bottom"></div>
</body>
</html>