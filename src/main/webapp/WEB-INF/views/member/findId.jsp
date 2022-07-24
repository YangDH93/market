<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
.ast{
	text-decoration: none;
	background-color: #FFFFFF;
	border: 2px solid #FFA200;
	color: #414141;
	border-radius: 5px;
	padding: 3px;
	font-weight: 600;
}
</style>
</head>
<body>
<c:choose>
	<c:when test="${result != null }"><!-- 회원임 -->
		<div style="display: flex; justify-content: center; margin-top: 50px;
		font-size: 30px; font-weight: bold;">
			<span>회원님의 아이디 : ${result.mbrId }</span>
		</div>
		<div style="display: flex; justify-content: center; margin-top: 50px;">
			<a href="${contextPath }/member/login" class="ast">로그인</a>
			<a href="${contextPath }/member/forgetIdPwd" class="ast"
			style="margin-left: 20px;">비밀번호 찾기</a>
		</div>
	</c:when>
	<c:otherwise><!-- 회원아님 -->
		<div style="display: flex; justify-content: center; margin-top: 50px;
		font-size: 30px; font-weight: bold;">
			<span>가입된 정보가 없습니다.</span>
		</div>
		<div style="display: flex; justify-content: center; margin-top: 30px;" >
			<a href="${contextPath }/member/register" class="ast">회원가입</a>
			<a href="${contextPath }/member/forgetIdPwd" class="ast"
			style="margin-left: 20px;">아이디 다시 찾기</a>
		</div>
	</c:otherwise>
</c:choose>
</body>
</html>