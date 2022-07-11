<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
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
function daumPost() {
	new daum.Postcode({
		oncomplete : function(data) {
			console.log(data.userSelectedType)
			console.log(data.roadAddress)
			console.log(data.jibunAddress)
			console.log(data.zonecode)
			var addr = ""
			if (data.userSelectedType == 'R') {
				addr = data.roadAddress
			} else {
				addr = data.jibunAddress
			}
			document.getElementById("addr1").value = data.zonecode
			$("#addr2").val(addr)
		}
	}).open();
}
function register() {
	var addr1 = $("#addr1").val()
	var addr2 = $("#addr2").val()
	$("#addr1").val(addr1 + "/" + addr2)
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

/* 파일 추가  */
$(document).ready(function() {
	$("#fileItem").change(function(e) {

		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		if (!fileCheck(fileObj.name, fileObj.size)) {
			fileList = null;
			return false;
		}

		for (let i = 0; i < fileList.length; i++) {
			formData.append("uploadFile", fileList[i]);
			let fileObj = fileList[i];
			console.log(fileObj)
			let reader = new FileReader();
			reader.readAsDataURL(fileObj);//파일의 정보를 토대로 파일 읽고
			reader.onload = function(e) { //파일 로드한 값을 표현
				// e : 이벤트 안에 result값이 파일의 정보를 가지고 있다
				$("#preview").attr('src', e.target.result);
			}
		}

		/* formData.append("uploadFile", fileObj); */

		$.ajax({
			url : 'uploadAjaxAction',
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

function fileCheck(fileName, fileSize) {

	if (fileSize >= maxSize) {
		alert("파일 사이즈 초과");
		return false;
	}

	if (!regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}

	return true;

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


/* 필수항목 체크 */
function buttonChk() {
	if ($('#fileItem').val() == '') {
		$("#fileItem").focus();
		alert('이미지는 필수항목 입니다.');
	} else if ($('#prodTitle').val() == '') {
		$("#prodTitle").focus();
		alert('제목은 필수항목 입니다.');
	} else if ($('#addr1').val() == '') {
		$("#addr1").focus();
		alert('우편번호는 필수항목 입니다');
	} else if ($('#addr2').val() == '') {
		$("#addr2").focus();
		alert('도로명주소,지번주소는 필수항목 입니다');
	} else if ($('#price').val() == '') {
		$("#price").focus();
		alert('가격은 필수항목 입니다.');
	} else if ($('#cateCode').val() == '') {
		$("#cateCode").focus();
		alert('카테고리는 필수항목 입니다');
	} else if ($('#prodContent').val() == '') {
		$("#prodContent").focus();
		alert('상품은 설명은 필수항목 입니다');
	} else {
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

/* 카테고리 wrap */
.catewrap{
	width: 1000px;
    display: flex;
}
/* 카테고리 box */
.cateBox1,
.cateBox2,
.cateBox3{
	float: left;
	border: 1px solid #ccc;
	width: 30%;
	height: 300px;
	overflow: auto;
}
/* 카테고리 리스트 */
.cate1List,
.cate2List,
.cate3List{
	padding: 10px;
	text-align: left;
	cursor: pointer;
	transition: 0.3s;
}
/* 카테고리 리스트 hover */
.cate1List:hover, 
.cate2List:hover, 
.cate3List:hover{
	background-color: #FFEFB9;
}

.cate1List.active,
.cate2List.active,
.cate3List.active {
  background-color: gold;
}


</style>
</head>
<body>
<%@include file="../default/header.jsp" %>

   <form id="frm" action="${contextPath }/product/prodRegister" method="post">
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
	         	<input type="text" id="cateCode" name="cateCode" style="display: none;">
            </div>
            
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
			<br>
		</div>
		
		<div>
			<label>선택한 카테고리 : </label>
			<span id="userSel1"></span>
			<span id="userSel2"></span>
			<span id="userSel3"></span>
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