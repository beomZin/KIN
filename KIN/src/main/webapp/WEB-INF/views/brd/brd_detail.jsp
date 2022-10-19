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
<title>게시판 _ 게시글 상세페이지</title>

<!-- 공통 script, css -->
<c:import url="/cmn"></c:import>

<style>    

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

.mid1_1, .mid1_2, .mid1_3 {
	margin : 5px 20px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 83px;
	color: #262626;
	font-weight : bold;
}

.mid1_1, .mid1_2, .mid1_3:hover {
	cursor: pointer;
}

.mid2 {
	height : 50px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
}

.mid2_1{
	margin : 15px 5px;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 22.4px;
	width: 200px;
	height: 30px;
	line-height: 30px;
	font-weight : bold;
	color: #262626;
}

.mid2_btn1, .mid2_btn2, .mid2_btn3 {
	margin-top : 15px;
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

.mid2_btn1, .mid2_btn3 {
	margin-right : 10px;
}

.mid2_btn1:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid2_btn2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid2_btn3:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.GBN {
	opacity: 0.6;
	letter-spacing: -.1em;
	font-size: 12px;
	position : absolute;
	right: 5%;
    top: 1.5%;
}

.mid3 {
	margin-top : 20px;
	padding-bottom : 10px;
	height : 40px;
	background : #FFFFFF;
	vertical-align : top;
	width : 1100px;
	border-bottom : 3px solid #F1F1F1;
}

.mid3_1 {
	margin-top : 5px;
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 15.4px;
	height: 30px;
	line-height: 30px;
	width: 600px;
	color: #262626;
	font-weight : bold;
}

.mid3_2 {
	width: 100px;
	margin-right: 20px;
}

.mid3_3 {
	width : 100px;
}

.mid3_4 {
	width : 180px;
}

.mid3_2, .mid3_3, .mid3_4 {
	margin-top : 5px;
	float: right;
	vertical-align : top;
	text-align : center;
	display : inline-block;
	border-radius: 5px;
	font-size: 14px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid4 {
	margin-top : 15px;
	padding-bottom : 20px;
	background : #FFFFFF;
	width : 1100px;
	border-bottom : 3px solid #F1F1F1;
	min-height: 400px;
}

.mid4_b {
	background : #FFFFFF;
	vertical-align : top;
	width : 1000px;
	margin : 30px auto;
}

.wrap {
	text-align : right;
	width : 1100px;
	height : 40px;
}

.mid6 {
	background : #f9f9f9;
	padding-bottom : 10px;
	border-bottom : 3px solid #EEEEEE;
	vertical-align : top;
	width: 100%;
	border-radius: 5px;
}

.mid6_1, .mid6_2, .mid6_3, .mid6_4{
	margin : 5px 5px;
	vertical-align : top;
	display : inline-block;
	border-radius: 5px;
	font-size: 14px;
	height: 30px;
	line-height: 30px;
	color: #262626;
}

.mid6_4 {
	margin-left : 670px;
}

.mid6_1 {
	width : 250px;
	margin-left : 30px;
	font-weight : bold;
}

.me {
	display: inline-block;
    width: 45px;
    height: 20px;
    border: 1px solid grey;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 20px;
}

.mid6_2, .mid6_3{
	float : right;
}

.mid6_2, .mid6_3 {
	cursor: pointer;
}

.mid6_h {
	background : #f9f9f9;
	vertical-align : top;
	width: 100%;
	border-radius: 5px;
}

.mid6_b {
	border-radius: 5px;
	background : #f9f9f9;
	vertical-align : top;
	width : 800px;
	margin : 0px auto;
	min-height: 85px;
}

.mid7 {
	margin-bottom : 40px;
	background : #FFFFFF;
	width: 100%;
}

.mid8 {
	background : #FFFFFF;
	padding: 10px 0px 10px 10px;
	border : 3px solid #EEEEEE;
	border-radius : 5px;
	vertical-align : top;
	width: 98.5%;
	height : 100px;
	position : relative;
}

textarea {
	width: 87%;
	height: 95px;
	border: none;
	resize: none;
	font-size: 14px;
}

textarea:focus {
	outline: none;
}

.cntCmt {
	float: right;
    margin: 0px 10px 0px;
    display: inline-block;
}

.mid8_btn1, .mid8_btn2, .mid8_btn3 {
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
    top:calc(100% - 45px);
    right:calc(1%);
    position: absolute;
}

.cmt_ubtn {
	display: none;
}

.mid8_btn2 {
	margin-top: -35px;
}

.mid8_btn1:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid8_btn2:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.mid8_btn3:hover {
   border: 1px solid #4F4D8C;
   background-color: #e1e1fb;
   color: #262626;
   cursor: pointer;
}

.bottom {
	background: #4b4a6e;
	height: 180px;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	
	// 제목, 내용에서 < and > 설정
	var title = "${dataBrd.TITLE}";
	var con = "${dataBrd.CON}";
	
	title = title.replace(/&lt;/gi, "<");
	title = title.replace(/&gt;/gi, ">");
	con = con.replace(/&lt;/gi, "<");
	con = con.replace(/&gt;/gi, ">");
	
	$(".mid3_1").html(title);
	$(".mid4_b").html(con);
	
	// 댓글 조회
	reloadList();
	
	// 수정 버튼
	$(".mid2_btn3").on("click", function() {
		$("#actionForm").attr("action", "brdUpdate");
		$("#actionForm").submit();
	});
	
	// 삭제 버튼
	$(".mid2_btn1").on("click", function() {
		makePopup({
			title : "알림",
			contents : "삭제 하시겠습니까?",
			buttons : [{
				name : "삭제",
				func:function() {
					// serialize() : 해당 내용물들 중 값 전달이 가능한 것들을 전송가능한 문자 형태로 전환.
					var params = $("#actionForm").serialize();
					
					$.ajax({
						url : "BRDAction/delete", // 경로
						type : "POST", // 전송방식(GET:주소형태, POST:주소 헤더형태)
						dataType : "json", // 데이터 형태
						data : params, // 보낼 데이터
						success : function(res) { // 성공했을 때 결과를 res에 받고 함수 실행
							switch(res.msg) {
								case "success" :
									switch("${param.cateNo}") {
										case "0" :
											location.href = "brdEducate";
											break;
										case "1" :
											location.href = "brdCulture";
											break;
										case "2" :
											location.href = "brdLounge";
											break;
										case "3" :
											location.href = "brdAsk";
											break;
									}
									break;
								case "fail" :
									makeAlert("알림", "삭제에 실패했습니다.");
									break;
								case "exception" :
									makeAlert("알림", "삭제 중 문제가 발생했습니다.");
									break;
							}
						},
						error : function(request, status, error) { // 실패했을 때 함수 실행
							console.log(request.responseText); // 실패 상세 내역
						}
					});
					
					closePopup();
				}
			},{
				name : "취소"
			}]
		})
	});
	
	// 목록 버튼
	$(".mid2_btn2").on("click", function() {
		switch($("#cateNo").val()) {
			case "0" :
				$("#actionForm").attr("action", "brdEducate");
				break;				
			case "1" :
				$("#actionForm").attr("action", "brdCulture");
				break;				
			case "2" :
				$("#actionForm").attr("action", "brdLounge");
				break;				
			case "3" :
				$("#actionForm").attr("action", "brdAsk");
				break;				
		}
		
		$("#actionForm").submit();
	});
	
	// 댓글 목록에서 수정 버튼
	$(".cmt_area").on("click", "#imgUpdate", function() {
		$("#insertCmt").val($(this).attr("con"));
		$(".cntCmt").html("( " + $("#insertCmt").val().length + " / 500 )");
		$("#cmt_no").val($(this).attr("cmt_no"));
		$("#insertCmt").focus();
		$(".cmt_ibtn").hide();
		$(".cmt_ubtn").show();
	});
	
	// 댓글 수정 영역에서 수정 버튼
	$(".cmt_ubtn").on("click", ".mid8_btn2", function() {
		if($.trim($("#insertCmt").val()) == "") {
			makeAlert("알림", "댓글 내용을 입력해주세요.");
		} else {
			actionCmt("update");
			$("#cmt_no").val("");
			$("#insertCmt").val("");
			$(".cntCmt").html("( 0 / 500 )");
			$(".cmt_ubtn").hide();
			$(".cmt_ibtn").show();
		}
	});
	
	// 댓글 수정 영역에서 취소 버튼
	$(".cmt_ubtn").on("click", ".mid8_btn3", function() {
		$("#insertCmt").val("");
		$(".cntCmt").html("( 0 / 500 )");
		$(".cmt_ubtn").hide();
		$(".cmt_ibtn").show();
	});
	
	// 댓글 삭제
	$(".cmt_area").on("click", "#imgDelete", function() {
		
		$("#cmt_no").val($(this).attr("cmt_no"));
		
		makePopup({
			title : "알람",
			contents : "삭제 하시겠습니까?",
			buttons : [{
				name : "삭제",
				func : function() {
					actionCmt("delete");
					
					closePopup();
				}
			}, {
				name : "취소"
			}]
		});
	});
	
	// 댓글 textarea
	$("#insertCmt").on("keyup", function() {
		$(".cntCmt").html("( " + $(this).val().length + " / 500 )");
		
		if($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$(".cntCmt").html("( 500 / 500 )");
		}
	});
	
	// 댓글 등록
	$(".mid8_btn1").on("click", function() {
		if("${sNick}" != "") {
			if($.trim($("#insertCmt").val()) == "") {
				makeAlert("알림", "댓글 내용을 입력해주세요.", function() {
					$("#insertCmt").focus();
				});
			} else {
				actionCmt("insert");
				$(".cntCmt").html("( 0 / 500 )");
			}
		} else {
			makeAlert("알림", "댓글을 작성하려면 닉네임이 필요합니다.<br> 회원정보에서 닉네임을 설정해주세요.");
		}
	});
	
}); // document ready End

function reloadList() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "brdCmtListAjax",
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
			drawCmt(res.listCmt);
		},
		error : function(request, status, error) {
			console.log(request.responseText);
		}
	});
};


