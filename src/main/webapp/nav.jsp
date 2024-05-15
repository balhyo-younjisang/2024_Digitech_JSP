<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
nav {
	width: 100%;
}

nav .gnb {
	width: 100%;
	height: 40px;
	line-height: 30px;
	font-size: 14px;
	display: flex;
	align-items: center;
	background-color: #41416c;
	color: white;
}

nav .gnb a {
	transition: .3s
}

nav .gnb a:hover {
	color: #b0b0ff;
}
</style>
<nav>
	<ul class="gnb">
		<li><a href="GetJoinMemberCtrl">회원등록</a></li>
		<li><a href="#">회원목록조회/수정</a></li>
		<li><a href="#">회원매출조회</a></li>
		<li><a href="#">홈으로</a></li>
	</ul>
</nav>