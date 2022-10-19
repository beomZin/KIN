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

<title>원장 _ 증빙서류</title>
<c:import url="/cmn"></c:import>
	
<style type="text/css">  

.logo {
	cursor : pointer;
}

.mid {
	width: 1100px;
	margin: 0 auto;
	position: relative;
	min-height: 700px;
}

.mid1 {
	margin-top : 5px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid1_1{
	margin-top : 5px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 22.4px;
	height: 30px;
	line-height: 30px;
	width: 200px;
	color: #262626;
	font-weight : bold;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 0.5%;
}

.mid2 {
	height : 50px;
	background : #FFFFFF;
	border-bottom : 3px solid #F1F1F1;
	vertical-align : top;
	width : 1100px;
}

.mid2_1 {
	width: 300px;
}

.mid2_2 {
	width: 100px;
}

.mid2_1, .mid2_2 {
	margin : 5px 5px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 14px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid2_2 {
	float: right;
}

.mid2_btn {
	margin-top : 5px;
	float: right;
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	color: #f1f1f1;
    border-radius: 5px;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.mid2_btn:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid3 {
	margin-top: 20px;
    padding-bottom: 30px;
    background: #FFFFFF;
    vertical-align: top;
    width: 1100px;
    text-align: center;
    min-height: 500px;
    border-bottom: 3px solid #F1F1F1;
}

.wrap {
	text-align: right;
	width: 1100px;
	height: 40px;
}

.t {
	border-collapse: collapse;
	width: 1000px;
	display: inline-table;
	vertical-align: top;
	margin-bottom: 30px;
	border-top: 1px solid #f1f1f1;
}

th {
	font-size: 16.8px;
	height: 50px;
	line-height: 50px;
	border-top: 1px solid #f1f1f1;
	border-bottom: 1px solid #f1f1f1;
}

td {
	font-size: 15.4px;
	height: 40px;
	line-height: 40px;
	border-top: 1px solid #f1f1f1;
	border-bottom: 1px solid #f1f1f1;
}

.mid4 {
    display: none;
	margin-top : 20px;;
	background : #FFFFFF;
	vertical-align : top;
	width: 1100px;
}

.mid4_1 {
	display: inline-block;
	background : #FFFFFF;
	padding: 10px 0px 10px 10px;
	border : 3px solid #EEEEEE;
	border-radius : 5px;
	vertical-align : top;
	width: 80%;
	height : 150px;
	position : relative;
	margin-top: 30px;
}

textarea {
	width: 85%;
	height: 150px;
	border: none;
	resize: none;
	font-size: 14px;
}

textarea:focus {
	outline: none;
}

.mid4_2, .mid4_3 {
	margin-top: 30px;
	float: right;
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #8F8EBF;
	background-color: #4F4D8C;
	color: #f1f1f1;
    border-radius: 5px;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : top;
}

.mid4_3 {
	margin-right : 10px;
}

.mid4_2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid4_3:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.cntCon {
	display: inline-block;
	float: right;
	margin: 0 10px;
}

.mid7 {
	margin-bottom : 40px;
	background : #FFFFFF;
	width: 100%;
}

.bottom {
	background: #4b4a6e;
	height: 180px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$(".logo").on("click", function() {
		location.href = "kinMain";
	});
	
	// 승인상태가 대기중 일 때
	if("${data.APPV}" == "2") {
		$(".mid4").show();
	};
	
	// 목록 버튼
	$(".mid2_btn").on("click", function() {
		$("#searchForm").submit();
	});
	
	// 거부 사유 영역
	$("#neg_con").on("keyup", function() {
		$(".cntCon").html("( " + $(this).val().length + " / 500 )");
		
		if($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$("#.cntCon").html("( 500 / 500)");
		}
	});
	
	// 승인 버튼
	$(".mid4_3").on("click", function() {
		if($("#neg_con").val() != "") {
			makeAlert("알림", "거부 사유에 내용이 작성된 상태입니다. <br> 다시 확인해주세요.", function() {
				$("#neg_con").focus();
			});
		} else {
			$("#appv").val("0");
			makePopup({
				title : "알림",
				contents : "승인 하시겠습니까?",
				buttons : [{
					name : "승인",
					func:function() {
						appvAction();
						closePopup();
					}
				},{
					name : "취소"
				}]
			})
		}
	});
	
	// 거절 버튼
	$(".mid4_2").on("click", function() {
		if($("#neg_con").val() == "") {
			makeAlert("알림", "거부 내용을 작성해주세요.", function() {
				$("#neg_con").focus();
			});
		} else {
			// con의 <들을 웹문자로 변환
			$("#neg_con").val($("#neg_con").val().replace(/</gi, "&lt;"));
			// con의 >들을 웹문자로 변환
			$("#neg_con").val($("#neg_con").val().replace(/>/gi, "&gt;"));
			$("#appv").val("1");
			makePopup({
				title : "알림",
				contents : "거부 하시겠습니까?",
				buttons : [{
					name : "거부",
					func:function() {
						appvAction();
						closePopup();
					}
				},{
					name : "취소"
				}]
			})
		}
	});
	
}); // documnet ready End

function appvAction() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "adminSuAppvAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) { 
			switch(res.msg) {
				case "success" :
					location.href = "adminSu"
					break;
				case "fail" :
					makeAlert("알림", "실패했습니다.")
					break;
				case "exception" :
					makeAlert("알림", "문제가 발생했습니다.")
					break;
			}
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	}); 
}
</script>
</head>
<body>
	<form action="adminSu" id="searchForm" method="POST">
		<input type="hidden" name="no" value="${param.no}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="searchGbn" value="${param.searchGbn}">
		<input type="hidden" name="searchText" value="${param.searchText}">
	</form>
    <div class="head">
        <div class="logo">
            <img src="resources/images/kin/logo_white.png" height="55px">
        </div>
    </div>
    <div class="mid">
    	<div class="mid1">
    		<div class = "mid1_1">원장 _ 증빙서류</div>
    		<span class="GBN">홈 > 관리자 페이지 > 회원 관리 > 원장 > 원장 _ 증빙서류</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid2_1">${data.ID} ( ${data.NICK} )</div>
			<div class="mid2_btn">목 록</div>
			<div class = "mid2_2">${data.REG_DT}</div>
    	</div>
    	<div class="mid3">
   			<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
   			<c:set var="fileLength" value="${fn:length(data.ATT_NM)}"></c:set>
   			<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
   			<c:set var="fileName" value="${fn:substring(data.ATT_NM, 20, fileLength)}"></c:set>
			<div class="wrap">
				<a href="resources/upload/${data.ATT_NM}"
				   download="${fileName}" style="color:grey">첨부파일 : ${fileName}</a>
			</div>
    		<table class="t">
    			<colgroup>
    				<col width="100">
    				<col width="900">
    			</colgroup>
    			<tbody>
    				<tr>
    					<th>이름</th>
    					<td>${data.NM}</td>
    				</tr>
    				<tr>
    					<th>유치원명</th>
    					<td>${data.KIN_NM}</td>
    				</tr>
    				<tr>
    					<th>유치원 주소</th>
    					<td>${data.KIN_ADDR}</td>
    				</tr>
    			</tbody>
    		</table>
    		<img alt="원장_제출서류" src="resources/upload/${data.ATT_NM}" height="800" width="800">
    	</div>
    	<div class="mid4">
    		<div class="mid4_1">
    			<form action="#" id="actionForm" method="POST">
    				<input type="hidden" name="no_su" value="${data.U_NO}">
    				<input type="hidden" name="no_admin" value="${sNo}">
					<input type="hidden" name="appv" id="appv">
	    			<textarea name= "neg_con" id="neg_con" placeholder="거부 사유를 입력해주세요."></textarea>
	    			<div class="cntCon" style="color:grey">( 0 / 500 )</div>
    			</form>
    		</div>
    		<div class="mid4_2">거 부</div>
    		<div class="mid4_3">승 인</div>
    	</div>
    	<div class="mid7"></div>
    </div>
    <div class="bottom"></div>
</body>
</html>