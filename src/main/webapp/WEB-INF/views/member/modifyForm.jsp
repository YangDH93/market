<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="dto" value="${mbrInfo }"/>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
/* 변수 지정시 JSTL문구 HTML보다 먼저 읽기 때문에 변수 사용 불가능. */
var dName = "${dto.mbrName}"

	/* bool1 - 닉네임 체크
	 * bool2 - 비밀번호 체크
	 * bool3 - 2차 비밀번호 체크
	 */
		var bool1 = true;
		var bool2 = false;
		var bool3 = false;
//전화번호 유효성 검사
function phoneFormat(target) {
  // 특수문자 제거
  target.value = target.value.replace(/[^0-9]/g, "");

  const value = target.value.split("");

  const textArr = [
    // 첫번째 구간 (00 or 000)
    [0, value.length > 9 ? 3 : 2],
    // 두번째 구간 (000 or 0000)
    [0, value.length > 10 ? 4 : 3],
    // 남은 마지막 모든 숫자
    [0, 4]
  ];

  // 총 3번의 반복 ({2,3}) - ({3,4}) - ({4})
  target.value = textArr
    .map(function(v)  { 
  	  return value.splice(v[0], v[1]).join("") 
    })
    .filter(function(text) { 
   	  return text 
    })
    .join("-");
}
		
//우편주소 api
function daumPost(){
    new daum.Postcode({
        oncomplete: function(data) {
         console.log(data.userSelectedType)
         console.log(data.roadAddress)
         console.log(data.jibunAddress)
         console.log(data.zonecode)
         var addr=""
         if(data.userSelectedType == 'R'){
            addr = data.roadAddress
         }else{
            addr = data.jibunAddress
         }
         document.getElementById("addr1").value=data.zonecode
           $("#addr2").val( addr )
        }
    }).open();
}
function register(){
   var addr1 = $("#addr1").val()
   var addr2 = $("#addr2").val()
   $("#addr1").val( addr1+"/"+addr2 )
   fo.submit()
}
		
/* 중복체크 함수 */
//그대로 쓰고 닉네임 번호만 수정해서 사용~~(코드 변경x) 
function dupChk(userInput, chkCode){
   // chkCode 1:닉네임, 2:아이디, 3:이메일
   $.ajax({
      url : 'dupChk', type : 'post', dataType : 'json',
      data : {
         uIn : userInput,
         cIn : chkCode
      },
      success : function(data){
         if(data == "0"){
            $("#chkMsg"+chkCode).html("사용 가능");
            $("#chkMsg"+chkCode).attr("class","correct");
            if(chkCode == "1"){
               bool1 = true; // 닉네임번호 통과
            }
         }else if(data == "1"){
            $("#chkMsg"+chkCode).html("중복 (사용 불가)");
            $("#chkMsg"+chkCode).attr("class","incorrect");
            if(chkCode == "1"){
               bool1 = false; // 닉네임번호 통과실패
            }
         }
         
      }
   });
   
}

/* boo1 - 닉네임 체크 */
function nameChk(){
   mbrName = $("#mbrName").val() // 전역변수
   var nameRegExp = /^[가-힣a-zA-Z0-9]{1,10}$/; // 1~10자리 한글,영문,숫자
   
   if(mbrName == ""){ // 첫 공백 체크
      $("#chkMsg1").html("닉네임을 입력하세요")
      $("#chkMsg1").attr("class","incorrect")
      bool1 = false;
   }else if(!nameRegExp.test(mbrName)){ // 유효성 체크
      $("#chkMsg1").html("1~10자의 영문 대소문자, 한글, 숫자만 입력 가능");
      $("#chkMsg1").attr("class","incorrect");
      bool1 = false;
   }else if(dName == document.getElementById("mbrName").value){
	   //default 이름과 입력한 이름 일치 -> 통과
	   $("#chkMsg1").html("현재 닉네임 입니다.");
	   bool1 = true;
   }else{ // 중복검사
      dupChk(mbrName, "1") // 함수호출
   }
   
}
/* bool2 - 비밀번호 안전성 검사(실시간) */
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
			bool2 = true;
		}
	}else{
		message = ":: 비밀번호를 입력해 주세요 ::";
		color="#000000";
	}
	document.getElementById("makyText").innerHTML = message;
	document.getElementById("makyText").style.color = color;
}

