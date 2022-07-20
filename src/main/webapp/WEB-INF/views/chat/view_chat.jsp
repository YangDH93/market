<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 채팅</title>
<style type="text/css">
.exit_btn {
	width: 95px;
	height: 38px;
	cursor: pointer;
	color: #FFA200;
	font-weight: bold;
	background-color: white;
	border: 2px solid #FFA200;
	border-radius: 5px;
}

.exit_btn:hover {
	color: white;
	background-color: #FFA200;
}

.myChat {
	padding: 17px;
	text-align: right;
}

.myChatBox {
	color: white;
	background-color: #FFA200;
	padding: 10px;
	border-radius: 5px;
<div class="myChat"><span>${chatList }</span></div>
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script type="text/javascript">
	var webSocket = {
		init: function(param) {
			this._url = param.url;
			this._initSocket();
		},
		sendChat: function() {
			this._sendMessage('${param.bang_id}', 'CMD_MSG_SEND', $('#message').val());
			$('#message').val('');
		},
		sendEnter: function() {
			this._sendMessage('${param.bang_id}', 'CMD_ENTER', $('#message').val());
			$('#message').val('');
		},
		receiveMessage: function(msgData) {

			// 정의된 CMD 코드에 따라서 분기 처리
			if(msgData.cmd == 'CMD_MSG_SEND') {					
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
			// 입장
			else if(msgData.cmd == 'CMD_ENTER') {
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
			// 퇴장
			else if(msgData.cmd == 'CMD_EXIT') {					
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
		},
		closeMessage: function(str) {
			$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
		},
		disconnect: function() {
			this._socket.close();
		},
		_initSocket: function() {
			this._socket = new SockJS(this._url);
			this._socket.onopen = function(evt) {
				webSocket.sendEnter();
			};
			this._socket.onmessage = function(evt) {
				webSocket.receiveMessage(JSON.parse(evt.data));
			};
			this._socket.onclose = function(evt) {
				webSocket.closeMessage(JSON.parse(evt.data));
			}
		},
		_sendMessage: function(bang_id, cmd, msg) {
			var msgData = {
					bang_id : bang_id,
					cmd : cmd,
					msg : msg
			};
			var jsonData = JSON.stringify(msgData);
			this._socket.send(jsonData);
		}
	};
</script>	
<script type="text/javascript">
       $(window).on('load', function () {
		webSocket.init({ url: '<c:url value="/chat" />' });	
	});
</script>
</head>
<body>
<%@include file="../default/header.jsp" %>
<div style="min-width: 1024px; width: 1024px; margin: 0 auto; padding:40px 0;">
		<div style="overflow: auto; margin: 0 auto; width: 600px; height: 500px; padding: 10px; border: solid 1px #e1e3e9; border-radius: 10px; ">
			<div id="divChatData" style="overflow: auto;">
				<c:forEach var="chatList" items="${chatList}">
					${chatList }<br>
				</c:forEach>
			</div>
		</div>
		<div style="margin: 0 auto; display:flex; justify-content:space-between; width: 600px; margin-top: 20px;">
			<input style="display:block; width: 400px;" type="text" id="message" onkeypress="if(event.keyCode==13){webSocket.sendChat();}" />
			<input class="exit_btn" style="display:block;" type="button" id="btnSend" value="채팅 전송" onclick="webSocket.sendChat()" />
			<input class="exit_btn" style="display:block;" type="button" value="방 나가기" onclick="location.href='${contextPath}/chatList'" />
		</div>
</div>
<%@ include file="../default/footer.jsp" %>	
</body>
</html>