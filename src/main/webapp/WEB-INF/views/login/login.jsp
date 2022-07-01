<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="login_container">
	<div class="large_category">
		<h2>로그인(test)</h2>
	</div>
	
	<form id="login_form" action="/loginSession" method="post" autocomplete="off">
		<div class="form-group">
			<label for="email">이메일:</label>
			<input type="email" class="form-control" id="email" value="${email}" placeholder="Email" name="email" onkeyup="enterLogin();">
			<p id="email_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="pswd">비밀번호:</label>
			<input type="password" class="form-control" id="pswd" placeholder="Password" name="pswd" onkeyup="enterLogin();">
			<p id="pswd_notice">${fail}</p>
		</div>
		
		<div class="form-group" id="button_div">
			<div id="button_div2">
				<button type="button" class="btn btn-primary" id="submit_login">로그인</button>
				<div id="search_div">
					<a id="search_email" href="/searchEmail">이메일 찾기</a>
					<a id="search_pswd" href="/searchPswd">비밀번호 찾기</a>
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<a href="${url}"><img class="form-control" src="static/img/naverLoginButton.png" alt="" /></a>
		</div>
	</form>
</div>
</body>
</html>

<script>
	// 유효성 검사 통과유무 변수
	var emailBlankCheck = false; // 이메일 여백
	var pswdBlankCheck = false; // 비밀번호 여백

	// 입력값 변수
	var email = $("#email").val(); // 이메일
	var pswd = $("#pswd").val(); // 비밀번호

	// 알림 태그 변수
	var emailNotice = $("#email_notice"); // 이메일 알림 태그
	var pswdNotice = $("#pswd_notice"); // 비밀번호 알림 태그

	// 엔터키 누를시 로그인 버튼 클릭 함수
	function enterLogin() {
		if (window.event.keyCode == 13) {
			$("#submit_login").click();
		}
	}

	$("#submit_login").click(function() {
		email = $("#email").val();
		pswd = $("#pswd").val();

		// 이메일 여백 검사
		if (email == "") {
			emailNotice.html("이메일을 입력해주세요.");
		} else {
			emailBlankCheck = true;
		}

		// 비밀번호 여백 검사
		if (pswd == "") {
			pswdNotice.html("비밀번호를 입력해주세요.");
		} else {
			pswdBlankCheck = true;
		}

		// 화면에서 통합 유효성 검사
		if (emailBlankCheck && pswdBlankCheck)
			$("#login_form").submit();
	})

	// 입력 후 여백에 관한 알림 삭제
	$("#email").keydown(function() {
		emailNotice.html("");
	})

	$("#pswd").keydown(function() {
		pswdNotice.html("");
	})
</script>
