package com.market.root.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ChatInterceptor extends HandlerInterceptorAdapter
implements SessionId{
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
          throws Exception {
       HttpSession session = request.getSession();
       if( session.getAttribute("loginUser") == null ) {
          //보내질 문자 타입 지정
          response.setContentType("text/html;charset=utf-8");
          //메세지 출력을 위한 메소드
          PrintWriter out = response.getWriter();
          //자신의 root 경로 읽어옴
          String path = request.getContextPath();
          out.print("<script> alert('로그인 후 이용 가능합니다.');"
                +"location.href='"+path+"/member/login'</script>");
          return false;
       }
       return true;
    }
}


