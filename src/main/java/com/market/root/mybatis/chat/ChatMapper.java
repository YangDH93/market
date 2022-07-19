package com.market.root.mybatis.chat;

import java.util.List;
import java.util.Map;

import com.market.root.chat.dto.ChatDTO;

public interface ChatMapper {

	public void addChatRoom(ChatDTO chatDTO);

	public List<ChatDTO> getChatList(Map<String, Object> map);

}
