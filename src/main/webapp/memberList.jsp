<%@page import="java.text.SimpleDateFormat"%>
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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

.custno {
	color: white;
	text-shadow: 1px 1px 1px black;
}

table {
	text-align: center;
}

table td {
	padding: 0 50px;
	font-weight: bold;
}
</style>
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
				<th>전화번호</th>
				<th>회원주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			<%
			for (int i = 0; i < list.size(); i++) {
				MemberVO vo = list.get(i);
			%>
			<tr>
				<td class="custno"><a href="EditMemberCtrl?custno=<%=vo.getCustno()%>"><%=vo.getCustno()%></a></td>
				<td><%=vo.getCustname()%></td>
				<td><%=vo.getPhone()%></td>
				<td><%=vo.getAddress()%></td>
				<td><%=sdf.format(vo.getJoindate())%></td>
				<td><%=vo.getGrade()%></td>
				<td><%=vo.getCity()%></td>
			</tr>
			<%
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>