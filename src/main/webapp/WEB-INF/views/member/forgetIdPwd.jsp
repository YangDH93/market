<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오!리!마!켓!</title>
<style type="text/css">
table{
	width: 400px;
	height: 100px;
}
.div_st {
	display: flex;
	justify-content: center;
}

.input_st {
	border-top: none;
	border-right: none;
	border-left: none;
	border-bottom-color: #FFB300;
	width: 260px;
	outline: none;
	margin-top: 30px;
}
.btn_st{
	background-color: #FFB300;
	border-radius: 5px;
	border: 0px;
	color: #FFFFFF;
	padding: 5px;
	cursor: pointer;
	margin-top: 15px;
	margin-left: 293px;
	margin-bottom: 30px;
}
.firsttd{
	background-color: #FFB300;
	color: #FFFFFF;
	font-weight: 600;
	border: 2px solid #FFB300;
}
.td_st{
	border: 2px solid #C0C0C0;
}

</style>
</head>
<body>
<div class="div_st">
	<form action="${contextPath }/member/findId" method="post">
	<table style="border-spacing: 0; margin-top: 130px;">
		<tr>
			<td class="firsttd">
				<div>아이디 찾기</div>
			</td>
		</tr>
		<tr>
			<td class="td_st" align="center"
			style="border-bottom: none; border-top: none;">
			<input name="mbrEmail" type="text" placeholder="가입할 당시의 이메일 주소를 입력해주세요."
			class="input_st">
			</td>
		</tr>
		<tr>
			<td class="td_st"
			style="border-top:none;">
				<button type="submit" class="btn_st">확인</button>
			</td>
		</tr>
	</table>
	</form>
</div>
<div class="div_st">
	<form action="${contextPath }/member/findPwd" method="post">
	<table style="border-spacing: 0; margin-top: 30px;">
		<tr>
			<td class="firsttd">
				<div>비밀번호 찾기</div>
			</td>
		</tr>
		<tr>
			<td class="td_st" align="center"
			style="border-bottom: none; border-top: none;">
				<input name="mbrEmail" type="text" placeholder="가입할 당시의 이메일 주소를 입력해주세요."
				class="input_st">
			</td>
		</tr>
		<tr>
			<td align="center" 
			class="td_st" style="border-bottom: none; border-top: none;">
				<div style="font-size: 11px; color: red; margin-top: 2px;">
					해당 이메일로 임시 비밀번호를 발송해 드립니다.
				</div>
			</td>
		</tr>
		<tr>
			<td class="td_st"
			style="border-top:none;">
				<button type="submit" class="btn_st">확인</button>
			</td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>