package com.market.root.chat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.market.root.chat.dto.ChatDTO;
import com.market.root.member.dto.MemberDTO;
import com.market.root.mybatis.chat.ChatMapper;
import com.market.root.mybatis.member.MemberMapper;
import com.market.root.mybatis.product.ProductMapper;
import com.market.root.product.dto.ProductDTO;

@Service
public class ChatServiceImpl implements ChatService{

	
	@Autowired ChatMapper mapper;
	@Autowired MemberMapper mMapper;
	@Autowired ProductMapper pMapper;
	
	//채팅룸 추가
	@Override
	public void addChatRoom(String bang_id) {
		
		try {
			String[] str = bang_id.split("_");
			
			//bang_id값에서 prodId,buyerId 추출
			int prodId = Integer.parseInt(str[0]) ;
			String buyerId = str[1];
			
			//구매자 name가져오는 메소드
			MemberDTO bdto = mMapper.logChk(buyerId);
			String buyerName = bdto.getMbrName();
			
			//판매자 Id가져오는 메소드
			ProductDTO pdto = pMapper.prodStatus(prodId);
			String sellerId = pdto.getMbrId();
			
			//판매자 Name가져오는 메소드
			MemberDTO sdto = mMapper.logChk(sellerId);
			String sellerName = sdto.getMbrName();
			
			//값 확인
			System.out.println("방Id : "+bang_id);
			System.out.println("품번 : "+prodId);
			System.out.println("구매자Id : "+buyerId);
			System.out.println("구매자N : "+buyerName);
			System.out.println("판매자Id : "+sellerId);
			System.out.println("판매자N : "+sellerName);
			
			//저장할 곳
			ChatDTO chatDTO = new ChatDTO();
			
			chatDTO.setBangId(bang_id);
			chatDTO.setProdId(prodId);
			chatDTO.setBuyerId(buyerId);
			chatDTO.setBuyerName(buyerName);
			chatDTO.setSellerId(sellerId);
			chatDTO.setSellerName(sellerName);
			
			chatDTO.setSellerBang(1);
			chatDTO.setBuyerBang(1);
			
			mapper.addChatRoom(chatDTO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//채팅 목록 가져오기(상태1인경우만)
	@Override
	public void getChatList(Model model, String mbrId) {
		//mbrId = 현재 session loginUser
		
		Map<String, Object> sMap = new HashMap<String, Object>();
		
		//판매 채팅 목록
		sMap.put("c1", "seller_id");
		sMap.put("v1", mbrId);
		
		try {
			List<ChatDTO> sArr = mapper.getChatList(sMap);
			if(sArr != null) {//판매자 목록
				model.addAttribute("sellList", sArr);
			}else {
				Map<String, Object> bMap = new HashMap<String, Object>();
				
				//구매채팅 목록
				bMap.put("c1", "buyer_id");
				bMap.put("v1", mbrId);
				
				List<ChatDTO> bArr = mapper.getChatList(bMap);
				if(bArr != null) {
					model.addAttribute("buyList", bArr);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		//mapper.getChatList();
		
		
		
	}


}
