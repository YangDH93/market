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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<head>
<meta charset="UTF-8">
<!-- 우편번호 및 주소 -->
<script>
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

$(document).ready(function(){
   $("#prodContent").on('keyup',function(){
      $("#textcount").html("("+$(this).val().length+" / 500)");
      
      if($(this).val().length > 500){
         $(this).val($(this).val().substring(0,500));
         alert("글자수는 500자까지 입력 가능합니다.")
         $("#textcount").html("(500 / 500)");
      }
   });
});
	
/* 파일 추가  */
$(document).ready(function(){
	 $("#fileItem").change(function(e){
		
		let formData = new FormData(); 
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		if(!fileCheck(fileObj.name, fileObj.size)){
			fileList = null;
			return false;
		}
		
		for(let i = 0; i < fileList.length; i++){
			formData.append("uploadFile", fileList[i]);
			let fileObj = fileList[i];
			console.log(fileObj)
			let reader = new FileReader();
			reader.readAsDataURL(fileObj);//파일의 정보를 토대로 파일 읽고
			reader.onload = function(e){ //파일 로드한 값을 표현
				// e : 이벤트 안에 result값이 파일의 정보를 가지고 있다
				$("#preview").attr('src',e.target.result); 
			}
		 }
	
		/* formData.append("uploadFile", fileObj); */
		
		$.ajax({
			url: 'uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json'
		});	
		
	});
});

/* 파일 유효성 테스트 */
let regex = new RegExp("(.*?)\.(jpg|png|PNG|JPG)$");
let maxSize = 1048576; //1MB	

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
		  
	if(!regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	
	return true;		
	
}
	
	
/* 필수항목 체크 */
function buttonChk(){
	if($('#prodContent').length < 10){
		$('#textChk').html('글자수 부족');
	}	
	
	
	if($('#fileItem').val() == ''){
		alert('이미지는 필수항목 입니다.');
		$("#fileItem").focus();
	}else if($('#prodTitle').val() == ''){
		alert('제목은 필수항목 입니다.');
		$("#prodTitle").focus();
	}else if($('#addr1').val() == ''){
		alert('우편번호는 필수항목 입니다');
		$("#addr1").focus();
	}else if($('#addr2').val() == ''){
		alert('도로명주소,지번주소는 필수항목 입니다');
		$("#addr2").focus();
	}else if($('#price').val() == ''){
		alert('가격은 필수항목 입니다.');
		$("#price").focus();
	}else if($('#category').val() == ''){
		alert('카테고리는 필수항목 입니다');
		$("#category").focus();
	}else if($('#prodContent').val() == ''){
		alert('상품은 설명은 필수항목 입니다');
		$("#prodContent").focus();
	}else{
		fo.submit();
	}
}

</script>

<style type="text/css">
.flex {
   display: flex;
}
.flex-direction{
   flex-direction:column;
}
.size_150{
   height: 150px;
   width: 150px;
}
.size2{
   height: 100px;
   width: 100px;
}
.size_30{
	height: 30px;
	width: 150px;
}
.redmen{
	color: red;
	font-size: medium;
}

</style>
</head>

<body>
<%@include file="../default/header.jsp" %>
   <form id="fo" action="${contextPath }" method="post">
      <section class="eeRGVw">
         <div>
               <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">기본 정보
               <span class="redmen">*은 필수항목 입니다.</span></h2>
            <div class="flex">
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size_150">
               	상품 이미지<span class="redmen">*</span>
            </div>
            <div>
            	<div>
                	<input type='file' accept='.jpg, .jpeg, .png' id="fileItem" name='uploadFile' multiple>
                </div>
                <div>
					<img id="preview" src="#" width="100" height="100" alt="선택 이미지 없음">
				                    									<!-- 선택 이미지 없음 사진 추가  -->
				</div>
            </div>
         </div>	
         <hr>
         <div class="flex">
            <div class="size_30">
              	 제목<span class="redmen">*</span>
            </div>
            <div>
               <input type="text" id="prodTitle" name="prodTitle" placeholder="상품 제목을 입력해주세요." size="100px">
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size_150">
               	카테고리<span class="redmen">*</span>
            </div>
            <div>
               <div>
                  <ul>
                     <li>의상</li>
                     <li>신발</li>
                     <li>아무개</li>
                  </ul>
                  <ul style="display: none;">
                     <li>남성</li>
                     <li>여성</li>
                     <li>아동</li>
                  </ul>
                  <ul style="display: none;">
                     <li>큰사이즈</li>
                     <li>중간사이즈</li>
                     <li>작은사이즈</li>
                  </ul>
               <br>
               <label>선택한 카테고리 : </label>
               </div>
            </div>
         </div>
         <hr>
        <div class="flex">
        	<div class="size_150">
              	 거래지역<span class="redmen">*</span>
            </div>
            <div class="size2">
            <div>
                 <div>
                  <input type="button" value="내 위치"><br>
                  <input type="button" onclick="daumPost()" value="주소 검색"><br>
                </div>
                  <input type="text" readonly id="addr1" name="addr" placeholder="우편번호"><br>
                  <input type="text" readonly id="addr2" placeholder="도로명주소, 지번주소"><br>
               </div>
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size_30">
               	가격<span class="redmen">*</span>
            </div>
            <div>
               <input type="text" id="price" name="price" placeholder="숫자만 입력해주세요."
               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">원<br><br>
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size_150">
               	설명<span class="redmen">*</span>
            </div>
            <div>
            <textarea id="prodContent" maxlength="500" style="resize: none;"
               rows="8" cols="100" placeholder="상품 설명을 상세히 작성해주세요.(10자 이상)"></textarea>
            <div id="textcount">(0 / 500)<span id="textChk" class="redmen"> </span></div>
            </div>
         </div>
         <hr>
	      <div>
	         <input type="button" onclick="buttonChk()" value="등록하기">
	      </div>
      </section>
   </form>	
<%@ include file="../default/footer.jsp" %>
</body>
</html>