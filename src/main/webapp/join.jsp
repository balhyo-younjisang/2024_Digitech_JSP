<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberVO vo = (MemberVO) request.getAttribute("vo");
String alert = (String) request.getAttribute("alert");
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
	if (alert != null) {
	%>
	<script>
		alert("<%=alert%>
		");
	</script>
	<%
	}
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<section>
		<div class="title_wrap">
			<p class="title">홈쇼핑 회원 등록</p>
		</div>
		<form action="JoinMemberCtrl" method="POST">
			<table border="1">
				<tr>
					<td>
						<p>회원번호(자동발생)</p>
					</td>
					<td><input value="<%=vo != null ? vo.getCustno() : ""%>"
						disabled name="custno"></td>
				</tr>
				<tr>
					<td>
						<p>회원성명</p>
					</td>
					<td><input type="text" name="custname"></td>
				</tr>
				<tr>
					<td>
						<p>회원전화</p>
					</td>
					<td><input type="tel" name="phone" maxlength="13" id="phone">
					</td>
				</tr>
				<tr>
					<td>
						<p>회원주소</p>
					</td>
					<td><input type="text" maxlength="60" name="address"></td>
				</tr>
				<tr>
					<td>
						<p>가입일자</p>
					</td>
					<td><input type="text" name="date"></td>
				</tr>
				<tr>
					<td>
						<p>고객등급(A:VIP,B:일반,C:직원)</p>
					</td>
					<td><input type="text" name="grade"></td>
				</tr>
				<tr>
					<td>
						<p>도시코드</p>
					</td>
					<td><input type="text" name="city"></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">등록</button>
						<button>
							<a href="GetMemberCtrl">조회</a>
						</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
	<script>
    window.onload = () => document.getElementById("phone").addEventListener("keyup", function (event) {
      inputPhoneNumber(event.target);
    });

    function inputPhoneNumber(phone) {
    if(phone.value.length > 13) return;

      if (event.keyCode != 8) {
        const regExp = new RegExp(/^[0-9]{2,3}-^[0-9]{3,4}-^[0-9]{4}/g);
        if (phone.value.replace(regExp, "").length != 0) {
          if (checkPhoneNumber(phone.value) == true) {
            let number = phone.value.replace(/[^0-9]/g, "");
            let tel = "";
            let seoul = 0;
            if (number.substring(0, 2).indexOf("02") == 0) {
              seoul = 1;
              phone.setAttribute("maxlength", "12");
              console.log(phone);
            } else {
              phone.setAttribute("maxlength", "13");
            }
            if (number.length < (4 - seoul)) {
              return number;
            } else if (number.length < (7 - seoul)) {
              tel += number.substr(0, (3 - seoul));
              tel += "-";
              tel += number.substr(3 - seoul);
            } else if (number.length < (11 - seoul)) {
              tel += number.substr(0, (3 - seoul));
              tel += "-";
              tel += number.substr((3 - seoul), 3);
              tel += "-";
              tel += number.substr(6 - seoul);
            } else {
              tel += number.substr(0, (3 - seoul));
              tel += "-";
              tel += number.substr((3 - seoul), 4);
              tel += "-";
              tel += number.substr(7 - seoul);
            }
            phone.value = tel;
          } else {
            const regExp = new RegExp(/[^0-9|^-]$/);
          }
        }
      }
    }

    function checkPhoneNumber(number) {
      const regExp = new RegExp(/^[0-9|-]$/);
      if (regExp.test(number) == true) {return true;}
      else {return false;}
    }
  </script>
</body>
</html>