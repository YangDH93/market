package com.market.root.product.service;

import java.util.Map;

import org.springframework.ui.Model;

import com.market.root.product.dto.ProductDTO;

public interface ProductService {
	//상품관리 게시판
	public void psAllView(Model model, int num);
	//검색항목 불러오기
	public void search(String keyword, Model model);
	//상품 추가
	public int prodRegister(ProductDTO dto,String orgImg);
	
}
