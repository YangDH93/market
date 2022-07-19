<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../default/header.jsp" %>
<div>
	<div><!-- 채팅목록 -->
		<div>
		<h1>판매 채팅 목록</h1>
			<c:forEach var="sellList" items="${sellList}">
				<div>
					<a href="${contextPath}/chat.do?bang_id=${sellList.bangId}">
						${sellList.buyerId}님과의 채팅
					</a>
				</div>
			</c:forEach>
		</div>
		<div>
		<h1>구매 채팅 목록</h1>
			<c:forEach var="buyList" items="${buyList}">
				<div>
					<a href="${contextPath}/chat.do?bang_id=${buyList.bangId}">
						${buyList.buyerId}님과의 채팅
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

	
	
<%@ include file="../default/footer.jsp" %>
</body>
</html>