<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

/* 공백체크 */
$(document).ready(function(){ 
	$("#login_btn").click(function(){
			if($("#mbrId").val().length==0){ 
				$("#caps_check_message").css ("display", "none")
				$("#login_check_message").html("");
				$("#input_check_message").css ("display", "block")
				$("#input_check_message").html("<b>아이디</b>를 입력하세요");
				$("#mbrId").focus();
				return false;
			}
			if($("#mbrPw").val().length==0){ 
				$("#login_check_message").html("");
				$("#input_check_message").css ("display", "block")
				$("#input_check_message").html("<b>비밀번호</b>를 입력하세요"); 
				$("#mbrPw").focus();
				return false;
			}
		});		
});


/* CapsLock 체크 */
function checkCapsLock(event){
	if (event.getModifierState("CapsLock")) {
		$("#caps_check_message").css ("display", "block")
	}else{
		$("#caps_check_message").css ("display", "none")
	}
}

</script>
</head>
<body>
	<!-- 입력폼 -->
	<div>
		<form id="fo" action="${contextPath }/member/logChk" method="post" autocomplete="off">
			<div>
				<input autofocus maxlength='16' id="mbrId" name="mbrId" 
						type="text" placeholder="input id"><br>
			</div>
			
			<div>		
				<input maxlength='16' id="mbrPw" name="mbrPw" 
						type="password" placeholder="input password" onkeyup="checkCapsLock(event)"><br>
			</div>
			
			<div>
				<input type="checkbox" id="autoLogin" name="autoLogin">
				<label for="autoLogin">자동로그인</label>
			</div>
				<input id="login_btn" type="submit"  value="로그인">
		</form>
	</div>
	
	<a href="${contextPath }/member/register">회원가입</a> 
	
	<!-- 경고문구 -->
	<div class="check_message" style="color : red; font-size : 14px;">
		<span id="caps_check_message" style="display: none;">
			<b>CapsLock</b>이 켜져 있습니다.
		</span><br>
		<span id="login_check_message">${massage}</span>
		<span id="input_check_message" style="display: none;"></span>
	</div>
</body>
</html>