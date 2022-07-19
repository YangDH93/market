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
.chat_nav{
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
	
}
.manage_li a:hover{
   color: orange;
   padding-bottom: 3px; /* a태그 밑줄과 글씨 간격*/
   border-bottom: 1px solid orange;
}
.chatTitle{
	text-align:center;
	font-size: 17pt;
	padding: 20px 0;
}
.chat_table{
	text-align:center;
	margin-bottom: 40px;
}

.chat_table td{
	padding: 15px;
}

.chat_table td a{
	text-decoration: none;
}

.chatRoomIn:hover {
	cursor:pointer;
	font-weight:bold;
	background-color: #F5F5F5;
}
.chat_table button {
	width: 70px;
	height: 38px;
	cursor:pointer;
	color: #FFA200;
	font-weight:bold;
	background-color: white;
	border: 2px solid #FFA200;
	border-radius: 5px;
}
.chat_table button:hover {
	color: white;
	background-color: #FFA200;
}

.click_main{
	display:inline-block;
	padding-top: 15px;
	font-weight: bold;
	text-decoration: none;
	color: black
}
.click_main:hover{
	color: #FFA200;
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