package com.market.root.customer.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.customer.dto.CustomerDTO;
import com.market.root.mybatis.customer.CustomerMapper;

@Service
public class CustomerServiceImpl implements CustomerService{

	@Autowired CustomerMapper mapper;
	
	//고객센터 문의글 전체 보기
	public void csAllView(Model model, int num, HttpSession session) {
		//한 페이지당 보여줄 문의글 수
		int pageLetter = 5; 
		//문의글 수 불러오기
		int allCount = mapper.selectBoardCount();
		//페이지 수 = 전체 문의글 수 / 보여줄 문의글 수
		int repeat = allCount / pageLetter;
		//전체 페이지(마지막 보여질 페이지) % 보여줄 문의글 수가 0이 아니면 페이지+1 증가
		if(allCount % pageLetter != 0) {
			repeat += 1;
		}
		String mbrId = (String)session.getAttribute("loginUser");
		//끝 페이지 번호
		int end = num * pageLetter;
		//시작 페이지 번호
		int start = end + 1 - pageLetter;
		//마지막 페이지번호 가져옴
		model.addAttribute("repeat",repeat);
		//문의글 모든 정보 가져옴
		model.addAttribute("csList", mapper.csAllView(start,end,mbrId) );
	}
	//고객센터 문의글 하나 보기 - 댓글 다는곳
	public void getCsContent(CustomerDTO dto, Model model) {
		try {
			model.addAttribute("cs",mapper.getCsContent(dto));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//고객센터 문의글 작성
	public void csWrite(CustomerDTO dto) {
		try {
			mapper.csWrite(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//고객센터 문의글 수정
	public int csUpdate(CustomerDTO dto) {
		int result = 0;
		try {
			result = mapper.csUpdate(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//고객센터 문의글 삭제
	public int csContentDel(int csNum) {
		int result = 0;
		try {
			result = mapper.csContentDel(csNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
