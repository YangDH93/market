<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prodNew</title>
<style type="text/css">
.flex {
	display: flex;
}
.flex-direction{
	flex-direction:column;
}
</style>
</head>
<body>
	<form action="#" method="post">
		<div>
			<div>
				<div class="flex">
					<h2>기본정보</h2> <span>*필수항목</span>
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					상품 이미지 <label>*</label>
				</div>
				<div>
					<input type="file" accept="image/jsp, image/jpeg, image/png" multiple><br> 설명맨~
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					제목<label>*</label>
				</div>
				<div>
					<input type="text" name="title" placeholder="상품 제목을 입력해주세요.">
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					카테고리<label>*</label>
				</div>
				<div>
					<div>
						<ul>
							<li>의상</li>
							<li>신발</li>
							<li>아무개</li>
						</ul>
						<ul style="display: none;">
							<li>남성</li>
							<li>여성</li>
							<li>아동</li>
						</ul>
						<ul style="display: none;">
							<li>큰사이즈</li>
							<li>중간사이즈</li>
							<li>작은사이즈</li>
						</ul>
					<br>
					<label>선택한 카테고리 : </label>
					</div>
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					거래지역<label>*</label>
				</div>
				<div>
					<div>
						<button>내 위치</button>
						<button>최근 지역</button>
						<button>주소 검색</button>
					</div>
					<div>
						<input type="text" name="addr" placeholder="상세주소">
					</div>
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					상태<label>*</label>
				</div>
				<div>
					<input type="radio" name="st1">중고상품
					<input type="radio" name="st1">새상품
				</div>
			</div>
			<hr>
			<div class="flex">
				교환<label>*</label>
				<div>
					<input type="radio" name="st2">교환불가
					<input type="radio" name="st2">교환가능
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					가격<label>*</label>
				</div>
				<div>
					<input type="number" name="숫자만 입력하세요" placeholder="숫자만 입력해주세요.">원<br>
					<input type="checkbox" name="st3">배송비 포함
				</div>
			</div>
			<hr>
			<div class="flex">
				<div>
					설명<label>*</label>
				</div>
				<div>
					<textarea rows="6" cols="50" placeholder="설명적는란"></textarea>
				</div>
			</div>
			<hr>
			<div>
				<input type="submit" value="등록하기">
			</div>
		</div>
	</form>
</body>
</html>