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
	
	@GetMapping("register")
	public String register() {
		return "member/register";
	}
	//회원가입 정보 전달
	@PostMapping("reg")
	public String reg(MemberDTO dto) {
		
		/* 들어온 정보 확인 -- 삭제해도 상관 x
		System.out.println(dto.getMbrName());
		System.out.println(dto.getMbrId());
		System.out.println(dto.getMbrPw());
		System.out.println(dto.getMbrEmail());
		*/
		
		return "redirect:login";
	}
	
}
