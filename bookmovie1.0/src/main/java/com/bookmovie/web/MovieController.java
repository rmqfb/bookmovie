package com.bookmovie.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.domain.MovieDto;
import com.bookmovie.domain.MovieReviewDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.MovieService;


@SessionAttributes("user")
@Controller
@RequestMapping(value="/movie")
public class MovieController {
	private static final Logger logger = LoggerFactory.getLogger(MovieController.class);
	@Autowired MovieService movieService;
	@Autowired MovieReviewDto movie;

	
	//jsp
	@RequestMapping("/list")
	public String list (@ModelAttribute("user") MemberDto user
	           ,Model model){
		model.addAttribute("member", user);
		return "movie/movie.tiles";
	}

	
	//페이징된 영화 리스트 출력
	@RequestMapping("/list/{pageNo}")
	public @ResponseBody Map<String,Object>  list2(@ModelAttribute MovieDto movie,
			@PathVariable("pageNo")int pageNo			
			){
		
		logger.info("view={}",movie.getPageNo());
		Map<String,Object>map = new HashMap<String,Object>();
		List<MovieDto> list = new ArrayList<MovieDto>();
		int size = movieService.size(CommandFactory.size());
		list = movieService.list(CommandFactory.list(pageNo));
		logger.info("리스트결과" + list);
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		logger.info("리스트결과 = {} " + list.toString());
		logger.info("리스트 사이즈 = {} " + size);
		logger.info("리스트 pageNo = {} " +pageNo);
		return map;
	}
	/*
	 영화 상세정보 
	 board 리뷰 
	 board2 영화 
	 */
	@RequestMapping("/detail/{movieCode}")
	public @ResponseBody MovieDto detail(@ModelAttribute MovieDto movie,
			@ModelAttribute("user") MemberDto user,
			@PathVariable("movieCode")String movieCode
			){
		logger.info("detail 무비 코드={}",movieCode);
		
		movie = movieService.detail(CommandFactory.search("movieCode", movieCode));  // 영화
		
		return movie;
	}


	

	
}
