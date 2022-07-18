package com.market.root.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberInterceptor 
extends HandlerInterceptorAdapter
implements SessionId{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if( session.getAttribute("loginUser") == null ) {
			//보내질 문자 타입 지정
			response.setContentType("text/html;charset=utf-8");
			//메세지 출력을 위한 메소드
			PrintWriter out = response.getWriter();
			//자신의 root 경로 읽어옴
			String path = request.getContextPath();
			out.print("<script> alert('경고! : 잘못된 접근 방식입니다.');"
					+"location.href='"+path+"'</script>");
			return false;
		}
		return true;
	}

}
