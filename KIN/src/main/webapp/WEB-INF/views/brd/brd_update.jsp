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
<title>게시판 _ 게시글 수정</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<!-- file데이터 전송을 위해 form.js 스크립트 추가  -->
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<!-- CKEditor -->
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>

<style type="text/css">    
.mid {
	width: 1100px;
	margin: 0 auto;
	position: relative;
	min-height: 700px;
}

.mid1 {
	margin-top : 20px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	position: relative;
}


.mid2 {
	height : 40px;
	background : #FFFFFF;
	padding-bottom : 10px;
	border-bottom : 1px solid #262626;
	vertical-align : top;
	width : 1100px;
}


.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 5%;
}

.mid2_1 {
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

.mid2_btn2 {
	margin-top : 5px;
	float: right;
    display: inline-block;
    line-height: 30px;
    height: 30px;
    width: 75px;
    border: 1px solid #8F8EBF;
	border: 1px solid #8F8EBF;
    color: #262626;
    border-radius: 5px;
    font-size: 15.4px;
    font-weight: bold;
    text-align: center;
    vertical-align : bottom;
}

.mid2_btn2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid2_btn1 {
	margin : 5px 10px;
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
    vertical-align : bottom;
}

.mid2_btn1:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.file_del_btn {
	margin : 5px 10px;
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
    vertical-align : bottom;
}

.file_del_btn:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid3 {
	margin-top : 20px;
	padding-bottom : 20px;
	background : #FFFFFF;
	width : 1100px;
}

.cateNo {
    border: 2px solid #DDD;
    height: 40px;
    width : 300px;
    font-size: 14px;
    border-radius: 4px;
    margin : 5px 0px 5px;
    padding-left: 5px;
    border-radius: 5px;
}

.title, .attFile {
	border: 2px solid #DDD;
	height: 40px;
	line-height : 40px;
	width : 99.5%;
	margin : 15px 0px 20px;
	font-size: 15.4px;
	text-indent: 5px;
	border-radius: 5px;
}

.attFile_y {
	text-align: right;
	border: 2px solid #DDD;
	height: 40px;
	line-height : 40px;
	width : 99.5%;
	margin : 15px 0px 20px;
	font-size: 15.4px;
	border-radius: 5px;
}

.attFile_re {
	display: none;
}

.mid3_1:focus {
	outline: none;
}

#con {
	width: 100%;
}

.bottom {
	background: #4b4a6e;
	height: 150px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	CKEDITOR.replace("con",{
		resize_enabled : false,
		language : "ko",
		enterMode : "2",
		width : "100%",
		height : 500
	});
	
	// 제목, 내용 < and > 설정
	var title = "${data.TITLE}";
	var con = "${data.CON}";
	
	title = title.replace(/&lt;/gi, "<");
	title = title.replace(/&gt;/gi, ">");
	con = con.replace(/&lt;/gi, "<");
	con = con.replace(/&gt;/gi, ">");
	
	$(".title").val(title);
	$("#con").val(con);
	
	// 카테고리 설정
	if(${param.cateNo} != "") {
		$(".cateNo").val("${param.cateNo}");
	};
	
	// 취소 버튼
	$(".mid2_btn2").on("click", function() {
		if("${param.cateNo}" == "4") {
			$("#searchForm").attr("action", "csDetail");
		} else {
			$("#searchForm").attr("action", "brdDetail")		
		}
		$("#searchForm").submit();
	});
	
	// 수정 버튼
	$(".mid2_btn1").on("click", function() {
		$("#con").val(CKEDITOR.instances['con'].getData());
	
		if($.trim($(".title").val()) == "") {
			makeAlert("알림", "제목을 입력해주세요.", function() {
				$(".title").focus();
			});
		} else if ($.trim($("#con").val()) == "") {
			makeAlert("알림", "내용을 입력해주세요.", function() {
				CKEDITOR.instances['con'].focus();
			});
		} else {
			
			$("#con").val($("#con").val().replace(/</gi, "&lt;"));
			$("#con").val($("#con").val().replace(/>/gi, "&gi;"));
			
			// 1. 파일 업로드 -> 2. 업로드 파일명 취득 -> 3. 글저장
			
			// 가장 먼저 form 객체 취득
			var form = $("#actionForm");
			
			// ajaxForm 적용
			form.ajaxForm({
				success: function(res) { // 데이터 주고 받기 성공 시 (단순 파일 업로드 성공했느냐 X)
					if(res.result == "SUCCESS") { // 파일 전송 성공
						// 올라간 파일이 존재한다면
						if(res.fileName.length > 0) {
							$("#att_nm").val(res.fileName[0]); // 올라간 파일명 보관
						}
					
						// 글 저장
						var params = $("#actionForm").serialize();
						
						$.ajax({
							url : "BRDAction/update", // 경로
							type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
							dataType : "json", // 데이터 형태
							data : params, // 보낼 데이터
							success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
								switch(res.msg) {
									case "success" :
										if("${param.cateNo}" == "4") {
											$("#searchForm").attr("action", "csDetail");
											$("#searchForm").submit();
										} else {
											$("#cateNo").val(res.cate);
											$("#searchForm").attr("action", "brdDetail");
											$("#searchForm").submit();
										}
										break;
									case "fail" :
										makeAlert("알림", "수정에 실패했습니다.")
										break;
									case "exception" :
										makeAlert("알림", "수정 중 문제가 발생했습니다.")
										break;
								}
							},
							error : function(requset, status, error) { // 실패했을 때 함수 실행
								console.log(request.responseText); // 실패 상세 내역
							}
						});
					} else { // 문제발생
						makeAlert("알림", "파일 업로드에<br>문제가 발생하였습니다.");
					}
				},
				error : function() { // 에러 시
					makeAlert("알림", "파일 업로드에<br>문제가 발생하였습니다.");
				}
			}); // ajaxForm 설정 끝
			
			// ajaxForm 실행!!
			form.submit();
		}
	});
	
	$("#file_del_btn").on("click", function() {
		// 기존 파일 내역 영역 제거
		$(".attFile_y").remove();
		// 기존 파일명 제거
		$("#att_nm").val("");
		// 파일 선택 영역 
		$(".attFile_re").show();
	});
});
</script>
    
