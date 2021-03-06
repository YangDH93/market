package com.market.root.chat.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.socket.WebSocketSession;

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
	
	//채팅룸 여부 확인
	public int chatRoomChk(String bang_id) {
		int result = -1; //db고장처리
		
		try {
			List<ChatDTO> arr = getList("bang_id", bang_id);
			
			if(arr.size() != 0) { result=1; }//방 이미 있음
			else { result=0; } //방 없음
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//채팅룸 추가
	@Override
	public void addChatRoom(String bang_id) {
		
		int result = -1;
		result = chatRoomChk(bang_id); //채팅룸 여부 확인 메소드
		if(result == 0) { //없음
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
				/*
				System.out.println("방Id : "+bang_id);
				System.out.println("품번 : "+prodId);
				System.out.println("구매자Id : "+buyerId);
				System.out.println("구매자N : "+buyerName);
				System.out.println("판매자Id : "+sellerId);
				System.out.println("판매자N : "+sellerName);
				*/
				
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
		}else if(result == 1) { //있음+채팅시도
			updateBang("seller_bang", "1", bang_id); //방 목록 생성
			updateBang("buyer_bang", "1", bang_id); //방 목록 생성
		}else {
			System.out.println("DB 고장");
		}
	}
	
	//채팅 목록 가져오기(상태1인경우만)
	@Override
	public void getChatList(Model model, HttpSession session) {
		//mbrId = 현재 session loginUser
		String mbrId = (String)session.getAttribute("loginUser");
		
		try {
			List<ChatDTO> sArr = getList("seller_id", mbrId); //목록 확인 메소드
			if(sArr.size() != 0) {
				chatSell1(model, sArr); //상태 1
			}else {
				chatSell1(model, sArr); //상태 0
			}
			
			List<ChatDTO> bArr = getList("buyer_id", mbrId); //목록 확인 메소드
			if(bArr.size() != 0) {
				chatBuy1(model, bArr); //상태 1
			}else {
				chatBuy1(model, bArr); //상태 0
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//getChatList의 sellList상태 1만 보냄
	public void chatSell1(Model model, List<ChatDTO> arr) {
		
		List<ChatDTO> sArr = new ArrayList<ChatDTO>();
		
		for(int i=0; i<arr.size(); i++) {
			ChatDTO dto = arr.get(i);
			int st = dto.getSellerBang();
			// 판매 방 있는 경우
			if(st == 1) { sArr.add(dto); }
		}//for문 종료
		
		//판매 채팅 목록
		model.addAttribute("sellList", sArr);
		//구매 채팅 prod목록
		List<ProductDTO> spArr = prodList(sArr);
		model.addAttribute("sProdList", spArr);
		
	}
	
	//getChatList의 buyList상태 1만 보냄
	public void chatBuy1(Model model, List<ChatDTO> arr) {
		
		List<ChatDTO> bArr = new ArrayList<ChatDTO>();
		
		for(int i=0; i<arr.size(); i++) {
			ChatDTO dto = arr.get(i);
			int st = dto.getBuyerBang();
			// 구매 방 있는 경우
			if(st == 1) { bArr.add(dto); }
		}//for문 종료
		
		//구매 채팅 목록
		model.addAttribute("buyList", bArr);
		//구매 채팅 prod목록
		List<ProductDTO> bpArr = prodList(bArr);
		model.addAttribute("bProdList", bpArr);
	}
	
	//ProductDTO의 값 Array로 저장
	public List<ProductDTO> prodList(List<ChatDTO> arr) {
		
		List<ProductDTO> pArr = new ArrayList<ProductDTO>();
		
		for(int i=0; i<arr.size(); i++) {
			ChatDTO cDto = arr.get(i);
			ProductDTO pDto = getProductDTO(cDto.getProdId());
			pArr.add(pDto);
		}
		return pArr;
	}
	
	//pMapper : select * from prod_info where prod_id=#{prodId} sql문
	//ProductDTO에 저장
	public ProductDTO getProductDTO(int prodId) {
		ProductDTO dto = new ProductDTO();
		try {
			dto = pMapper.prodStatus(prodId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//mapper : select * from chat_room where ${c1}=#{v1} sql문
	//List<ChatDTO>에 저장
	public List<ChatDTO> getList(String c1, String v1){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c1", c1);
		map.put("v1", v1);
		List<ChatDTO> arr = new ArrayList<ChatDTO>(); 
		try {
			arr = mapper.getChatList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}

	//seller 방 나가기
	@Override
	public void updateSB(String bangId) {
		updateBang("seller_bang", "0", bangId);
	}

	//buyer 방 나가기
	@Override
	public void updateBB(String bangId) {
		updateBang("buyer_bang", "0", bangId);
	}

	//mapper 방나가기 : update chat_room set ${c1}=#{v1} where bang_id=#{v2} sql
	public void updateBang(String c1, String v1, String v2) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c1", c1);
		map.put("v1", v1);
		map.put("v2", v2);
		try {
			mapper.updateBang(map);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void selectChatRoom(Model model, String bang_id, HttpSession session) {
		List<String> arr = new ArrayList<String>();
		String chatUserN = (String) session.getAttribute("userName")+" ";
		////////////////File Read/////////////////
		try(FileReader rw = new FileReader("C:\\market\\chat\\"+bang_id+".txt");
				BufferedReader br = new BufferedReader( rw );
				) {
			//읽을 라인이 없을 경우 br은 null을 리턴한다.
			String readLine = null;
			String me = null;
			String inOut = null;
			String other = null;
			while( ( readLine = br.readLine() ) != null ) {
				System.out.println(readLine);
				String[] userChk = readLine.split(":");
				
				if(chatUserN.equals(userChk[0])) {
					me = "<div class='myChat'><p class='myChatBox'>"+ readLine +"</p></div>";
					arr.add(me);
				}else if(userChk.length == 1){
					//inOut = "<div class='userInOut'><div class='userInOutBox'>" + readLine + "</div></div>";
					//arr.add(inOut);
				}else {
					other = "<div class='otherChat'><p class='otherChatBox'>"+ readLine +"</p></div>";
					arr.add(other);
				}
			}
			model.addAttribute("chatList",arr);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delFileName(String bang_id) {
		try {
			ChatDTO dto = mapper.delFileName(bang_id);
			if(dto != null) {//지움
				mapper.deleteZBang();
				File file = new File("C:\\market\\chat\\" + bang_id + ".txt");
		    	if( file.exists() ){
		    		if(file.delete()){
		    			System.out.println("파일삭제 성공");
		    		}else{
		    			System.out.println("파일삭제 실패");
		    		}
		    	}else{
		    		System.out.println("파일이 존재하지 않습니다.");
		    	}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
