package com.market.root.mybatis.chat;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import com.market.root.chat.dto.ChatDTO;

public interface ChatMapper {

	public void addChatRoom(ChatDTO chatDTO);

	public List<ChatDTO> getChatList(Map<String, Object> map);

	public void updateBang(Map<String, Object> map);

	public void deleteZBang();
	
	public ChatDTO delFileName(String bangId);

}
