package com.market.root.product.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.market.root.file.service.FileService;
import com.market.root.product.dto.CategoriesDTO;
import com.market.root.product.dto.ProductDTO;
import com.market.root.product.service.ProductService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired ProductService ps;
	@Autowired FileService fs;
	
	//상품등록
	@GetMapping("prodNew")
	public String prodNew(Model model) {
		ps.cateAllList(model);
		return "product/prodNew";
	}
	
	//상품 정보 prodUpdateForm으로 넘겨줌
	@GetMapping("prodUpdateForm")
	public String prodUpdateForm(@RequestParam (required = false) int prodId,
								Model model) {
		
		try {
			ps.prodStatus(prodId, model);
			fs.prodImgList(model,prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "product/prodUpdateForm";
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
	
	//개인 물품 거래 페이지
	@GetMapping("prodTrade")
	public String prodTrade() {
		return "product/prodTrade";
	}
	
	//구매,판매목록, 찜목록, 등 상품관리 기능
	//페이징 기능 추가 , 상품 판매중 메소드 , 시간 설정 후 넘김
	@GetMapping("prodStatus")
	public String prodStatus(Model model, //defaultValue = "1" : 값이 들어오지 않았다면 1로 처리
			@RequestParam(value="num", required = false, defaultValue = "1") int num,
			HttpSession session) {
			System.out.println(session.getAttribute("loginUser"));
			ps.psAllView(model,num,session);
		
		return "product/prodStatus";
	}
	
	//상품 판매완료 메소드 - update
	@GetMapping("sellsComple")
	public String sellsComple(ProductDTO dto,
								HttpSession session,
								Model model) {
		System.out.println("상품 고유번호 : " + dto.getProdId() + " 상품 판매상태 : " + dto.getProdStat());
		dto.setMbrId((String) session.getAttribute("loginUser"));
		dto.setProdStat(1);
		System.out.println("업데이트 후 아이디 : " + dto.getMbrId() + " 상품 상태 : " + dto.getProdStat());
		int result;
		result = ps.sellsComple(dto,model);
		if(result == 1) {
			return "redirect:prodStatus";
		}else {
			return "redirect:prodStatus";
		}
		
	}
	
	//상품 검색기능
	@GetMapping("prodSearch")
	public String prodSearch(@RequestParam(value="keyword", required = false) String keyword,
							Model model) {
		System.out.println(keyword);
		
		ps.prodSearch(keyword,model);
		
		return "product/products";
	}
	
	//상품 추가기능
	@PostMapping("prodRegister")
	public String prodRegister(@RequestParam(value="orgImg", required = false) String orgImg,
								@RequestParam(value="uploadPath", required = false) String uploadPath,
								@RequestParam(value="UUID", required = false) String UUID,
								ProductDTO dto){
		int result = 0;
		
		try {
			long time = System.currentTimeMillis();
			dto.setProdDate(time);
			result = ps.prodRegister(dto,orgImg,uploadPath,UUID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//임시로 전체 상품 보여주는 곳으로 넘김
		if(result == 1) {
			return "redirect:prodStatus";
		}
		// 상품등록 실패시 다시 상품등록으로 이동
		System.out.println("등록 실패");
		return "redirect:prodNew";
	}
	
	//한개의 상품 정보 가져옴
	@GetMapping("trade")
	public String trade(@RequestParam (required = false)Map<Object, Object> map,
						Model model) {
		System.out.println("상품 아이디 : " + map.get("prodId") + ", 조회수 : " + map.get("hit"));
		
		try {
			fs.prodImgList(model, map.get("prodId"));
			ps.oneProduct(map,model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "product/prodTrade";
	}
	
	//자신의 상품 삭제
	@GetMapping("prodDelete")
	public String prodDelete(@RequestParam (required = false) int prodId) {
		int result = 0;
		try {
			result = ps.prodDelete(prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result == 1) {
			System.out.println("상품 삭제 성공!");
			return "redirect:prodStatus";
		}else {
			System.out.println("상품 삭제 실패!");
			return "redirect:trade";
		}
	}
	
	//상품수정
	@PostMapping("prodUpdate")
	public String prodUpdate(@RequestParam(value="orgImg", required = false) String orgImg,
								@RequestParam(value="uploadPath", required = false) String uploadPath,
								@RequestParam(value="UUID", required = false) String UUID,
								@RequestParam(value="prodDate", required = false) long prodDate,
								ProductDTO dto){
		int result = 0;
		try {
			dto.setProdDate(prodDate);
			result = ps.prodUpdate(dto,orgImg,uploadPath,UUID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 수정되면 물품 확인
		if(result == 1) {
			return "redirect:prodStatus";
		}
		// 실패시 물품 확인란으로 이동
		System.out.println("업데이트 실패");
		return "redirect:prodStatus";
	}
	
	//상품 판매완료.jsp
	@GetMapping("sellsComplete")
	public String sellsComplete(Model model, //defaultValue = "1" : 값이 들어오지 않았다면 1로 처리
			@RequestParam(value="num", required = false, defaultValue = "1") int num,
			HttpSession session) {
		
		ps.sellsAllView(model,num,session);
		
		return "product/sellsComplete";
	}

}















