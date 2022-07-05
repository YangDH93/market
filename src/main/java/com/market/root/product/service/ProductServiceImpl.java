package com.market.root.product.service;

import java.util.Map;

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
			// TODO: handle exception
		}
	}
	//검색항목 불러오기
	public void search(String keyword, Model model) {
		model.addAttribute("keyList",mapper.search(keyword));
	}

	@Override
	public int prodRegister(Map<Object, Object> map) {
		
		int result = 0;
		map.put("tumImg","s_"+ map.get("orgImg"));
		try {
			// 결과 2 또는 0 반환 (행 2개 추가로 반환됨)
			result = mapper.prodRegister(map);	
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return result;
	}
}
