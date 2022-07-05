<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="email_container">
	<div class="large_category">
		<h2>이메일 찾기</h2>
	</div>
	
	<form id="search_email_form" method="post" autocomplete="off">
		<div class="form-group">
			<label for="name">이름:</label> <input type="text" class="form-control" id="name" name="name" onkeyup="enterSearch();">
			<p id="name_notice"></p>
		</div>
		
		<div class="form-group">
			<label for="phone">휴대폰 번호:</label>
			<input type="text" class="form-control" id="phone" name="phone" onkeyup="enterSearch();">
			<p id="phone_notice"></p>
		</div>
		
		<div class="form-group">
			<button type="button" class="btn btn-primary" id="submit_search_email">확인</button>
			<a href="/login"><button type="button" class="btn btn-primary" id="cancel_search_email">취소</button></a>
		</div>
	</form>
</div>

<div class="container mt-3">
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">이메일 찾기</h4>
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
</body>
</html>

<script>
	// 유효성 검사 통과유무 변수
	var nameBlankCheck = false; // 이름 확인 여백
	var phoneBlankCheck = false; // 휴대폰 번호 여백

	// 입력값 변수
	var name = $("#name").val(); // 이름
	var phone = $("#phone").val(); // 휴대폰 번호

	// 알림 태그 변수
	var nameNotice = $("#name_notice"); // 이름 알림 태그
	var phoneNotice = $("#phone_notice"); // 휴대폰 번호 알림 태그

	// 엔터키 누를시 확인 버튼 클릭 함수
	function enterSearch() {
		if (window.event.keyCode == 13) {
			$("#submit_search_email").click();
		}
	}

	$("#submit_search_email").click(function() {
		name = $("#name").val();
		phone = $("#phone").val();

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
		if (nameBlankCheck && phoneBlankCheck) {
			var data = {
				name: name,
				phone: phone
			}

			$.ajax({
				type: "post",
				url: "/searchEmailOk",
				data: data,
				success: function(result) {
					$("#myModal").modal();

					var html = "";
					html = "<ul style='padding: 16px; margin: 0;'>";
					// 존재하는 이메일 모두 출력
					for (var i = 0; i < result.length; i++) {
						html += "<li>" + result[i] + "</li>";
					}
					html += "</ul>";
					$(".modal-body").html(html);
				},
				error : function() {
					$("#myModal").modal();
					
					$(".modal-body").html("해당 계정이 없습니다.");
				}
			})
		}
	});

	// 입력 후 여백에 관한 알림 삭제
	$("#name").keydown(function() {
		nameNotice.html("");
	})

	$("#phone").keydown(function() {
		phoneNotice.html("");
	})
</script>
