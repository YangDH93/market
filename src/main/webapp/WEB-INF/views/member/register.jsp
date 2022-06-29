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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

var bool1 = false;
var bool2 = false;
var bool3 = false;
var bool4 = false;

/* 아이디 체크 */
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
					/* 특수문자, 중간공백 확인 데이터 만들기========================== */
					$("#id_chkMsg").html("사용 가능 아이디")
					$("#id_chkMsg").attr("class","correct")
				}
			}
		});
	}
}


//비밀번호 안전성 검사(실시간)
function safetyPasswordPattern(str){
	var pass = str.value;
	var message = "";
	var color = "";
	var checkPoint = 0;
	
	//입력값이 있을경우에만 실행
	if(pass.length){
		//최대 입력 글자수 제한
		if(pass.length < 8 || pass.length > 16){
			message = ":: 최소 8자 이상, 최대 16자 이하 ::";
			color = "#A23E48"
		//문자열 길이가 8 ~ 16인 경우	
		}else{
			//비밀번호 문자열에 숫자 존재 여부 검사
			var pattern1 = /[0-9]/; //숫자
			if(pattern1.test(pass) == false){
				checkPoint = checkPoint + 1;
			}
			//비밀번호 문자열에 영문 소문자 존재 여부 검사
			var pattern2 = /[a-z]/;
			if(pattern2.test(pass) == false) {
                checkPoint = checkPoint + 1;
			}
			//비밀번호 문자열에 영문 대문자 존재 여부 검사
			var pattern3 = /[A-Z]/;
			if(pattern3.test(pass) == false){
				checkPoint = checkPoint + 1;
			}
			//비밀번호 문자열에 특수문자 존재 여부 검사
			var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/; //특수문자
			if(pattern4.test(pass) == false){
				checkPoint = checkPoint + 1;
			}
			if(checkPoint >= 3) {
                message = ":: 보안성이 취약한 비밀번호 ::";
                color = "#A23E48";
            } else if(checkPoint == 2) {
                message = ":: 보안성이 낮은 비밀번호 ::";
                color = "#FF8C42";
            } else if(checkPoint == 1) {
                message = ":: 보안성이 보통인 비밀번호 ::";
                color = "#FF8C42";
            } else {
                message = ":: 보안성이 강력한 비밀번호 ::";
                color = "#0000CD";
            }
			bool3 = true;
		}
	}else{
		message = ":: 비밀번호를 입력해 주세요 ::";
		color="#000000";
	}
	document.getElementById("makyText").innerHTML = message;
	document.getElementById("makyText").style.color = color;
}

//2차 비밀번호 확인
function pwCheck(){
    if(document.getElementById('mbrPw').value !='' && document.getElementById("mbrPw2").value!=''){
        if(document.getElementById('mbrPw').value==document.getElementById("mbrPw2").value){
            document.getElementById('pwCheck').innerHTML=':: 2차 비밀번호가 일치합니다. ::'
            document.getElementById('pwCheck').style.color='blue';
            bool4 = true;
        }
        else{
            document.getElementById('pwCheck').innerHTML=':: 비밀번호가 일치하지 않습니다. ::';
            document.getElementById('pwCheck').style.color='red';
        }
    }
}

//form 제출전 유효성 체크 확인
function regChk(){
	var name = document.getElementById("mbrName")
	var id = document.getElementById("mbrId")
	var pw = document.getElementById("mbrPw")
	var pwChk =document.getElementById("pwChk")
	console.log(name)
	console.log(id)
	console.log(pw)
	console.log(pwChk)
	
 	//닉네임 중복 확인
	if(bool1 != true){
		alert("닉네임 중복확인이 되지 않았습니다.")
		name.focus();
		return;
	}
	//아이디 중복 확인
	if(bool2 != true){
		alert("아이디 중복확인이 되지 않았습니다.")
		id.focus();
		return;
	}
	//비밀번호 조건 확인
	if(bool3 != true){
		alert("비밀번호가 조건에 부합하지 않습니다.")
		pw.focus();
		return;
	}
	//2차 비밀번호 확인
	if(bool4 != true){
		alert("2차 비밀번호가 일치하지 않습니다.")
		pwChk.focus();
		return;
	}
	fo.submit();
}
</script>

</head>
<body>
<h1>REGISTER</h1>
<form id="fo" action="reg" method="post">
	<div>
		<input type="text" placeholder="닉네임" name="mbrName" id="mbrName">
		<input type="button" value="중복확인"><br>
	</div>
	
	<div>
		<input id="mbrId" name="mbrId" type="text" placeholder="아이디">
		<input id="idChk_btn" onclick="idChk()" type="button" value="중복확인"><br>
		<span id="id_chkMsg"></span><!-- 메시지 띄움 -->
	</div>
	
	<div>
		<input type="text" placeholder="비밀번호" name="mbrPw" id="mbrPw"
		onkeyup="safetyPasswordPattern(this);" style="ime-mode:disabled;"/>
		<span id="makyText">:: 비밀번호를 입력해 주세요 ::</span><br>
		<input type="text" onchange="pwCheck()" placeholder="비밀번호 확인" id="mbrPw2">
		<span id="pwCheck">:: 2차 비밀번호 확인 ::</span>
		<br>
	</div>
	
	<div>
		<input type="email" placeholder="이메일" name="mbrEmail" id="mbrEmail">
		<input type="button" value="인증">
	</div>
	
	<hr>
	<input type="button" onclick="regChk()" value="가입하기">
</form>
</body>
</html>