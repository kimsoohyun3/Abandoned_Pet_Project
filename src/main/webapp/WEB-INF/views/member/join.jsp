<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="join_container">
	<div class="large_category">
		<h2>회원가입</h2>
	</div>
	
	<form:form id="join_form" action="/joinOK" method="post" autocomplete="off" modelAttribute="memberVo">
		<div class="form-group">
			<label for="email">이메일:</label>
			<form:input type="email" class="form-control" path="email" placeholder="Email" />
			<b><form:errors path="email" /></b>
			<p id="email_notice">이메일 입력 후 인증번호 전송 버튼을 클릭해주세요.</p>
		</div>
		
		<div class="form-group" id="email_check_wrap" style="margin: auto;">
			<div id="code_input_box_false" style="display: inline-block; width: 30%;">
				<input type="number" id="code" name="code" class="form-control" placeholder="Code" disabled="disabled" />
			</div>
			<button type="button" class="btn btn-primary mb-2" id="code_button" style="display: inline-block;">인증번호 전송</button>
			<span id="code_notice" style="${emailReCheck == '재인증 요망' ? 'color: red;' : ''}">${emailReCheck}</span>
			<b style="${mailCheckFail == '!' ? 'color: red;' : ''}">${mailCheckFail}</b>
		</div>
		
		<div class="form-group">
			<label for="pswd">비밀번호:</label>
			<form:input type="password" class="form-control" path="pswd" placeholder="Password" />
			<b><form:errors path="pswd" id="b" /></b>
			<p id="pswd_notice">영문자, 숫자 포함 8~13자로 입력해주세요.</p>
		</div>
		
		<div class="form-group">
			<label for="cfpswd">비밀번호 확인:</label>
			<form:input type="password" class="form-control" path="cfpswd" placeholder="Confirm password" />
			<b><form:errors path="cfpswd" /></b>
			<p id="cfpswd_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="name">이름:</label>
			<form:input type="text" class="form-control" path="name" placeholder="Name" />
			<b><form:errors path="name" /></b>
			<p id="name_notice">한글 이름으로만 입력해주세요.</p>
		</div>
		
		<div class="form-group">
			<label for="nickname">별명:</label>
			<form:input type="text" class="form-control" path="nickname" placeholder="Nickname" />
			<b><form:errors path="nickname" /></b>
			<p id="nickname_notice">한글 별명으로만 입력해주세요.</p>
		</div>
		
		<div class="form-group">
			<label for="phone">휴대폰 번호:</label>
			<form:input type="text" class="form-control" path="phone" placeholder="Phone" />
			<b><form:errors path="phone" /></b>
			<p id="phone_notice">'-'를 생략하고 입력해주세요.</p>
			<p id="phone_notice2"></p>
		</div>
		
		<div class="form-group">
			<button type="button" class="btn btn-primary" id="submit_member" style="margin: auto;">완료</button>
		</div>
	</form:form>
</div>
</body>
</html>

