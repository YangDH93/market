package com.market.root.product.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.root.member.dto.MemberDTO;
import com.market.root.product.dto.ProductDTO;
import com.market.root.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired ProductService ps;
	
	//회원등록(정보) // (무시) 지울놈임
	@GetMapping("memberInfo")
	public String memberInfo() {
		return "product/memberInfo";
	}
	//상품등록
	@GetMapping("prodNew")
	public String prodNew() {
		return "product/prodNew";
	}
	//검색상품 보여줄 페이지
	@GetMapping("products")
	public String products() {
		return "product/products";
	}
	
	//구매,판매목록, 찜목록, 등 상품관리 기능
	//페이징 기능 추가
	@GetMapping("prodStatus")
	public String prodStatus(Model model, //defaultValue = "1" : 값이 들어오지 않았다면 1로 처리
			@RequestParam(value="num", required = false, defaultValue = "1") int num) {
			
			ps.psAllView(model,num);
		
		return "product/prodStatus";
	}
	
	//상품 검색기능
	@GetMapping("prodSearch")
	public String prodSearch(@RequestParam(value="keyword", required = false) String keyword,
							Model model) {
		System.out.println(keyword);
		
		ps.search(keyword,model);
		
		return "redirect:products";
	}
	
//	//상품 추가기능
//	@PostMapping("prodRegister")
//	public String prodRegister(@RequestParam Map<Object, Object> map){
//		
//		
//		int result = ps.prodRegister(map);
//		// 임시로 전체 상품 보여주는 곳으로 넘김
//		if(result == 2) {
//			return "redirect:products";
//		}
//		// 상품등록 실패시 다시 상품등록으로 이동
//		System.out.println("등록 실패");
//		return "redirect:prodNew";
//	}
	
	//상품 추가기능
	@PostMapping("prodRegister")
	public String prodRegister(@RequestParam(value="orgImg", required = false) String orgImg 
								,ProductDTO dto){
		System.out.println(dto.getProdTitle());
		System.out.println(orgImg);
		int result = ps.prodRegister(dto,orgImg);
		//임시로 전체 상품 보여주는 곳으로 넘김
		if(result == 1) {
			return "redirect:products";
		}
		// 상품등록 실패시 다시 상품등록으로 이동
		System.out.println("등록 실패");
		return "redirect:prodNew";
	}
}

















