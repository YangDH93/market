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
.prod_nav {
	margin: 20px;
}

.manage_li {
	float: left;
}

.manage_li+.manage_li:before {
	content: "";
	display: inline-block;
	width: 1px;
	height: 15px;
	margin: 0 40px; /* 상하 좌우 */
	background-color: #e4e8eb;
	vertical-align: -1px;
}

.manage_li a {
	color: #777;
	font-size: 14px;
	text-decoration: none;
}

.manage_li a:hover {
	color: orange;
	padding-bottom: 3px; /* a태그 밑줄과 글씨 간격*/
	border-bottom: 1px solid orange;
}

.prodTable_st table thead th {
	padding: 10px 0;
	border-right-color: #FFFFFF;
	border-top-color: #FFB300;
}

.prodTable_st table thead th:first-child {
	border-left-color: #FFB300;
}

.prodTable_st table thead th:last-child {
	border-right-color: #FFB300;
}
.td_btn_st button {
	color: #FFFFFF;
	width: 80px;
	background-color: #FFFFFF;
	border: 1px solid #FFA200;
	border-radius: 5px;
	color: #414141;
	padding: 3px;
	font-weight: 500;
	cursor: pointer;
}

.td_btn_st button:hover {
	color: #FFFFFF;
	font-weight: 600;
	background-color: #FFA200;
	border: 1px solid #FFA200;
}


.td_pbtn_st button {
	color: #FFFFFF;
	width: 50px;
	background-color: #FFFFFF;
	border: 1px solid #FFA200;
	border-radius: 5px;
	color: #414141;
	padding: 5px;
	font-weight: 500;
	cursor: pointer;
}
.td_pbtn_st button:hover {
	color: #FFFFFF;
	font-weight: 600;
	background-color: #FFA200;
	border: 1px solid #FFA200;

}
.td_title_st:hover{
	border: 1px solid #551A8B;
}
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