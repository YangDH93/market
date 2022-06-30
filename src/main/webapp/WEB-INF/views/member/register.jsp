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

var bool1 = false; // 닉네임
var bool2 = false; // 아이디
var bool3 = false; // 비번
var bool4 = false; // 비번체크
var bool5 = false; // 이메일
var bool6 = false; // 이메일 인증번호

/* boo1 - 닉네임 체크 */
function nameChk(){
	inputName = $("#mbrName").val() // 전역변수
	var nameRegExp = /^[a-zA-Z0-9]{1,10}$/; // 한글은???
	
	
	if(inputName == ""){ // 첫 공백 체크
		$("#name_chkMsg").html("닉네임을 입력하세요")
		$("#name_chkMsg").attr("class","incorrect")
	}else if(!nameRegExp.test(inputName)){ // 유효성 체크
		$("#name_chkMsg").html("1~10자의 영문 대소문자와 한글, 숫자만 입력가능");
		$("#name_chkMsg").attr("class","incorrect");
	}else{ // 중복검사
		$.ajax({
			url : 'getName', type : 'post', dataType : 'json',
			data : {inputName : inputName},
			
			success : function(data){
				console.log(data)
				if(data == "1"){
					$("#name_chkMsg").html("중복 닉네임");
					$("#name_chkMsg").attr("class","incorrect");
				}else{
					$("#name_chkMsg").html("사용 가능 닉네임");
					$("#name_chkMsg").attr("class","correct");
					bool1 = true; // 닉네임 통과
				}
			}
		});
	}
}

/* bool2 - 아이디 체크 */
function idChk(){
	inputId = $("#mbrId").val() // 전역변수
	var idRegExp = /^[a-zA-Z0-9]{4,12}$/;
	
	if(inputId == ""){ // 첫 공백 체크
		$("#id_chkMsg").html("아이디를 입력하세요")
		$("#id_chkMsg").attr("class","incorrect")
	}else if(!idRegExp.test(inputId)){ // 유효성 체크
		$("#id_chkMsg").html("4~12자의 영문 대소문자와 숫자만 입력가능");
		$("#id_chkMsg").attr("class","incorrect");
	}else{ // 중복체크
		$.ajax({
			url : 'getId', type : 'post', dataType : 'json',
			data : {inputId : inputId},
			
			success : function(data){
				//console.log(data)
				if(data == "1"){
					$("#id_chkMsg").html("중복 아이디");
					$("#id_chkMsg").attr("class","incorrect");
				}else{
					$("#id_chkMsg").html("사용 가능 아이디");
					$("#id_chkMsg").attr("class","correct");
					bool2 = true; // 아이디 통과
				}
			}
		});
	}
}


