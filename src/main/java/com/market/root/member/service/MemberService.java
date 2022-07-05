package com.market.root.member.service;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.market.root.common.SessionId;
import com.market.root.member.dto.MemberDTO;


public interface MemberService {
	public int logChk(String mbrId, String mbrPw, HttpSession session);
	public void KeepLogin(String sessionId, Date limitDate, String mbrId);
	public MemberDTO chkSessionId(String sessionId);
	public int modify(String si, Model model);
	public void memberInfo(String id, Model model);
	public void pwChkForm(String mbrId, Model model);
	public int pwChk(String mbrId,String mbrPw,Model model);
	public int mbrUpdate(Map<Object, Object> map);
}
