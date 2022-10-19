<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교직원 목록</title>
<c:import url="/cmn"></c:import>
<link href="resources/css/kin/staff_list.css" rel="stylesheet" type="text/css" />
<style>
.p {
margin-bottom: 100px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	if("${param.searchGbn}" != "") {
		$("#searchGbn").val("${param.searchGbn}");
	} else {
		$("#oldGbn").val("0");
	}
	
	reloadList();
	
	$("#insertBtn").on("click", function() {
		$("#kinForm").attr("action", "staffInsert");
		$("#kinForm").submit();
	}); // insertBtn
	
	$(".paging_area").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchText").val($("#oldText").val());
		
		reloadList();
	}); // paging
	
	// 개별선택
	$("#staffList tbody").on("click", ".cb", function() {
		var chk = [];
		
		$("#staffList tbody .cb:checked").each(function() {
			chk.push("'" + $(this).val() + "'");
		});
		
		if(chk.length == $("#staffList tbody .cb").length) {
			$("#staffList thead .cb").prop("checked", true);
		} else {
			$("#staffList thead .cb").prop("checked", false);
		}
 		
		$("#chkStaff").val(chk);
	}); // checkbox 개별선택
	
	// 전체선택
	$("#staffList thead").on("click", ".cb", function() {
		
		if($(this).is(":checked")) {
			$("#staffList tbody .cb").prop("checked", true);
		} else {
			$("#staffList tbody .cb").prop("checked", false);
		}
		
		var chk = [];
		
		$("#staffList tbody .cb:checked").each(function() {
			chk.push("'" + $(this).val() + "'");
		});
 	
		$("#chkStaff").val(chk);
	}); // checkbox 전체선택
	
	$("#deleteBtn").on("click", function() {
		
		if($("#chkStaff").val() == "") {
			makeAlert("알림", "교직원 선택이 완료되지 않았습니다.");
		} else {
			makePopup({
				title : "알림",
				contents : "삭제 시 해당 교직원은<br/> 홈페이지 탈퇴처리 됩니다.",
				buttons : [{
					name : "삭제",
					func:function() {
						var params = $("#actionForm").serialize();
						$.ajax({
							url : "staffAction/delete",
							type : "POST", 
							dataType : "json", 
							data : params, 
							success : function(res) { 
								switch(res.msg) {
									case "success" :
					    			    $("#page").val("1");
					    			    $("#searchGbn").val("0");
					    			    $("#searchTxt").val("");
					    			    $("#oldGbn").val("0");
					    			    $("#oldTxt").val("");
										
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
	}); // deleteBtn end
	
	$(".search_b_wrap #searchBtn").on("click", function() {
		
		$("#page").val("1");
		
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		reloadList();
	}); // searchBtn
	
	$("#listBtn").on("click", function() {
		
		// 초기화
		$("#page").val("1");
		$("#searchGbn").val("0");
		$("#searchTxt").val("");

		reloadList();
	}); // listBtn

}); // doc ready

function reloadList() {
	var params = $("#actionForm").serialize();
    $.ajax({
        url : "staffInfoListAjax", //경로
        type : "POST", //전송방식
        dateType : "json", //데이터 형태
        data : params, //보낼 데이터
        success : function(res) { //성공했을 때 결과를 res에 받아서 보내줌
     	    drawList(res.list); 
        	drawPaging(res.pd);
        },
        error : function(request, status, error) { //실패했을 때 함수 실행
           console.log(request.responseText); //실패 상세내역
        }
     }); // ajax end	
} // reloadList

function drawList(list) {
	var html = "";
	
	for(var data of list) {
		
		html += "<tr>";
		html += "<td><input type=\"checkbox\" class=\"cb\" value=\"" + data.U_NO + "\"></td>";
		html += "<td>" + data.ID + "</td>";
		html += "<td>" + data.NM + "</td>";
		html += "<td>" + data.CEL + "</td>";
		html += "<td>" + data.EMAIL + "</td>";
		html += "</tr>";
	}
	
	$("#staffList tbody").html(html);
} // drawList

function drawPaging(pd) {
	var html = "";
	
	html += "<span class=\"page_btn page_first\" page=\"1\">처음</span>";
	
	if($("#page").val() == "1") {
		html += "<span class=\"page_btn page_prev\" page=\"1\">이전</span>";
	} else {
		html += "<span class=\"page_btn page_prev\" page=\"" + ($("#page").val() * 1 - 1)  + "\">이전</span>";
	}
	   
	   for(var i = pd.startP ; i <= pd.endP ; i++) {
		  if($("#page").val()*1 == i) { 
			   html += "<span class=\"page_btn_on\" page=\"" + i + "\">" + i + "</span>";
		  } else {
			   html += "<span class=\"page_btn\" page=\"" + i + "\">" + i + "</span>";
		  }
	   }
		  
		  if($("#page").val()*1 == pd.maxP) { 
			   html += "<span class=\"page_btn page_next\" page=\"" + pd.maxP + "\">다음</span>";
		  } else {
			   html += "<span class=\"page_btn page_next\" page=\"" + ($("#page").val()*1 + 1) + "\">다음</span>";
		  }
		  
		   html += "<span class=\"page_btn page_last\" page=\"" + pd.maxP + "\">마지막</span>";
	   
	   $(".paging_area").html(html);
} // drawPaging 
</script>
</head>

<body>
<c:import url="/header"></c:import>
<!-- 이전 화면 검색구분/검색어 보관  -->
<input type="hidden" id="oldGbn" value="${param.searchGbn}"/>
<input type="hidden" id="oldTxt" value="${param.searchTxt}"/>
    <div class="mid">
    	<div class="mid1">
    		<span class="GBN">홈 > 마이 페이지 > 교직원 관리</span>
    	</div>
    	<div class="mid2">
    		<div class = "mid2_1" id="listBtn">교직원 목록</div>
    	</div>
		<form action="#" method="post" id="actionForm" >
 		<!-- 페이지정보 보관 -->
		<input type="hidden" name="page" id="page" value="${page}" >
    	<input type="hidden" name="chkStaff" id="chkStaff"/>
		<input type="hidden" name="kinNo" id="kinNo" value="${param.kinNo}" />	
	    	<div class="search_b_wrap">
				<select class="select_b" name="searchGbn" id="searchGbn" >
		            <option value="0">전체</option>
		            <option value="1">아이디</option>
		            <option value="2">이름</option>
		    	</select>
		    	<div class="search_b">
		            <input type ="text" class="b_txt" id="searchTxt" name="searchTxt" value="${param.searchTxt}" >
		    	</div>
		    	<div class="search_btn" id="searchBtn">검색</div>
			</div>
		<div class="btnWrap">
			<input type="button" class="boxBtn" value="등록" id="insertBtn" />
			<input type="button" class="boxBtn" value="삭제" id="deleteBtn"/>
		</div>
		</form>
			
       	<form action="#" id="kinForm" method="post"  >
	 		<input type="hidden" name="kinNo" id="kinNo" value="${param.kinNo}"  >        	
       	</form>

		<div class="p">
			<table class="t" id="staffList">
				<colgroup> <!-- 전체 1100 -->
					<col width="50" />
					<col width="200" />
					<col width="200" />
					<col width="250" />
					<col width="400" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" class="cb" /></th>
						<th>아이디</th>			
						<th>이름</th>			
						<th>휴대폰번호</th>			
						<th>E-mail</th>	
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<div class="paging_area"></div>	
   		</div>
    </div>
    <div class="bottom"></div>
</body>
</html>