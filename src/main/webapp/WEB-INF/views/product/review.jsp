<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.star-rating {
  display:flex;
  flex-direction: row-reverse;
  font-size:1.5em;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}
</style>
</head>
<body>
<jsp:include page="../default/header.jsp"/>
<div class="wrap_review" style="min-width: 1280px; 
					width: 1280px; margin: 0 auto;">
<!-- 페이지 이름 -->
	<div>
		<h2>리뷰 쓰기</h2>
	</div>

<!-- 상품정보 -->
	<div style="display: flex">
		<div>
			사진||
		</div>
		<div>
			카테고리||
		</div>
		<div>
			게시글제목
		</div>
	</div>
	
<!-- 내용 -->
	<div>
		<form action="">
		<!-- 별점 -->
		<div>
			<div>
				<h4>별점평가</h4>
			</div>
			<div style="display: flex">
				<p>만족도</p>
				<div class="star-rating">
					<input type="radio" id="5-stars" name="rating" value="5" />
					<label for="5-stars" class="star">&#9733;</label>
					<input type="radio" id="4-stars" name="rating" value="4" />
					<label for="4-stars" class="star">&#9733;</label>
					<input type="radio" id="3-stars" name="rating" value="3" />
					<label for="3-stars" class="star">&#9733;</label>
					<input type="radio" id="2-stars" name="rating" value="2" />
					<label for="2-stars" class="star">&#9733;</label>
					<input type="radio" id="1-star" name="rating" value="1" />
					<label for="1-star" class="star">&#9733;</label>
				</div>
			</div>
		</div>
		<!-- 이미지첨부 -->
		<div>
			<p>사진을 첨부해주세요. (최대 1장)</p>
			<button>사진첨부하기</button>
		</div>
		<!-- 글작성 -->
		<div>
			<div>
				<h4>리뷰 작성</h4>
			</div>
			<div>
				<textarea style="resize: none; height: 50px; width: 200px"
							placeholder="자세하고 솔직한 리뷰는 다른 고객에게 큰 도움이 됩니다.(최소 20자 이상)">
				</textarea>
				<!-- 
				https://bskyvision.com/1012
				글자 수 제한 코드 jQuery
				 -->
			</div>
		</div>
		<button>완료</button>
		</form>
	</div>
</div><!-- wrap끝 -->
<jsp:include page="../default/footer.jsp"/>
</body>
</html>