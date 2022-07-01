<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="pswd_container">
	<div class="large_category">
		<h2>비밀번호 찾기</h2>
	</div>
	
	<form id="search_pswd_form" method="post" autocomplete="off">
		<div class="form-group">
			<label for="email">이메일:</label>
			<input type="email" class="form-control" id="email" name="email">
			<p id="email_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="name">이름:</label>
			<input type="text" class="form-control" id="name" name="name">
			<p id="name_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="phone">휴대폰 번호:</label>
			<input type="text" class="form-control" id="phone" name="phone">
			<p id="phone_notice"></p>
		</div>
		
		<div class="form-group">
			<button type="button" class="btn btn-primary" id="submit_search_pswd">확인</button>
			<a href="/login"><button type="button" class="btn btn-primary" id="cancel_search_password">취소</button></a>
		</div>
	</form>
</div>
</body>
</html>

<div class="container mt-3">
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">비밀번호 찾기</h4>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>

				<div class="modal-body"></div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	//유효성 검사 통과유무 변수
	var emailBlankCheck = false; // 이메일 확인 여백
	var nameBlankCheck = false; // 이름 확인 여백
	var phoneBlankCheck = false; // 휴대폰 번호 여백

	// 입력값 변수
	var email = $("#email").val(); // 이메일
	var name = $("#name").val(); // 이름
	var phone = $("#phone").val(); // 휴대폰 번호

	// 알림 태그 변수
	var emailNotice = $("#email_notice"); // 이메일 알림 태그
	var nameNotice = $("#name_notice"); // 이름 알림 태그
	var phoneNotice = $("#phone_notice"); // 휴대폰 번호 알림 태그

	// 엔터키 누를시 확인 버튼
	function enterSearch() {
		if (window.event.keyCode == 13) {
			$("#submit_search_pswd").click();
		}
	}

	$("#submit_search_pswd").click(function() {
		email = $("#email").val();
		name = $("#name").val();
		phone = $("#phone").val();

		// 이메일 여백 검사
		if (email == "") {
			emailNotice.html("이메일을 입력해주세요.");
		} else {
			emailBlankCheck = true;
		}

		// 이름 여백 검사
		if (name == "") {
			nameNotice.html("이름을 입력해주세요.");
		} else {
			nameBlankCheck = true;
		}

		// 휴대폰 번호 여백 검사
		if (phone == "") {
			phoneNotice.html("휴대폰 번호를 입력해주세요.");
		} else {
			phoneBlankCheck = true;
		}

		// 통합 유효성 검사 후 이메일 찾기
		if (emailBlankCheck && nameBlankCheck&& phoneBlankCheck) {
			var data = {
				email: email,
				name: name,
				phone: phone
			}

			$.ajax({
				type: "post",
				url: "/searchPswdOk",
				data: data,
				success: function(result) {
					$("#myModal").modal();

					var html = "";
					if (result == "success") {
						html = "<p style='margin: 0;'>임시 비밀번호를 입력하신 이메일로 전송하였습니다.</p>";
						$(".modal-body").html(html);
					} else {
						html = "<p style='margin: 0;'>해당 계정이 없습니다.</p>";
						$(".modal-body").html(html);
					}
				}
			})
		}
	});

	// 입력 후 여백에 관한 알림 삭제
	$("#email").keydown(function() {
		emailNotice.html("");
	})

	$("#name").keydown(function() {
		emailNotice.html("");
	})

	$("#phone").keydown(function() {
		emailNotice.html("");
	})
</script>
