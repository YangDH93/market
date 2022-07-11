package com.market.root.product.service;

import java.util.Map;

import org.springframework.ui.Model;

public interface ProductService {
	//상품관리 게시판
	public void psAllView(Model model, int num);
	//상품 검색
	public void prodSearch(String keyword,Model model);
	public void oneProduct(Map<Object, Object> map, Model model);
	public int prodDelete(int prodId);
	public int prodUpdate(int prodId);
	public void prodStatus(int prodId, Model model);
}
