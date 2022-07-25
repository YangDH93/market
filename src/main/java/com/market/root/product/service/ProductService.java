package com.market.root.product.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import com.market.root.product.dto.CategoriesDTO;
import com.market.root.product.dto.ProductDTO;

public interface ProductService {
	//main 전체 목록
	public void mainAllView(Model model);
	//상품관리 게시판
	public void psAllView(Model model, int num, HttpSession session);
	//카테고리 대분류 불러오기
	public void cateAllList(Model model);
	//카테고리 하위분류 목록 불러오기
	public ArrayList<CategoriesDTO> cateList(String sltCode);
	//하나의 상품 카테고리 불러오기
	public void oneCateAll(Model model,ProductDTO dto);
	//상품 추가
	public int prodRegister(ProductDTO dto,String orgImg,String uploadPath,String UUID);
	//상품 검색
	public void prodSearch(String keyword,Model model);
	public void oneProduct(Map<Object, Object> map, Model model);
	//상품삭제
	public int prodDelete(int prodId);
	//상품 업데이트
	public int prodUpdate(ProductDTO dto,String orgImg,String uploadPath,String UUID);
	public void prodStatus(int prodId, Model model);
	public int sellsComple(ProductDTO dto, Model model);
	public void sellsAllView(Model model, int num, HttpSession session);
	
	public void picksAllView(Model model, int num, HttpSession session);
	public void pickDelete(ProductDTO dto);
	public void cateSerchView(Model model, String cateCode);
	public void cateSet(HttpSession session);
	public void oneCateclick(Model model, Map<Object, Object> map);
	
}
