package com.market.root.mybatis.customer;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.market.root.customer.dto.CustomerDTO;

public interface CustomerMapper {
	//고객센터 문의글 보기
	//값이 2개 이상이라면 @Param을 사용한다. - XML로 전송하기 위함.
	public List<CustomerDTO> csAllView(
			@Param("s")int start,
			@Param("e")int end,
			@Param("mbrId")String mbrId);
	public int selectBoardCount();
	public CustomerDTO getCsContent(CustomerDTO dto);
	public int csContentDel(int csNum);
	public void csWrite(CustomerDTO dto);
	public int csUpdate(CustomerDTO dto);
}
