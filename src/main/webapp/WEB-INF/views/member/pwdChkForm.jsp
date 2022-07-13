<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
//비밀번호 입력 체크
function inputChk(){
	if( document.getElementById("mbrPw").value == ""){
		alert("현재 비밀번호를 입력해 주세요");
		mbrPw.focus();
	}else{
		fo.submit();
	}
}

</script>
</head>
<body>
	<c:set var="dto" value="${mbrInfo }"/>
	<form id="fo" action="pwdChk" method="post">
		<input type="text" readonly value="${dto.mbrId }" name="mbrId"><br>
		<input type="text" name="mbrPw" id="mbrPw" placeholder="현재 비밀번호 입력"><br>
		<input type="button" onclick="inputChk()" value="제출">
	</form>
</body>
</html>