package com.market.root.product.service;

import java.util.ArrayList;
import java.util.Map;
import org.springframework.ui.Model;
import com.market.root.product.dto.CategoriesDTO;
import com.market.root.product.dto.ProductDTO;

public interface ProductService {
	//상품관리 게시판
	public void psAllView(Model model, int num);
	//카테고리 대분류 불러오기
	public void cateAllList(Model model);
	//카테고리 하위분류 목록 불러오기
	public ArrayList<CategoriesDTO> cateList(String sltCode);
	//상품 추가
	public int prodRegister(ProductDTO dto,String orgImg,String uploadPath,String UUID);
	
	//상품 검색
	public void prodSearch(String keyword,Model model);
	public void oneProduct(Map<Object, Object> map, Model model);
	public int prodDelete(int prodId);
	public int prodUpdate(int prodId);
	public void prodStatus(int prodId, Model model);
	
}