function drawCmt(list) {
	 
	var html = "";
	
	for (var data of list) {
		
		var cmt_con = data.CON;
		cmt_con = cmt_con.replace(/&lt;/gi, "<");
		cmt_con = cmt_con.replace(/&gt;/gi, ">");
		
		html += "<div class=\"mid6\">";
		html += "<div class=\"mid6_h\" noCmt=\"" + data.CMT_NO + "\" user_no=\"" + data.U_NO + "\">";
		html += "<div class=\"mid6_1\">" + data.NICK;
		if("${dataBrd.U_NO}" == data.U_NO) {
			html += " <div class=\"me\" style=\"color:grey\">작성자</div>";
		}
		html += "</div>";
		if(${sNo} == data.U_NO) {
			html += "<div class=\"mid6_2\">";
			html += "<img alt=\"삭제\" src=\"resources/images/kin/delete.png\" height=\"20\" id=\"imgDelete\" cmt_no=\"" + data.CMT_NO + "\">";
			html += "</div>";
			html += "<div class=\"mid6_3\">";
			html += "<img alt=\"수정\" src=\"resources/images/kin/update.png\" height=\"20\" id=\"imgUpdate\" cmt_no=\"" + data.CMT_NO + "\" con=\"" + cmt_con + "\">";
			html += "</div>";
		}
		html += "<div class=\"mid6_4\">" + data.REG_DT + "</div>";
		html += "</div>";
		html += "<div class=\"mid6_b\">";
		html += cmt_con;
		html += "</div>";
		html += "</div>";
		
	}
	
	$(".cmt_area").html(html);
}

