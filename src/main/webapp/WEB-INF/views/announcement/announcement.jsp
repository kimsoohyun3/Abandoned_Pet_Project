<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container container_margin" id="container_announcement">
	<div class="large_category">
		<h2>공지사항</h2>
	</div>
	<table class="table" id="table_announcement">
		<thead class="thead-light">
			<tr>
				<th><input type="checkbox" id="allCheck" name="allCheck" /></th>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${voList}" var="vo">
				<tr>
					<td><input type="checkbox" name="oneCheck" value="${vo.announcementNo}" /></td>
					<td>${vo.announcementNo}</td>
					<td><a class="move text_deco_none" href="<c:out value='${vo.announcementNo}'/>">${vo.announcementTitle}</a></td>
					<td>${vo.announcementDate}</td>
					<td>${vo.announcementHits}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<form id="moveForm">
		<input type="hidden" name="currentPageNum" value="${pageMakerVo.pagingProcessingVo.currentPageNum}">
		<input type="hidden" name="amount" value="${pageMakerVo.pagingProcessingVo.amount}">
	</form>

	<div class="pageInfo_wrap">
		<div class="pageInfo_area">
			<ul class="pageInfo" id="pageInfo">
				<c:if test="${pageMakerVo.prev}">
					<li class="pageInfo_btn previous text_deco_none"><a href="${pageMakerVo.startPage-1}"><img src="static/img/prevPage.png"></a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMakerVo.startPage}" end="${pageMakerVo.endPage}">
					<li class="pageInfo_btn text_deco_none ${pageMakerVo.pagingProcessingVo.currentPageNum == num ? 'active' : ''}"><a href="${num}">${num}</a></li>
				</c:forEach>

				<c:if test="${pageMakerVo.next}">
					<li class="pageInfo_btn text_deco_none next"><a href="${pageMakerVo.endPage+1}"><img src="static/img/nextPage.png"></a></li>
				</c:if>
			</ul>
		</div>
	</div>
	
	<p>${deleteFail}</p>
	
	<c:if test="${auth == 'A'}">
		<div>
			<div id="notice_Button_div">
				<p id="delete_notice"></p>
				<div>
					<input type="button" class="btn btn-primary" value="삭제" onclick="deleteAnnouncement();">
					<a id="register_announcement" href="/registerAnnouncement"><input type="button" class="btn btn-primary" value="등록"></a>
				</div>
			</div>
		</div>
	</c:if>
</div>
</body>
</html>

<script>
	var moveForm = $("#moveForm");
	// 상세 공지사항으로 가기 위한 announcementNo 값 보내기
	// 다시 상세 공지사항 -> 공지사항 목록 이동시 해당 페이지로 올수 있도록 pagingProcessingVo 보내기 
	$(".move").on("click", function(e) {
		e.preventDefault();
						
		// 공지사항 목록 -> 상세 공지사항 이동 후 목록 버튼이 아닌 뒤로가기를 누를시 이전 append 처리되었던 input 태그 중복현상 방지
		$("#moveForm input[name='announcementNo']").remove();
						
			moveForm.append("<input type='hidden' name='announcementNo' value='" + $(this).attr("href") + "'>");
			moveForm.attr("action", "/detailAnnouncement");
			moveForm.submit();
		})

	// 페이징 처리
	$(".pageInfo a").on("click", function(e) {
				e.preventDefault();
				
				moveForm.find("input[name='currentPageNum']").val($(this).attr("href"));
				moveForm.attr("action", "/announcement");
				moveForm.submit();
			})
			
	// 서버에서 한번 더 관리자인지 판별 후 아닐시 실패 메세지 받기
	var failMessage = "${failMessage}";
	if(failMessage != null && failMessage != ""){
		alert(failMessage);
	}

	var oneCheckCnt = $("input[name='oneCheck']").length; // 한 페이지의 게시물 체크박스 수

	// 전체선택 눌렀을때
	$("input[name='allCheck").click(function() {
		var checkList = $("input[name='oneCheck']"); // 체크된 게시물 배열
		
		
		if ($("input[name='allCheck']").is(":checked"))
			$("input[name='oneCheck']").prop("checked", true);
		else
			$("input[name='oneCheck']").prop("checked", false);
	});

	// 개별선택 눌렀을때
	$("input[name='oneCheck']").click(function() {
		var checked = $("input[name='oneCheck']:checked").length; // 체크된 게시물 수
		
		// 한 페이지의 게시물 체크박스 수와 체크된 게시물 수와 다를 경우
		if (oneCheckCnt != checked)
			$("input[name='allCheck']").prop("checked", false);
		// 한 페이지의 게시물 체크박스 수와 체크된 게시물 수와 같을 경우
		else
			$("input[name='allCheck']").prop("checked", true);
	});

	// 게시물 삭제 함수
	function deleteAnnouncement() {
		var announcementArray = new Array(); // 체크된 게시물의 announcement_no 값을 담을 배열
		var checkList = $("input[name='oneCheck']"); // 체크된 게시물 배열

		// 체크된 게시물의 announcement_no 값 배열에 담기
		for (var i = 0; i < checkList.length; i++) {
			if (checkList[i].checked) {
				announcementArray.push(checkList[i].value);
			}
		}

		// 체크된 게시물 없을 시
		if (announcementArray.length == 0) {
			$("#delete_notice").html("선택된 게시글이 없습니다.");
		// 체크된 게시물 있을 시
		} else {
			if (confirm("정말로 삭제하시겠습니까?") == true) {
				$.ajax({
					url: "/deleteAnnouncement",
					type: "post",
					contentType: 'application/json',
					data: JSON.stringify(announcementArray),
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
	}
</script>
