<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.chat_nav {
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

.chatTitle { /* 판매,구매 채팅 목록 제목 글씨 */
	text-align: center;
	font-size: 17pt;
	padding: 20px 0;
}

/* 테이블 전체 감싸는 div (wrap 역할) */
.chat_table {
	text-align: center;
	margin-bottom: 40px;
}

.chat_table table {
	border-collapse: collapse;
	width: 100%;
}
.chat_table table thead{
	background-color: #FFB300;
	color: white;
	font-weight: 600;
	
}

.chat_table table thead td{
	border: 1px solid white;
}

.chat_table table tbody{
	border-bottom: 1px solid #C0C0C0;
}

/* td(칸)의 스타일 */
.chat_table td {
	padding: 15px;
	border: 1px solid #C0C0C0;
}
.chat_table td:first-child {
	border-left: none;
}
.chat_table td:last-child {
	border-right: none;
}

/* 목록 없을때 뜨는 문구의 a태그[] */
.chat_table td a {
	text-decoration: none;
}
/* 목록 없을때 뜨는 문구의 a태그[] */
.click_a {
	display: inline-block;
	padding-top: 15px;
	font-weight: bold;
	text-decoration: none;
	color: black
}
/* 목록 없을때 뜨는 문구의 a태그[] */
.click_a:hover {
	color: #FFA200;
}

/* 채팅방 td(칸) hover스타일 */
.chatRoomIn:hover {
	cursor: pointer;
	font-weight: bold;
	background-color: #FFFFFF;
}

/* 테이블 안의 삭제 버튼 */
.chat_table button {
	width: 70px;
	height: 38px;
	cursor: pointer;
	color: #414141;
	font-weight: 600;
	background-color: #FFFFFF;
	border: 1px solid #FFB300;
	border-radius: 5px;
}
/* 테이블 안의 삭제 버튼 hover */
.chat_table button:hover {
	color: white;
	background-color: #FFB300;
	font-weight: 600;
}
</style>
</head>
<body>
<div class="chat_nav">
	<ul class="manage_ul" style="padding-left: 0; list-style: none; display: inline-block;">
		<li class="manage_li"><a href="#">전체 채팅 목록</a></li>
		<li class="manage_li"><a href="#chat_sell_top">판매 채팅</a></li>
		<li class="manage_li"><a href="#chat_buy_top">구매 채팅</a></li>
	</ul>
</div>
</body>
</html>