package com.market.root.mybatis.product;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.market.root.product.dto.ProductDTO;

public interface ProductMapper {
	public List<ProductDTO> psAllView(
			@Param("s")int start,
			@Param("e")int end);
	public int selectBoardCount();
	public int prodRegister(ProductDTO dto);
	public int prodImgRegister(Map<Object,Object> map);
	public List<ProductDTO> prodSearch(String keyword);
	public ProductDTO oneProduct(Map<Object, Object> map);
	public void upHit(Map<Object, Object> map);
	public int prodDelete(int prodId);
	public int prodUpdate(ProductDTO dto);
	public ProductDTO prodStatus(int prodId);
	public int prodImgUpdate(Map<Object, Object> map);
}
