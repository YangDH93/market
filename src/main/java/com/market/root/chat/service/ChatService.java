package com.market.root.chat.service;

import org.springframework.ui.Model;

public interface ChatService {
	//채팅룸 추가
	public void addChatRoom(String bang_id);
	//채팅 목록 가져오기
	public void getChatList(Model model, String mbrId);


}
