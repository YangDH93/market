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
function deleteChk(){
    if (!confirm("이 문의글을 삭제 하시겠습니까?")) {
    	alert("삭제를 취소하셨습니다.");
        location.href="#";
    } else {
    	alert("글 삭제가 완료되었습니다. 문의목록 화면으로 돌아갑니다.");
    	location.href="csContentDel?csNum="+${cs.csNum };
    }
}
</script>
</head>
<body>
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
		<td colspan="2">${cs.csImg }<img alt=""	src=""></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" value="수정" onclick="location.href='${contextPath}/customer/csUpdateForm?csNum=${param.csNum }'">
			<input type="button" value="삭제" 
			onclick="deleteChk()">
		</td>
	</tr>
</table>
</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>