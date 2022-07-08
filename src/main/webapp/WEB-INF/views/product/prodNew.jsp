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
         var trdLocation=data.jibunAddress
         document.getElementById("trdLocation").value=data.zonecode
           $("#trdLocation").val( trdLocation )
         } 
    }).open();
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


let uuidList = "";
let orgImg = "";
var count = 0; 
/* 파일 추가  */
$(document).ready(function(){
	 $("#fileItem").change(function(e){
		
		let formData = new FormData(); 
		let fileInput = $('input[name="uploadImg"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		
		for(let i = 0; i < fileList.length; i++){
			formData.append("uploadImg", fileList[i]);
			let fileObj = fileList[i];
			let reader = new FileReader();
			reader.readAsDataURL(fileObj);
		 }
		
		// 이미지 파일 저장 및 출력
		$.ajax({
			url: 'uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		$('#uploadPath').val(result[0].uploadPath);
	    		for(let i=0;i<result.length;i++){
	    			uuidList += result[i].uuid;
	    			orgImg += result[i].orgImg;
	    			if(i != result.lenght-1){
		    			uuidList += "/";
		    			orgImg += "/";
	    			}
		    		count++;
    				console.log(count);
	    		}
	    			    		
    			if(count >= 10){
    				alert("이미지는 10개까지 가능합니다");
    				return false;
    			}
    			
    			// 월요일에 나 부탁해 이미지 10개 들어가는 부분 수정 필요 
    			
	    		/* 이미지 출력 부분 */
	    		showUploadImage(result);
	    		
	    		/* UUID 추가 부분 */
	    		$('#UUID').val(uuidList);
	    		console.log(uuidList);
	    		
	    		/* orgImg 추가 부분 */
	    		$('#orgImg').val(orgImg);
	    		console.log(orgImg);
	    		
	    	},
	    	error : function(result){
	    		alert("해당 종류의 파일은 업로드할 수 없습니다.");
	    	}
		});	
	});
});

/* 이미지 출력 */
function showUploadImage(uploadResultArr){
	
	/* 전달받은 데이터 검증 */
	if(!uploadResultArr || uploadResultArr.length == 0){return}
	
	let uploadResult = $("#uploadResult");
	for(let i=0;i<uploadResultArr.length;i++){
		let obj = uploadResultArr[i];
		let str = "";
		let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.orgImg;
		str += "<div style='margin: 5px;'>"
		str += "<img src='${contextPath}/product/display?fileName=" + fileCallPath +"' width='120px' height='120px' >";
		str += "<div class='imgDeeteBtn'>x</div>";
		str += "</div>"; 
		
		uploadResult.append(str);
	}
    
}

/* 파일 유효성 테스트 */
let regex = new RegExp("(.*?)\.(jpg|png|PNG|JPG|JPEG|jpeg)$");
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
	if($('#fileItem').val() == ''){
		$("#fileItem").focus();
		alert('이미지는 필수항목 입니다.');
	}else if($('#prodTitle').val() == ''){
		$("#prodTitle").focus();
		alert('제목은 필수항목 입니다.');
	}else if($('#trdLocation').val() == ''){
		$("#trdLocation").focus();
		alert('주소는 필수항목 입니다');
	}else if($('#price').val() == ''){
		$("#price").focus();
		alert('가격은 필수항목 입니다.');
	}else if($('#category').val() == ''){
		$("#category").focus();
		alert('카테고리는 필수항목 입니다');
	}else if($('#prodContent').val() == ''){
		$("#prodContent").focus();
		alert('상품은 설명은 필수항목 입니다');
	}else{
		frm.submit();
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
   <form id="frm" action="${contextPath}/product/prodRegister" method="post">	
      <section class="eeRGVw">
   	  	 <input name="mbrId" value="${loginUser}" style="display: none;">
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
                	<input type='file' accept='.jpg, .jpeg, .png' id="fileItem" name='uploadImg' multiple>
                </div>
                <div id="uploadResult" class="flex" style="width: 600; flex-flow: wrap;">
					<!-- <img id="preview" src="#" width="100" height="100" alt="선택 이미지 없음"> -->
				</div>
         	</div>	
         	<input id="orgImg" name='orgImg' style="display: none;">
         	<input id="uploadPath" name='uploadPath' style="display: none;">
         	<input id="UUID" name='UUID' style="display: none;">
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
                  <input type="text" readonly id="trdLocation" name="trdLocation" placeholder="도로명주소, 지번주소"><br>
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
            <textarea id="prodContent" name="prodContent" maxlength="500" style="resize: none;"
               rows="8" cols="100" placeholder="상품 설명을 상세히 작성해주세요.(10자 이상)"></textarea>
            <div id="textcount">(0 / 500)</div>
            </div>
         </div>
         <hr>
	      <div>
	         <input type ="button" onclick="buttonChk()" value="등록하기">
	      </div>
      </section>
   </form>	
<%@ include file="../default/footer.jsp" %>

</body>
</html>