package com.market.root.customer.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.root.customer.dto.CustomerDTO;
import com.market.root.customer.service.CustomerService;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	
	@Autowired CustomerService cs;
	
	//고객센터 문의글 작성 페이지
	@GetMapping("csWriteForm")
	public String csWriteForm() {
		return "customer/csWriteForm";
	}
	//고객센터 문의글 작성
	@GetMapping("csWrite")
	public String csWrite(CustomerDTO dto) {
		System.out.println(dto.getCsContent() + dto.getCsTitle() + dto.getMbrId() + dto.getCsImg());
		cs.csWrite(dto);
		
		return "redirect:csList";
	}
	//고객센터 문의글 수정 폼
	@GetMapping("csUpdateForm")
	public String csUpdateForm(CustomerDTO dto, Model model) {
		
		cs.getCsContent(dto, model);
		
		return "customer/csUpdateForm";
	}
	//고객센터 문의글  전체 보기, 페이징 처리
	@GetMapping("csList")
	public String csView(Model model, //defaultValue = "1" : 값이 들어오지 않았다면 1로 처리
			@RequestParam(value="num", required = false, defaultValue = "1") int num,
			HttpSession session) {
		
		cs.csAllView(model,num,session);
		
		return "customer/csList";
	}
	//고객센터 문의글 한 개 보기 - 답글 다는곳
	@GetMapping("csView")
	public String csView(CustomerDTO dto, Model model) {
		
		cs.getCsContent(dto, model);
		
		return "customer/csView";
	}
	//고객센터 문의글 삭제
	@GetMapping("csContentDel")
	public String csContentDel(@RequestParam (required = false) int csNum) {
		System.out.println(csNum);
		int result = 0;
		result = cs.csContentDel(csNum);
		if(result == 1) {
			System.out.println("삭제 성공!");
			return "redirect:csList";
		}else {
			System.out.println("삭제 실패!");
			return "redirect:csView?csNum="+csNum;
		}
		
	}
	//고객센터 문의글 수정
	@GetMapping("csUpdate")
	public String csUpdate(CustomerDTO dto) {
		int result;
		System.out.println(dto.getCsTitle());
		System.out.println(dto.getCsImg());
		System.out.println(dto.getCsNum());
		System.out.println(dto.getCsContent());
		
		result = cs.csUpdate(dto);
		if(result == 1) {
			System.out.println("수정이 완료되었습니다.");
			return "redirect:csList";
		}else {
			System.out.println("수정 실패!");			
			return "redirect:csView?csNum="+dto.getCsNum();
		}
	}
	
}
