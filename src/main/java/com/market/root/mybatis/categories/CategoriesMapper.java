package com.market.root.mybatis.categories;

import java.util.ArrayList;
import java.util.Map;

import com.market.root.product.dto.CategoriesDTO;

public interface CategoriesMapper {
	public ArrayList<CategoriesDTO> cateAllListSe();
	public ArrayList<CategoriesDTO> cateAllList();
	public ArrayList<CategoriesDTO> cateList(String sltCode);
	public ArrayList<CategoriesDTO> oneCateAll(String cateCode);
}
