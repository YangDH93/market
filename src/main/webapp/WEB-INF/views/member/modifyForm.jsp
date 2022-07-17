<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="dto" value="${mbrInfo }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.correct {
	color: green;
	font-size: 16px;
}

.incorrect {
	color: red;
	font-size: 16px;
}

.modify {
	display: flex;
	justify-content: center;
	margin-top: 58px;
	font-size: 18px;
}

.fb {
	width: 90px;
	height: 25px;
	border-radius: 5px;
	border: 1px solid #FFA200;
	color: #414141;
	background-color: #FFFFFF;
	margin-left: 395px;
	font-size: 16px;
	padding-bottom: 3px;
	cursor: pointer;
}

.input_st {
	outline-style: none;
	border-color: #FFA200;
	border-top: none;
	border-left: none;
	border-right: none;
	width: 355px;
	font-size: 16px;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
           $("#addr2").val( addr )
        }
    }).open();
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
			message = "최소 8자 이상, 최대 16자 이하";
			color = "#FF0000"
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
                message = "보안성이 취약한 비밀번호";
                color = "#F0000";
            } else if(checkPoint == 2) {
                message = "보안성이 낮은 비밀번호";
                color = "#FF0000";
            } else if(checkPoint == 1) {
                message = "보안성이 보통인 비밀번호";
                color = "#FF0000";
            } else {
                message = "보안성이 강력한 비밀번호";
                color = "#006600";
            }
			bool2 = true;
		}
	}else{
		message = "비밀번호를 입력해 주세요";
		color="#000000";
	}
	document.getElementById("makyText").innerHTML = message;
	document.getElementById("makyText").style.color = color;
}

/* bool3 - 2차 비밀번호 확인 */
function pwCheck(){
    if(document.getElementById('mbrPw').value !='' && document.getElementById("mbrPw2").value!=''){
        if(document.getElementById('mbrPw').value==document.getElementById("mbrPw2").value){
            document.getElementById('pwCheck').innerHTML='2차 비밀번호가 일치합니다.'
            document.getElementById('pwCheck').style.color='green';
            bool3 = true;
        }
        else{
            document.getElementById('pwCheck').innerHTML='비밀번호가 일치하지 않습니다.';
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
		alert("닉네임을 다시 입력해주세요")
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
	   var addr2 = $("#addr2").val()
	
	alert("회원정보 수정이 완료되었습니다.")
  	fo.submit()
	
}

function deleteChk(){
    if (!confirm("정말 계정을 삭제 하시겠습니까?")) {
    	alert("계정 삭제를 취소하셨습니다. 메인 화면으로 돌아갑니다.");
        location.href="../";
    } else {
    	alert("계정 삭제가 완료되었습니다. 메인 화면으로 돌아갑니다.")
    	delfo.submit();    	
    }
}
</script>

</head>
<body>
	<div class="modify">
		<form id="fo" action="memberUpdate" method="post">
			<!-- 기존 닉네임. 업데이트 전송을 위해 숨김 -->
			<input type="text" value="${dto.mbrName }" name="dName"
				style="display: none;">

			<table>
				<tr>
					<td colspan="2" align="center"><img
						style="width: 300px; height: 300px;"
						src="${contextPath}/resources/image/duck.png"
						onclick="location.hrer='http://localhost:8085/root/'" /></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input class="input_st" type="text" name="mbrName"
						id="mbrName" value="${dto.mbrName }" onkeyup="nameChk()">
					</td>
				</tr>
				<tr>
					<td></td>
					<td><label id="chkMsg1"></label></td>
				</tr>

				<tr>
					<td>아이디</td>
					<td><input class="input_st" type="text" value="${dto.mbrId }"
						readonly name="mbrId"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>

				<tr>
					<td>비밀번호</td>
					<td><input class="input_st" type="text" name="mbrPw"
						id="mbrPw" onkeyup="safetyPasswordPattern(this);"
						style="ime-mode: disabled;"></td>
				</tr>
				<tr>
					<td></td>
					<td><span id="makyText"
						style="color: red; font-size: 16px; margin-left: 4px;">비밀번호를
							입력해 주세요</span></td>
				</tr>

				<tr>
					<td>비밀번호 확인</td>
					<td><input class="input_st" type="text" onchange="pwCheck()"
						id="mbrPw2"></td>
				</tr>
				<tr>
					<td></td>
					<td><span id="pwCheck"
						style="color: red; font-size: 16px; margin-left: 4px;">2차
							비밀번호를 확인해주세요</span></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input class="input_st" type="text"
						value="${dto.mbrEmail }" readonly name="mbrEmail"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input class="input_st" type="text" value="${dto.mbrTel }"
						oninput="phoneFormat(this)" id="mbrTel" name="mbrTel"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>

				<tr>
					<td>주소</td>
					<td><input class="input_st" type="text" readonly id="addr2"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2" style="padding-top: 3px; padding-bottom: 35px;">
						<input type="button" onclick="daumPost()" value="주소찾기" class="fb">
					</td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="button"
						value="수정완료" onclick="subChk()"
						style="cursor: pointer; font-weight: 500; color: #FFFFFF; background-color: #FFA200; border: 0px; border-radius: 10px; font-size: 18px; width: 100%; height: 50px;">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div style="font-size: 13px; display: flex; justify-content: center;">
		&nbsp;&nbsp; <input type="text" value="${dto.mbrId }" name="mbrId"
			style="display: none;"> <a onclick="deleteChk()"
			style="cursor: pointer; color: #FFA200; font-weight: bold;">회원
			탈퇴를 원하시면 여기를 눌러주세요</a>
	</div>
</body>
</html>