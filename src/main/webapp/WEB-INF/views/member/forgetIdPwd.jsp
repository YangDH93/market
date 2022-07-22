<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
</head>
<body>
<div>
	<form action="${contextPath }/member/findId" method="post">
		<div>아이디 찾기</div>
		이메일 주소 입력 : <input name="mbrEmail" type="text">
		<button type="submit">확인</button>
	</form>
</div>
<hr>
<div>
	<form action="${contextPath }/member/findPwd" method="post">
		<div>비밀번호 찾기</div>
		<div>회원 가입시 작성한 이메일 주소를 입력하면 해당 이메일로 임시 비밀번호를 발송해 드립니다.</div>
		이메일 주소 입력 : <input name="mbrEmail" type="text">
		<button type="submit">확인</button>
	</form>
</div>
</body>
</html>