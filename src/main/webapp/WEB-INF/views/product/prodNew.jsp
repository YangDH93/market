<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
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
         document.getElementById("trdLocation").value=data.zonecode;
	         $("#mes2").css({
					"color" : "red",
					"font-size" : "12px"
		   	 });
		   	 $("#mes2").html('주소가 입력되었습니다.');
	         $("#trdLocation").val(trdLocation);
         } 
    }).open();
}
$(document).ready(function() {
   $("#prodContent").on('keyup', function() {
      $("#textcount").html("(" + $(this).val().length + " / 500)");
      if ($(this).val().length > 500) {
         $(this).val($(this).val().substring(0, 500));
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
	    		
	    		if(count==0 && result.length > 1){
	    			$("#mes1").css({
	    				"color" : "red",
	    				"font-size" : "13px"
	    			});
	    			$("#mes1").html('먼저 대표 사진 1장만 등록해주세요!');
	    			return false;
	    		}else if(count+result.length > 10){
	    			alert("이미지는 최대 10개까지 등록 가능합니다.\n\n 현재 이미지 갯수 : " + count);
	    			return false;
	    		}
	    		for(let i=0;i<result.length;i++){
	    			console.log(count);
	    			
	    			uuidList += result[i].uuid;
	    			orgImg += result[i].orgImg;
	    			if(i != result.lenght-1){
		    			uuidList += "/";
		    			orgImg += "/";
	    			}
		    		count++;
		    		$("#mes").html("현재 등록된 사진 갯수: " + count +"/10");
	    		}
	    			    		
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
	let uploadResult1 = $('#uploadResult1');
	let uploadResult2 = $('#uploadResult2');
	for(let i=0;i<uploadResultArr.length;i++){
		let obj = uploadResultArr[i];
		let str = "";
		let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.orgImg;
		
		if(count == 1){
			str += "<div>"
			str += "<div style='margin: 5px;'>"
			str += "<img id='imgMen' src='${contextPath}/product/display?fileName=" + fileCallPath +"' width='200px' height='200px'>";
			str += "</div></div>"; 
			uploadResult1.append(str);
			
		}
		str = "";
		str += "<div style='margin: 5px;'>"
		str += "<img id='imgSelect' onclick='mouseClick(this)' src='${contextPath}/product/display?fileName=" + fileCallPath +"' width='50px' height='50px'>";
		str += "</div>"; 
		uploadResult2.append(str);
	}
	$("#mes1").css({
		"color":"blue",
		"font-size" : "12px"
	});
	$("#mes1").html(" 첫 번째 등록된 사진이 대표 사진입니다.");
}

function mouseClick(obj){
	var img = document.getElementById("imgSelect"); 
	document.getElementById("imgMen").src = obj.src;
}	

function resetImg() {
	count = 0;
	uuidList = "";
	orgImg = "";
	/* 사진 출력 리셋부분 */
	$("#uploadResult1").empty();
	$("#uploadResult2").empty();
	/* UUID 리셋부분 */
	$('#UUID').empty();
	/* orgImg 리셋부분 */
	$('#orgImg').empty();
	$("#mes1").css({
		"color":"blue",
		"font-size" : "12px"
	});
	$("#mes").html(" 현재 등록된 사진 갯수: 0/10");
	$("#mes1").html(" 첫 번째 등록된 사진이 대표 사진입니다.");
}

/* 카테고리 관련코드 */
/* 카테고리 하위 목록 ajax */
function getList(sltCode,num){
   $.ajax({
      url : 'getList', type : 'post', dataType : 'json',
      data : { sltCode : sltCode },
      success : function(list){
         
         let str = "";
         let lab = "";
         
         if(num == 1){
            for(let i=0; i<list.length; i++){
               str += '<div class="cate2List" onclick="openCate2(event,'+list[i].cateCode+", '"+list[i].cateName+"'"+')">'+list[i].cateName+'</div>';
            }
            $(".cateBox2").append(str);
            
         }else if(num == 2){
            for(let i=0; i<list.length; i++){
               str += '<div class="cate3List" onclick="openCate3(event,'+list[i].cateCode+", '"+list[i].cateName+"'"+')">'+list[i].cateName+'</div>';
            }
            $(".cateBox3").append(str);
         }
      }
   });
}

/* 카테고리 중분류 목록 이벤트 */ 
function openCate(evt, sltCode, name) { //대분류 코드, 이름
   
   $('input[name=cateCode]').attr('value',sltCode); // 카테고리저장 
   
   var cate1List = $(".cate1List");
   
   /* ==========기존삭제========== */
   
   for (var i = 0; i < cate1List.length; i++) {
      cate1List[i].className = cate1List[i].className.replace(" active", "");
   }

   $(".cateBox2").empty(); //기존 중분류 목록 지움
   $(".cateBox3").empty(); //기존 소분류 목록 지움
   
   $("#userSel2").text("") //기존 중분류 이름 지움
   $("#userSel3").text("") //기존 소분류 이름 지움
   
   /* ==========새로생성========== */
   
   $("#userSel1").text(name) //선택한 대분류 이름 들어옴
   evt.currentTarget.className += " active"; //색상변경

   getList(sltCode,"1") //ajax 리스트 불러옴
   
}
/* 카테고리 소분류 목록 이벤트 */
function openCate2(evt, sltCode, name) { //소분류 나타남
   
   $('input[name=cateCode]').attr('value',sltCode); // 카테고리저장 
   
   var cate2List = $(".cate2List");
   
   /* ==========기존삭제========== */

   for (var i = 0; i < cate2List.length; i++) {
      cate2List[i].className = cate2List[i].className.replace(" active", "");
   }
   $(".cateBox3").empty(); //기존 소분류 목록 지움
   $("#userSel3").text("") //기존 소분류 이름 지움
   
   /* ==========새로생성========== */
   
   $("#userSel2").text(" > "+name) //선택한 중분류 이름 들어옴
   evt.currentTarget.className += " active"; //색상변경
   
   getList(sltCode,"2") //ajax 리스트 불러옴
}
/* 카테고리 소분류  */
function openCate3(evt, sltCode, name) { //소분류 나타남
   
   $('input[name=cateCode]').attr('value',sltCode); // 카테고리저장 
   
   var cate3List = $(".cate3List");
   
   /* ==========기존삭제========== */
   
   for (var i = 0; i < cate3List.length; i++) {
      cate3List[i].className = cate3List[i].className.replace(" active", "");
   }
   
   /* ==========새로생성========== */
   
   $("#userSel3").text(" > "+name) //선택한 소분류 이름 들어옴
   evt.currentTarget.className += " active"; //색상변경
}

function myLocation(){
	   let place = document.getElementById("place").value;
	   console.log(place);
	   if(place == ""){
		   $("#mes2").html("회원정보 수정란에서 내 위치(주소)를 추가할 수 있습니다.");
	   }
	   $("#trdLocation").val(place);
}

/* 필수항목 체크 */
function buttonChk(){
	if($('#orgImg').val() == ''){
		$("#orgImg").focus();
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
	}else if($('#cateCode').val() == ''){
		$("#cateCode").focus();
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

.flex-direction {
   flex-direction: column;
}

.size_150 {
   height: 150px;
   width: 150px;
}

.size2 {
   height: 100px;
   width: 500px;
}

.size_30{
   height: 30px;
   width: 150px;
}
.redmen{
   color: red;
   font-size: medium;
}

/* 카테고리 wrap */
.catewrap {
   width: 874px;
   display: flex;
}
/* 카테고리 box */
.cateBox1, .cateBox2, .cateBox3 {
   float: left;
   border: 1px solid #ccc;
   width: 30%;
   height: 300px;
   overflow: auto;
   border-radius: 3px;
}
/* 카테고리 리스트 */
.cate1List, .cate2List, .cate3List {
   padding: 10px;
   text-align: left;
   cursor: pointer;
   transition: 0.3s;
}
/* 카테고리 리스트 hover */
.cate1List:hover, .cate2List:hover, .cate3List:hover {
   background-color: #FFD823;
}

.cate1List.active, .cate2List.active, .cate3List.active {
   background-color: #FFD823;
}

#psub {
   margin-left:830px;
   width: 100px;
   height: 40px;
   background-color: #FFA200;
   border: 0px;
   border-radius: 5px;
   color: #FFFFFF;
   font-weight: 500;
   cursor: pointer;
}

</style>
</head>
<body>
   <%@include file="../default/header.jsp"%>
   <form id="frm" action="${contextPath }/product/prodRegister"
      method="post">
      <section class="eeRGVw">
         <input name="mbrId" value="${loginUser}" style="display: none;">
         <div>
            <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
               기본 정보 <span class="redmen">*은 필수항목 입니다.</span>
            </h2>
            <div class="flex"></div>
         </div>
         <div class="flex">
            <div class="size_150">
                 	 상품 이미지<span class="redmen">*</span>
            </div>
            <div>
            	<div style="padding-bottom: 10px;">
            		<label for="fileItem" style="padding: 3px; width: 80px; height: 30px; background-color: #FFFFFF; border-radius: 5px; border: 1px solid #FFA200; color: #414141; cursor: pointer;">이미지 첨부</label>
                	<input type='file' accept='.jpg, .jpeg, .png' id="fileItem" name='uploadImg' multiple style="display: none;">
                	<label for="pr" style="padding: 3px; margin-left: 10px; width: 80px; height: 30px; background-color: #FFFFFF; border-radius: 5px; border: 1px solid #FFA200; color: #414141; cursor: pointer;">이미지 리셋</label>
                	<input type="button" id="pr" value="사진 리셋" onclick="resetImg()"  style="display: none;">
                	<span id="mes" style="font-size: 12px;">현재 등록된 사진 갯수: 0/10</span>
                </div>
                <div><h2>[ 대표사진 ]<span id ="mes1" style="color:blue; font-size: 12px;"> 첫 번째 등록된 사진이 대표 사진입니다.</span></h2></div>
                <div id="uploadResult1" class="flex" style="width: 200; flex-flow: wrap;"></div>
                <div id="uploadResult2" class="flex" style="width: 600; flex-flow: wrap;"></div>
         	</div>	
         	<input id="orgImg" name='orgImg' style="display: none;">
         	<input id="uploadPath" name='uploadPath' style="display: none;">
         	<input id="UUID" name='UUID' style="display: none;">
         </div>
         <div class="flex" style="padding-top: 10px;">
            <div class="size_30">
                  제목<span class="redmen">*</span>
            </div>
            <div>
               <input type="text" id="prodTitle" name="prodTitle"
                  placeholder="상품 제목을 입력해주세요." size="100px"
                  style="outline-style: none; border-color: #FFA200; border-top: none; border-left: none; border-right: none; width: 778px;">
            </div>
         </div>
         <br>
         <div class="flex">
	            <div class="size_150">
	                 	 카테고리<span class="redmen">*</span>
	               <input type="text" id="cateCode" name="cateCode" style="display: none;">
	            </div>
			<div>  
				<div class="catewrap">
				  <div class="cateBox1">
				     <c:forEach var="dto" items="${cateList }">
				        <div class="cate1List" onclick="openCate(event,'${dto.cateCode}','${dto.cateName }')">${dto.cateName }</div>
				     </c:forEach>
				   </div>
				
				   <div class="cateBox2">
				   </div>
				
				   <div class="cateBox3">
				   </div>
				
				</div>
				
				<div class="flex">
			      <div style="padding: 10px 0">
			         <label>선택한 카테고리 : </label>
			         <span id="userSel1"></span>
			         <span id="userSel2"></span>
			         <span id="userSel3"></span>
			      </div>
      			</div>
			
			</div>
         
      </div>

        
        <div class="flex">
           <div class="size_150">
                 	 거래지역<span class="redmen">*</span>
            </div>
            <div class="size2">
                <div>
                   <input type="text" readonly style="display: none;" id="place" value="${mbrAddr.mbrAddr}">
                   <input type="button" value="내 위치" onclick="myLocation()"
                      style="cursor: pointer; padding: 3px; width: 70px; height: 30px; background-color: #FFFFFF; border-radius: 5px; border: 1px solid #FFA200; color: #414141;">                           
                   <input type="button" onclick="daumPost()" value="주소 검색"
                      style="padding: 3px; margin-left: 15px; width: 80px; height: 30px; background-color: #FFFFFF; cursor: pointer; border-radius: 5px; border: 1px solid #FFA200; color: #414141;">
                   <span id="mes2" style="color:blue; font-size: 12px;"></span>
                </div>
               	<div>
                   <input type="text" readonly id="trdLocation" name="trdLocation" placeholder="도로명주소, 지번주소"
                      style="padding-top:10px; outline-style: none; border-color: #FFA200; border-top: none; border-left: none; border-right: none; width: 530px;">
                </div>     
            </div>
         </div>
         <div class="flex" style="margin-top: -60px;">
            <div class="size_30">
                               가격<span class="redmen">*</span>
            </div>
            <div>
               <input type="text" id="price" name="price"
                  placeholder="숫자만 입력해주세요."
                  style="outline-style: none; border-color: #FFA200; border-top: none; border-left: none; border-right: none; width: 220px;"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;원<br>
               <br>
            </div>
         </div>
         <div class="flex">
            <div class="size_150">
                                설명<span class="redmen">*</span>
            </div>
            <div>
               <textarea id="prodContent" name="prodContent" maxlength="500"
                  style="resize: none; outline-style: none; border-color: #C0C0C0; border-radius: 3px; width: 793px;"
                  rows="8" cols="100" placeholder="상품 설명을 상세히 작성해주세요."></textarea>
               <div id="textcount">(0 / 500)</div>
            </div>
         </div>
         <div class="flex">
            <input type="button" id="psub" onclick="buttonChk()" value="등록하기">
         </div>
      </section>
   </form>
<%@ include file="../default/footer.jsp"%>
</body>
</html>