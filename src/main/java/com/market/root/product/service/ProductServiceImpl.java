package com.market.root.product.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.mybatis.product.ProductMapper;
import com.market.root.product.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired ProductMapper mapper;

	//상품관리 게시판
	public void psAllView(Model model, int num) {

		try {
			//한 페이지당 보여줄 게시글 수
			int pageLetter = 5; 
			//게시글 수 불러오기
			int allCount = mapper.selectBoardCount();
			//페이지 수 = 전체 게시글 수 / 보여줄 게시글 수
			int repeat = allCount / pageLetter;
			//전체 페이지(마지막 보여질 페이지) % 보여줄 게시글 수가 0이 아니면 페이지+1 증가
			if(allCount % pageLetter != 0) {
				repeat += 1;
			}
			//끝 페이지 번호
			int end = num * pageLetter;
			//시작 페이지 번호
			int start = end + 1 - pageLetter;
			//마지막 페이지번호 가져옴
			model.addAttribute("repeat",repeat);
			//게시글 모든 정보 가져옴
			model.addAttribute("psList", mapper.psAllView(start,end) );	

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//상품 검색 기능
	public void prodSearch(String keyword, Model model) {
		try {
			model.addAttribute("prodList", mapper.prodSearch(keyword));
			//System.out.println("디비연결"); 
		} catch (Exception e) {
			System.out.println("디비고장");
			e.printStackTrace(); 
		}
	}
}
