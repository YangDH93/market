package com.market.root.common;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.market.root.member.dto.MemberDTO;
import com.market.root.member.service.MemberService;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	MemberService ms;
	
	// 컨트롤러 전 걸러서 실행
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 자동로그인체크
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		//  request에서 MemberController의 "loginCookie"찾음
		
		if(loginCookie != null) { // 쿠키값 있음(자동로그인 체크)
			String sessionId = loginCookie.getValue(); // 세션아이디 저장
			
			// DB 조회
			MemberDTO dto = ms.chkSessionId(sessionId);
			if(dto != null) { // 일치 세션아이디 있음
				HttpSession session = request.getSession();
				session.setAttribute(SessionId.LOGIN, dto.getMbrId());
			}
		}
		return true; // 무조건 일단 통과
	}
	
}
