<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="profile_container">
	<div class="large_category">
		<h2>내 정보</h2>
	</div>
	
	<form:form id="profile_form" method="post" autocomplete="off" modelAttribute="memberVo">
		<table class="table" id="profile_table">
			<tr>
				<th>이메일</th>
				<td>${loginMember.email}${naverLoginMember.email}</td>
			</tr>
			
			<tr>
				<th>비밀번호</th>
				<td id="pswd_td">
					<p id="encoded_pswd">****</p>
					<form:input type="password" class="form-control" path="pswd" value="${pswd}" placeholder="영문자, 숫자 포함 8~13자로 입력해주세요." />
					<p id="pswd_notice"></p>
					<form:input type="password" class="form-control" path="cfpswd" value="${pswd}" placeholder="비밀번호 확인" />
					<p id="cfpswd_notice" style="${resultOfAlterPswd == '비밀번호가 변경되었습니다.' ? 'color: green;' : ''}">${resultOfAlterPswd}</p>
				</td>
				<td><b><form:errors path="cfpswd" /></b></td>
			</tr>
			
			<tr>
				<th>이름</th>
				<td>${loginMember.name}${naverLoginMember.name}</td>
			</tr>
			
			<tr>
				<th>별명</th>
				<td>
					<p id="nickname_data">${loginMember.nickname}${naverLoginMember.nickname}</p>
					<form:input type="text" class="form-control" path="nickname" value="${loginMember.nickname}" placeholder="한글 별명으로만 입력해주세요." />
					<p id="nickname_notice" style="${resultOfAlterNickname == '별명이 변경되었습니다.' ? 'color: green;' : ''}">${resultOfAlterNickname}</p>
				</td>
				<td><b><form:errors path="nickname" /></b></td>
			</tr>
			
			<tr>
				<th>휴대폰 번호</th>
				<td>
					<p id="phone_data">${loginMember.phone}${phone}</p>
					<form:input type="text" class="form-control" path="phone" value="${loginMember.phone}" placeholder="'-'를 생략하고 입력해주세요." />
					<p id="phone_notice" style="${resultOfAlterPhone == '휴대폰 번호가 변경되었습니다.' ? 'color: green;' : ''}">${resultOfAlterPhone}</p>
				</td>
				<td><b><form:errors path="phone" /></b></td>
			</tr>
			
			<c:if test="${!empty loginMember.name}">
			<tr>
				<td id="alter_notice_td" colspan="2"><p id="alter_notice">입력칸에  focus를 주고 떼셔서 유효성 검사를 완료해주세요.</p></td>
			</tr>
			</c:if>
			
			<c:if test="${!empty naverLoginMember.name}">
			<tr style="height: 70px">
				<td id="alter_notice_td2" colspan="2"><p id="alter_notice2">네이버 계정 정보와 연동됩니다. 프로필 수정은 네이버에서 해주시길 바랍니다.</p></td>
			</tr>
			</c:if>
			
			<c:if test="${!empty loginMember.name}">
			<tr id="button_tr">
				<td id="alter_button_td"><button type="button" class="btn btn-primary mb-2" id="alter_button">변경</button></td>
				<td id="cf_alter_button_td" colspan="2"><button type="button" class="btn btn-primary mb-2" id="cf_alter_button" disabled="disabled">확인</button></td>
				<td id="alter_cancel_button_td" colspan="2"><a href="/profile"><button type="button" class="btn btn-primary mb-2" id="alter_cancel_button">취소</button></a></td>
			</tr>
			</c:if>
		</table>
	</form:form>
