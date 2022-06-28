package com.market.root.member.service;

import java.util.Date;

import javax.servlet.http.HttpSession;

import com.market.root.member.dto.MemberDTO;


public interface MemberService {
	public int logChk(String mbrId, String mbrPw, HttpSession session);
	public void KeepLogin(String sessionId, Date limitDate, String mbrId);
	public MemberDTO chkSessionId(String sessionId);
}
