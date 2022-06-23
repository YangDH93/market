<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.manage_li{
	float: left;
}
.manage_li+.manage_li:before{
	content: "";
	display: inline-block;
	width: 1px;
	height: 10px;
	margin: 0 50px; /* 상하 좌우 */
	background-color: #e4e8eb;
	vertical-align: -1px;
}
.manage_li a{
	color: #777;
	font-size:14px;
	text-decoration: none;
}
</style>
</head>
<body>
<div class="wrap_manage" style="min-width: 1280px; width: 1280px; margin: 0 auto;">
	<!-- 페이지 메뉴바 상품관리/구매판매내역 -->
	<div class="" style="border-top: 1px solid #e4e8eb;
						border-bottom: 1px solid #e4e8eb;">
		<ul class="manage_ul" style="padding-left: 0; list-style: none; display: inline-block;">
			<li class="manage_li"><a href="#">상품관리</a></li>
			<li class="manage_li"><a href="#">구매/판매 내역</a></li>
		</ul>
	</div>
	<!-- 검색 -->
	<div style="display: flex; padding: 20px 0;">
		<div style="padding-right: 20px">
			<input type="text" placeholder="상품명을 입력해주세요.">
			<button>검색</button>
		</div>
		
		<div style="padding-right: 20px">
			<select name="subject">
   				<option>10개씩</option>
   				<option>20개씩</option>
   				<option>50개씩</option>
  			</select>
		</div>
		
		<div>
			<select name="status">
   				<option>전체</option>
   				<option>판매중</option>
   				<option>예약중</option>
   				<option>판매완료</option>
  			</select>
		</div>
		
	</div>
	
<!-- 목록 : 테이블형식 -->
<div class="">
	<table style="border-top: 2px solid black;
					border-collapse: collapse; width: 100%">
		<!-- 테이블 머리 -->
		<thead style="border-bottom: 2px solid black; ">
			<tr>
				<th>사진</th> <th>판매상태</th> <th>상품명</th>
				<th>가격</th> <th>찜/댓글</th> <th>최근수정일</th>
				<th>기능</th>
			</tr>
		</thead>
		<!-- 테이블 몸통(내용 리스트로 가져옴) -->
		<tbody style="border-bottom: 1px solid black">
			<!-- DB에서 반복문으로 데이터 list로 가져올때 사용 -->
			<%-- <c:forEach var="" items=""> --%>
				<tr>
					<td>사진</td> <td>판매상태</td> <td>상품명</td>
					<td>가격</td> <td>찜/댓글</td> <td>최근수정일</td>
					<td>
						<button>UP</button><br>
						<button>수정</button>
					</td>
				</tr>
				
				<!-- 삭제할것 start 확인용 -->
				<tr>
					<td>사진</td> <td>판매상태</td> <td>상품명</td>
					<td>가격</td> <td>찜/댓글</td> <td>최근수정일</td>
					<td>
						<button>UP</button><br>
						<button>수정</button>
					</td>
				</tr>
				<tr>
					<td>사진</td> <td>판매상태</td> <td>상품명</td>
					<td>가격</td> <td>찜/댓글</td> <td>최근수정일</td>
					<td>
						<button>UP</button><br>
						<button>수정</button>
					</td>
				</tr>
				<!-- 삭제할것 end 확인용 -->
				
				
			<%-- </c:forEach> --%>
		</tbody>
	</table>
</div>
	
<!-- 페이징 처리 -->
<div class="" style="text-align: center; padding: 20px 0; ">
	<a href="#">&laquo;</a>
	<a href="#">1</a>
	<a href="#">2</a>
	<a href="#">3</a>
	<a href="#">4</a>
	<a href="#">5</a>
	<a href="#">6</a>
	<a href="#">&raquo;</a>
</div>

</div><!-- wrap끝 -->
<!-- footer -->
<jsp:include page="../default/footer.jsp"/>

</body>
</html>