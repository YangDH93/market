package com.market.root.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.root.member.dto.MemberDTO;
import com.market.root.mybatis.member.MemberMapper;

@Service
public class RegisterServiceImpl implements RegisterService{

	@Autowired MemberMapper mapper;

	// reg Id 중복확인
	@Override
	public int regIdChk(String inputId) {
		
		int result = 0; //기본값?
		MemberDTO dto = null;
		
		try {
			dto = mapper.regIdChk(inputId);
			if(dto != null) { // 값 있음 = 중복
				result = 1;
			}else { // 사용가능
				result = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
