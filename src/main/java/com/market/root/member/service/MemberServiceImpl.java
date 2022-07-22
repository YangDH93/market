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
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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

	//카카오 로그인
	public String getAccessToken (String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id=f08ac675d19148fc1c8231df859ca51a"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8090/root/member/kakaoLogin"); // 본인이 설정한 주소
            
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
            
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	//카카오 인증 성공 사용자 토큰값 받아옴
	public HashMap<String, Object> getUserInfo(String access_Token) {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String id = element.getAsJsonObject().get("id").getAsString();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			
			System.out.println(id);
			
			userInfo.put("kakaoId", id);
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
}
