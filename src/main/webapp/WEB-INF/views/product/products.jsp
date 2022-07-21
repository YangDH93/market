<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
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
}
.main_list_t1st{
	padding-bottom: 10px;
	font-weight: bold;
	width: 180px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
.price_st{
	width: 180px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
</style>
</head>
<body>
<%@include file="../default/header.jsp" %>
<div class="mainlist">
	<c:choose>
		<c:when test="${prodList.size() == 0}">
			<div style="text-align: center; font-weight: 500; padding-bottom: 20px;">
				일치하는 결과가 존재하지 않습니다.
			</div>	
		</c:when>
		<c:otherwise>
			<c:forEach var="productDTO" items="${prodList }" varStatus="status">
				<div class="div_st" onclick="location.href='${contextPath }/product/prodTrade?prodId=${productDTO.prodId}&hit=${productDTO.hit}&prodDate=${productDTO.prodDate}&prodStat=${productDTO.prodStat}';">
					<img class="imglist" src="${contextPath}/product/display?fileName=${filePath[status.index]}"/>
					<div class="mian_list_text">
						<div class="main_list_t1st">${productDTO.prodTitle }</div>
						<div class="price_st">
							<span>${productDTO.price } 원</span>
						</div>
					</div>
				</div>				
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
<%@include file="../default/footer.jsp" %>			
</body>
</html>