package com.market.root.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	//id 중복체크 + 메시지 돌려줌
	@ResponseBody //ajax 값 리턴
	@PostMapping(value = "getId",
				produces = "application/json; charset=utf-8")
	public int getId(String inputId,
						RedirectAttributes ra) {
		// 돌려줄 값 ( 0 : 사용가능, 1 : 중복)
		int result = rs.regIdChk(inputId);
		
		if(result == 0) {
			ra.addFlashAttribute("message", "사용 가능한 아이디");
		}else { //1
			ra.addFlashAttribute("message", "중복 아이디");
		}
		
		
		return result;
	}
	
	
}
