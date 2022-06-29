package com.market.root.mybatis.member;

import java.util.Map;

import com.market.root.member.dto.MemberDTO;

public interface MemberMapper {
	public MemberDTO logChk(String mbrId);
	public void keepLogin(Map<String, Object> map);
	public MemberDTO chkSessionId(String sessionId);
	public int register(MemberDTO dto);
}
