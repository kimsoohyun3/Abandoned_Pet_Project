<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="container_register">
	<div class="large_category">
		<h2>공지사항</h2>
	</div>
	
	<form id="register_form" autocomplete="off">
		<div class="form-group">
			<label for="title">제목:</label>
			<input type="text" class="form-control" id="title" placeholder="Title" name="announcementTitle">
			<p id="title_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="content">내용:</label>
			<textarea class="form-control" id="content" placeholder="Content" name="announcementContent" rows="15" onkeyup="contentByteLimit(this, 3000);"></textarea>
			<p id="content_notice"></p>
		</div>
		
		<div class="form-group" id="notice_Button_div">
			<p><span id="byte_notice">0</span> / 3000byte</p>
			<div>
				<input type="button" class="btn btn-primary" id="cancel_registration" value="취소">
				<input type="button" class="btn btn-primary" id="submit_Announcement" value="등록">
			</div>
		</div>
	</form>
</div>
</body>
</html>

<script>
	registerForm = $("#register_form");
	// 공지사항 등록 취소
	$("#cancel_registration").click(function() {
		if(confirm("작성중인 것을 취소하시겠습니까?")){
			registerForm.attr("action", "announcement");
			registerForm.submit();
		}
	})

	//유효성 검사 통과유무 변수
	var titleBlankCheck = false; // 제목 여백
	var contentBlankCheck = false; // 내용 여백

	// 입력값 변수
	var title = $("#title").val(); // 제목
	var content = $("#content").val(); // 내용

	// 알림 태그 변수
	var titleNotice = $("#title_notice"); // 제목 알림 태그
	var byteNotice = $("#byte_notice"); // 내용 byte 제한 알림 태그
	var contentNotice = $("#content_notice"); // 내용 알림 태그

	$("#submit_Announcement").click(function() {
		title = $("#title").val();
		content = $("#content").val();

		// 제목 여백 검사
		if (title == "") {
			titleNotice.html("제목을 입력해주세요.");
			titleNotice.css("color", "red");
		} else {
			titleBlankCheck = true;
		}

		// 내용 여백 검사
		if (content == "") {
			contentNotice.html("내용을 입력해주세요.");
			contentNotice.css("color", "red");
		} else {
			contentBlankCheck = true;
		}

		// 화면에서 통합 유효성 검사
		if (titleBlankCheck && contentBlankCheck) {
			registerForm.attr("action", "/insertAnnouncement");
			registerForm.submit();
		}
	})

	// 입력 후 여백에 관한 알림 삭제
	$("#title").keydown(function() {
		titleNotice.html("");
	})

	$("#content").keydown(function() {
		contentNotice.html("");
	})

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
</script>
