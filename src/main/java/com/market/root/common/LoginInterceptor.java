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
		// 로컬의 쿠키값 가져오기
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		// 로그인 유지를 위해 세션 데이터 만들어줌
		HttpSession session = request.getSession();
		
		if(loginCookie != null) { // 쿠키값 있음(자동로그인 체크유저)
			
			String sessionId = loginCookie.getValue(); // 세션아이디 저장
			//System.out.println(sessionId);
			
			MemberDTO dto = ms.chkSessionId(sessionId); // DB 조회
			
			if(dto != null) { // 일치 세션아이디 있음
				session.setAttribute(SessionId.LOGIN, dto.getMbrId());
			}
		}
		return true; // 무조건 일단 통과
	}
	
}