</head>
<body>
<form action="#" id="searchForm" method="POST">
	<input type="hidden" name="no" value="${data.NO}">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="searchGbn" value="${param.searchGbn}">
	<input type="hidden" name="searchText" value="${param.searchText}">
	<input type="hidden" name="cateNo" id="cateNo" value="${param.cateNo}">
</form>

<c:import url="/header"></c:import>
    
<div class="mid">
	<div class="mid1">
		<span class="GBN">홈 > 게시판 > 게시글 수정</span>
	</div>
	<div class="mid2">
		<div class = "mid2_1">게시글 수정</div>
		<div class="mid2_btn2">취 소</div>
		<div class="mid2_btn1">수 정</div>
	</div>
	<div class="mid3">
		<!-- 
			file데이터 전송을 위해
			1) form에 enctype 지정 
			2) form의 action에  # -> fileUploadAjax로 변경
			3) form.js 스크립트 추가
			4) SQL.xml에서 목록조회, 상세조회, insert, update 변경
		-->
		<form action="fileUploadAjax" id="actionForm" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="no" value="${data.NO}">
			<input type="hidden" name="att_nm" id="att_nm" value="${data.ATT_NM}">
			<input type="hidden" name="user_no" value="${sNo}">
			<c:choose>
				<c:when test="${param.cateNo eq 4}">
					<select name="cateNo" class="cateNo"  value="${param.cateNo}"">
			         	<option value="4">고객센터</option>
					</select>
				</c:when>
				<c:when test="${sTp eq 3}">
					<select name="cateNo" class="cateNo" value="${param.cateNo}">
			         	<option value="1">문화생활</option>
			         	<option value="2">동네 라운지</option>
			         	<option value="3">궁금해요!</option>
			    	</select>
				</c:when>
				<c:otherwise>
					<select name="cateNo" class="cateNo" value="${param.cateNo}">
			         	<option value="0">육아교육</option>
			         	<option value="1">문화생활</option>
			         	<option value="2">동네 라운지</option>
			         	<option value="3">궁금해요!</option>
			    	</select>
				</c:otherwise>
			</c:choose>
			<input type="text" name="title" class="title" placeholder="제목을 입력해주세요.">
			<textarea rows="10" cols="30" name="con" id="con"></textarea>
			<c:choose>
				<c:when test="${empty data.ATT_NM}">
				<!-- 파일이 없을 때 -->
					<input type="file" name="attFile" class="attFile">
				</c:when>
				<c:otherwise>
				<!-- 파일이 있을 때 -->
					<div class="attFile_y">
						<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
						<c:set var="fileLength" value="${fn:length(data.ATT_NM)}"></c:set>
						
						<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터 숫자2미만까지 인덱스 기준으로 자른다.  -->
						<c:set var="fileName" value="${fn:substring(data.ATT_NM, 20, fileLength)}"></c:set>
						
						첨부파일 : ${fileName}
						<div class="file_del_btn" id="file_del_btn">파일삭제</div>
					</div>
					<div class="attFile_re">
						<input type="file" name="attFile" class="attFile">
					</div>
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</div>
<div class="bottom"></div>
</body>
</html>