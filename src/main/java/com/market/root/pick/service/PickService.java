package com.market.root.pick.service;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.ui.Model;

import com.market.root.pick.dto.PickDTO;
import com.market.root.product.dto.ProductDTO;

public interface PickService {
	//prodTrade의 찜 total부분
	public void pickTotal(Model model, String prodId);
	//prodTrade의 loginUser찜 확인부분
	public void userPick(Model model, String prodId, HttpSession session);
	public int pickChk(String mbrId, String prodId, String num);
	public void getTotalList(Model model, List<ProductDTO> psAllView);

}
