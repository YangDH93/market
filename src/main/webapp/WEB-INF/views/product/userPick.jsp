<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
#td_st{
	width: 150px;
	height: 150px;
	vertical-align: middle;
}
</style>
</head>
<jsp:include page="../default/header.jsp"/>
<body>
<div class="wrap_manage" style="min-width: 1024px; width: 1024px; margin: 0 auto;">
	<!-- 페이지 메뉴바 상품관리/구매판매내역 -->
	<jsp:include page="../default/prodNav.jsp"/>
<!-- 목록 : 테이블형식 -->
<div class="prodTable_st" style="text-align: center;">
	<table border="1" style="border-color: #C0C0C0; width: 100%;
	border-collapse: collapse; table-layout: fixed;">
		<!-- 테이블 머리 -->
		<thead style="background-color: #FFB300; border-color: #FFB300; color: white; font-weight: 600;">
			<tr>
				<th>사진</th> <th>판매상태</th> <th>상품명</th>
				<th>가격</th>
				<c:if test="${loginUser != 'admin' }">
					<th>기능</th>
				</c:if>
			</tr>
		</thead>
		<!-- 테이블 몸통(내용 리스트로 가져옴) -->
		<tbody>
			<!-- DB에서 반복문으로 데이터 list로 가져올때 사용 -->
			<c:choose>
				<c:when test="${pickList.size() == 0}">
					<tr>
						<c:choose>
							<c:when test="${loginUser != 'admin' }">
								<th colspan="6" align="center" style="padding: 30px 30px">
									찜 목록이 존재하지 않습니다.
								</th>
							</c:when>
							<c:otherwise>
								<th colspan="5" align="center" style="padding: 30px 30px">
									찜 목록이 존재하지 않습니다.
								</th>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:when>
			<c:otherwise>
				<c:forEach var="psdto" items="${pickList }" varStatus="status">
					<tr>
						<td id="td_st">
							<div>
								<img width="100%" height="150" src="${contextPath}/product/display?fileName=${filePath[status.index]}"
								style="vertical-align: bottom;"/>
							</div>
						</td> 
						<td id="td_st">
							<c:choose>
								<c:when test="${psdto.prodStat != 1 }">
									판매중
								</c:when>
								<c:otherwise>
									판매완료
								</c:otherwise>
							</c:choose>
						</td>
						<td id="td_st" class="td_title_st" style="cursor: pointer;"
						onclick= "location.href='${contextPath }/product/prodTrade?prodId=${psdto.prodId}&hit=${psdto.hit}&prodDate=${psdto.prodDate}&prodStat=${psdto.prodStat}'">
						<div align="center">
							<div>
								<span style="text-decoration: none; color: #551A8B; overflow: hidden;
							white-space: nowrap; text-overflow: ellipsis; width: 150px;
							display: block;">${psdto.prodTitle }
								</span>
						</div>
							</div>
						</td>
						<td id="td_st" style="text-align: center;">${psdto.price}원</td> 
						<td id="td_st">
							<div class="td_pbtn_st">
								<button onclick="location.href='${contextPath}/product/pickDelete?prodId=${psdto.prodId}&mbrId=${psdto.mbrId}'">
									삭제
								</button>
							</div>
						</td>
					</tr>
				</c:forEach> 
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
	
<!-- 페이징 처리 -->
<div class="" style="text-align: center; padding: 20px 0; ">
	<a href="#" style="color: #000000; text-decoration: none;">&laquo;</a>
			<c:forEach var="num" begin="1" end="${repeat }">
				<a href="prodStatus?num=${num }" style="color: #000000; text-decoration: none;">${num }</a>
			</c:forEach>
	<a href="#" style="color: #000000; text-decoration: none;">&raquo;</a>
</div>

</div><!-- wrap끝 -->
<!-- footer -->
<jsp:include page="../default/footer.jsp"/>

</body>
</html>