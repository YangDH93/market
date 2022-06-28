<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#input_check_message {
	color : red; font-size : 14px;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

/* 공백체크 */
function loginChk(){
	var mbrId = $("#mbrId")
	var mbrPw = $("#mbrPw")
	
	/* 입력값 체크 */
	if(mbrId.val() == ""){ //아이디 공백
		$("#input_check_message").html("<b>아이디</b>를 입력하세요")
		mbrId.focus()
	}else if(mbrPw.val() == ""){ //비번 공백
		$("#input_check_message").html("<b>비밀번호</b>를 입력하세요")
		mbrPw.focus()
	}else{ 
		frm.submit()
	} // 공백아니면 제출
	
}

/* CapsLock 체크 */
function checkCapsLock(event){
	if (event.getModifierState("CapsLock")) {
		$("#input_check_message").html("<b>CapsLock</b>이 켜져 있습니다.")
	}else{
		$("#input_check_message").html("")
	}
}

</script>
</head>
<body>
	<!-- maxlength='입력수 제한~~~~~'변경하기~~ -->
	<form id="frm" action="${contextPath }/member/logChk" method="post">
		<input maxlength='14' id="mbrId" name="mbrId" 
				type="text" placeholder="input id"><br>
		<input maxlength='14' id="mbrPw" name="mbrPw" 
				type="password" placeholder="input password" onkeyup="checkCapsLock(event)"><br>
		<input type="button" onclick="loginChk()" value="로그인">
		<a href="${contextPath }/member/register">회원가입</a>
		<input type="checkbox" name="autoLogin">자동로그인
	</form>
	<!-- 경고문구 -->
	<div class="check_message">
		<span id="input_check_message">${massage}</span>
	</div>
</body>
</html>









