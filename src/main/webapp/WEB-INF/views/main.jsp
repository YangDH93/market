<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="fileDTO" value="${fileDTO }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
.mainlist {
	width: 1024px;
	margin: 0 auto;
	padding-top: 30px;
	padding-bottom: 16.5px;
	overflow: hidden;
}

.div_st {
	float: left;
	margin: 0 13.5px 13.5px 0;
	border: 1px solid #C0C0C0;
	cursor: pointer;
	width: 192px;
	border-radius: 3px;
}

.div_st:nth-child(5n) {
	float: left;
	margin-right: 0;
}

.imglist {
	width: 192px;
	height: 192px;
}
.mian_list_text{
	padding: 10px;
	font-size: 11pt;
	text-overflow: ellipsis;
}
.main_list_t1st{
	padding-bottom: 10px;
	font-weight: bold;
}
</style>
</head>
<body>
<%@include file="default/header.jsp"%>
	<div class="mainlist">
		<c:forEach var="prod_dto" items="${mainAllView }" varStatus="status" >
		<div class="div_st" onclick="location.href='${contextPath }/product/prodTrade?prodId=${prod_dto.prodId}&hit=${prod_dto.hit}&prodDate=${prod_dto.prodDate}&prodStat=${prod_dto.prodStat}';">
			<img class="imglist" src="${contextPath}/product/display?fileName=${filePath[status.index]}"/>
			<div class="mian_list_text">
				<div class="main_list_t1st">${prod_dto.prodTitle }</div>
				<div>
					<span>${prod_dto.price } 원</span>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
<%@include file="default/footer.jsp"%>
</body>
</html>