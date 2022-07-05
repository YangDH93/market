package com.market.root.product.service;

import org.springframework.ui.Model;

public interface ProductService {
	//상품관리 게시판
	public void psAllView(Model model, int num);
	//상품 검색
	public void prodSearch(String keyword,Model model);
}
