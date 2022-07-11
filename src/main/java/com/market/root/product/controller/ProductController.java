package com.market.root.product.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.market.root.product.dto.CategoriesDTO;
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
	public String prodNew(Model model) {
		ps.cateAllList(model);
		return "product/prodNew";
	}
	//검색상품 보여줄 페이지
	@GetMapping("products")
	public String products() {
		return "product/products";
	}
	
	@ResponseBody //값 리턴
	@PostMapping(value = "getList",
	produces = "application/json; charset=utf-8")
	public ArrayList<CategoriesDTO> getList(String sltCode) {
		ArrayList<CategoriesDTO> arr = ps.cateList(sltCode);
		return arr;
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
	
	//상품 추가기능
	@PostMapping("prodRegister")
	public String prodRegister(@RequestParam(value="orgImg", required = false) String orgImg,
								@RequestParam(value="uploadPath", required = false) String uploadPath,
								@RequestParam(value="UUID", required = false) String UUID,
								ProductDTO dto){
		int result = ps.prodRegister(dto,orgImg,uploadPath,UUID);
		//임시로 전체 상품 보여주는 곳으로 넘김
		if(result == 1) {
			return "redirect:products";
		}
		// 상품등록 실패시 다시 상품등록으로 이동
		System.out.println("등록 실패");
		return "redirect:prodNew";
	}
}

















