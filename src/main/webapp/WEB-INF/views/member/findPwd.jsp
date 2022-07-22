<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
console.log(${mbrPw });
</script>
</head>
<body>
<div>
이메일 발송을 완료했습니다.<br>
로그인 후 임시 비밀번호를 반드시 변경해 주세요.<br>
<a href="${contextPath }/member/login">로그인</a>
</div>
</body>
</html>