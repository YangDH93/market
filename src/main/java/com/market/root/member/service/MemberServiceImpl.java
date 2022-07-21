package com.market.root.member.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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
					
					// 아이디 세션저장
					session.setAttribute(SessionId.LOGIN, dto.getMbrId());
					// 이름 세션 저장 - 채팅 기능때문
					session.setAttribute("userName", dto.getMbrName());
					
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


	@Override
	public MemberDTO chkSessionId(String sessionId) {
		MemberDTO dto = null;
		try {
			dto = mapper.chkSessionId(sessionId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//한 명의 회원 모든정보 가져옴
	public void memberInfo(String id, Model model) {
		try {
			System.out.println(id);
			model.addAttribute("mbrInfo",mapper.memberInfo(id));
			System.out.println("DB 다녀옴");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB 실행불가");
		}
	}
	
	//회원정보 수정
	public int modify(String si, Model model) {
		int result = 0;
		
		try {
			result = mapper.modify(si);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//비밀번호 확인 전 DTO값 전송
	public void pwChkForm(String mbrId,Model model) {
		try {
			model.addAttribute("mbrInfo", mapper.logChk(mbrId));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원정보 수정 폼으로 DTO 전송 및 비밀번호 체크
	public int pwChk(String mbrId, String mbrPw, Model model) {
		int result = 1; //비밀번호 일치
		MemberDTO dto = null;
		try {
			dto = mapper.logChk(mbrId);
			if(dto != null) {
				if(en.matches(mbrPw, dto.getMbrPw()) || dto.getMbrPw().equals(mbrPw)) {
					//비밀번호 일치.
					model.addAttribute("mbrInfo",dto);
					return result;
				}else {
					//비번 다름
					result = 0;
				}
			}else {
				//dto값이 없음
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원정보 수정 - 업데이트
	public int mbrUpdate(Map<Object, Object> map) { 
		int result=0;
		
		if(map.size() != 0) {
			try {
				result = mapper.mbrUpdate(map);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	//계정 삭제
	public int userDelete(String mbrId) {
		int result = 0;
		if(mbrId != null) {
			try {
				result = mapper.userDelete(mbrId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	//회원 주소 검색
	@Override
	public void mbrAddr(HttpSession session,Model model) {
		String mbrId = (String)session.getAttribute("loginUser");
		try {
			model.addAttribute("mbrAddr", mapper.logChk(mbrId));
		} catch (Exception e) {
			
		}
	}
}
