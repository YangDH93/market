<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
.review{
	display: flex;
	justify-content: center;
	margin-top: 30px;
	margin-bottom: 30px;
}
</style>
</head>
<body>
<jsp:include page="../default/header.jsp"/>
<div class="review">
	<form action="">
	<table border="1" style="border-collapse: collapse; width: 800px; height: 800px;">
		<tr>
		<td>제목</td><td><input type="text"></td>
		<tr>
		<td>카테고리</td><td><input type="text"></td>
		</tr>
			<tr>
				<td><button>이미지 첨부</button> 이미지를 첨부해주세요. (최대 1장)</td>
			</tr>
			<tr>
				<td><img src=""></td>
			</tr>
			<tr>
			<td>
			     <textarea id="prodContent" name="prodContent" maxlength="500"
                  style="resize: none; outline-style: none; border-color: #C0C0C0; border-radius: 3px; width: 300px;"
                  rows="8" cols="100" placeholder="리뷰를 작성해주세요."></textarea>
                <!-- 
				https://bskyvision.com/1012
				글자 수 제한 코드 jQuery
				 -->
			</td>
			</tr>
			<tr>
			<td><button>완료</button></td>
			</tr>
		</table>
		</form>
	</div>
<jsp:include page="../default/footer.jsp"/>
</body>
</html>