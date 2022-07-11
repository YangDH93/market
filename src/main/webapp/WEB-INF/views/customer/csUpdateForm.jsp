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
<script type="text/javascript">
function updateChk(){
    if (!confirm("수정 하시겠습니까?")) {
    	alert("수정을 취소하셨습니다.");
    	history.go(-1); 
    } else {
    	alert("글 수정이 완료되었습니다. 문의목록 화면으로 돌아갑니다.");
    	upfo.submit();
    }
}
</script>
</head>
<body>
<%-- <%@include file="../default/header.jsp" %> --%>
<section class="eeRGVw">
<form id="upfo" action="csUpdate">
	<input type="text" style="display: none;" name="csNum" value="${cs.csNum }">
<table border="1" style="width: 70%; margin: auto;">
	<!-- 글번호 숨겨서 전달 -->
	<tr>
		<th>제목</th> <th>작성날짜</th>
	</tr>
	<tr>
		<td><input type="text" name="csTitle" value="${cs.csTitle }"></td> 
		<td>${cs.date }</td>
	</tr>
	<tr>
		<td colspan="2"><input type="text" name="csContent" value="${cs.csContent }"></td>
	</tr>
	<!-- 이미지 있을 경우 처리할것 -->
	<tr>
		<td colspan="2"><input type="file" name="csImg" value="${cs.csImg }"></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" value="수정" 
			onclick="updateChk()">
		</td>
	</tr>
</table>
</form>
</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>