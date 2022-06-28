package com.market.root.member.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
						HttpSession session,
						RedirectAttributes rs) {
		int result = ms.logChk(mbrId, mbrPw, session);
		rs.addFlashAttribute("result", result); // 값 안보이게 전달
		// 0 : session id값 저장 + 로그인 성공 / -1 : 비번틀림 / 1 : 아이디 없음
		if(result == 0) {
			return "redirect:/"; 
		}else if(result == -1) {
			rs.addFlashAttribute("massage", "비밀번호가 틀렸습니다.");
		}else {
			rs.addFlashAttribute("massage", "아이디가 없습니다.");
		}
		return "redirect:/member/login"; 
	}
	
}
