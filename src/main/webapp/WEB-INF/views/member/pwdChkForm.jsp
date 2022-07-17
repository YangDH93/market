<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<title>오!리!마!켓!</title>
<meta charset="UTF-8">
<script type="text/javascript">
	//비밀번호 입력 체크
	function inputChk() {
		if (document.getElementById("mbrPw").value == "") {
			alert("현재 비밀번호를 입력해 주세요");
			mbrPw.focus();
		} else {
			fo.submit();
		}
	}
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
		<img style="width: 400px;"
			src="${contextPath}/resources/image/duck.png" onclick="location.href='http://localhost:8085/root/'"/>
	</div>
	<div class="pwdC">
		<c:set var="dto" value="${mbrInfo }" />
		<form id="fo" action="pwdChk" method="post">
			<input type="text" class="inip" readonly value="${dto.mbrId }" name="mbrId"><br>
			<input type="password" class="inip" name="mbrPw" id="mbrPw" placeholder="현재 비밀번호 입력"><br>
			<input type="button" onclick="inputChk()" value="제출"
				style="cursor:pointer; font-size: 18px; width: 388px; height: 60px;
				background-color: #FFA200; border-radius: 10px; border: 0px;
				color: #FFFFFF; font-weight: 500; margin-left: 1px; margin-top: 30px;">
		</form>
	</div>
</body>
</html>