<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="container_detail">
	<div class="large_category">
		<h2>공지사항</h2>
	</div>
	
	<form id="detail_form" action="/alterAnnouncement" method="post" autocomplete="off">
		<input type="hidden" name="announcementNo" id="announcementNo" value="${vo.announcementNo}">
		<input type="hidden" name="currentPageNum" value="${pagingProcessingVo.currentPageNum}">
		<input type="hidden" name="amount" value="${pagingProcessingVo.amount}">
		
		<table class="table">
			<tr>
				<th><label for="announcementTitle" id="announcementTitle_label">제목</label></th>
				<td><p id='announcementTitle_data'>${vo.announcementTitle}</p>
					<input type='text' class='form-control' name='announcementTitle' id='announcementTitle' value='${vo.announcementTitle}'>
					<p id='title_notice'></p></td>
			</tr>
			<tr>
				<th><label for="announcementContent" id="announcementContent_label">내용</label></th>
				<td><p id="announcementContent_data">${vo.announcementContent}</p><textarea class="form-control" name="announcementContent" id="announcementContent" rows="15" onkeyup="contentByteLimit(this, 3000);">${vo.announcementContent}</textarea><p id="content_notice"></p></td></tr>
			<tr>
				<th>날짜</th>
				<td>${vo.announcementDate}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.announcementHits}</td>
			</tr>
		</table>
	</form>
	
	<div id="notice_Button_div">
		<p id="byteNotice">
			<span id="byte_notice">0</span> / 3000byte
		</p>
		
		<div>
			<c:if test="${auth == 'A'}">
				<input type="button" class="btn btn-primary" id="cancel_alteration" value="취소">
				<input type="button" class="btn btn-primary" id="delete_button" value="삭제" onclick="deleteAnnouncement();">
				<input type="button" class="btn btn-primary" id="alter_button" value="수정">
				<input type="button" class="btn btn-primary" id="confirm_button" value="확인">
			</c:if>
			<input type="button" class="btn btn-primary" id="announcement" value="목록">
		</div>
	</div>
</div>
</body>
</html>

