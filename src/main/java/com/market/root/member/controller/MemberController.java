package com.market.root.member.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.reflect.Member;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.market.root.common.SessionId;
import com.market.root.member.dto.MemberDTO;
import com.market.root.member.service.MemberService;
import com.market.root.member.service.RegisterService;

// 주소값 ~root/member/로 시작
@Controller
@RequestMapping("member")
public class MemberController{
	
	@Autowired RegisterService rs;
	@Autowired MemberService ms; //Member 관련 class
	
	@GetMapping("login") // 로그인 페이지
	public String login() {
		return "member/login";
	}
	
	//회원정보 수정 전 - 비밀번호 확인 페이지
	@GetMapping("pwdChkForm")
	public String pwdChkForm(@RequestParam String mbrId,
						Model model) {
		System.out.println(mbrId + "회원정보 수정 전 확인");
		ms.pwChkForm(mbrId, model);
		
		return "member/pwdChkForm";
	}
	
	//비밀번호 일치 확인 후 회원정보 수정 페이지로 DTO값 전송
	@PostMapping("pwdChk")
	public String pwdChk(@RequestParam String mbrId,
						@RequestParam String mbrPw,
						Model model) {
		int result = ms.pwChk(mbrId, mbrPw, model);
		
		if(result == 1) {
			System.out.println("비밀번호 일치합니다.");
			return "member/modifyForm";
		}else {
			
			System.out.println("비밀번호 불일치 혹은 id값 전송 실패(dto == null)");
			return "redirect:pwdChkForm?mbrId="+mbrId;
		}
		
	}
	
	//회원정보 수정/추가 페이지
	@GetMapping("modifyForm")
	public String memberModify(Model model,
			@RequestParam String id) {
		System.out.println(id);
		ms.memberInfo(id, model);
		
		return "member/modifyForm";
	}
	
	//회원정보 수정/추가 메소드
	@PostMapping("modify")
	public String modify(String si,Model model) {
		
		int result=0;
		result = ms.modify(si, model);
		
		if(result == 0) {
			System.out.println("수정 실패!");
			return "redirect:memberModify";
		}
		
		System.out.println("수정완료!!");
		return "product/prodStatus";
	}
	
	//로그인 확인 페이지
	@PostMapping("logChk")
	public String logChk(@RequestParam String mbrId,
						@RequestParam String mbrPw,
						@RequestParam(required = false)
									String autoLogin,
						HttpSession session,
						RedirectAttributes rs) {
		
		int result = ms.logChk(mbrId, mbrPw, session);
		// 0 : session id값 저장 + 로그인 성공 / -1 : 비번틀림 / 1 : 아이디 없음
		
		if(result == 0) { // 성공
			//checkbox값 저장
			session.setAttribute("autoLogin", autoLogin);
			return "redirect:successLogin"; 
		}else if(result == -1) {
			rs.addFlashAttribute("massage", "비밀번호가 틀렸습니다.");
		}else {
			rs.addFlashAttribute("massage", "아이디가 없습니다.");
		}
		return "redirect:/member/login"; 
	}
	
