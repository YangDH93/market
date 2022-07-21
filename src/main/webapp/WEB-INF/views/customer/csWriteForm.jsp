<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
.cs-btn {
	border: none;
	margin: 0px;
	overflow: visible;
	font-family: SFProText, SFProDisplay, Arial;
	line-height: normal;
	box-sizing: border-box;
	-webkit-font-smoothing: inherit;
	appearance: none;
	font-size: 16px;
	font-weight: bold;
	border-radius: 6px;
	color: rgb(255, 255, 255);
	background: #FFA200;
	cursor: pointer;
	width: 502px;
	height: 50px;

}

.wf {
	display: flex;
	justify-content: center;
}

.input_st {
	outline-style: none;
	border-color: #FFA200;
	border-top: none;
	border-left: none;
	border-right: none;
	margin-bottom: 30px;
	width: 500px;
	font-size: 25px;
	}

.memo {
	outline: none;
	resize: none;
	width: 500px;
	height: 500px;
	font-size: 15px;
	border-color: #C0C0C0;
	font-family: sans-serif;
}
</style>
</head>
<body>
	<section class="eeRGVw">
		<div
			style="position: flex; z-index: 2; justify-content: space-between; top: 0px; left: 0px; right: 0px;">
			<header>
				<img
					src="https://help.bunjang.co.kr/static/media/icon-ic-chevron-left.0609bd8b.svg"
					onclick="location.href='csList'" style="cursor: pointer;">
			</header>
		</div>
		<!-- 페이지 이름 -->
		<!-- 내용 -->
		<div class="wf">
			<form action="csWrite" id="csfo">
		<div>
			<h2>문의하기</h2>
		</div>
				<br> <input type="text" class="input_st" placeholder="제목"
					name="csTitle">

				<!-- 해당 작성 아이디 hidden으로 전달 -->
				<input type="text" style="display: none;" name="mbrId"
					value="${param.mbrId }">

				<!-- 글작성 -->
				<div>
					<textarea class="memo" placeholder="문의 내용을 입력해주세요."
						name="csContent"></textarea>
					<!-- 
					https://bskyvision.com/1012
					글자 수 제한 코드 jQuery
					 -->
				</div>
				<!-- 이미지첨부 -->
				<div style="margin-left: 2px; padding-bottom:  20px;">
					<br><input type="file" name="csImg">
				</div>
				<input type="submit" class="cs-btn" value="문의하기">
			</form>
		</div>
	</section>
</body>
</html>