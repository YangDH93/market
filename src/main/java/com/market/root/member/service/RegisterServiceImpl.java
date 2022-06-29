package com.market.root.member.service;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.market.root.member.dto.MemberDTO;
import com.market.root.mybatis.member.MemberMapper;

@Service
public class RegisterServiceImpl implements RegisterService{

	@Autowired MemberMapper mapper;
	@Autowired JavaMailSender gmailSender;

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

	// 메일 인증코드 만드는 메소드
    private String createKey(int size) {
    	StringBuffer key = new StringBuffer();
    	Random ran = new Random();
    	for(int i = 0; i < size; i++) {// 몇 자리
    		key.append((ran.nextInt(10))); // 0~9
    	}
        return key.toString();  
    }
	
    // 메일관련 기본 메소드+예외처리
	public void sendGmail(String to, String subject, String body) {
		MimeMessage mime = gmailSender.createMimeMessage();
		
		try {
			MimeMessageHelper m = 
					new MimeMessageHelper(mime,true,"utf-8");
			
			m.setTo(to);
			m.setSubject(subject);
			m.setText(body);
			gmailSender.send(mime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Login 메일 발송 코드
	@Override
	public String gmailSend(String mail) {
		String to, subject, body, key;
		
		key = createKey(6);// 키 생성
		
		to = mail; // 받는메일
		subject = "[오리마켓]가입 인증코드입니다."; // 메일제목
		body = "인증번호 : "+ key; // 메일내용
		
		sendGmail(to,subject,body);
		return key; // key값 돌려줌
	}
	
}
