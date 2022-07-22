package com.market.root.member.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.market.root.member.dto.MemberDTO;
import com.market.root.member.service.RegisterService;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String reg(MemberDTO dto, Map<Object,Object> map) {
		map.get("nickname");
		map.get("email");
		
		/*
		int result = rs.register(dto);
		
		
		//회원가입 성공시 로그인 화면으로 이동
		if(result == 1) {
			return "redirect:login";
		}
		//회원가입 실패시 회원가입 창으로 다시 이동
		return "redirect:register";
		*/
		
		return "redirect:/";
	}
	
	// 중복체크
	@ResponseBody //ajax 값 리턴
	@PostMapping(value = "dupChk",
	produces = "application/json; charset=utf-8")
	public int dupChk(String uIn, String cIn) {
		
		// 돌려줄 값 ( 0 : 사용가능, 1 : 중복)
		int result = rs.dupChk(cIn, uIn);
		
		return result;
	}
	
	//가입 메일인증 ajax Controller
	@ResponseBody //ajax후 값 리턴
	@PostMapping(value = "sendMail",
				produces = "application/json; charset=utf-8")
	public String sendMail(String mail,
							HttpServletResponse response,
							HttpServletRequest request) 
										throws Exception{
		//System.out.println(mail);
		String key = rs.gmailSend(mail);//메일 전송 메소드
		return key; //key값 ajax 리턴
	}
	
}
