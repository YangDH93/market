package com.market.root.mybatis.member;

import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.market.root.member.dto.MemberDTO;

public interface MemberMapper {
	public MemberDTO logChk(String mbrId);
	public void keepLogin(Map<String, Object> map);
	public MemberDTO chkSessionId(String sessionId);
	public MemberDTO regNameChk(String inputName);
	public MemberDTO regIdChk(String inputId);
	public MemberDTO regEmailChk(String mail);
	public int register(MemberDTO dto);
	
	public MemberDTO dupChk(Map<String, String> map);
	
	
}
