package com.market.root.member.service;

import com.market.root.member.dto.MemberDTO;


public interface RegisterService {
	public int register(MemberDTO dto);
	public int regNameChk(String inputName);
	public int regIdChk(String inputId);
	public String gmailSend(String mail);
}
