package com.market.root.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("product")
public class ProductController {
	
	//회원등록(정보)
	@GetMapping("memberInfo")
	public String memberInfo() {
		return "product/memberInfo";
	}
	//상품등록
	@GetMapping("prodNew")
	public String prodNew() {
		return "product/prodNew";
	}
	//상품등록(가입)
	@PostMapping("prodRegister")
	public String prodRegister() {
		return "redirect:prodNew";
	}
}

















