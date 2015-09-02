package com.bookmovie.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.bookmovie.domain.MemberDto;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/home")
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/main")
	public String main(@ModelAttribute("user") MemberDto user,Model model){
		logger.info("홈 컨트롤러 : 메인페이지");
		model.addAttribute("member", user);
		return "home/homeMain.tiles";
	}
}

