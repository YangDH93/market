package com.market.root.member.service;

import com.market.root.member.dto.MemberDTO;


public interface RegisterService {
	public int register(MemberDTO dto);
	public String gmailSend(String mail);
	public int dupChk(String cIn, String uIn); //중복체크
	public void kakaoRegister(MemberDTO dto);
	public String gSendPwd(String mail); //임시 비번 발송
}
