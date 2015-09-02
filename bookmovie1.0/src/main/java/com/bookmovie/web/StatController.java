package com.bookmovie.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/stat")
public class StatController {
	private static final Logger logger = LoggerFactory.getLogger(StatController.class);
	
	@RequestMapping(value="/main")
	public String main(Model model){
		logger.info("예약 메인페이지");
		return "stat/statMain.tiles";
	}
}

