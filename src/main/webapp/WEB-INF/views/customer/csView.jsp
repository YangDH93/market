<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageContext" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%@include file="../default/header.jsp" %> --%>
<section class="eeRGVw">
<table border="1" style="width: 70%; margin: auto;">
	<tr>
		<th>제목</th> <th>작성날짜</th>
	</tr>
	<tr>
		<td>제목입니다</td> <td>날짜가져옴</td>
	</tr>
	<tr>
		<td colspan="2">내요옹</td>
	</tr>
	<!-- 이미지 있을 경우 처리할것 -->
	<tr>
		<td colspan="2">이미지<img alt=""	src=""></td>
	</tr>
</table>
</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>