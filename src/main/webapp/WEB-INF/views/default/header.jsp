<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/main.css">
<style>
    ul, ol, li { list-style:none; margin:0; padding:0; }
   
    ul.myMenu {}
    ul.myMenu > li { display:inline-block; width:80px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; position:relative; }
    ul.myMenu > li:hover { background:#fff; }
    ul.myMenu > li ul.submenu { display:none; position:absolute; top:30px; left:0; }
    ul.myMenu > li:hover ul.submenu { display:block; }
    ul.myMenu > li ul.submenu > li { display:inline-block; width:80px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; }
    ul.myMenu > li ul.submenu > li:hover { background:#fff; }

.hDmINX {
		text-decoration: none;
}
.elwjyI{
		text-decoration: none;
}
.elwjyI:hover {
   color: orange;
   padding-bottom: 3px; /* a태그 밑줄과 글씨 간격*/
   border-bottom: 1px solid orange;
   transition: all 0.25s;
}
</style>
</head>
<body>
	<div id="root">
		<div class="gvnzUM">
			<div class="IvAsD">
				<div class="kaFNmQ">
					<div class="jYMzIJ">
						<a class="hvNQEV"> <img
							src="${contextPath}/resources/image/duck.png" width="16"
							height="17" alt="앱다운로드버튼 이미지"> 앱 다운로드
						</a> <a class="hvNQEV"> <img
							src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAN8xiK6nINoEgUKSjyFc4eDd0Vws_5PoeyQ&usqp=CAU"
							width="16" height="15" alt="즐겨찾기버튼 이미지"> 즐겨찾기
						</a>
					</div>
					<div class="jYMzIJ">
						<c:choose>
							<c:when test="${loginUser == null }">
								<a class="hvNQEV" href="${contextPath}/member/register">회원가입</a>
								<a class="hvNQEV" href="${contextPath}/member/login">로그인</a>
							</c:when>
							<c:otherwise>
								<a class="hvNQEV" href="${contextPath}/member/pwdChkForm?mbrId=${loginUser }">회원정보 수정</a>
								<a class="hvNQEV" href="${contextPath}/member/logout">로그아웃</a>
								<a class="hvNQEV" href="${contextPath}/customer/csList">고객센터</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="hLFFUa">
				<div class=" zvczX">
					<div class="gLAQAm">
						<a class="hDmINX" href="${contextPath}"> <img
							src="${contextPath}/resources/image/duck.png" width="150"
							height="120" alt="오리마켓 로고">
						</a>
						<div class="keyjxL">
							<div class="voMyM">
								<form action="${contextPath}/product/prodSearch">
									<input type="text" placeholder="제목, 상품이름 입력"
									name="keyword" class="cLfdog" size="50">
								</form>
							</div>
							<div class="iOzCaT">
								<div class="letkud">
									<div class="ciUXLo">
										<a class="drHLIP">최근검색어</a> <a class="kFQETw">인기검색어</a>
									</div>
								</div>
							</div>
						</div>
						<div class="etIgxm">
							<a class="elwjyI" href="#">
								<img src="data:image/png;base64,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"
								 width="23" height="24" alt="오리톡버튼 이미지">
								오리톡
							</a>
							<a class="elwjyI" href="${contextPath }/product/prodStatus?mbrId=${loginUser}">
							<img src="data:image/png;base64,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" 
							width="23" height="24" alt="내상점버튼 이미지">
							내상점
							</a>
							<a class="elwjyI" href="${contextPath }/product/prodNew">
								<img src="https://cdn-icons-png.flaticon.com/512/1611/1611178.png" width="23" height="26" alt="판매하기버튼 이미지">
								판매하기
							</a>
						</div>
					</div>
					<div class="ZKoFr">
						<!-- 카테고리 -->
						<div class="gIJOQQ">
							<img alt="메뉴 버튼 아이콘"
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAANwAAADcCAMAAAAshD+zAAAAQlBMVEX///8AAABERERbW1sGBgbm5uacnJzo6OhxcXGtra04ODjR0dELCwv8/PzMzMx0dHTCwsITExPu7u6Ojo4/Pz+0tLRWWxupAAABbUlEQVR4nO3aSXKDQAxAUeIBz8bj/a+auFzeNgQWjeT3TiAVJODmNw0AAAAAAAAAADDKut0uFyEst+36X6vt9j+h7HeDVzsEW+1lfxh42Y61Jx3jOOjitbXHHKvt3+2yqj3kWKtL3263a+0Zx7veepbb1p5wiq682zrsTfmyKj/w7rXnm+ZeXO5Re7xpFqXdTqHvyr/78lT6k6s93VSbwnLn2sNNdf7W5VLflqn/oaR+FOR+iKd+/Wq62gNO0fPinPsnT+ofq7mPGZrmmfiAKObR3mPg0V6T+lD2ZdN2UY7Tu7b0RgkAAAAAAIwivZ8N6f37siX+spr5m3jmmiF1hyK9nyvpfVjS+7Ck91FJ74OS3kclvQ9Keh+T9F56PzfS+w/pPQAAAAAAfDfp/WxI79+XLfGX1czfxDPXDKk7FOn9XEnvw5LehyW9j0p6H5T0PirpfVDS+5ik99L7uZHef0jvAQAAAAAAAADgG/wCAYxL0BP5utUAAAAASUVORK5CYII="
								width="20" height="16">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>