<script>
	// 유효성 검사 통과유무 변수
	var emailBlankCheck = false; // 이메일 여백
	var emailCheck = false; // 이메일 형식
	var emailOverlapCheck = false; // 이메일 중복
	var codeBlankCheck = false; // 인증번호 여백
	var codeCheck = false; // 인증번호 비교
	var pswdBlankCheck = false; // 비밀번호 여백
	var pswdCheck = false; // 비밀번호 형식
	var cfpswdBlankCheck = false; // 비밀번호 확인 여백
	var cfpswdCheck = false; // 비밀번호 확인 형식
	var pswdConcordCheck = false; // 비밀번호 일치
	var nameBlankCheck = false; // 이름 확인 여백
	var nameCheck = false; // 이름 형식
	var nicknameBlankCheck = false; // 별명 확인 여백
	var nicknameCheck = false; // 별명 형식
	var nicknameOverLapCheck = false; // 별명 중복
	var phoneBlankCheck = false; // 휴대폰 번호 여백
	var phoneCheck = false; // 휴대폰 번호 형식

	// 입력값 변수
	var email = $("#email").val(); // 이메일
	var code = $("#code").val(); // 인증번호
	var pswd = $("#pswd").val(); // 비밀번호
	var cfpswd = $("#cfpswd").val(); // 비밀번호 확인
	var name = $("#name").val(); // 이름
	var nickname = $("#nickname").val(); // 별명
	var phone = $("#phone").val(); // 휴대폰 번호

	// 알림 태그 변수
	var emailNotice = $("#email_notice"); // 이메일 알림 태그
	var codeNotice = $("#code_notice"); // 인증번호 알림 태그
	var pswdNotice = $("#pswd_notice"); // 비밀번호 알림 태그
	var cfpswdNotice = $("#cfpswd_notice"); // 비밀번호 확인 알림 태그
	var nameNotice = $("#name_notice"); // 이름 알림 태그
	var nicknameNotice = $("#nickname_notice"); // 별명 알림 태그
	var phoneNotice = $("#phone_notice"); // 휴대폰 번호 알림 태그

	// 이메일 형식 검사
	function emailFormCheck(email) {
		var form = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
		return form.test(email);
	}

	// 이메일 중복검사(ajax 통신)
	$("#email").blur(function() {
		email = $("#email").val();
		var data = {
			email : email
		}

		// 이메일 형식 검사
		// 이메일 형식이 맞을 경우
		if (emailFormCheck(email)) {
			emailCheck = true;

			$.ajax({
				type: "post",
				url: "/emailOverlap",
				data: data,
				success: function(result) {
					if (result != "fail") {
						emailOverlapCheck = true;

						emailNotice.html("사용 가능한 이메일입니다.");
						emailNotice.css("color", "green");
					} else {
						emailNotice.html("이메일이 이미 존재합니다.");
						emailNotice.css("color", "red");
					}
				}
			});
		// 이메일 입력란이 공란이 아니면서 형식이 맞지 않을 경우
		} else if (email != "") {
			emailNotice.html("올바르지 못한 이메일 형식입니다.");
			emailNotice.css("color", "red");
		// 이메일 입력란이 공란일 경우
		} else {
			emailNotice.html("이메일 입력 후 인증번호 전송 버튼을 클릭해주세요.");
			emailNotice.css("color", "gray");
		}
	});

	var code = "";
	// 인증번호 이메일 전송
	$("#code_button").click(function() {
		// 이메일 통합 유효성검사 통과 성공할 경우
		if (emailCheck && emailOverlapCheck) {
			var inputCode = $("#code");
			var boxWrap = $("#code_input_box_false");
			email = $("#email").val();

			$.ajax({
				type: "GET",
				url: "/emailCheck?email=" + email,
				success: function(data) {
					inputCode.attr("disabled", false);
					boxWrap.attr("id", "code_input_box_true");
					
					code = data;
				}
			});
			
			alert("인증번호가 전송되었습니다.");
		// 이메일 통합 유효성검사 통과 실패할 경우
		} else {
			emailNotice.html("입력칸에  focus를 주고 떼셔서 유효성 검사를 완료해주세요.");
			emailNotice.css("color", "red");
		}
	});

	// 인증번호 비교
	$("#code").blur(function() {
		var inputCode = $("#code").val();
		var codeNotice = $("#code_notice");
		
		// 인증번호 일치할 경우
		if (code == inputCode) {
			codeCheck = true;

			codeNotice.html("인증번호 일치");
			codeNotice.css("color", "green");
		// 인증번호 입력란이 공란이 아니면서 인증번호 미일치할 경우
		} else if (inputCode != "") {
			codeNotice.html("인증번호 미일치");
			codeNotice.css("color", "red");
		// 인증번호 입력란이 공란일 경우
		} else {
			codeNotice.html("");
		}
	});

	// 비밀번호 형식 검사 함수
	function pswdFormCheck(pswd) {
		var form = /^(?=.*[a-zA-z])(?=.*[0-9])(?!.*[^a-zA-z0-9]).{8,13}$/;
		
		return form.test(pswd);
	}

	// 비밀번호 형식 검사 + 비밀번호 일치 검사(비밀번호가 일치하지 않아 첫번째 비밀번호 칸을 수정하는 경우)
	$("#pswd").blur(function() {
		pswd = $("#pswd").val()
		cfpswd = $("#cfpswd").val()

		// cfpswd 입력란이 공란이 아닐 경우
		if (cfpswd != "") {
			// pswd 가 비밀번호 형식이 맞을 경우
			if (pswdFormCheck(pswd)) {
				pswdCheck = true;

				if (pswd == cfpswd) {
					pswdConcordCheck = true;

					pswdNotice.html("");
					cfpswdNotice.html("사용 가능한 비밀번호입니다.");
					cfpswdNotice.css("color", "green");
				} else {
					pswdNotice.html("사용 가능한 비밀번호입니다.");
					pswdNotice.css("color", "green");
					cfpswdNotice.html("비밀번호가 불일치합니다.");
					cfpswdNotice.css("color", "red");
				}

			// pswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
			} else if (pswd != "") {
				pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
				pswdNotice.css("color", "red");
				cfpswdNotice.html("비밀번호가 불일치합니다.");
				cfpswdNotice.css("color", "red");
			// pswd 입력란이 공백일 경우
			} else {
				pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
				pswdNotice.css("color", "gray");
				cfpswdNotice.html("");
			}
		// cfpswd 입력란이 공란일 경우 + pswd 가 비밀번호 형식이 맞을 경우
		} else if (pswdFormCheck(pswd)) {
			pswdCheck = true;

			pswdNotice.html("사용 가능한 비밀번호입니다.");
			pswdNotice.css("color", "green");

		// cfpswd 입력란이 공란일 경우 + pswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (pswd != "") {
			pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
			pswdNotice.css("color", "red");
		// cfpswd 입력란이 공란일 경우 + pswd 입력란이 공백일 경우
		} else {
			pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
			pswdNotice.css("color", "gray");
		}
	});

	// 비밀번호 확인 형식 검사 + 비밀번호 일치 검사
	$("#cfpswd").blur(function() {
		pswd = $("#pswd").val();
		cfpswd = $("#cfpswd").val();
		
		// cfpswd 가 비밀번호 형식이 맞을 경우
		if (pswdFormCheck(cfpswd)) {
			cfpswdCheck = true;

			if (pswd == cfpswd) {
				pswdConcordCheck = true;

				pswdNotice.html("");
				cfpswdNotice.html("사용 가능한 비밀번호입니다.");
				cfpswdNotice.css("color", "green");
			} else {
				cfpswdNotice.html("비밀번호가 불일치합니다.");
				cfpswdNotice.css("color", "red");
			}
		
		// cfpswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (cfpswd != "") {
			cfpswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
			cfpswdNotice.css("color", "red");
		// cfpswd 입력란이 공백일 경우
		} else {
			cfpswdNotice.html("");
		}
	});

	// 이름 형식 검사
	function nameFormCheck(name) {
		var form = /^[가-힣]{2,6}/;
		
		return form.test(name);
	}

	$("#name").blur(function() {
		name = $("#name").val();
	
		// 이름 형식이 맞을 경우
		if (nameFormCheck(name)) {
			nameCheck = true;

			nameNotice.html("");
			
		// 이름 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (name != "") {
			nameNotice.html("한글 2~6자로 입력해주세요.");
			nameNotice.css("color", "red");
		// 이름 입력란이 공백일 경우
		} else {
			nameNotice.html("한글 이름으로만 입력해주세요.");
			nameNotice.css("color", "gray");
		}
	});

	// 별명 형식 검사 함수
	function nicknameFormCheck(nickname) {
		var form = /^[가-힣]{1,8}/;
		
		return form.test(nickname);
	}

	// 별명 중복검사(ajax 통신)
	$("#nickname").blur(function() {
		nickname = $("#nickname").val();
		var data = {
			nickname : nickname
		}

		// 별명 형식이 맞을 경우
		if (nicknameFormCheck(nickname)) {
			nicknameCheck = true;

			$.ajax({
				type: "post",
				url: "/joinNicknameOverlap",
				data: data,
				success: function(result) {
					if (result != "fail") {
						nicknameOverlapCheck = true;

						nicknameNotice.html("사용 가능한 별명입니다.");
						nicknameNotice.css("color", "green");
					} else {
						nicknameNotice.html("별명이 이미 존재합니다.");
						nicknameNotice.css("color", "red");
					}
				}
			});
		// 별명 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (nickname != "") {
			nicknameNotice.html("올바르지 못한 별명 형식입니다.");
			nicknameNotice.css("color", "red");
		// 별명 입력란이 공백일 경우
		} else {
			nicknameNotice.html("한글 별명으로만 입력해주세요.");
			nicknameNotice.css("color", "gray");
		}
	});

	// 휴대폰 번호 형식 검사
	function phoneFormCheck(phone) {
		var form = /^[0-9].{10,10}$/;
		
		return form.test(phone);
	}

	$("#phone").blur(function() {
		phone = $("#phone").val();
	
		// 휴대폰 번호 형식이 맞을 경우
		if (phoneFormCheck(phone)) {
			phoneCheck = true;

			phoneNotice.html("'-'를 생략하고 입력해주세요.");
			phoneNotice.css("color", "gray");
		// 휴대폰 번호 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (phone != "") {
			phoneNotice.html("'-'를 생략하고 휴대폰 번호 11자로 입력해주세요.");
			phoneNotice.css("color", "red");
		// 휴대폰 번호 입력란이 공백일 경우
		} else {
			phoneNotice.html("'-'를 생략하고 입력해주세요.");
			phoneNotice.css("color", "gray");
		}
	});

	$("#submit_member").click(
			function() {
				// 이메일 여백 검사
				if (email == "") {
					emailNotice.html("이메일을 입력해주세요.");
					emailNotice.css("color", "red");
				} else {
					emailBlankCheck = true;
				}

				// 인증번호 여백 검사
				if (code == "") {
					codeNotice.html("이메일 인증을 해주세요.");
					codeNotice.css("color", "red");
				} else {
					codeBlankCheck = true;
				}

				// 비밀번호 여백 검사
				if (pswd == "") {
					pswdNotice.html("비밀번호를 입력해주세요.");
					pswdNotice.css("color", "red");
				} else {
					pswdBlankCheck = true;
				}

				// 비밀번호 확인 여백 검사
				if (cfpswd == "") {
					cfpswdNotice.html("비밀번호 확인을 입력해주세요.");
					cfpswdNotice.css("color", "red");
				} else {
					cfpswdBlankCheck = true;
				}

				// 이름 여백 검사
				if (name == "") {
					nameNotice.html("이름을 입력해주세요.");
					nameNotice.css("color", "red");
				} else {
					nameBlankCheck = true;
				}

				// 별명 여백 검사
				if (nickname == "") {
					nicknameNotice.html("별명을 입력해주세요.");
					nicknameNotice.css("color", "red");
				} else {
					nicknameBlankCheck = true;
				}

				// 휴대폰 번호 여백 검사
				if (phone == "") {
					phoneNotice.html("휴대폰 번호를 입력해주세요.");
					phoneNotice.css("color", "red");
				} else {
					phoneBlankCheck = true;
				}
				
				// 화면에서 통합 유효성 검사
				if (emailBlankCheck && emailOverlapCheck && pswdCheck && pswdBlankCheck && cfpswdCheck && cfpswdBlankCheck && pswdConcordCheck && nameBlankCheck && nameCheck
						&& nicknameBlankCheck && nicknameCheck && phoneBlankCheck && phoneCheck && codeCheck && codeBlankCheck) {
					alert("회원가입이 완료되었습니다.");
					
					$("#join_form").submit();
				}
			})
</script>
