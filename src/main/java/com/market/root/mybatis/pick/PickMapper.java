package com.market.root.mybatis.pick;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.market.root.pick.dto.PickDTO;

public interface PickMapper {

	public int pickTotal(String prodId);
	public int userPickChk(@Param("prodId") String prodId, @Param("mbrId")String mbrId);
	public void pickInsert(@Param("prodId") String prodId, @Param("mbrId")String mbrId);
	public void pickDelete(@Param("prodId") String prodId, @Param("mbrId")String mbrId);
	public List<PickDTO> userPickList(@Param("mbrId")String mbrId);
}
