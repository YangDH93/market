<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/main.css">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style type="text/css">
	body {font-family: Arial;}

.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

.tab button:hover {
  background-color: #ddd;
}

.tab button.active {
  background-color: #ccc;
}

.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
</style>
</head>
<body>
	<jsp:include page="../default/header.jsp" />
	<div>
		<div style="display: flex;">
			<div>
				<img width="100" height="100" alt="사진같은거 //  " src="상점 프로필 이미지" />
				<div align="left">동훈맨</div>
			</div>
			<div>
				<div>
					<div style="display: flex;">
						<div>
							동훈맨
							<button>상점명 수정</button>
						</div>
						<div align="right">본인인증 완료</div>
					</div>
				</div>
				<div>
					<div>
						<img width="14" height="13" alt=src=""> 
						<img width="14" height="13" alt=src=""> 
						<img width="14" height="13" alt=src=""> 
						<img width="14" height="13" alt=src="">
					</div>
					<div>
						<button>소개글 수정</button>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div>
				<div class="tab">
					<button class="tablinks" onclick="openCity(event, '1')">상품 <span>0</span></button>
					<button class="tablinks" onclick="openCity(event, '2')">상점문의 <span>0</span></button>
					<button class="tablinks" onclick="openCity(event, '3')">찜 <span>0</span></button>
					<button class="tablinks" onclick="openCity(event, '4')">상점후기 <span>0</span></button>
					<button class="tablinks" onclick="openCity(event, '5')">팔로잉 <span>0</span></button>
					<button class="tablinks" onclick="openCity(event, '6')">팔로워 <span>0</span></button>
				</div>
				
				<div id="1" class="tabcontent" >
					<div>
						<div style="display: flex;">
							<div>
								<h3>상품 <span>0</span></h3>
							</div>
							<div align="right">
								<select size="1" name="sel">
									<option value="1">전체상품
									<option value="2">2번
									<option value="3">3번
								</select> 
							</div>
						</div>
						<hr>
						<div>
							등록된 상품이 없습니다
						</div>
					</div>
				</div>

				<div id="2" class="tabcontent">
					<div>
						<div>
							<div>
								<h3>상점문의 <span>0</span></h3>
							</div>
							<div>
								<div>
									상품문의 입력
								</div>
								<hr>
								<div style="display: flex;">
									<div>
										<div>0 / 100</div>
									</div>
									<div align="right">
										<button>등록</button>
									</div>
								</div>
							</div>
						</div>
						<hr>
						<div>
							등록된 문의가 없습니다. 첫 상품문의를 등록해보세요!
						</div>
					</div>
				</div>

				<div id="3" class="tabcontent">
					<div>
						<div>
							<div>
								<h3>찜 <span>0</span></h3>
							</div>
						</div>
						<hr>
						<div>
							찜한 상품이 없습니다.
						</div>
					</div>
				</div>
				<div id="4" class="tabcontent">
					<div>
						<div>
							<div>
								<h3>상점후기 <span>0</span></h3>
							</div>
						</div>
						<hr>
						<div>
							상점후기가 없습니다.
						</div>
					</div>
				</div>

				<div id="5" class="tabcontent">
					<div>
						<div>
							<div>
								<h3>팔로잉 <span>0</span></h3>
							</div>
						</div>
						<hr>
						<div>
							아직 팔로우한 사람이 없습니다.
						</div>
					</div>
				</div>

				<div id="6" class="tabcontent">
					<div>
						<div>
							<div>
								<h3>팔로워<span>0</span></h3>
							</div>
						</div>
						<hr>
						<div>
							아직 이 상점을 팔로우한 사람이 없습니다.
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	function openCity(evt, cityName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(cityName).style.display = "block";
		evt.currentTarget.className += " active";
	}
</script>
	<jsp:include page="../default/footer.jsp" />
</body>
</html>