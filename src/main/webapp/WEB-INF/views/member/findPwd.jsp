<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<script type="text/javascript">
console.log(${mbrPw });
</script>
</head>
<body>
<div style="display: flex; justify-content: center;">
	<table style="border-spacing: 0; margin-top: 50px;">
		<tr>
			<td align="center" width="500" height="40" style="font-size: 30px; font-weight: bold;">
				이메일 발송을 완료했습니다.
			</td>
		</tr>
		<tr>
			<td align="center" width="500" height="20" style="font-size: 13px; color: red;">
				로그인 후 임시 비밀번호를 반드시 변경해 주세요.
			</td>
		</tr>
		<tr>
			<td align="center" width="500" height="60">
				<a href="${contextPath }/member/login"
					style="text-decoration: none; background-color: #FFFFFF;
					border: 2px solid #FFA200; color: #414141; border-radius: 5px;
					padding: 3px; font-weight: 600;">로그인</a>
				</td>
		</tr>
	</table>
</div>
</body>
</html>