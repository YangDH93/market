package com.market.root.product.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.root.product.dto.ProductDTO;
import com.market.root.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired ProductService ps;
	
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
	//상품 정보 prodUpdateForm으로 넘겨줌
	@GetMapping("prodUpdateForm")
	public String prodUpdateForm(@RequestParam (required = false) int prodId,
								Model model) {
		ps.prodStatus(prodId, model);
		return "product/prodUpdateForm";
	}
	//검색상품 보여줄 페이지
	@GetMapping("products")
	public String products() {
		return "product/products";
	}
	//상품등록(가입)
	@PostMapping("prodRegister")
	public String prodRegister() {
		return "redirect:prodNew";
	}
	//개인 물품 거래 페이지
	@GetMapping("prodTrade")
	public String prodTrade() {
		return "product/prodTrade";
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
		
		ps.prodSearch(keyword,model);
		
		return "product/products";
	}
	//한개의 상품 정보 가져옴
	@GetMapping("trade")
	public String trade(@RequestParam (required = false)Map<Object, Object> map,
						Model model) {
		System.out.println("상품 아이디 : " + map.get("prodId") + ", 조회수 : " + map.get("hit"));
		
		ps.oneProduct(map,model);
		
		return "product/prodTrade";
	}
	//자신의 상품 삭제
	@GetMapping("prodDelete")
	public String prodDelete(@RequestParam (required = false) int prodId) {
		System.out.println(prodId);
		int result;
		result = ps.prodDelete(prodId);
		if(result == 1) {
			System.out.println("상품 삭제 성공!");
			return "redirect:prodStatus";
		}else {
			System.out.println("상품 삭제 실패!");
			return "redirect:trade";
		}
	}
	@GetMapping("prodUpdate")
	public String prodUpdate(ProductDTO dto) {
//		System.out.println(dto.getProdTitle());
//		System.out.println(dto.getProdContent());
//		System.out.println(dto.getTrdLocation());
//		System.out.println(dto.getPrice());
//		int result;
//		result = ps.prodUpdate(dto);
//		if(result == 1) {
//			System.out.println("상품 업데이트 성공!");
//			return "redirect:trade?prodId="+prodId;
//		}else {
//			System.out.println("상품 업데이트 실패!");
//			return "redirect:trade?prodId="+prodId;
//		}
		return null;
	}
	
}

















