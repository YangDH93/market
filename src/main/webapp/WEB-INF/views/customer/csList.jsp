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
:link { color: #FF8000; }
:visited { color: #551A8B; }
</style>
</head>
<body>
<%@include file="../default/header.jsp" %>
<section class="eeRGVw">
	<div>
			<h1 style="font-size: 1.5rem; margin-bottom: 1.5rem;">문의게시판</h1>
	</div>
	<!-- 목록 : 테이블형식 -->
	<div class="">
		<table style="border-top: 1px solid #FFA200;
						border-collapse: collapse; width: 100%">
			<!-- 테이블 머리 -->
			<thead style="border-bottom: 1px solid #FFA200;
			font-weight: 600; color: white; background-color: #FFB300;">
				<tr>
					<th>작성자</th> 
					<th>제목</th>
					<th>작성날짜</th> <th>답변여부</th>
				</tr>
			</thead>
			<!-- 테이블 몸통(내용 리스트로 가져옴) -->
			<tbody style="border-bottom: 1px solid #FFA200">
				<!-- DB에서 반복문으로 데이터 list로 가져올때 사용 -->
					<c:choose>
					<c:when test="${csList.size() == 0}">
						<tr>
							<td colspan="4" align="center" style="padding: 30px 30px;">
								<b>작성된 글이 존재하지 않습니다.</b>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="csdto" items="${csList }">
							<tr>
								<td align="center" style="padding: 10px 10px;">${csdto.mbrId }</td> 
								<td align="center">
									<a href="${contextPath }/customer/csView?csNum=${csdto.csNum}"
									style="text-decoration: none;">
										${csdto.csTitle}
									</a>
								</td>
								<td align="center">${csdto.date}</td> 
								<td align="center">${csdto.replyStat}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
					</c:choose>
			</tbody>
			<tr>
				<td colspan="4" align="right">
					<input type="button" value="문의글 작성"
					style="cursor: pointer; font-weight: 600;
					margin-top: 20px; background-color: #FFA200; color: white; border: 0px; border-radius: 5px; padding: 3px;"
					onclick="location.href='${contextPath}/customer/csWriteForm?mbrId=${loginUser }'">
				</td>
			</tr>
		</table>
	</div>
		
	<!-- 페이징 처리 -->
	<div class="" style="text-align: center; padding: 20px 0; ">
			<a href="#" style="color: black; text-decoration: none;">&laquo;</a>
				<c:forEach var="num" begin="1" end="${repeat }">
					<a href="csList?num=${num }" style="color: black; text-decoration: none;">
					${num }</a>
				</c:forEach>
			<a href="#" style="color: black; text-decoration: none;">&raquo;</a>
	</div>
</section>
<%@include file="../default/footer.jsp" %>
</body>
</html>