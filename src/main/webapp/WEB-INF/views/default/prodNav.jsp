<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.prod_nav{
	margin: 20px;
}
.manage_li{
	float: left;
}
.manage_li+.manage_li:before{
	content: "";
	display: inline-block;
	width: 1px;
	height: 15px;
	margin: 0 40px; /* 상하 좌우 */
	background-color: #e4e8eb;
	vertical-align: -1px;
}
.manage_li a{
	color: #777;
	font-size:14px;
	text-decoration: none;
</style>
</head>
<body>
	<div class="prod_nav">
		<ul class="manage_ul" style="padding-left: 0; list-style: none; display: inline-block;">
			<li class="manage_li"><a href="${contextPath }/product/prodStatus">상품관리</a></li>
			<li class="manage_li"><a href="${contextPath }/product/sellsComplete">구매/판매 내역</a></li>
			<li class="manage_li"><a href="${contextPath }/product/userPick">찜 목록</a></li>
		</ul>
	</div>
</body>
</html>