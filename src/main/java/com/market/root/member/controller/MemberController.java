package com.market.root.member.controller;


import java.sql.Date;
import java.util.Calendar;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.market.root.common.SessionId;
import com.market.root.member.dto.MemberDTO;
import com.market.root.member.service.MemberService;

// 주소값 ~root/member/로 시작
@Controller
@RequestMapping("member")
public class MemberController {

	@Autowired MemberService ms; //Member 관련 class
	
	@GetMapping("login") // 로그인 페이지
	public String login() {
		return "member/login";
	}

	@PostMapping("logChk")
	public String logChk(@RequestParam String mbrId,
						@RequestParam String mbrPw,
						@RequestParam(required = false)
									String autoLogin,
						HttpSession session,
						RedirectAttributes rs) {
		int result = ms.logChk(mbrId, mbrPw, session);
		// 0 : session id값 저장 + 로그인 성공 / -1 : 비번틀림 / 1 : 아이디 없음
		if(result == 0) { // 성공
			//checkbox값 저장
			session.setAttribute("autoLogin", autoLogin);
			return "redirect:successLogin"; 
		}else if(result == -1) {
			rs.addFlashAttribute("massage", "비밀번호가 틀렸습니다.");
		}else {
			rs.addFlashAttribute("massage", "아이디가 없습니다.");
		}
		return "redirect:/member/login"; 
	}
	
	@GetMapping("successLogin")
	public String successLoin(HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response) {
		//System.out.println(session.getAttribute(SessionId.LOGIN)); // session 저장 확인
		//System.out.println(session.getAttribute("autoLogin")); //checked : on / null
		
		if(session.getAttribute("autoLogin") != null) { // checked상태
			int time = 60*60*24*90; // 90일의 시간
			Cookie cook = new Cookie("loginCookie", session.getId());
			cook.setPath("/");
			cook.setMaxAge(time);
			response.addCookie(cook); // 사용자에게 쿠키값 전달
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new java.util.Date());
			cal.add(Calendar.MONTH, 3);
			
			java.sql.Date limitDate = new java.sql.Date(cal.getTimeInMillis());
			ms.KeepLogin(session.getId(), limitDate, (String)session.getAttribute(SessionId.LOGIN));
		}
		
		return "redirect:/";
	}
	
}
