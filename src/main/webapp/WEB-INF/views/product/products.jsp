<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title><!-- 검색상품 조회 페이지 -->
</head>
<body>
<%@include file="../default/header.jsp" %>
			<div class="iWIYdZ">
				<section class="eeRGVw">
					<h2>오늘의 상품 추천</h2>
					<div class="eIZYPa">
						<div class="dSYEIN">
							<div class="cXyXMN">
								상품 이미지들
								<c:forEach var="key" items="${keyList }">
									${key.prodTitle }
								</c:forEach>
							</div>
						</div>
					</div>
				</section>
			</div>
<%@include file="../default/footer.jsp" %>
</body>
</html>