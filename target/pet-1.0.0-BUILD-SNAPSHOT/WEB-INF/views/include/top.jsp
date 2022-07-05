<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">


<title>Abandoned_Pet</title>

<meta content="" name="description">
<meta content="" name="keywords">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<!-- Template Main CSS File -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

<!-- join.jsp, login.jsp, profile form 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<style>
/* common */
.container_margin{
	margin-top: 7%;
	margin-bottom: 16px
}

.large_category {
	text-align: center;
}

.large_category h2 {
	margin-bottom: 20px;
	color: #6a7489;
}

.text_deco_none:hover{
	text-decoration: none;
}

.errorMessage_container{
	margin-top: 10%;
}

.errorMessage_container .errorMessage_wrap{
	text-align: center;
}

.errorMessage_container .errorMessage{
	color: gray;
	font-size: 20px;
}

.errorMessage_container .button_wrap{
	text-align: center;
}

/* join.jsp style  */
#join_form #email, #join_form #pswd, #join_form #cfpswd, #join_form #name, #join_form #nickname, #join_form #phone {
	width: 95%;
	display: inline;
}

#join_form .form-group {
	width: 50%;
	margin: auto;
}

#join_form #email_notice {
	color: gray;
}

.container #join_form b {
	display: inline;
	color: red;
}

#join_form #code_input_box_false {
	background-color: #ebebe4;
}

#join_form #code_input_box_true {
	background-color: white;
}

#join_form input[type="number"]::-webkit-outer-spin-button, #join_form input[type="number"]::-webkit-inner-spin-button{
	-webkit-appearance: none;
	margin: 0;
}

#join_form #code {
	margin: 0;
}

#join_form #pswd_notice {
	color: gray;
}

#join_form #name_notice {
	color: gray;
}

#join_form #nickname_notice {
	color: gray;
}

#join_form #phone_notice {
	color: gray;
}

/* login.jsp style */
#login_form .form-group {
	width: 50%;
	margin: auto;
}

#login_form #email, #login_form #pswd {
	width: 95%;
}

#login_form #email_notice, #login_form #pswd_notice {
	color: red;
}

#login_form #button_div2 {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 95%;
}

#login_form #search_div {
	display: inline-block;
}

#login_form #search_email {
	margin-right: 5px;
}

#login_form #search_email, #login_form #search_pswd {
	color: gray;
}

#login_form #search_email:hover, #login_form #search_pswd:hover {
	color: black;
}

#login_form img {
	margin-top: 16px;
	width: 50%;
	padding: 0;
}

/* profile style */
#profile_table {
	width: 50%;
	margin: auto
}

#profile_table, #profile_form tr, #profile_form th, #profile_form td {
	border: none;
}

#profile_form th, #profile_form td {
	padding: 15px;
}

#profile_form th {
	background-color: #e9ecef;
	width: 30%;
	font-weight: normal;
}

#profile_form #encoded_pswd, #profile_form #pswd_notice, #profile_form #cfpswd_notice{
	margin: 0;
}

#profile_form #pswd, #profile_form #cfpswd, #profile_form #nickname, #profile_form #phone {
	display: none;
}

#profile_table td:nth-child(3) {
	padding-top: 18px;
}

#profile_form b {
	color: red;
}

#profile_form #nickname_data, #profile_form #nickname_notice, #profile_form #phone_data, #profile_form #phone_notice {
	margin: 0;
}

#profile_form #nickname_notice {
	margin: 0;
}

#profile_form #alter_notice_td{
	padding: 0;
}

#profile_form #alter_notice{
	display: none;
	color: gray;
	font-size: 13px;
	margin: 0;
}

#profile_form #alter_notice_td2{
	padding: 8px 0;
}

#profile_form #alter_notice2{
	color: gray;
	font-size: 13px;
}

#profile_form #button_tr{
	display: flex;
}

#profile_form #alter_button_td {
	padding-left: 0;
}

#profile_form #cf_alter_button_td{
	padding: 0 8px 0 0;
	display: none;
}

#profile_form #alter_cancel_button_td {
	padding: 0;
	display: none;
}

/* email.jsp style */
#search_email_form .form-group {
	width: 50%;
	margin: auto;
}

#search_email_form #name, #search_email_form #phone {
	width: 95%;
}

#search_email_form #name_notice, #search_email_form #phone_notice {
	color: red;
}

#search_email_form #cancel_search_email{
	margin-left: 8px;
}

/* password.jsp style */
#search_pswd_form .form-group {
	width: 50%;
	margin: auto;
}

#search_pswd_form #email, #search_pswd_form #name, #search_pswd_form #phone {
	width: 95%;
}

