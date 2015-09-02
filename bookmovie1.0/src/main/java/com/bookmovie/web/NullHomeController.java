package com.bookmovie.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value="/homes")
public class NullHomeController {
	private static final Logger logger = LoggerFactory.getLogger(NullHomeController.class);
	
	@RequestMapping(value="/null/main")
	public String main(Model model){
		logger.info("홈 컨트롤러 : 메인페이지");
		return "homes/nulls/homeMain.tiles";
	}
	@RequestMapping(value="/null/log")
	public String log(){
		logger.info("로그인창으로 이동");
		return "homes/nulls/login.tiles";
	}
	
}

