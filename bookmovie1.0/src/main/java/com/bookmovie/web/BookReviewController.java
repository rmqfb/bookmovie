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

import com.bookmovie.domain.BookReviewDto;
import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.BookReviewService;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/b-review")
public class BookReviewController {
	private static final Logger logger = LoggerFactory.getLogger(BookReviewController.class);
	
	@Autowired BookReviewService service;
	@Autowired BookReviewDto bReview;
	@RequestMapping(value="/main")
	public String main(@ModelAttribute("user")MemberDto user, Model model){
		logger.info("책리뷰 메인페이지");
		model.addAttribute("member", user);
			return "bookReview/BookReviewMain.tiles";
	}

	
	/* 책 리뷰에 관한 컨트롤러 */
	@RequestMapping(value="/list/{pageNo}")
	public @ResponseBody Map<String,Object> reviewList(BookReviewDto bReview,
			@PathVariable("pageNo")String paramPage){
		Map<String,Object>map = new HashMap<String,Object>();
		List<BookReviewDto> list = new ArrayList<BookReviewDto>();
		int size = service.size(CommandFactory.size(1001));
		int pageNo = Integer.parseInt(paramPage);
		list = service.list(CommandFactory.list(pageNo, 1001));
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
		
	}
	
	/* 책 리뷰 상세보기 */
	@RequestMapping(value="/detail/{brdNo}")
	public @ResponseBody BookReviewDto detail(
			@PathVariable("brdNo")String brdNo){
		bReview = service.detail(CommandFactory.detail("BRD_NO", brdNo, 1001));
		return bReview;
	}
	
	/* 책 리뷰 삭제 */
	@RequestMapping(value="/del/{brdNo}")
	public @ResponseBody BookReviewDto del(
			@PathVariable("brdNo")String brdNo){
		int ok = service.delete(bReview);
		return bReview;
	}
	
	/* 리뷰 작성 */
	@RequestMapping(value="/writeConfirm")
	public @ResponseBody BookReviewDto writeConfirm(
			@ModelAttribute BookReviewDto bReview){
		logger.info("리뷰 책시리얼넘버={}",bReview.getSerialNo());
		logger.info("리뷰 작성={}",bReview.getUserId());
		logger.info("리뷰 평점={}",bReview.getgPoint());
		logger.info("리뷰 리뷰제목={}",bReview.getBrdTitle());
		logger.info("리뷰 리뷰내용={}",bReview.getBrdContent());
		int insert = service.insert(bReview);
		if (insert == 1) {
			int seq = service.getBrdSeq();
			bReview.setBrdNo(seq);
			int insert2 = service.insert2(bReview);
			logger.info("두번째 인서트 성공 ={}",insert2);
		}
		return bReview;
	}
	
	/* 책 리뷰 상세정보 업데이트 */
	@RequestMapping(value="/update/{brdNo}")
	public @ResponseBody BookReviewDto update(
			@ModelAttribute BookReviewDto bReview,
			@PathVariable("brdNo")String brdNo){
		
		logger.info("업데이트  글넘버={}",brdNo);
		logger.info("업데이트 제목=[{}] 글내용=[{}]", bReview.getBrdTitle(), bReview.getBrdContent());
		int ok = service.update(bReview);
		
		if (ok == 1) {
			bReview = service.detail(CommandFactory.detail("BRD_NO", brdNo, 1001));
		}
		return bReview;
	}
	
	
	/* 검색어로 검색 */
	@RequestMapping(value="/search/{sel}/{word}/{pageNo}",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> search(
			@PathVariable("sel")String sel,
			@PathVariable("word")String word,
			@PathVariable("pageNo")String paramPage){
		logger.info("리뷰 통합검색 = {}",sel);
		Map<String,Object>map = new HashMap<String,Object>();
		List<BookReviewDto> list = new ArrayList<BookReviewDto>();
		int pageNo = Integer.parseInt(paramPage);
		logger.info("리뷰 검색 카테고리 페이지 = {}",pageNo);
		int size = service.keywordsize(CommandFactory.size(sel,word));
		list = service.search(CommandFactory.search(pageNo, sel, word));
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
	}
	
	/* 리뷰 작성 확인*/
	@RequestMapping(value="/write/{serialNo}/{userId}")
	public @ResponseBody Map<String,Object> write(
			@PathVariable("serialNo")String serialNo,
			@PathVariable("userId")String userId){
		Map<String,Object>map = new HashMap<String,Object>();
		int count = service.count(CommandFactory.count(serialNo, userId));
		bReview = service.detail2(CommandFactory.detail("book_serial_no", serialNo));
		map.put("count", count);
		map.put("bReview", bReview);
		return map;
	}
}
