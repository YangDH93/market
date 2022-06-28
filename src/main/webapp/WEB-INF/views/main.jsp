<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
</head>
<body>
<%@include file="default/header.jsp" %>
			<div class="iWIYdZ">
				<div class="fzXIGc"><!-- 이미지 슬라이드 -->
					<div class="slick-slider" dir="ltr">
						<div class="slick-list">
							슬라이드 광고 이미지
						</div>
					</div>
				</div>
				<div class="cVIMCT"> <!-- 고정 광고 배너 -->
					고정 광고 배너
				</div>
				<section class="eeRGVw">
					<h2>오늘의 상품 추천</h2>
					<div class="eIZYPa">
						<div class="dSYEIN">
							<div class="cXyXMN">
								상품 이미지들
							</div>
						</div>
					</div>
				</section>
			</div>
<%@include file="default/footer.jsp" %>			
</body>
</html>