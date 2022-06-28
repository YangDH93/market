package com.market.root.member.service;

import java.util.Date;

import javax.servlet.http.HttpSession;


public interface MemberService {
	public int logChk(String mbrId, String mbrPw, HttpSession session);
	public void KeepLogin(String sessionId, Date limitDate, String mbrId);
}