</div>
</body>
</html>
<script>
	// 유효성 검사 통과유무 변수
	var pswdCheck = true; // 비밀번호 형식
	var pswdBlankCheck = true; // 비밀번호 여백
	var cfpswdCheck = true; // 비밀번호 확인 형식
	var cfpswdBlankCheck = true; // 비밀번호 확인 여백
	var pswdConcordCheck = true; // 비밀번호 일치
	var nicknameCheck = true; // 별명 형식
	var nicknameBlankCheck = true; // 별명여백
	var nicknameOverLapCheck = true; // 별명 중복
	var phoneBlankCheck = true; // 휴대폰 번호 확인 여백
	var phoneCheck = true; // 휴대폰 번호 형식

	// 입력값 변수
	var pswd = $("#pswd").val(); // 비밀번호
	var cfpswd = $("#cfpswd").val(); // 비밀번호 확인
	var nickname = $("#nickname").val(); // 별명
	var phone = $("#phone").val(); // 별명

	// 알림 태그 변수
	var pswdNotice = $("#pswd_notice"); // 비밀번호 알림 태그
	var cfpswdNotice = $("#cfpswd_notice"); // 비밀번호 알림 태그
	var nicknameNotice = $("#nickname_notice"); // 별명 알림 태그
	var phoneNotice = $("#phone_notice"); // 핸드폰 번호 알림 태그

	var cfAlterButton = $("#cf_alter_button"); //변경 확인 버튼
	
	// 변경 확인 버튼 disabled 여부
	var pswd_cf_alter_disabled = true;
	var nickname_cf_alter_disabled = true;
	var phone_cf_alter_disabled = true;
	
	// 변경 버튼 클릭시 css 수정
	$("#alter_button").click(function() {
		$("#encoded_pswd").css("display", "none");
		$("#pswd").css("display", "inline-block");
		$("#cfpswd").css("display", "inline-block");
		$("#cfpswd").css("margin-top", "2%");
		$("#nickname_data").css("display", "none");
		$("#nickname").css("display", "inline-block");
		$("#phone_data").css("display", "none");
		$("#phone").css("display", "inherit");
		$("#alter_notice_td").css("padding", "8px 0");
		$("#alter_notice").css("display", "inline-block");
		$("#alter_button_td").css("display", "none");
		$("#cf_alter_button_td").css("display", "inline-block");
		$("#alter_cancel_button_td").css("display", "inline-block");
	})
	
	// 변경 확인 버튼 disabled 유무 검사 함수
	function cf_alter_disabled_check(){
			if(pswd_cf_alter_disabled == false || nickname_cf_alter_disabled == false || phone_cf_alter_disabled == false){
				cfAlterButton.removeAttr("disabled");
			}else{
				cfAlterButton.attr("disabled", "true");
			}
		}

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
			cfpswdBlankCheck = true;
			
			// 기존 pswd일 경우
			if ("${pswd}" == pswd) {
				pswdNotice.html("");
				
				pswdCheck = true;
				pswdBlankCheck = true;
				cfpswdCheck = true;
				cfpswdBlankCheck = true;
				pswdConcordCheck = true;
				pswd_cf_alter_disabled = true;
				
			// pswd 가 비밀번호 형식이 맞을 경우
			} else if (pswdFormCheck(pswd)) {
					pswdCheck = true;
					pswdBlankCheck = true;
					
				if (pswd == cfpswd) {
					pswdNotice.html("");
					cfpswdNotice.html("사용 가능한 비밀번호입니다.");
					cfpswdNotice.css("color", "green");
					
					pswdConcordCheck = true;
					pswd_cf_alter_disabled = false;
				} else {
					pswdNotice.html("사용 가능한 비밀번호입니다.");
					pswdNotice.css("color", "green");
					cfpswdNotice.html("비밀번호가 불일치합니다.");
					cfpswdNotice.css("color", "red");
					
					pswdConcordCheck = false;
					pswd_cf_alter_disabled = true;
				}
			// pswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
			} else if (pswd != "") {
				pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
				pswdNotice.css("color", "red");
				cfpswdNotice.html("비밀번호가 불일치합니다.");
				cfpswdNotice.css("color", "red");
				
				pswdBlankCheck = true;
				pswdCheck = false;
				pswdConcordCheck = false;
				pswd_cf_alter_disabled = true;
			// pswd 입력란이 공백일 경우
			} else {
				pswdNotice.html("");
				cfpswdNotice.html("");
				
				pswdBlankCheck = false;
				pswdCheck = false;
				pswdConcordCheck = false;
				pswd_cf_alter_disabled = true;
			}
		// cfpswd 입력란이 공란일 경우 + pswd 가 비밀번호 형식이 맞을 경우
		} else if (pswdFormCheck(pswd)) {
			pswdNotice.html("사용 가능한 비밀번호입니다.");
			pswdNotice.css("color", "green");
			
			pswdCheck = true;
			pswdBlankCheck = true;
			cfpswdCheck = false;
			cfpswdBlankCheck = false;
			pswdConcordCheck = false;
			pswd_cf_alter_disabled = true;
		// cfpswd 입력란이 공란일 경우 + pswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (pswd != "") {
			pswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
			pswdNotice.css("color", "red");
			
			pswdCheck = false;
			pswdBlankCheck = true;
			cfpswdCheck = false;
			cfpswdBlankCheck = false;
			pswdConcordCheck = false;
			pswd_cf_alter_disabled = true;
		// cfpswd 입력란이 공란일 경우 + pswd 입력란이 공백일 경우
		} else {
			pswdCheck = false;
			pswdBlankCheck = false;
			cfpswdCheck = false;
			cfpswdBlankCheck = false;
			pswdConcordCheck = false;
			pswd_cf_alter_disabled = true;
			
			pswdNotice.html("");
		}
		cf_alter_disabled_check();
	});

	// 비밀번호 확인 형식 검사 + 비밀번호 일치 검사
	$("#cfpswd").blur(function() {
		pswd = $("#pswd").val();
		cfpswd = $("#cfpswd").val();
		
		// 기존 cfpswd일 경우
		if ("${pswd}" == cfpswd) {
			cfpswdNotice.html("");
			
			pswdCheck = true;
			pswdBlankCheck = true;
			cfpswdCheck = true;
			cfpswdBlankCheck = true;
			pswdConcordCheck = true;
			pswd_cf_alter_disabled = true;
		// cfpswd 가 비밀번호 형식이 맞을 경우
		} else if (pswdFormCheck(cfpswd)) {
			cfpswdCheck = true;
			cfpswdBlankCheck = true;
			
			if (pswd == cfpswd) {
				pswdNotice.html("");
				cfpswdNotice.html("사용 가능한 비밀번호입니다.");
				cfpswdNotice.css("color", "green");
				
				pswdCheck = true;
				pswdBlankCheck = true;
				pswdConcordCheck = true;
				pswd_cf_alter_disabled = false;
			} else {
				cfpswdNotice.html("비밀번호가 불일치합니다.");
				cfpswdNotice.css("color", "red");
				
				pswdConcordCheck = false;
				pswd_cf_alter_disabled = true;
			}
		// cfpswd 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (cfpswd != "") {
			cfpswdNotice.html("영문자, 숫자 포함 8~13자로 입력해주세요.");
			cfpswdNotice.css("color", "red");
			
			cfpswdCheck = false;
			cfpswdBlankCheck = true;
			pswdConcordCheck = false;
			pswd_cf_alter_disabled = true;
		// cfpswd 입력란이 공백일 경우
		} else {
			cfpswdCheck = false;
			cfpswdBlankCheck = false;
			pswdConcordCheck = false;
			pswd_cf_alter_disabled = true;
			
			cfpswdNotice.html("");
		}
		cf_alter_disabled_check();
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
			nicknameBlankCheck = true;
			nicknameCheck = true;
			
			$.ajax({
				type: "post",
				url: "/alterNicknameOverlap",
				data: data,
				success: function(result) {
					// 별명 중복이 아닐 경우
					if (result == "success") {
						nicknameNotice.html("사용 가능한 별명입니다.");
						nicknameNotice.css("color", "green");
						
						nicknameOverLapCheck = true;
						nickname_cf_alter_disabled = false;
					// 기존 별명일 경우
					} else if (result == "alterNot") {
						nicknameNotice.html("");
						
						nickname_cf_alter_disabled = true;
					// 별명 중복일 경우
					} else {
						nicknameNotice.html("별명이 이미 존재합니다.");
						nicknameNotice.css("color", "red");
						
						nicknameOverLapCheck = false;
						nickname_cf_alter_disabled = true;
						
					}
					cf_alter_disabled_check();
				}
			});
		// 별명 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (nickname != "") {
			nicknameNotice.html("올바르지 못한 별명 형식입니다.");
			nicknameNotice.css("color", "red");
			
			nicknameCheck = false;
			nicknameBlankCheck = true;
			nickname_cf_alter_disabled = true;
			
			cf_alter_disabled_check();
		// 별명 입력란이 공백일 경우
		} else {
			nicknameNotice.html("");
			
			nicknameCheck = false;
			nicknameBlankCheck = false;
			nickname_cf_alter_disabled = true;
			
			
			cf_alter_disabled_check();
		}
	});

	// 휴대폰 번호 형식 검사
	function phoneFormCheck(phone) {
		var form = /^[0-9].{10,10}$/;
		
		return form.test(phone);
	}

	$("#phone").blur(function() {
		phone = $("#phone").val();
		var phoneBlankCheck = true; // 휴대폰 번호 확인 여백
		var phoneCheck = true; // 휴대폰 번호 형식
		// 기존 휴대폰 번호일 경우
		if ("${loginMember.phone}" == phone) {
			phoneNotice.html("");
			
			phoneBlankCheck = true;
			phoneCheck = true;
			phone_cf_alter_disabled = true;
		// 휴대폰 번호 형식이 맞을 경우
		} else if (phoneFormCheck(phone)){
			phoneNotice.html("");
			
			phoneBlankCheck = true;
			phoneCheck = true;
			phone_cf_alter_disabled = false;
		// 휴대폰 번호 입력란이 공백이 아니면서 형식이 맞지 않을 경우
		} else if (phone != "") {
			phoneNotice.html("'-'를 생략하고 휴대폰 번호 11자로 입력해주세요.");
			phoneNotice.css("color", "red");
			
			phoneBlankCheck = true;
			phoneCheck = false;
			phone_cf_alter_disabled = true;
		// 휴대폰 번호 입력란이 공백일 경우
		} else {
			phoneNotice.html("");
			
			phoneBlankCheck = false;
			phoneCheck = false;
			phone_cf_alter_disabled = true;
		}
		cf_alter_disabled_check();
	});

	// 변경 확인 버튼 클릭시 form submit
	$("#cf_alter_button").click(function() {
		// 비밀번호 여백 검사
		if (pswd == "") {
			pswdNotice.html("비밀번호를 입력해주세요.");
			pswdNotice.css("color", "red");
			
			pswdBlankCheck = false;
		}

		// 비밀번호 확인 여백 검사
		if (cfpswd == "") {
			cfpswdNotice.html("비밀번호 확인을 입력해주세요.");
			cfpswdNotice.css("color", "red");
			
			cfpswdBlankCheck = false;
		}

		// 별명 여백 검사
		if (nickname == "") {
			nicknameNotice.html("별명을 입력해주세요.");
			nicknameNotice.css("color", "red");
			
			nickBlankCheck = false;
		}

		// 휴대폰 번호 여백 검사
		if (phone == "") {
			phoneNotice.html("휴대폰 번호를 입력해주세요.");
			phoneNotice.css("color", "red");
			
			phoneBlankCheck = false;
		}
		
		// 최종 유효성 검사			
		if (pswdCheck && pswdBlankCheck && cfpswdCheck && cfpswdBlankCheck && pswdConcordCheck && nicknameCheck && nicknameOverLapCheck && nicknameBlankCheck && phoneCheck 
				&& phoneBlankCheck) {
		$("#profile_form").attr("action", "/alterProfile");
		$("#profile_form").submit();
								}
	});
</script>
