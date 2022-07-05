<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../default/header.jsp" %>
				<section class="eeRGVw">
					<div class="eIZYPa">
						<div class="dSYEIN">
							<div class="cXyXMN">
								<div align="center"> <!-- 테이블전용 div -->
								<table border="1">
									<tr>
										<th>글작성자</th>
										<th>글제목</th>
										<th>글내용</th>
										<th>게시날짜</th>
										<th>상품번호</th>
										<th>가격</th>
										<th>조회수</th>
										<th>거래장소</th>
									</tr>
								<c:choose>
									<c:when test="${prodList.size() == 0}">
										<tr>
											<td colspan="8">
												<b>일치하는 결과가 존재하지 않습니다.</b>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="productDTO" items="${prodList }">
											<tr>
												<td>${productDTO.mbrId }</td>
												<td>${productDTO.prodTitle}</td>
												<td>${productDTO.prodContent}</td>
												<td>${productDTO.prodDate}</td>
												<td>${productDTO.prodId }</td>
												<td>${productDTO.price }</td>
												<td>${productDTO.hit }</td>
												<td>${productDTO.trdLocation }</td>
											</tr>
										</c:forEach>	 
									</c:otherwise>
								</c:choose>
								</table>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
<%@include file="../default/footer.jsp" %>			
</body>
</html>