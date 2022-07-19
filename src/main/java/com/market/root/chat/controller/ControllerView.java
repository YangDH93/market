package com.market.root.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.root.chat.service.ChatService;
import com.market.root.product.dto.ProductDTO;

@Controller
public class ControllerView {

	@Autowired ChatService cs;
	
	// 채팅방 입장
	@RequestMapping(value = "/chat.do", method = RequestMethod.GET)
	public String view_chat(HttpServletRequest request, 
						HttpServletResponse response, 
						Model model,
						@RequestParam String bang_id) throws Exception {
		
		cs.addChatRoom(bang_id);
		model.addAttribute("bangId", bang_id);
		
		
		return "chat/view_chat";
	}
	
	@RequestMapping(value = "/chatList", method = RequestMethod.GET)
	public String chatList(@RequestParam String mbrId,
							Model model) {
		//System.out.println("오리톡 유저 "+mbrId);
		
		cs.getChatList(model, mbrId);
		
		
		return "chat/chatList";
	}
	
	
}
