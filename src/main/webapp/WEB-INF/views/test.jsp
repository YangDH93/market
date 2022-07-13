<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>   
<!DOCTYPE html>
<html>
<head>
<title>test</title>
<style>
</style>
</head>
<body>	
	<div>
		<img src="${contextPath}/display?fileName=test.PNG">
		<img src="${contextPath}/display?fileName=s_test.PNG">
	</div>
</body>
</html>