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
.mainlist {
	width: 1024px;
	white-space: nowrap;
	display: flex;
	justify-content: center;
	margin: auto;
	overflow: hidden;
	flex-flow: wrap;
}

.imglist {
	width: 183px;
	height: 183px;
	cursor: pointer;
	border-radius: 3px;
}

.div_st {
	border: 1px solid black;
	margin: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
<%@include file="default/header.jsp"%>
	<div class="mainlist">
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist" src="${contextPath}/resources/image/nothing.png"></img>
			<br> <input type="text" style="width: 180px;"><br>
			<input type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
		<div class="div_st"
			onclick="location.href='#';">
			<img class="imglist"
						src="${contextPath}/resources/image/nothing.png"></img> <br>
			<input type="text" style="width: 180px;"><br> <input
				type="text" style="width: 180px;">
		</div>
	</div>
<%@include file="default/footer.jsp"%>
</body>
</html>