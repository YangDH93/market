<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.correct{
	color : green;
	font-size: 14px
}
.incorrect{
	color : red;
	font-size: 14px
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
function idChk(){
	//alert("동작")
	var inputId = $("#mbrId").val()
	
	if(inputId == ""){ // 첫 공백 체크
		$("#id_chkMsg").html("아이디를 입력하세요")
		$("#id_chkMsg").attr("class","incorrect")
	}else{
		$.ajax({
			url : 'getId', type : 'post', dataType : 'json',
			data : {inputId : inputId},
			
			success : function(data){
				//console.log(data)
				if(data == "1"){
					$("#id_chkMsg").html("중복 아이디")
					$("#id_chkMsg").attr("class","incorrect")
				}else{
					// 특수문자, 중간공백 확인
					$("#id_chkMsg").html("사용 가능 아이디")
					$("#id_chkMsg").attr("class","correct")
					
				}
			}
		});
	}
}

</script>

</head>
<body>
<h1>REGISTER</h1>
<form id="fo" action="reg" method="post">
	<input type="text" placeholder="닉네임" name="mbrName" id="mbrName">
	<input type="button" value="중복확인"><br>
	
	<div>
		<input id="mbrId" name="mbrId" type="text" placeholder="아이디">
		<input id="idChk_btn" onclick="idChk()" type="button" value="중복확인"><br>
		<span id="id_chkMsg"></span>
	</div>
	
	<input type="text" placeholder="비밀번호" name="mbrPw" id="mbrPw"><br>
	<input type="text" placeholder="비밀번호 확인" id="pwChk"><br>

	<input type="email" placeholder="이메일" name="mbrEmail" id="mbrEmail">
	<input type="button" value="인증">
	<hr>
	<input type="submit" value="가입하기"><br>
</form>
</body>
</html>