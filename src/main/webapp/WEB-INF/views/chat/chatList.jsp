<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
</head>
<body>
<%@include file="../default/header.jsp" %>
<div class="wrap_manage" style="min-width: 1024px; width: 1024px; margin: 0 auto;">
	<!-- 페이지 메뉴바 판매/구매 채팅 목록 -->
	<jsp:include page="../default/chatListNav.jsp"/>

	<div class="chatTitle">
		<span id="chat_sell_top">판매 채팅 목록</span>
	</div>
	<div class="chat_table">
		<table border=1 style="border-collapse: collapse; width: 100%">
			<!-- 테이블 머리 -->
			<thead style="background-color: #FFB300; color: white;
			font-weight: 600;">
				<tr>
					<td width="20%">판매상태</td> <td width="60%">채팅방</td> <td width="20%">기능</td>
				</tr>
			</thead>
			<!-- 테이블 몸통(내용 리스트로 가져옴) -->
			<tbody style="border-bottom: 1px solid black">
				<c:choose>
				
					<c:when test="${sellList.size() == 0 }">
						<tr>
							<th colspan="5" align="center" style="padding: 30px 30px">
								<div>판매 채팅 목록이 없습니다.</div>
								<a class="click_main" href="${contextPath}/product/prodNew"
									title="오리마켓 상품등록 페이지로 이동합니다">[ 오리마켓 상품 등록하기  ]</a>
						</tr>
					</c:when>
					
					<c:otherwise>
						<c:forEach var="sellList" items="${sellList}" varStatus="status">
							<tr>
								<td>
									<c:choose>
										<c:when test="${sProdList[status.index].prodStat == 1 }">
											판매완료
										</c:when>
										<c:otherwise>
											판매중
										</c:otherwise>
									</c:choose>
								</td>
								
								<td class="chatRoomIn" onclick="location.href='${contextPath}/chat.do?bang_id=${sellList.bangId}'">
									[ ${sProdList[status.index].prodTitle } ] 구매자 ${sellList.buyerName}님
								</td>
								
								<td>
									<button onclick="location.href='${contextPath}/updateSB?bangId=${sellList.bangId}'"
									style="color: #414141;">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
					
				</c:choose>
			</tbody>
		</table>
	</div><!-- sellChat End -->

	<div class="chatTitle">
		<span id="chat_buy_top">구매 채팅 목록</span>
	</div>
	<div class="chat_table">
		<table style="border-top: 2px solid black;
						border-collapse: collapse; width: 100%">
			<!-- 테이블 머리 -->
			<thead style="border-bottom: 2px solid black; ">
				<tr>
					<td width="20%">판매상태</td> <td width="60%">채팅방</td> <td width="20%">기능</td>
				</tr>
			</thead>
			<!-- 테이블 몸통(내용 리스트로 가져옴) -->
			<tbody style="border-bottom: 1px solid black">
				<c:choose>
				
					<c:when test="${buyList.size() == 0 }">
						<tr>
							<th colspan="5" align="center" style="padding: 30px 30px">
								<div>구매 채팅 목록이 없습니다.</div>
								<a class="click_main" href="${contextPath}"
									title="오리마켓 메인 페이지로 이동합니다">[ 오리마켓 둘러보기 ]</a>
						</tr>
					</c:when>
					
					<c:otherwise>
						<c:forEach var="buyList" items="${buyList}" varStatus="status">
							<tr>
								<td>
									<c:choose>
										<c:when test="${bProdList[status.index].prodStat == 1 }">
											판매완료
										</c:when>
										<c:otherwise>
											판매중
										</c:otherwise>
									</c:choose>
								</td>
								<td class="chatRoomIn" onclick="location.href='${contextPath}/chat.do?bang_id=${buyList.bangId}'">
									[ ${bProdList[status.index].prodTitle } ] 판매자 ${buyList.sellerName}님
								</td>
								<td>
									<button onclick="location.href='${contextPath}/updateBB?bangId=${buyList.bangId}'"
									style="color: #414141;">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
					
				</c:choose>
			</tbody>
		</table>
	</div><!-- buyChat End -->
	
</div><!-- wrap End -->
<%@ include file="../default/footer.jsp" %>
</body>
</html>