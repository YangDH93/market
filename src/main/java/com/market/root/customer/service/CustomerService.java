package com.market.root.customer.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.market.root.customer.dto.CustomerDTO;

public interface CustomerService {
	//고객센터 문의글 전체 보기
	public void csAllView(Model model, int num, HttpSession session);
	//고객센터 문의글 하나 보기 - 댓글 다는곳
	public void getCsContent(CustomerDTO dto, Model model);
	public int csContentDel(int csNum);
	public void csWrite(CustomerDTO dto);
	public int csUpdate(CustomerDTO dto);
}
