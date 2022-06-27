package com.market.root.member.service;

import javax.servlet.http.HttpSession;


public interface MemberService {
	public int logChk(String mbrId, String mbrPw, HttpSession session);
}
