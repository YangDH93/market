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
	<!-- 목록 : 테이블형식 -->
	<div class="">
		<table style="border-top: 2px solid black;
						border-collapse: collapse; width: 100%">
			<!-- 테이블 머리 -->
			<thead style="border-bottom: 2px solid black; ">
				<tr>
					<th>작성자</th> 
					<th>제목</th>
					<th>작성날짜</th> <th>답변여부</th>
				</tr>
			</thead>
			<!-- 테이블 몸통(내용 리스트로 가져옴) -->
			<tbody style="border-bottom: 1px solid black">
				<!-- DB에서 반복문으로 데이터 list로 가져올때 사용 -->
				<c:forEach var="csdto" items="${csList }">
					<tr>
						<td>작성자${csdto.mbrId }</td> 
						<td><a href="csView">제목${csdto.csTitle}</a></td>
						<td>작성날짜${csdto.date}</td> <td>답변여부${csdto.replyStat}</td>
					</tr>
					
					<!-- 삭제할것 start 확인용 -->
					<tr>
						<td>작성자</td> 
						<td><a href="csView">제목</a></td>
						<td>작성날짜</td> <td>답변여부</td>
					</tr>
					<tr>
						<td>작성자</td> 
						<td><a href="csView">제목</a></td>
						<td>작성날짜</td> <td>답변여부</td>
					</tr>
					
					<!-- 삭제할것 end 확인용 -->
					
			</c:forEach>
			</tbody>
		</table>
	</div>
		
	<!-- 페이징 처리 -->
	<div class="" style="text-align: center; padding: 20px 0; ">
		<a href="#">&laquo;</a>
			<c:forEach var="num" begin="1" end="${repeat }">
				<a href="csList?num=${num }">[${num }]</a>
			</c:forEach>
		<a href="#">&raquo;</a>
	</div>
</section>
<%@include file="../default/footer.jsp" %>
</body>
</html>