<script>
	var detailForm = $("#detail_form");
	// 공지사항 수정 취소
	$("#cancel_alteration").click(function(){
		if(confirm("작성중이신 것을 취소하시겠습니까?")){
			detailForm.attr("action", "/detailAnnouncement");
			detailForm.submit();
		}
	})
	
	// 유효성 검사 통과유무 변수
	var titleBlankCheck = false; // 제목 여백
	var contentBlankCheck = false; // 내용 여백
	
	// 입력값 변수
	var title = $("#announcementTitle").val(); // 제목
	var content = $("#announcementContent").val(); // 내용

	// 알림 태그 변수
	var titleNotice = $("#title_notice"); // 제목 알림 태그
	var byteNotice = $("#byte_notice"); // 내용 byte 제한 알림 태그
	var contentNotice = $("#content_notice"); // 내용 알림 태그

	// 내용 byte 제한 함수
	function contentByteLimit(contentParam, maxByte) {

		var content = contentParam.value; // 내용 입력값
		var contentLength = content.length; // 내용 입력값 길이
		var contentOneChar = ""; // content 문자열을 char타입으로 담을 변수
		var contentByte = 0; // 내용 입력한 byte값
		var strVariable = 0; // 문자열 자르는 것에 이용
		var afterCutContent = ""; // 자른 문자열

		// 내용 byte 계산
		for (var i = 0; i < contentLength; i++) {
			contentOneChar = content.charAt(i); // content의 i번째 문자를 char타입으로 변환

			// contentOneChar을 유니코드로 변환하여 문자를 판단(1byte = %XX / 2byte = %uXXXX, 변환한 문자 > 4 일시 2byte 한글로 판단)
			// 2byte 한글일때
			if (escape(contentOneChar).length > 4) {
				contentByte += 2;
			// 1byte 영문자일때
			} else {
				contentByte++;
			}
			// 내용 입력한 byte값이 maxByte값보다 높을시 strVariable 변수에 저장 후 문자열 자르는 것에 이용
			if (contentByte <= maxByte) {
				strVariable = i + 1;
			}
		}

		// 내용 입력한 byte값이 maxByte값보다 높을시 문자열 자르기
		if (contentByte > maxByte) {
			contentNotice.html("한글 " + (maxByte / 2) + "자 , 영문 " + maxByte + "자를 초과 입력할 수 없습니다");

			afterCutContent = content.substr(0, strVariable);

			// 자른 문자열 내용 입력값으로 다시 담기(최종 입력 완료된 문자열)
			contentParam.value = afterCutContent;

			// 내용 입력한 byte값 표기
			byteNotice.html(maxByte);
		} else {
			byteNotice.html(contentByte);
		}
	}
	
	registerForm = $("#register_form");
	// 공지사항 등록 취소
	$("#cancel_registration").click(function() {
		registerForm.attr("action", "announcement");
		registerForm.submit();
	})
	
	// 게시물 삭제 함수
	function deleteAnnouncement(){
		var data = {
				announcementNo : ${vo.announcementNo}
		}
		
		if(confirm("정말로 삭제하시겠습니까?") == true){
			$.ajax({
				url: "/deleteOneAnnouncement",
				type: "post",
				data: data,
				success: function(result) {
					if(result == "fail"){
						alert("관리자만 해당 기능을 사용할수 있습니다.");
					}else{
						alert("게시글이 삭제되었습니다.");
						
						location.replace("/announcement");
					}
				}
			})
		}
	}
	
	// 수정 버튼 클릭시 css 수정
	$("#alter_button").click(function(){
		$("#announcementTitle_data").css("display", "none");
		$("#announcementContent_data").css("display", "none");
		$("#announcementTitle").css("display", "inline-block");
		$("#announcementContent").css("display", "inline-block");
		$("#notice_Button_div").css("justify-content", "space-between");
		$("#byteNotice").css("display", "inline-block");
		$("#delete_button").css("display", "none");
		$("#alter_button").css("display", "none");
		$("#cancel_alteration").css("display", "inline-block");
		$("#confirm_button").css("display", "inline-block");
	})
	
	// 수정 화면에서 확인 버튼 클릭시
	$("#confirm_button").click(function() {
		title = $("#announcementTitle").val();
		content = $("#announcementContent").val();

		// 제목 여백 검사
		if(title == "") {
			titleNotice.html("제목을 입력해주세요.");
			titleNotice.css("color", "red");
		} else {
			titleBlankCheck = true;
		}

		// 내용 여백 검사
		if(content == "") {
			contentNotice.html("내용을 입력해주세요.");
			contentNotice.css("color", "red");
		} else {
			contentBlankCheck = true;
		}

		// 화면에서 통합 유효성 검사
		if (titleBlankCheck && contentBlankCheck) {
			detailForm.submit();
		}
	})
	
	// 서버에서 한번 더 관리자인지 판별 후 아닐시 실패 메세지 받기
	var failMessage = "${failMessage}";
	if(failMessage != null && failMessage != ""){
		alert(failMessage);
	}
	
	var announcementNo = $("#announcementNo");
	var announcementTitle = $("#announcementTitle");
	var announcementContent = $("#announcementContent");
	// 목록 버튼 클릭시
	$("#announcement").click(function(){
		// 상세 공지사항 화면일때
		if($("#announcementTitle_data").is(":visible")){
			announcementNo.remove();
			announcementTitle.remove();
			announcementContent.remove();
					
			detailForm.attr("action", "/announcement");
			detailForm.submit();
			// 상세 공지사항 수정 화면일때
		}else{
			if(confirm("작성중이신 것을 취소하시겠습니까?") == true){
				announcementNo.remove();
				announcementTitle.remove();
				announcementContent.remove();
					
				detailForm.attr("action", "/announcement");
				detailForm.submit();
			}
		}
	})
</script>
