package com.market.root.pick.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.mybatis.pick.PickMapper;
import com.market.root.pick.dto.PickDTO;
import com.market.root.product.dto.ProductDTO;

@Service
public class PickServiceImpl implements PickService{

	@Autowired PickMapper mapper;
	
	//상품별 찜 total갯수
	@Override
	public void pickTotal(Model model, String prodId) {
		try {
			int pickTotal = mapper.pickTotal(prodId);
			model.addAttribute("pickTotal", pickTotal);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//prodTrade 로그인 유저 찜여부 확인
	@Override
	public void userPick(Model model, String prodId, HttpSession session) {
		String mbrId = (String) session.getAttribute("loginUser");
		if(mbrId != null) {//로그인 유저일때만 기능 수행
			try {
				int pickCk = mapper.userPickChk(prodId,mbrId);
				// 0 : 찜한적 없음, 1 : 이미 찜한 상품
				model.addAttribute("pick", pickCk);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	//loginUser pick Ajax
	@Override
	public int pickChk(String mbrId, String prodId, String num) {
		int pickTotal = -1; //ajax처리 안함
		try {
			//0 : 찜 취소, 1 : 찜
			
			if(num.equals("0")) {
				//System.out.println("delete문 작성 ");
				mapper.pickDelete(prodId, mbrId);
			}else if(num.equals("1")) {
				//System.out.println("insert문 작성");
				mapper.pickInsert(prodId, mbrId);
			}
			//data보냄
			pickTotal = mapper.pickTotal(prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pickTotal;
	}
	
	
	//현재 model로 출력될 리스트의 pickTotal model에 저장하는 메소드
	public void getTotalList(Model model, 
							List<ProductDTO> arr) {
		List<Integer> pickArr = new ArrayList<Integer>();
		
		try {
			for(int i=0; i<arr.size(); i++) {
				ProductDTO dto = arr.get(i); //DTO 값 저장
				//System.out.println("상품번호 : "+dto.getProdId());
				//ProdId에 맞는 pickTotal값 가져옴
				int pickTotal = mapper.pickTotal((Integer.toString(dto.getProdId())));
				
				pickArr.add(pickTotal);
			}
			model.addAttribute("pickTotal", pickArr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
