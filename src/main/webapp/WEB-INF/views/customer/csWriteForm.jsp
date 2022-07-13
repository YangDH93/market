<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.cs-btn{
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
    background: rgb(216, 12, 24);
    padding: 1rem 1.25rem;
    cursor: pointer;
    width: 100%;
}
</style>
</head>
<body>
<section class="eeRGVw">
<div style="position:flex; z-index: 2;
			justify-content: space-between;
			top: 0px; left: 0px; right: 0px;">
	<header>
		<img src="https://help.bunjang.co.kr/static/media/icon-ic-chevron-left.0609bd8b.svg">
		<a href="csList">취소</a>
	</header>
</div>
<!-- 페이지 이름 -->
	<div>
		<h2>1:1 문의하기</h2>
	</div>
<!-- 내용 -->
	<div>
		<form action="csWrite" id="csfo">
			<div>제목<label>*</label></div><br>
			<input type="text" placeholder="제목입력"
			name="csTitle">
			
			<!-- 해당 작성 아이디 hidden으로 전달 -->
			<input type="text" style="display: none;" name="mbrId" value="${param.mbrId }">
			
			<!-- 글작성 -->
			<div>
				<div>문의 내용<label>*</label></div>
				<div>
					<textarea style="resize: none; height: 50px; width: 200px"
								placeholder="문의 내용을 자세히 입력해주세요."
								name="csContent"></textarea>
					<!-- 
					https://bskyvision.com/1012
					글자 수 제한 코드 jQuery
					 -->
				</div>
			</div>
			<!-- 이미지첨부 -->
			<div>
				<div>사진첨부</div><br>
				<input type="file" name="csImg">
			</div>
			<input type="submit" class="cs-btn" value="문의하기">
		</form>
	</div>
</section>
</body>
</html>