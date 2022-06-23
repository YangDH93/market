<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>REGISTER MODIFY</h1>
	<table>
		<tr>
			<td>닉네임</td>
			<td><input type="text" placeholder="닉네임 입력"></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" placeholder="아이디 입력"></td>
		</tr>
			<tr>
			<td>이메일</td>
			<td><input type="text" placeholder="이메일 입력"></td>
			</tr>
		<tr>
			<td rowspan="3">비밀번호</td>
			<td><input type="text" placeholder="현재 비밀번호 입력"></td>
		</tr>
		<tr>
			<td><input type="text" placeholder="새 비밀번호 입력"></td>
		</tr>
		<tr>
			<td><input type="text" placeholder="비밀번호 확인"></td>
		</tr>
		<tr>
			<td align="right" colspan="2"><br><input type="button" value="확인"><br></td>
		</tr>
		
		
	</table>
	<hr>
	
	<input type="submit" value="수정">
	
	<h6 align="right">탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.
	<input type="button" value="회원탈퇴">
	</h6>
	
	

</body>
</html>