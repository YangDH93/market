package com.market.root.chat.controller;

import java.io.FileWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.root.chat.handler.HandlerChat;
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
						@RequestParam String bang_id,
						HttpSession session) throws Exception {
		
		cs.addChatRoom(bang_id);
		model.addAttribute("bangId", bang_id);
		session.setAttribute("bangId", bang_id);
		cs.selectChatRoom(model,bang_id,session);
		
		return "chat/view_chat";
	}
	
	// 오리톡 리스트
	@RequestMapping(value = "/chatList", method = RequestMethod.GET)
	public String chatList(Model model, 
							HttpSession session) {
		//System.out.println("오리톡 유저 "+mbrId);
		
		cs.getChatList(model, session);
		
		return "chat/chatList";
	}
	
	// 오리톡 seller의 방 나가기-update
	@GetMapping("/updateSB")
	public String updateSB(@RequestParam String bangId,HttpSession session) {
		cs.updateSB(bangId);
		cs.delFileName(bangId);
		return "redirect:chatList";
	}
	
	// 오리톡 buyer의 방 나가기-update
	@GetMapping("/updateBB")
	public String updateBB(@RequestParam String bangId,HttpSession session) {
		cs.updateBB(bangId);
		cs.delFileName(bangId);
		return "redirect:chatList";
	}
	
}
