package com.market.root.product.service;

import java.util.HashMap;
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
	public int prodRegister(ProductDTO dto , String orgImg) {
		
		System.out.println(dto.getProdTitle());
		System.out.println(orgImg);
		String[] orgImg1 = orgImg.split(",");
		orgImg = "";
		String tumImg = "";
		for(int i=0;i<orgImg1.length;i++) {
			tumImg += "s_" + orgImg1[i];
			orgImg += orgImg1[i];
			if(i != orgImg1.length -1) {
				tumImg += "/";
				orgImg += "/";
			}
		}
		int result = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("orgImg", orgImg);
		map.put("tumImg", tumImg);
		try {
			// 결과 1 또는 0 반환
			result = mapper.prodRegister(dto);
			result = mapper.prodImgRegister(map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
}
