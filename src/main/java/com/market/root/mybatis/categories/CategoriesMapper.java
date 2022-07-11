package com.market.root.mybatis.categories;

import java.util.ArrayList;
import java.util.Map;

import com.market.root.product.dto.CategoriesDTO;

public interface CategoriesMapper {
	public ArrayList<CategoriesDTO> cateAllList();
	public ArrayList<CategoriesDTO> cateList(String sltCode);
}
