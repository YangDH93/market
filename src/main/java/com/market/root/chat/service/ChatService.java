package com.market.root.chat.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface ChatService {
	//채팅룸 추가
	public void addChatRoom(String bang_id);
	//채팅 목록 가져오기
	public void getChatList(Model model, HttpSession session);
	//seller 방 나가기
	public void updateSB(String bangId);
	//buyer 방 나가기
	public void updateBB(String bangId);
	

}
