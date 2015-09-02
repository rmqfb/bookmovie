package com.bookmovie.web;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.domain.TheaterDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.serviceImpl.TheaterServiceImpl;


@Controller
@SessionAttributes("user")
@RequestMapping(value="/theater")
public class TheaterController {
	private static final Logger logger = LoggerFactory.getLogger(TheaterController.class);
	
	@Autowired TheaterServiceImpl service;
	
	@RequestMapping("/list/{date}")  // 영화관 메인 화면
	public @ResponseBody List<TheaterDto> view(@ModelAttribute TheaterDto theater,
			@PathVariable("date")String date){
		logger.info("극장view={}", date);
		List<TheaterDto> list = new ArrayList<TheaterDto>();
		list = service.list(CommandFactory.list(date)); 
		return list;
	}
	@RequestMapping("/list")
	public String list(@ModelAttribute("user") MemberDto user 
			,Model model){
		logger.info("극장view");
		model.addAttribute("member", user);
		return "theater/theater.tiles";
	}
	
	
	@RequestMapping("/detail/{thCode}/{thTime}")
	public @ResponseBody TheaterDto detail(@ModelAttribute TheaterDto theater,
			@PathVariable("thCode")String thCode,
			@PathVariable("thTime")String thTime
			){
		logger.info("thDetail thCode={}, thTime={}",theater.getThCode(), theater.getThTime());
		
		theater= service.detail(CommandFactory.detail("th_code", thCode));
		
		if(thTime.equals("1")){
			theater.setThTime(theater.getFirstTime());
		}else if (thTime.equals("2")) {
			theater.setThTime(theater.getSecondTime());
		}else if (thTime.equals("3")){
			theater.setThTime(theater.getThirdTime());
		}else if (thTime.equals("4")){
			theater.setThTime(theater.getFourthTime());
		}else if (thTime.equals("5")){
			theater.setThTime(theater.getFifthTime());
		}
		
		
		return theater;
	}
	@RequestMapping("/detail")
	public String detail(){
		logger.info("극장view");
		return "list";
	}
	
	
	@RequestMapping("/theaterMap")  //영화관 오시는 길
	public ModelAndView theaterMap(ModelAndView mav){
		return null;
	}
	
}