/* bool3 - 2차 비밀번호 확인 */
function pwCheck(){
    if(document.getElementById('mbrPw').value !='' && document.getElementById("mbrPw2").value!=''){
        if(document.getElementById('mbrPw').value==document.getElementById("mbrPw2").value){
            document.getElementById('pwCheck').innerHTML=':: 2차 비밀번호가 일치합니다. ::'
            document.getElementById('pwCheck').style.color='blue';
            bool3 = true;
        }
        else{
            document.getElementById('pwCheck').innerHTML=':: 비밀번호가 일치하지 않습니다. ::';
            document.getElementById('pwCheck').style.color='red';
            bool3 = false;
        }
    }
}
//제출 전 체크항목
function subChk(){
	console.log(dName);
	console.log(document.getElementById("mbrName").value);
	
	if(document.getElementById("mbrName").value == ""){
		alert("닉네임을 입력 해주세요.")
		document.getElementById("mbrName").focus();
	}else if(document.getElementById("mbrPw").value == ""){
		alert("비밀번호를 입력해주세요.")
		mbrPw.focus();
	}else if(document.getElementById("mbrPw2").value == ""){
		alert("2차 비밀번호를 입력해주세요.")
		mbrPw2.focus();
	}
	
	//bool true인지 체크 후 제출
	//닉네임 중복 확인
	if(bool1 != true){
		alert("닉네임 다시 입력")
		mbrName.focus();
		return;
	}
	//비밀번호 조건 확인
	if(bool2 != true){
		alert("비밀번호가 조건에 부합하지 않습니다.")
		mbrPw.focus();
		return;
	}
	//2차 비밀번호 확인
	if(bool3 != true){
		alert("2차 비밀번호가 일치하지 않습니다.")
		mbrPw2.focus();
		return;
	}
	   var addr1 = $("#addr1").val()
	   var addr2 = $("#addr2").val()
	  $("#addr1").val( addr1+"/"+addr2 )
	  
  	fo.submit()
	
}
</script>

</head>
<body>
	<h1>MEMBER UPDATE</h1>
	<form id="fo" action="memberUpdate" method="post">
		<!-- 기존 닉네임. 업데이트 전송을 위해 숨김 -->
		<input type="text" value="${dto.mbrName }" name="dName" style="display:none;">
	<table border="1">
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="mbrName" id="mbrName" value="${dto.mbrName }" 
			onkeyup="nameChk()" placeholder="닉네임 입력">
			<label id="chkMsg1"></label>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><input type="text" value="${dto.mbrId }" readonly placeholder="아이디 입력"
			name="mbrId"></td>
		</tr>
			<tr>
			<th>이메일</th>
			<td><input type="text" value="${dto.mbrEmail }" readonly placeholder="이메일 입력"
			name="mbrEmail"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
			<input type="text" placeholder="새 비밀번호 입력" name="mbrPw" id="mbrPw"
			onkeyup="safetyPasswordPattern(this);" style="ime-mode:disabled;"/>
			<span id="makyText">:: 비밀번호를 입력해 주세요 ::</span>
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td>
				<input type="text" onchange="pwCheck()" placeholder="비밀번호 확인" id="mbrPw2">
				<span id="pwCheck">:: 2차 비밀번호 확인 ::</span>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<input type="text" value="${dto.mbrTel }" placeholder="010-0000-0000" 
				oninput="phoneFormat(this)" id="mbrTel" name="mbrTel">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
                <input type="text" readonly id="addr1" name="mbrAddr" placeholder="우편번호"><br>
                <input type="text" readonly id="addr2" placeholder="도로명주소, 지번주소">
                <input type="button" onclick="daumPost()" value="주소 검색">
			</td>
		</tr>
		<tr>
			<td align="right" colspan="2">
				<input type="button" onclick="subChk()" value="수정">
			</td>
		</tr>
		
		
	</table>
	<hr>
		<h6 align="right">탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.
			<input type="button" onclick="" value="회원탈퇴">
		</h6>
	</form>
	

</body>
</html>