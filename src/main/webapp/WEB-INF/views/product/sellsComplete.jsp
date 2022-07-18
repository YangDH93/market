<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td{
	text-align: center;
}
</style>
</head>
<jsp:include page="../default/header.jsp"/>
<body>
<div class="wrap_manage" style="min-width: 1024px; width: 1024px; margin: 0 auto;">
	<!-- 페이지 메뉴바 상품관리/구매판매내역 -->
	<jsp:include page="../default/prodNav.jsp"/>
<!-- 목록 : 테이블형식 -->
<div class="" >
	<table style="border-top: 2px solid black;
					border-collapse: collapse; width: 100%">
		<!-- 테이블 머리 -->
		<thead style="border-bottom: 2px solid black; ">
			<tr>
				<th>사진</th> <th>판매상태</th> <th>상품명</th>
				<th>가격</th> <th>찜</th> 
			</tr>
		</thead>
		<!-- 테이블 몸통(내용 리스트로 가져옴) -->
		<tbody style="border-bottom: 1px solid black">
			<!-- DB에서 반복문으로 데이터 list로 가져올때 사용 -->
			<c:choose>
				<c:when test="${psList.size() == 0}">
					<tr>
						<th colspan="5" align="center" style="padding: 30px 30px">
							 판매완료된 상품이 존재하지 않습니다.
						</th>
					</tr>
				</c:when>
			<c:otherwise>
				<c:forEach var="psdto" items="${psList }" varStatus="status">
					<tr>
						<td>
							<img width="100px" height="100px" src="${contextPath}/product/display?fileName=${filePath[status.index]}"/>
						</td> 
						<td>
							<c:choose>
								<c:when test="${psdto.prodStat != 1 }">
									판매중
								</c:when>
								<c:otherwise>
									판매완료
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<a href="${contextPath }/product/prodTrade?prodId=${psdto.prodId}&hit=${psdto.hit}&prodDate=${psdto.prodDate}&prodStat=${psdto.prodStat}">
								${psdto.prodTitle }
							</a>
						</td>
						<td>${psdto.price}</td> 
						<td>${pickTotal[status.index] }</td> 
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
	
<!-- 페이징 처리 -->
<div class="" style="text-align: center; padding: 20px 0; ">
	<a href="#">&laquo;</a>
			<c:forEach var="num" begin="1" end="${repeat }">
				<a href="sellsComplete?num=${num }">[${num }]</a>
			</c:forEach>
	<a href="#">&raquo;</a>
</div>

</div><!-- wrap끝 -->
<!-- footer -->
<jsp:include page="../default/footer.jsp"/>

</body>
</html>