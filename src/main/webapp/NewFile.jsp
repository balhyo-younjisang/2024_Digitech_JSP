<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html, body {
	width: 100%;
	height: 100%;
}

a {
	color: inherit;
	text-decoration: none;
}


ul, li {
	list-style: none;
}

section {
	width: 100%;
	height: calc(100% - 180px);
}

.title_wrap {
	text-align: center;
}

.title {
	font-size: 20px;
	line-height: 50px;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<section>
		<div class="title_wrap">
			<p class="title">쇼핑몰회원관리프로그램</p>
		</div>
		<p>쇼핑몰 회원정보와 회원매출정보데이터베이스를 구축하고 회원관리 프로그램을 작성하는 프로그램이다.</p>
		<ul>
			<p>프로그램 작성 순서</p>
			<li>회원정보 테이블을 생성한다.</li>
			<li>매출정보 테이블을 생성한다.</li>
			<li>회원정보, 매출정보 테이블에 제시된 문제지의 참조 데이터를 추가 생성한다.</li>
			<li>회원정보 입력 화면 프로그램을 작성한다.</li>
			<li>회원정보 조회 화면 프로그램을 작성한다.</li>
			<li>회원매출정보 조회 프로그램을 작성한다.</li>
		</ul>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>