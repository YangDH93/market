package com.market.root.member.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.market.root.common.SessionId;
import com.market.root.member.dto.MemberDTO;
import com.market.root.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired MemberMapper mapper;
	
	// 비번 암호화 클래스
	BCryptPasswordEncoder en =
			new BCryptPasswordEncoder();


	// loginChk
	@Override
	public int logChk(String mbrId, String mbrPw, HttpSession session) {
		int result = 1; // 실패처리 기본 - 아이디없음
		MemberDTO dto  = null; //dto 초기화
		
		try {
			dto = mapper.logChk(mbrId);
			if(dto != null) { // 데이터베이스 값 들어옴
				if(en.matches(mbrPw, dto.getMbrPw()) || dto.getMbrPw().equals(mbrPw)) {
					// 관리자계정 때문에 두 가지로 확인(관리자계정 - 암호화 안됨)
					session.setAttribute(SessionId.LOGIN, dto.getMbrId());
					//System.out.println(dto.getId()); // 아이디 세션저장
					
					// 이름으로 사용 할 경우 주석 풀고 userName변수로 사용~
					// session.setAttribute("userName", dto.getMbrName());
					
					result = 0; // session id값 저장 + 로그인 성공
				}else {
					result = -1; // 비번틀림
				}
			}else {
				result = 1; // 아이디 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	@Override
	public void KeepLogin(String sessionId, Date limitDate, String mbrId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("s", sessionId);
		map.put("d", limitDate);
		map.put("id", mbrId);
		
		mapper.keepLogin(map);
	}


	
}
