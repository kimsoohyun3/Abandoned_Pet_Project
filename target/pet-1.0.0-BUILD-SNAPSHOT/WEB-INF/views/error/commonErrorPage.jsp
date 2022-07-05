<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

<div class="container errorMessage_container">
	<div class="errorMessage_wrap">
		<p class="errorMessage">${errorMessage}</p>
	</div>
	
	<div class="errorMessage_wrap">
		<p class="errorMessage">HTTP ERROR: ${errorCode}</p>
	</div>
	
	<div class="button_wrap">
		<a href="/"><button type="button" class="btn btn-primary mb-2" id="home_button">홈</button></a>
	</div>
</div>
</body>
</html>