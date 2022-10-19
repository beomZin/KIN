<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>즐겨찾기 목록</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/bm_list.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">
$(document).ready(function() {
	reloadList();
	
	$(".paging_area").on("click", "span", function() {
		$("#bmpage").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchText").val($("#oldText").val());
		
		reloadList();
	}); // paging

	// 개별선택
	$("tbody").on("click", ".cb", function() {
		var del = [];
		var chk = [];
		$("tbody .cb:checked").each(function() {
			del.push($(this).val());
		});
		$("tbody .cb:checked").each(function() {
			chk.push($(this).val());
		});
		if(chk.length == $("tbody .cb").length) {
			$("#chkHead .cb").prop("checked", true);
		} else {
			$("#chkHead .cb").prop("checked", false);
		}
		
		if(del.length == $("tbody .cb").length) {
			$("#chkHead .cb").prop("checked", true);
		} else {
			$("#chkHead .cb").prop("checked", false);
		}
		
		// 삭제용 유치원값
		$("#delKins").val(del);
		// 간편비교용 유치원값
		$("#kins").val(chk);
		
		console.log("adsfadsf     " + $("#delKins").val());

	}); // checkbox 개별선택
	
	// 전체선택
	$("#chkHead").on("click", ".cb", function() {
		
		var del = [];
		var chk = [];
		
		if($(this).is(":checked")) {
			$(".t tbody .cb").prop("checked", true);
		} else {
			$(".t tbody .cb").prop("checked", false);
		}
		
		$(".t tbody .cb:checked").each(function() {
			del.push($(this).val());
		});
		$(".t tbody .cb:checked").each(function() {
			chk.push($(this).val());
		});
			
		// 삭제용 유치원값
		$("#delKins").val(del);
		// 간편비교용 유치원값
		$("#kins").val(chk);
		
		console.log($("#delKins").val());
			
	}); // checkbox 전체선택
	
	
	$("#delBtn").on("click", function() {
		if($("tbody .cb:checked").length == 0) {
			makeAlert("알림", "유치원을 선택해주세요.");
		} else {
			makePopup({
				title : "알림",
				contents : "해당 유치원이</br>즐겨찾기 목록에서 삭제됩니다.",
				buttons : [{
					name : "삭제",
					func:function() {

						var params = $("#actionForm").serialize();
						$.ajax({
							url : "bmAction/chkDelete",
							type : "POST", 
							dataType : "json", 
							data : params, 
							success : function(res) { 
								switch(res.msg) {
									case "success" :
					    			    $("#bmpage").val("1");
										
					    			    reloadList();
										break;
									case "fail" :
										makeAlert("알림", "삭제에 실패했습니다.")
										break;
									case "exception" :
										makeAlert("알림", "삭제 중 문제가 발생했습니다.")
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
			}) // makePopup end
		}
	}); // delBtn end
	
	// 간편비교 이동
	$("#compareBtn").on("click", function() {
		var kintoCompare = [];
		
		if($("tbody .cb:checked").length != 2){
			makeAlert("알림", "간편비교를 원하시면</br> 두개의 유치원을 선택해주세요.");
		} else {
			$("tbody .cb:checked").each(function() {
				kintoCompare.push($(this).val());
			});
			// 체크값 개별 보관
			$("#kinA").val(kintoCompare[0]);
			$("#kinB").val(kintoCompare[1]);
			$("#actionForm").attr("action", "compare");
			$("#actionForm").submit();
		} 
		
	}); // compareBtn end
	
}); // doc ready end

function reloadList() {
	var params = $("#actionForm").serialize();
    $.ajax({
        url : "bmAjax", //경로
        type : "POST", //전송방식
        dateType : "json", //데이터 형태
        data : params, //보낼 데이터
        success : function(res) { //성공했을 때 결과를 res에 받아서 보내줌
     	    drawList(res.bmlist); 
        	drawPaging(res.bmpd);
        },
        error : function(request, status, error) { //실패했을 때 함수 실행
           console.log(request.responseText); //실패 상세내역
        }
     }); // ajax end	
} // reloadList


function drawList(bmlist) {
	var html = "";
	
	for(var data of bmlist) {
		
		html += "<tr>";
		html += "<td><input type=\"checkbox\" class=\"cb\" value=\"" + data.KIN_NO + "\"></td>";
		html += "<td>" + data.DIS_NM + "</td>";
		html += "<td>" + data.KIN_NM + "</td>";
		html += "<td>" + data.REG_DT + "</td>";
		html += "<td>" + data.AVG + "</td>";
		html += "</tr>";
	}
	
	$(".t tbody").html(html);
} // drawList


function drawPaging(bmpd) {
	var html = "";
	
	      html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
	   if($("#bmpage").val() == "1") {
	      html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
	   } else {
	      html += "<span class=\"page_btn page_prev\" page=\"" + ($("#bmpage").val() * 1 - 1) + "\">이전</span>";
	   }
	   
	   for(var i = bmpd.startP ; i <= bmpd.endP ; i++) {
		  if($("#bmpage").val()*1 == i) { 
			   html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
		  } else {
			   html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
		  }
	   }
		  
		  if($("#bmpage").val()*1 == bmpd.maxP) { 
			   html += "<span class=\"page_btn page_next\" page=\"" + bmpd.maxP + "\">다음</span>";
		  } else {
			   html += "<span class=\"page_btn page_next\" page=\"" + ($("#bmpage").val()*1 + 1) + "\">다음</span>";
		  }
		  
		   html += "<span class=\"page_btn page_last\" page=\"" + bmpd.maxP + "\">마지막</span>";
	   
	   $(".paging_area").html(html);
} // drawPaging 

</script>
</head>
<body>
	<c:import url="/header"></c:import>
	<div class="p">
		<div class="title">즐겨찾기 목록</div>
		<span class="GBN">홈 > 즐겨찾기 > 목록</span><br />
		<form action="#" id="actionForm" method="post">
			<input type="hidden" name="bmpage" id="bmpage" value="${bmpage}">
			<input type="hidden" name="kins" id="kins" /> 
			<input type="hidden" name="uNo" id="uNo" value="${sNo}">
			<!-- 상세비교 유치원 개별보관 -->
			<input type="hidden" name="no" id="kinA" /> 
			<input type="hidden" name="noB" id="kinB" /> 
			<input type="hidden" name="chkdel" id="delKins" />
		</form>
		<table class="t">
			<colgroup>
				<!-- 전체 1000 -->
				<col width="50" />
				<col width="150" />
				<col width="400" />
				<col width="200" />
				<col width="200" />
			</colgroup>
			<thead id="chkHead">
				<tr>
					<th><input type="checkbox" class="cb" /></th>
					<th>지역구</th>
					<th>유치원명</th>
					<th>추가일자</th>
					<th>평균별점</th>
				</tr>
			</thead>
			<tbody id="chkTbody"></tbody>
		</table>
		<div class="paging_area"></div>
		<div class="btnWrap">
			<input type="button" class="boxBtn" value="간편비교" id="compareBtn" />
			<input type="button" class="boxBtn" value="삭제" id="delBtn" /><br />
		</div>
	</div>
	<div class="bottom"></div>
</body>
</html>