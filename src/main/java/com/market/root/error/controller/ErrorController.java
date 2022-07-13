package com.market.root.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ErrorController {

	//에러 처리
	@GetMapping("/error")
	public String error() {
		return "error/error";
	}
	//첫 번째 오류
	@GetMapping("/divide")
	public String problem(Model model) {
		int result = 1 / 0;
		model.addAttribute("serverTime", result);
		return "home";
	}
	//두 번째 오류
	@PostMapping("/method")
	public String method(Model model) {
		return "home";
	}
}
