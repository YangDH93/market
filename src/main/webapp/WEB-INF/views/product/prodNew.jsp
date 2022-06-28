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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
/* 글자수 제한 */
$(document).ready(function(){
	$("#textbox").on('keyup',function(){
		$("#textcount").html("("+$(this).val().length+" / 500)");
		
		if($(this).val().length > 500){
			$(this).val($(this).val().substring(0,500));
			alert("글자수는 500자까지 입력 가능합니다.")
			$("#textcount").html("(500 / 500)");
		}
	});
});
</script>


<style type="text/css">
.flex {
   display: flex;
}
.flex-direction{
   flex-direction:column;
}
.size{
   height: 150px;
   width: 150px;
}
.size2{
   height: 100px;
   width: 100px;
}

</style>
</head>
<body>
<%@include file="../default/header.jsp" %>
   <form id="fo" action="prodRegister" method="post">
      <section class="eeRGVw">
         <div>
               <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">기본 정보
               <span style="color: red; font-size: medium;">*은 필수항목 입니다.</span></h2>
            <div class="flex">
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size">
               상품 이미지<label>*</label>
            </div>
            <div>
               <input type="file" accept="image/jsp, image/jpeg, image/png" multiple><br> 설명맨~
            </div>
         </div>
         <hr>
         <div class="flex">
            <div>
               제목<label>*</label>
            </div>
            <div>
               <input type="text" name="title" placeholder="상품 제목을 입력해주세요.">
            </div>
         </div>
         <hr>
         <div class="flex">
            <div class="size">
               카테고리<label>*</label>
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
               거래지역<label>*</label>
            <div class="size2">
            <div>
               	<div>
                  <input type="button" value="내 위치">
                  <input type="button" onclick="daumPost()" value="주소 검색"><br>
                </div>
                  <input type="text" readonly id="addr1" name="addr" placeholder="우편번호"><br>
                  <input type="text" readonly id="addr2" placeholder="도로명주소, 지번주소"><br>
               </div>
            </div>
         </div>
         <hr>
         <div class="flex">
            <div>
               가격<label>*</label>
            </div>
            <div>
               <input type="text" name="price" placeholder="숫자만 입력해주세요."
               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">원<br><br>
            </div>
         </div>
         <hr>
         <div class="flex">
            <div>
               설명<label>*</label>
            </div>
            <div>
            <textarea id="textbox" maxlength="500" style="resize: none;"
               rows="6" cols="50" placeholder="상품 설명을 작성해주세요."></textarea>
			   <div id="textcount">(0 / 500)</div>
            </div>
         </div>
         <hr>
         <div>
            <input type="submit" value="등록하기">
         </div>
      </section>
   </form>
<%@include file="../default/footer.jsp" %>
</body>
</html>