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

import com.bookmovie.domain.BookDto;
import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.BookService;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/book")
public class BookController {
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);
	
	/* 책 검색에 관한 컨트롤러 */
	@Autowired BookService service;
	@Autowired BookDto book;
	@RequestMapping(value="/main")
	public String main(@ModelAttribute("user")MemberDto user, Model model){
		logger.info("책 메인페이지");
		model.addAttribute("member", user);
			return "book/bookMain.tiles";
	}
	
	/* 대분류 출력 */
	@RequestMapping(value="/big-cat",method=RequestMethod.GET)
	public @ResponseBody List<BookDto> bigCat(){
		List<BookDto> list = new ArrayList<BookDto>();
		list = service.bigCat();
		return list;
	}
	
	/* 중분류 출력 */
	@RequestMapping(value="/medium-cat/{sel}",method=RequestMethod.GET)
	public @ResponseBody List<BookDto> mediumCat(
			@PathVariable("sel")String sel){
		List<BookDto> list = new ArrayList<BookDto>();
		list = service.mediumCat(CommandFactory.search("mediumCat", sel));
		return list;
	}
	
	/* 소분류 출력 */
	@RequestMapping(value="/small-cat/{sel}",method=RequestMethod.GET)
	public @ResponseBody List<BookDto> smallCat(
			@PathVariable("sel")String sel){
		List<BookDto> list = new ArrayList<BookDto>();
		list = service.smallCat(CommandFactory.search("smallCat", sel));
		return list;
	}
	
	/* 카테고리 검색 */
	@RequestMapping(value="/search-list/{sel}/{pageNo}",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> searchList(
			@PathVariable("sel")String sel,
			@PathVariable("pageNo")String paramPage){
		logger.info("검색 카테고리1 = {}",sel);
		Map<String,Object>map = new HashMap<String,Object>();
		List<BookDto> list = new ArrayList<BookDto>();
		int pageNo = Integer.parseInt(paramPage);
		logger.info("검색 카테고리 페이지 = {}",pageNo);
		int size = service.size(CommandFactory.size(sel));
		list = service.search(CommandFactory.search(pageNo, "smallCat", sel));
		logger.info("검색 카테고리2 = {}",sel);
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
	}
	
	/* 검색어 검색 */
	@RequestMapping(value="/searching/{sel}/{word}/{pageNo}",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> searching(
			@PathVariable("sel")String sel,
			@PathVariable("word")String word,
			@PathVariable("pageNo")String paramPage){
		logger.info("통합검색 = {}",sel);
		Map<String,Object>map = new HashMap<String,Object>();
		List<BookDto> list = new ArrayList<BookDto>();
		int pageNo = Integer.parseInt(paramPage);
		logger.info("검색 카테고리 페이지 = {}",pageNo);
		int size = service.keywordsize(CommandFactory.size(sel,word));
		list = service.searching(CommandFactory.search(pageNo, sel, word));
		logger.info("검색 카테고리2 = {}",sel);
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
	}
	
	/* 책 상세정보 */
	@RequestMapping(value="/detail/{serialNo}",method=RequestMethod.GET)
	public @ResponseBody BookDto detail(
			@PathVariable("serialNo")String serialNo){
		logger.info(serialNo);
		String searchVal = serialNo;
		book = service.detail(CommandFactory.detail("imgAddr", searchVal));
		return book;
	}
	

	
}
