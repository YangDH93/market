package com.market.root.error;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class MyAdvice {
	
	Logger logger = LoggerFactory.getLogger(MyAdvice.class);
	
	 @ExceptionHandler(Exception.class) public String handleException(Exception
	  ex, Model model) { logger.error("Exception 발생 : {}", ex.getMessage());
	  model.addAttribute("msg", "<script>alert('잠시 후 다시 시도해주세요')</script>"); return
	  "error/error"; }
	
	  @ExceptionHandler(NoHandlerFoundException.class)
	  @ResponseStatus(value = HttpStatus.NOT_FOUND) public String
	  handle404(NoHandlerFoundException ex, Model model) { logger.error("404요청 발생",
			  ex.getRequestURL());
	  model.addAttribute("msg","<script>alert('그런 페이지는 없어요.')</script>"); return
			  "error/error"; 
	  }
	 
}
