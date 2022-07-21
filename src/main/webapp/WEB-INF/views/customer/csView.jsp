<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="cs" value="${cs }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
#modal_wrap{
	display: none;
	position: fixed;
	z-index: 9;
	margin: 0 auto;
	top:0;
	left: 0;
	right: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}
#first{
	display: none;
	position: fixed;
	z-index: 10;
	margin: 0 auto;
	top: 30px;
	left: 0;
	right: 0;
	width: 350px;
	height: 450px;
	background-color: rgba(247, 212, 106, 0.9);
	text-align: center;
}
.btn{
	background-color: #FFA200;
	border: 0px;
	color: white;
	border-radius: 5px;
	padding: 3px;
	font-weight: 600;
	cursor: pointer;
}
.t_div{
	margin-top: 130px;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function slideClick(){
	$("#first").slideDown("slow");
	$("#modal_wrap").show();
}
function slide_hidde(){
	$("#first").hide()
	$("#modal_wrap").hide()
}

function deleteChk(){
    if (!confirm("이 문의글을 삭제 하시겠습니까?")) {
    	alert("삭제를 취소하셨습니다.");
        location.href="#";
    } else {
    	alert("글 삭제가 완료되었습니다. 문의목록 화면으로 돌아갑니다.");
    	location.href="csContentDel?csNum="+${cs.csNum };
    }
}

function rep(){
	let form={};
	let arr = $("#frm").serializeArray();
	for(i=0; i<arr.length;i++){
		form[arr[i].name] = arr[i].value
	}
	console.log(form)
	$.ajax({
		url:"addReply", type:"post",
		data: JSON.stringify(form),
		contentType:"application/json; charset=utf-8",
		success: function(){
			alert("답글이 달렸습니다");
			slide_hidde();
			replyData();
		}
	})
}
function replyData(){
	$.ajax({
		url:"replyData/"+${cs.csNum}, type:"get",
		dataType:"json",
		success: function(rep){
			console.log( rep );
			let html = "";
			rep.forEach(function(data){
				let d = new Date(data.write_date);
				let w_d = d.getFullYear()+"년";
				w_d += d.getMonth()+1+"월";
				w_d += d.getDate()+"일";
				w_d += d.getHours()+"시";
				w_d += d.getMinutes()+"분";
				w_d += d.getSeconds()+"초";
				
html += "<div align='left'><b>아이디 : </b>"+data.id+"님 / ";
html += "<b>작성일</b> : "+w_d+"<br>";
html += "<b>제목</b> : "+data.title+"<br>";
html += "<b>내용</b> : "+data.content+"<hr></div>";
			})
			$("#reply").html(html);
		}
	})
}
</script>
</head>
<body onload="replyData()">
<%-- <%@include file="../default/header.jsp" %> --%>
<section class="eeRGVw">
<div class="t_div">
<table border="1" style="border-collapse: collapse; margin: auto;">
	<tr>
		<th style="color: white; width: 100px;
			background-color: #FFB300; border: 2px solid #FFB300;">
			작성날짜
		</th>
		<th style="color: white; width: 500px; border: 2px solid #FFB300;
		background-color: #FFB300;">
			제목
		</th>
	</tr>
	<tr>
		<td align="center" style="border: 2px solid #FFB300; padding: 5px;">
		${cs.date }
		</td>
		
		<td align="center" style="border: 2px solid #FFB300;">
		${cs.csTitle }
		</td>
	</tr>
	<tr>
		<td colspan="2" style="height: 600px; text-align: center; border: 2px solid #FFA200;"
		>${cs.csContent }
		</td>
	</tr>
	<!-- 이미지 있을 경우 처리할것 -->
	<tr>
		<td colspan="2" align="center" style="border: 2px solid #FFA200;">${cs.csImg }
		<img alt=""	src="">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right" style="border-bottom-color: #FFB300; border-top-color: white;
		border-right-color: white; border-left-color: white; padding-top: 30px; padding-bottom: 30px;">
			<c:if test="${loginUser == 'admin' }">
				<input type="button" class="btn" value="답글달기" onclick="slideClick()">
			</c:if>
			<input type="button" class="btn" value="수정" 
			onclick="location.href='${contextPath}/customer/csUpdateForm?csNum=${param.csNum }'">
			<input type="button" class="btn" value="삭제" 
			onclick="deleteChk()">
			<input type="button" class="btn" value="이전" onclick="location.href='csList'">
		</td>
	</tr>
	<tr>
		<td colspan="2" style="border: 2px solid #FFFFFF;">
			<div id="reply"></div>
		</td>
	</tr>
</table>
</div>




<div id="modal_wrap">
<div id="first">
<div style="margin:0 auto;">
	<form id="frm">
		<input type="hidden" name="write_no" 
								value="${cs.csNum }">
		<b>답글 작성 페이지</b><hr>
		<b>작성자 : ${loginUser }</b><hr>
		<b>제목</b><br>
		<input type="text" id="title" size="28" name="title"
			style="outline: none;">
		<hr>
		<b>내용</b><br>
		<textarea rows="15" cols="30" id="content" name="content"
			style="resize: none; outline: none;">
		</textarea>
		<hr>
		<button type="button" onclick="rep()"
			style="background-color: #FFFFFF; border: 0px;
			border-radius: 5px; color: #414141; cursor: pointer;">
			답글
		</button>
		<button type="button" onclick="slide_hidde()"
			style="background-color: #FFFFFF; border: 0px;
			border-radius: 5px; color: #414141; cursor: pointer;">
			취소
		</button>
	</form>
</div>
</div>
</div>


</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>