#search_pswd_form #cancel_search_password{
	margin-left: 8px;
}

#search_pswd_form #email_notice, #search_pswd_form #name_notice,
	#search_pswd_form #phone_notice {
	color: red;
}

/* announcement.jsp */
#container_announcement th, #container_announcement td {
	text-align: center;
}

#container_announcement .thead-light th:nth-child(1) {
	width: 5%;
}

#container_announcement .thead-light th:nth-child(2) {
	width: 8%;
}

#container_announcement .thead-light th:nth-child(4) {
	width: 15%;
}

#container_announcement .thead-light th:nth-child(5) {
	width: 8%;
}

#container_announcement .move{
	color: black;
}

#container_announcement .move:hover{
	color: gray;
}

#container_announcement #notice_Button_div {
	display: flex;
	justify-content: space-between;
}

#container_announcement #delete_notice {
	color: red;
}

#container_announcement #register_announcement {
	margin-left: 8px;
}

#container_announcement .pageInfo_area {
	text-align: center;
}

#container_announcement .pageInfo {
	list-style: none;
	padding: 0;
	margin: 0;
}

#container_announcement .pageInfo_btn {
	display: inline-block;
}

#container_announcement .pageInfo_btn img {
	width: 20px;
	margin-bottom: 5px;
}

#container_announcement .pageInfo_btn a {
	font-size: 18px;
	color: gray;
}

#container_announcement .pageInfo_btn a:hover {
	color: black;
}

#container_announcement .pageInfo li {
	margin-left: 10px;
}

#container_announcement .active {
	color: black !important;
	text-decoration: underline;
}

/* registerAnnouncement.jsp */
#container_register #content {
	resize: none;
}

#container_register #title_notice, #container_register #content_notice {
	color: red;
}

#container_register #notice_Button_div {
	display: flex;
	justify-content: space-between;
}

#container_register #submit_Announcement {
	margin-left: 8px;
}

/* detailAnnouncement.jsp */
#container_detail th {
	background-color: #e9ecef;
	width: 15%;
}

#container_detail th, #container_detail td {
	padding: 15px;
}

#container_detail #announcementTitle_label, #container_detail #announcementContent_label {
	margin: 0;
}

#container_detail #announcementTitle, #container_detail #announcementContent, #container_detail #byteNotice, #container_detail #confirm_button {
	display: none;
}

#container_detail p {
	margin: 0;
}

#container_detail tr:nth-child(2) td {
	white-space: pre-wrap;
}

#container_detail #announcementContent {
	resize: none;
}

#container_detail #notice_Button_div {
	display: flex;
	justify-content: flex-end;
}

#container_detail #alter_button, #container_detail #announcement, #container_detail #confirm_button {
	margin-left: 8px;
}

#container_detail #cancel_alteration{
	display: none;
}
</style>
</head>

<body>
<header id="header" class="fixed-top">
	<div class="container d-flex align-items-center justify-content-between">
		<h3 class="logo">
			<a href="/">Abandoned pet</a>
		</h3>

		<nav id="navbar" class="navbar">
			<ul>
				<c:if test="${loginMember != null || naverLoginMember != null}">
					<li class="dropdown"><a href="#" class="nav-link scrollto ${nav == 'my' ? 'active' : ''}">
						<span>${loginMember.nickname}${naverLoginMember.nickname}<c:if test="${naverLoginMember.nickname == null}">${naverLoginId}</c:if>님</span>
						<i class="bi bi-chevron-down"></i></a>
						<ul>
							<li><a href="/profile">내 프로필</a></li>
							<li><a href="#">Before development</a></li>
						</ul>
					</li>
				</c:if>
				<li><a class="nav-link scrollto ${nav == 'announcement' ? 'active' : ''}" href="/announcement">공지사항</a></li>
				<li><a class="nav-link scrollto " href="#">Before development</a></li>
				<li><a class="nav-link scrollto " href="#">Before development</a></li>
				<c:if test="${loginMember == null && naverLoginMember == null}">
					<li><a class="getstarted scrollto text_deco_none" href="/login" style="${nav == 'login' ? 'background-color: #007bff; color: white;' : ''}">로그인</a></li>
				</c:if>
				<c:if test="${loginMember != null || naverLoginMember != null}">
					<li><a class="getstarted scrollto text_deco_none" href="/logout">로그아웃</a></li>
				</c:if>
				<c:if test="${loginMember == null && naverLoginMember == null}">
						<li><a class="getstarted scrollto text_deco_none" href="/join" style="${nav == 'join' ? 'background-color: #007bff; color: white;' : ''}">회원가입</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</header>
	