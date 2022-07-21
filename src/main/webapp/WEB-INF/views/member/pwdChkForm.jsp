<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<title>오!리!마!켓!</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
//비밀번호 입력 체크
$(document).ready(function() {
	$("#chkIn_btn").click(function() {
		if ($("#mbrPw").val().length == 0) {
			alert("현재 비밀번호를 입력해 주세요");
			$("#mbrPw").focus();
			return false;
		}
	});
});
</script>
<style type="text/css">
.pwdC {
	display: flex;
	justify-content: center;
}

.inip {
	outline-style: none;
	border-color: #FFA200;
	border-top: none;
	border-left: none;
	border-right: none;
	margin-bottom: 30px;
	width: 380px;
	font-size: 18px;
	padding: 5px;
}
</style>
</head>
<body>
	<div style="display: flex; justify-content: center; margin-top: 130px;">
		<img style="width: 400px; cursor: pointer;"
			src="${contextPath}/resources/image/duck.png" onclick="location.href='${contextPath}'"/>
	</div>
	<div class="pwdC">
		<c:set var="dto" value="${mbrInfo }" />
		<form id="fo" action="pwdChk" method="post">
			<input type="text" class="inip" readonly value="${dto.mbrId }" name="mbrId"><br>
			<input type="password" class="inip" name="mbrPw" id="mbrPw" autofocus placeholder="현재 비밀번호 입력"><br>
			<input type="submit" value="확인" id="chkIn_btn"
				style="cursor:pointer; font-size: 18px; width: 388px; height: 60px;
				background-color: #FFA200; border-radius: 10px; border: 0px;
				color: #FFFFFF; font-weight: 500; margin-left: 1px; margin-top: 30px;">
		</form>
	</div>
</body>
</html>