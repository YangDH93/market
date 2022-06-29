package com.market.root.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.market.root.member.dto.MemberDTO;
import com.market.root.mybatis.member.MemberMapper;

@Service
public class RegisterServiceImpl implements RegisterService{

	@Autowired MemberMapper mapper;
	//비밀번호 암호화 객체 생성
	BCryptPasswordEncoder en =
					new BCryptPasswordEncoder();
	
	
	@Override
	//회원가입
	public int register(MemberDTO dto) {
		System.out.println("변경전 pw : " + dto.getMbrPw());
		String se = en.encode(dto.getMbrPw());
		System.out.println("변경후 pw : " + se);
		//dto에 암호화된 비빌번호 재 세팅
		dto.setMbrPw(se);
		
		int result = 0;
		try {
			//결과 1 또는 0 반환
			result = mapper.register(dto);
		} catch (Exception e) {
			System.err.println("register메소드 에러!!!");
			e.printStackTrace();
		}
		return result;
	}
	
}
