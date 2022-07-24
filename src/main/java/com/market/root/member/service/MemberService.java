package com.market.root.member.service;

import java.util.Date;
import java.util.HashMap;
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
	public int userDelete(String mbrId);
	//사용자 저장된 주소 확인
	public void mbrAddr(HttpSession session,Model model);
	public String getAccessToken(String code);
	public HashMap<String, Object> getUserInfo(String access_Token);
	public void findId(String mbrEmail, Model model);
	public void sendPwd(String mbrEmail, Model model);
}
