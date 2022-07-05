package com.market.root.product.service;

import org.springframework.ui.Model;

public interface ProductService {
	//상품관리 게시판
	public void psAllView(Model model, int num);
	//검색항목 불러오기
	public void search(String keyword, Model model);
	//카테고리 항복 불러오기
	public void cateAllList(Model model);
}
