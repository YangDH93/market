<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>REGISTER</h1>
<form id="fo" action="reg" method="post">
	<input type="text" placeholder="닉네임" name="mbrName" id="mbrName">
	<input type="button" value="중복확인"><br>
	<input type="text" placeholder="아이디" name="mbrId" id="mbrId">
	<input type="button" value="중복확인"><br>
	<input type="text" placeholder="비밀번호" name="mbrPw" id="mbrPw"><br>
	<input type="text" placeholder="비밀번호 확인" id="pwChk"><br>
	<input type="email" placeholder="이메일" name="mbrEmail" id="mbrEmail">
	<input type="button" value="인증">
	<hr>
	<input type="submit" value="가입하기"><br>
</form>
</body>
</html>