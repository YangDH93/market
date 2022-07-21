<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
/* 공백체크 */
$(document).ready(function() {
	$("#login_btn").click(function() {
		if ($("#mbrId").val().length == 0) {
			$("#caps_check_message").css("display", "none")
			$("#login_check_message").html("");
			$("#input_check_message").css("display", "block")
			$("#input_check_message").html("<b>아이디</b>를 입력하세요");
			$("#mbrId").focus();
			return false;
		}
		if ($("#mbrPw").val().length == 0) {
			$("#login_check_message").html("");
			$("#input_check_message").css("display", "block")
			$("#input_check_message").html("<b>비밀번호</b>를 입력하세요");
			$("#mbrPw").focus();
			return false;
		}
	});
});

/* CapsLock 체크 */
function checkCapsLock(event) {
	if (event.getModifierState("CapsLock")) {
		$("#caps_check_message").css("display", "block")
	} else {
		$("#caps_check_message").css("display", "none")
	}
}
</script>

<style type="text/css">
#rg {
	display: flex;
	justify-content: center;
	margin-top: 130px;
}

.ip_btn {
	font-size: 20px;
	width: 100%;
	height: 55px;
	background-color: #FFA200;
	border-radius: 10px;
	border-color: #FFA200;
	color: white;
	cursor: pointer;
	font-weight: 600;
	border: 0px;
	
}

#au {
	margin-left: 55px;
	width: 13px;
	height: 13px;
	font-size: 13px;
}

#ip {
	color: #414141;
	text-decoration: none;
	font-size: 17px;
}

.login_input {
	outline-style: none;
	border-color: #FFA200;
	border-top: none;
	border-left: none;
	border-right: none;
	margin-bottom: 30px;
	width: 100%;
	font-size: 18px;
}
</style>
</head>
<body>
	<div id="rg">
		<form id="fo" action="${contextPath }/member/logChk" method="post"
			autocomplete="off">
			<div>
				<img style="width: 400px; cursor: pointer; margin-bottom: 30px;"
					src="${contextPath}/resources/image/duck.png"
					onclick="location.href='${contextPath}'"/>
			</div>

			<table style="width: 400px;">
				<tr>
					<!-- 아이디  비밀번호 자동로그인-->
					<td width="250px" height="50px"><input autofocus
						maxlength='16' id="mbrId" name="mbrId" class="login_input"
						type="text" placeholder="아이디를 입력해주세요"> <br> <input
						maxlength='16' id="mbrPw" name="mbrPw" class="login_input"
						type="password" placeholder="비밀번호를 입력해주세요"
						onkeyup="checkCapsLock(event)"> <br>
						<div style="display: flex; justify-content: space-between;">
							<div style="font-size: 17px; color: #414141;">
								<input type="checkbox" id="autoLogin" name="autoLogin"
									style="cursor: pointer;"> <label for="autoLogin"
									style="cursor: pointer;">자동로그인</label>
							</div>
							<a href="#" id="ip">아이디/비밀번호 찾기</a>
						</div></td>
				</tr>

				<tr>
					<!-- 경고문구 -->
					<td height="60px">
						<div class="check_message" style="color: red; font-size: 15px;">
							<span id="caps_check_message" style="display: none;"> <b>CapsLock</b>이
								켜져 있습니다.
							</span> <span id="login_check_message">${massage}</span> <span
								id="input_check_message" style="display: none;"></span>
						</div>
					</td>
				</tr>

				<tr>
					<!-- 로그인 버튼 -->
					<td style="text-align: center; height: 50px;"><input
						class="ip_btn" id="login_btn" type="submit" value="로그인"></td>
				</tr>

				<tr>
					<!-- 회원가입 -->
					<td style="padding-top: 10px; text-align: center; font-size: 15px; color: #414141;">
						아직 회원이 아니신가요? <a style="text-decoration: none; color: #414141"
						href='${contextPath }/member/register'><b>회원가입</b></a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>