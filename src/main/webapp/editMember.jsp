<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberVO vo = (MemberVO) request.getAttribute("vo");
String alertMsg = (String) request.getAttribute("alertMsg");
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
}

.title_wrap {
	text-align: center;
}

.title {
	font-size: 20px;
	line-height: 50px;
}

form {
	display: flex;
	align-items: center;
	justify-content: center;
}

table {
	text-align: center;
}

table tr, td {
	width: 300px;
}

table td {
	font-weight: bold;
}
</style>
</head>
<body>
	<%
	if (alertMsg != null && vo == null) {
	%>
	<script>
		alert("<%=alertMsg%>
		");
	</script>
	<%
	response.sendRedirect("NewFile.jsp");
	}
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<section>
		<div class="title_wrap">
			<p class="title">홈쇼핑 회원 등록</p>
		</div>
		<form action="EditMemberCtrl?custno=<%=vo.getCustno()%>"
			method="POST">
			<table border="1">
				<tr>
					<td>
						<p>회원번호(자동발생)</p>
					</td>
					<td><input value="<%=vo.getCustno()%>" disabled name="custno"></td>
				</tr>
				<tr>
					<td>
						<p>회원성명</p>
					</td>
					<td><input type="text" name="custname"
						value="<%=vo.getCustname()%>"></td>
				</tr>
				<tr>
					<td>
						<p>회원전화</p>
					</td>
					<td><input type="tel" name="phone" maxlength="13" id="phone"
						value="<%=vo.getPhone()%>"></td>
				</tr>
				<tr>
					<td>
						<p>회원주소</p>
					</td>
					<td><input type="text" maxlength="60" name="address"
						value="<%=vo.getAddress()%>"></td>
				</tr>
				<tr>
					<td>
						<p>가입일자</p>
					</td>
					<td><input type="text" name="date"
						value="<%=vo.getJoindate()%>" disabled></td>
				</tr>
				<tr>
					<td>
						<p>고객등급(A:VIP,B:일반,C:직원)</p>
					</td>
					<td><input type="text" name="grade" value="<%=vo.getGrade()%>"></td>
				</tr>
				<tr>
					<td>
						<p>도시코드</p>
					</td>
					<td><input type="text" name="city" value="<%=vo.getCity()%>"></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
						<button>
							<a href="GetMemberCtrl">조회</a>
						</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>