// bool3 - 비밀번호 안전성 검사(실시간)
function safetyPasswordPattern(str){
	var pass = str.value;
	var message = "";
	var color = "";
	var checkPoint = 0;
	
	//입력값이 있을경우에만 실행
	if(pass.length){
		//입력 글자수 제한
		if(pass.length < 8 || pass.length > 16){ //문자열 길이가 8 ~ 16 아닌 경우
			message = ":: 최소 8자 이상, 최대 16자 이하 ::";
			color = "#A23E48"
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

// bool4 - 2차 비밀번호 확인
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


var code = ""; // 인증번호 저장 변수

/* 이메일 입력방법 */
function selectOpt() {
	mbr_email3_opt = $("#mbrEmail3").val()
	mbr_email2 = $("#mbrEmail2") // 주소 입력값
	
	if(mbr_email3_opt == "1"){ // 직접입력
		mbr_email2.val('') //초기화
		mbr_email2.attr("disabled",false)
	}else{
		mbr_email2.val(mbr_email3_opt)
		mbr_email2.attr("disabled",true)
	}
	//console.log(mbr_email2.val())
}


/* bool5 - 입력값 저장, 이메일 발송 코드 */
// config 메일전송 막음~!!@!!!!!!!!!!!!!!!!!!!
function gmailSend(){
	mail = $("#mbrEmail").val() // 입력 이메일 아이디
	var email_IdRegExp = /^[A-Za-z0-9_]+[a-zA-Z0-9_]{1,12}$/; // 입력이메일 아이디 유효성 검사
	
	// 이메일 도메인 형식 검사
	var email_DoRegExp = /^[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	
	
	if(mail == ""){ // 입력 이메일 공백
		alert("이메일 입력")
		$("#mbrEmail").focus()
	}else if(!email_IdRegExp.test(mail)){ // 입력 이메일 아이디 유효성 검사
		alert("1~12자의 영문 대소문자, 숫자만 입력")
		$("#mbrEmail").focus()
	}else if(!email_DoRegExp.test(mbr_email2.val())){ // 이메일 도메인 유효성 검사
		alert("이메일 주소 확인")
		$("#mbrEmail2").focus()
	}else{ // 통과 시 메일 발송
		mail = mail + "@" + mbr_email2.val() //이메일 전체 입력값 저장
		//console.log(mail)
		let inputCode = $("#inputCode") // 인증번호 입력란
		let codeCkBtn = $("#codeCkBtn") // 인증번호 버튼
		
		$.ajax({
			url : 'sendMail', type : 'post', dataType : 'json',
			data : {mail : mail},
			
			success : function(data){
				alert("메일 발송 완료!")
				inputCode.attr("disabled",false)
				codeCkBtn.attr("disabled",false)
				$("#mbrEmail").val(mail); // DB저장위해 다시 저장
				bool5 = true;
				//console.log($("#mbr_email").val())
				// console.log(data) // 인증코드 콘솔 확인
				code = data // 인증코드 변수에 저장 
			},error : function(request,status,error){
				console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				alert("메일 발송 실패!")
			}
		});
	}
}

/* bool6 - 이메일 인증번호 확인 코드 */
function mailCodeCk(){
	var inputCode = $("#inputCode").val(); // 사용자 입력코드
	var checkMsg = $("#checkMsg") // 결과
	if(inputCode == code){// 일치
		checkMsg.html("인증번호 일치")
		checkMsg.attr("class","correct")
		bool6 = true;
	}else{ //불일치
		checkMsg.html("인증번호 불일치")
		checkMsg.attr("class","incorrect")
	}
}

//form 제출전 유효성 체크 확인
function regChk(){
	var name = document.getElementById("mbrName")
	var id = document.getElementById("mbrId")
	var pw = document.getElementById("mbrPw")
	var pwChk =document.getElementById("mbrPw2")
	var mailCk =document.getElementById("mbrEmail")
	console.log(name)
	console.log(id)
	console.log(pw)
	console.log(pwChk)
	console.log(mbrEmail)
	
 	//닉네임 중복 확인
	if(bool1 != true){
		alert("닉네임 다시 입력")
		name.focus();
		return;
	}
	//아이디 중복 확인
	if(bool2 != true){
		alert("아이디 다시 입력")
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
	
	if(bool5 != true){
		alert("이메일 확인")
		mbrEmail.focus();
		return;
	}
	if(bool6 != true){
		alert("이메일 인증번호 확인")
		$("#inputCode").focus();
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
		<!-- 닉네임 -->
		<!-- pattern 속성으로 유효성검사 : 1~10자의 영문 대소문자와 한글, 숫자만 입력가능 -->
		<input id="mbrName" name="mbrName" maxlength="10" 
		onkeyup="nameChk()"
		type="text" placeholder="닉네임" >
		<span id="name_chkMsg"></span><!-- 메시지 띄움 -->
		<br>
	</div>
	
	<div>
		<!-- id -->
		<!-- pattern 속성으로 유효성검사 : 4~12자의 영문 대소문자와 숫자만 입력가능 -->
		<input id="mbrId" name="mbrId" maxlength="14" 
		onkeyup="idChk()"
		type="text" placeholder="아이디">
		<span id="id_chkMsg"></span><!-- 메시지 띄움 -->
		<br>
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
		<div class="email">
			<!-- mbr_email값만 저장(js로 전체값 저장처리완료) -->
			<input id="mbrEmail" name="mbrEmail" type="text" placeholder="이메일"> @ 
			<input disabled="disabled" id="mbrEmail2" name="mbrEmail2" type="text">
			<select id="mbrEmail3" onchange="selectOpt()">
				<option value="" selected>선택하기</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="1">직접입력</option>
			</select>
			<button id="sendCode" type="button" onclick="gmailSend()" >인증번호 전송</button><br>
		</div>
		<div class="emailAuth">	
			<input disabled="disabled" id="inputCode" type="text">
			<button disabled="disabled" id="codeCkBtn" type="button" onclick="mailCodeCk()">인증번호 확인</button><br>
			<span id="checkMsg"></span>
		</div>
	</div>
	
	<hr>
	<input type="button" onclick="regChk()" value="가입하기">
</form>
</body>
</html>