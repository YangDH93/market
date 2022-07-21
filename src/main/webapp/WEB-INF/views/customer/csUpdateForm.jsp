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
<style type="text/css">
.Numst{
	display: none;
}
.tablest{
	margin: auto;
	border-collapse: collapse;
	margin-top: 130px;
}
</style>
</head>
<body>
<%-- <%@include file="../default/header.jsp" %> --%>
<section class="eeRGVw">
<form id="upfo" action="csUpdate">
	<input type="text" class="Numst" name="csNum" value="${cs.csNum }">
<table border="1" class="tablest">
	<!-- 글번호 숨겨서 전달 -->
	<tr>
		<th style="color: white; width: 100px;
			background-color: #FFB300; border: 2px solid #FFB300;">
			작성날짜
		</th>
		<th style="color: white; border: 2px solid #FFB300;
		background-color: #FFB300; width: 500px;">
		제목
		</th> 
	</tr>
	<tr>
		<td align="center" style="border: 2px solid #FFB300;
		padding: 5px;">
		${cs.date }</td>
		<td style="border: 2px solid #FFB300;">
		<textarea name="csTitle" cols="60"
		style="font-size: 16px;
		outline: none; border: 0px; resize: none;"
		>${cs.csTitle }
		</textarea>
		</td> 
	</tr>
	<tr>
		<td colspan="2" style="border: 2px solid #FFB300;">
		<textarea name="csContent" cols="71" rows="30"
		style="outline: none; font-size: 16px; border: 0px; resize: none;" 
		>${cs.csContent }
		</textarea>
		</td>
	</tr>
	<!-- 이미지 있을 경우 처리할것 -->
	<tr>
		<td colspan="2" style="border: 2px solid #FFFFFF;">
		<input type="file" name="csImg" value="${cs.csImg }"
		style="margin-top: 15px;">
		</td>
	</tr>
	<tr> 
		<td colspan="2" align="right" style="border: 2px solid white;">
			<input type="button" value="수정" onclick="updateChk()"
						style="background-color: #FFA200; border: 0px;
						color: white; border-radius: 5px; padding: 5px;
						font-weight: 600; cursor: pointer;">
					</td>
	</tr>
</table>
</form>
</section>
<%-- <%@include file="../default/footer.jsp" %> --%>
</body>
</html>