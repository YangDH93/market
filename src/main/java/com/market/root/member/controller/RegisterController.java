package com.market.root.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.market.root.member.dto.MemberDTO;
import com.market.root.member.service.RegisterService;

@Controller
@RequestMapping("member")
public class RegisterController {

	@Autowired RegisterService rs;
	
	//회원가입 폼
	@GetMapping("register")
	public String register() {
		return "member/register";
	}
	
	//회원가입 정보 전달
	@PostMapping("reg")
	public String reg(MemberDTO dto) {
		int result = rs.register(dto);
		//회원가입 성공시 로그인 화면으로 이동
		if(result == 1) {
			return "redirect:login";
		}
		//회원가입 실패시 회원가입 창으로 다시 이동
		return "redirect:register";
	}
	
}