	// 자동로그인,세션,쿠키저장
	@GetMapping("successLogin")
	public String successLoin(HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response) {
		//System.out.println(session.getAttribute(SessionId.LOGIN)); // session 저장 확인
		//System.out.println(session.getAttribute("autoLogin")); //checked : on / null
		
		if(session.getAttribute("autoLogin") != null) { // checked상태
			int time = 60*60*24*90; // 90일의 시간
			Cookie cook = new Cookie("loginCookie", session.getId());
			cook.setPath("/");
			cook.setMaxAge(time);
			response.addCookie(cook); // 사용자에게 쿠키값 전달
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new java.util.Date());
			cal.add(Calendar.MONTH, 3);
			
			java.sql.Date limitDate = new java.sql.Date(cal.getTimeInMillis());
			ms.KeepLogin(session.getId(), limitDate, (String)session.getAttribute(SessionId.LOGIN));
		}
		return "redirect:/";
	}
	
	// 로그아웃
	@GetMapping("logout")
	public ModelAndView logout(HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response,
							String access_Token) {
		
		// 리턴타입 object이므로 String으로 다운캐스팅
		String se = (String)session.getAttribute(SessionId.LOGIN);
		
		if(se != null) { // 세션객체 있을 경우
			session.removeAttribute(SessionId.LOGIN); //세션객체 삭제
			session.invalidate(); //세션 객체 무효화
			
			// 자동로그인체크
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			// request에서 MemberController의 "loginCookie"찾음
			
			if(loginCookie != null) { // 쿠키값 있음(자동로그인 체크)
				loginCookie.setMaxAge(0); // 쿠키 수명 0초 설정
				response.addCookie(loginCookie); // 사용자에게 쿠키값 전달
				ms.KeepLogin("nan", new java.util.Date(), se);// DB 세션아이디, 만료시간 update
			}
		}
		//카카오 로그아웃
		kakaoLogout(access_Token);
		
		return new ModelAndView("redirect:/");
	}
	
	//회원정보 수정 - 업데이트
	//동훈이형 나중에 여기 이미지 업데이트시 modifyForm.jsp에서 multipart로 받을것
	@PostMapping("memberUpdate")
	public String memberUpdate(@RequestParam Map<Object, Object> map) {
		
//		System.out.println(map.get("mbrName"));
//		System.out.println(map.get("dName"));
//		System.out.println(map.get("mbrAddr"));
//		System.out.println(map.get("mbrTel"));
		
		int result = ms.mbrUpdate(map);
		if(result == 1) {
			System.out.println("업데이트 완료!");
			return "redirect:/";
		}else {
			System.out.println("업데이트 실패!");
			return "member/modifyForm";
		}
	}
	
	//계정삭제
	@GetMapping("userDelete")
	public String userDelete(@RequestParam (required = false) String mbrId) {
		System.out.println("삭제할 계정 : "+mbrId);
		int result;
		
		result = ms.userDelete(mbrId);
		
		if(result == 1) {
			System.out.println(mbrId + " : 계정 삭제 성공!");
			return "redirect:logout";
		}else {
			System.out.println(mbrId + " : 계정 삭제 실패!");
		}
		
		return "redirect:/";
	}
	
	//카카오 로그인 및 가입
	@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code,
			HttpSession session) throws Exception {
		//System.out.println("#########" + code);
		String access_Token = ms.getAccessToken(code);
		
		HashMap<String, Object> userInfo = ms.getUserInfo(access_Token);
        
		// 위에서 만든 코드 아래에 코드 추가
		//System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###kakaoId### : " + userInfo.get("kakaoId")); 
		System.out.println("###email#### : " + userInfo.get("email"));

		MemberDTO dto = new MemberDTO();
		dto.setMbrName((String) userInfo.get("nickname"));
		dto.setMbrId((String) userInfo.get("kakaoId"));
		dto.setMbrEmail((String) userInfo.get("email"));
		
		//mbr_info로 kakao 이메일, 닉네임, 아이디 전송
		rs.kakaoRegister(dto);
		
		String mbrName = URLEncoder.encode((String) userInfo.get("nickname"));
		
		
		//리턴 매핑
		//"redirect:reg?mbrId="+userInfo.get("kakaoId")+"&mbrEmail="+userInfo.get("email")+"&mbrName="+mbrName;
		session.setAttribute(SessionId.LOGIN, userInfo.get("kakaoId"));
		
		return "redirect:/";
    }
	
	//카카오 로그아웃
    public void kakaoLogout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String result = "";
            String line = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	//아이디 비밀번호 찾기 페이지
	@GetMapping("forgetIdPwd")
	public String forgetId() {
		return "member/forgetIdPwd";
	}
	
	//아이디 찾음 페이지
	@PostMapping("findId")
	public String findId(@RequestParam String mbrEmail,
							Model model) {
		//System.out.println(mbrEmail);
		ms.findId(mbrEmail,model);
		
		return "member/findId";
	}
	
	//임시 비밀번호 발송 페이지
	@PostMapping("findPwd")
	public String forgetPwd(@RequestParam String mbrEmail,
								Model model) {
		
		ms.sendPwd(mbrEmail,model);
		
		return "member/findPwd";
	}
	
}