var flag = {
	"insert" : "등록",
	"update" : "수정",
	"delete" : "삭제"
}

function actionCmt(flag) {
	
	// con의 <들을 웹문자로 변환
	$("#insertCmt").val($("#insertCmt").val().replace(/</gi, "&lt;"));
	// con의 >들을 웹문자로 변환
	$("#insertCmt").val($("#insertCmt").val().replace(/>/gi, "&gt;"));
	
	var params = $("#cmtForm").serialize();
	
	$.ajax({
		url : "ActionCmtAjax/" + flag,
		type : "POST",
		dataType : "json",
		data : params,
		success : function(res) {
			switch(res.msg) {
				case "success" :
					if(flag == "insert") {
						// 댓글 textarea 초기화
						$("#insertCmt").val("");
					}
					
					// 댓글 목록 재조회
					reloadList();
					break;
				case "fail" :
					makeAlert("알림", msg[flag] + "에 실패했습니다.");
					break;
				case "exception" :
					makeAlert("알림", msg[flag] + " 중 문제가 발생했습니다.");
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
	<form action="#" id="actionForm" method="POST">
		<input type="hidden" name="no" value="${dataBrd.NO}">
		<input type="hidden" name="cateNo" id="cateNo" value="${param.cateNo}">
		<input type="hidden" name="user_no" value="${sNo}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="searchGbn" value="${param.searchGbn}">
		<input type="hidden" name="searchText" value="${param.searchText}">
	</form>
    
    <c:import url="/header"></c:import>
    
    <div class="mid">
    	<div class="mid1">
			<span class="GBN">홈 > 게시판 >
			<c:choose>
				<c:when test="${param.cateNo eq 0}">
					육아교육	
				</c:when>
				<c:when test="${param.cateNo eq 1}">
					문화생활	
				</c:when>
				<c:when test="${param.cateNo eq 2}">
					동네라운지	
				</c:when>
				<c:when test="${param.cateNo eq 3}">
					궁금해요!	
				</c:when>
			</c:choose>
			 > 게시글</span>
		</div>
    	<div class="mid2">
    		<div class = "mid2_1">${dataBrd.CT_NM}</div>
	    	<div class ="mid2_btn2">목 록</div>
	    	<c:if test="${sNo eq dataBrd.U_NO}">
		    	<div class ="mid2_btn1">삭 제</div>
		    	<div class ="mid2_btn3">수 정</div>
	    	</c:if>
    	</div>
    	<div class="mid3">
    		<div class="mid3_1"></div>
    		<div class="mid3_2">조회 ${dataBrd.HIT}</div>
    		<div class="mid3_3">${dataBrd.REG_DT}</div>
    		<div class="mid3_4">${dataBrd.NICK}</div>
    	</div>
    	<div class="mid4">
   			<c:if test="${!empty dataBrd.ATT_NM}">
   			
		    	<!-- fn:length(대상) : 대상 문자열의 길이나 배열, 리스트의 크기를 가져온다. -->
		    	<c:set var="fileLength" value="${fn:length(dataBrd.ATT_NM)}"></c:set>
		    	<!-- fn:substring(값, 숫자1, 숫자2) : 값을 숫자1이상부터 숫자2미만까지 인덱스 기준으로 자른다. -->
		    	<c:set var="fileName" value="${fn:substring(dataBrd.ATT_NM, 20, fileLength)}"></c:set>
	    		<div class="wrap">
		    			<a href="resources/upload/${dataBrd.ATT_NM}" 
		    			   download="${fileName}" style="color:grey">첨부파일 : ${fileName}</a>
	    		</div>
		    		
	    	</c:if>
    		<div class="mid4_b"></div>
    	</div>
		<div class="mid7"></div>
    	<div class="cmt_area"></div>
    	<div class="mid7"></div>
    	<div class="mid8">
    		<form action="#" id="cmtForm">
    			<input type="hidden" name="cmt_no" id="cmt_no">
    			<input type="hidden" name="user_no" value="${sNo}">
    			<input type="hidden" name="brd_no" value="${dataBrd.NO}">
	    		<textarea name="insertCmt" id="insertCmt" placeholder="댓글을 입력해주세요."></textarea>
	    		<div class="cntCmt" style="color:grey">( 0 / 500 )</div>
	    		<div class="cmt_ibtn">
		    		<div class="mid8_btn1">등 록</div>
	    		</div>
	    		<div class="cmt_ubtn">
		    		<div class="mid8_btn2">수 정</div>
		    		<div class="mid8_btn3">취 소</div>
	    		</div>
    		</form>
    	</div>
    	<div class="mid7"></div>
    </div>
    <div class="bottom"></div>
</body>
</html>