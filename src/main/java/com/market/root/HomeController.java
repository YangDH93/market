package com.market.root;

import java.io.File;
import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		File marketFile = new File("C:/market");
		if(marketFile.exists() == false) {
			marketFile.mkdirs();
		}
		
		return "main";
	}
}
