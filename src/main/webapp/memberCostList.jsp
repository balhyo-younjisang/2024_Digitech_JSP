<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<MemberVO> list = (ArrayList<MemberVO>) request.getAttribute("list");
list.forEach(vo -> {
	if (vo.getGrade().equals("A"))
		vo.setGrade("VIP");
	else if (vo.getGrade().equals("B"))
		vo.setGrade("일반");
	else
		vo.setGrade("직원");
});
%>
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
	display: flex;
	align-items: center;
	flex-direction: column;
}

.title_wrap {
	text-align: center;
}

.title {
	line-height: 70px;
	font-weight: bold;
	font-size: 35px;
}

table {
	text-align: center;
}

table td {
	padding: 0 50px;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<section>
		<div class="title_wrap">
			<p class="title">회원목록조회/수정</p>
		</div>
		<table border="1">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>
			</tr>
			<%
			for (int i = 0; i < list.size(); i++) {
				MemberVO vo = list.get(i);
			%>
			<tr>
				<td><%=vo.getCustno()%></td>
				<td><%=vo.getCustname()%></td>
				<td><%=vo.getGrade()%></td>
				<td><%=vo.getPrice()%></td>
			</tr>
			<%
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>