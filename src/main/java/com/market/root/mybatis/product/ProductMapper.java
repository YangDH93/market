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
	public List<ProductDTO> search(String keyword);
	public int prodRegister(Map<Object, Object> map);
}
