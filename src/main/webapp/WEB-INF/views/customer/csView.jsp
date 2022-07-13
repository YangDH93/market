<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="cs" value="${cs }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#modal_wrap{
	display: none; position: fixed; z-index: 9;
	margin: 0 auto; top:0; left: 0; right: 0;
	width: 100%; height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}
#first{
	display: none; position: fixed; z-index: 10;
	margin: 0 auto; top: 30px; left: 0; right: 0;
	width: 350px; height: 450px;
	background-color: rgba(212, 244, 250, 0.9);
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
<table border="1" style="width: 70%; margin: auto;">
	<tr>
		<th>제목</th> <th>작성날짜</th>
	</tr>
	<tr>
		<td>${cs.csTitle }</td> <td>${cs.date }</td>
	</tr>
	<tr>
		<td colspan="2">${cs.csContent }</td>
	</tr>
	<!-- 이미지 있을 경우 처리할것 -->
	<tr>
		<td colspan="2">${cs.csImg }
		<img alt=""	src="">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<c:if test="${loginUser == 'admin' }">
				<input type="button" value="답글달기" onclick="slideClick()">
			</c:if>
			<input type="button" value="수정" 
			onclick="location.href='${contextPath}/customer/csUpdateForm?csNum=${param.csNum }'">
			<input type="button" value="삭제" 
			onclick="deleteChk()">
			<input type="button" value="이전" onclick="location.href='csList'">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<div id="reply"></div>
		</td>
	</tr>
</table>




<div id="modal_wrap">
<div id="first">
<div style="width:250px; margin:0 auto; padding-top:20px">
	<form id="frm">
		<input type="hidden" name="write_no" 
								value="${cs.csNum }">
		<b>답글 작성 페이지</b><hr>
		<b>작성자 : ${loginUser }</b><hr>
		<b>제목</b><br>
		<input type="text" id="title" size="30" name="title">
		<hr>
		<b>내용</b><br>
		<textarea rows="5" cols="30" 
					id="content" name="content"></textarea>
		<hr>
		<button type="button" onclick="rep()">답글</button>
		<button type="button" onclick="slide_hidde()">취소</button>
	</form>
</div>
</div>
</div>


</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>