<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${result != null }"><!-- 회원임 -->
		<div>
			<span>회원님의 아이디 : ${result.mbrId }</span>
		</div>
		<div>
			<a href="${contextPath }/member/login">로그인</a>
			<a href="${contextPath }/member/forgetIdPwd">비밀번호 찾기</a>
		</div>
	</c:when>
	<c:otherwise><!-- 회원아님 -->
		<div>
			<span>가입된 정보가 없습니다.</span>
		</div>
		<div>
			<a href="${contextPath }/member/register">회원가입</a>
			<a href="${contextPath }/member/forgetIdPwd">아이디 다시 찾기</a>
		</div>
	</c:otherwise>
</c:choose>
</body>
</html>