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
import com.bookmovie.domain.MovieReviewDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.MovieReviewService;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/m-review")
public class MovieReviewController {
	private static final Logger logger = LoggerFactory.getLogger(MovieReviewController.class);
	
	@Autowired MovieReviewService service;
	@Autowired MovieReviewDto mReview;
	@RequestMapping(value="/main")
	public String main(@ModelAttribute("user")MemberDto user, Model model){
		logger.info("영화 리뷰 메인페이지");
		model.addAttribute("member", user);
			return "movieReview/movieReviewMain.tiles";
	}
	

	/* 영화 리뷰에 관한 컨트롤러 */
	@RequestMapping(value="/list/{pageNo}")
	public @ResponseBody Map<String,Object> reviewList(MovieReviewDto mReview,
			@PathVariable("pageNo")String paramPage){
		Map<String,Object>map = new HashMap<String,Object>();
		List<MovieReviewDto> list = new ArrayList<MovieReviewDto>();
		int size = service.size(CommandFactory.size(1001));
		int pageNo = Integer.parseInt(paramPage);
		list = service.list(CommandFactory.list(pageNo, 1002));
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
		
	}

	/* 검색어로 검색 */
	@RequestMapping(value="/search/{sel}/{word}/{pageNo}",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> search(
			@PathVariable("sel")String sel,
			@PathVariable("word")String word,
			@PathVariable("pageNo")String paramPage){
		logger.info("리뷰 통합검색 = {}",sel);
		Map<String,Object>map = new HashMap<String,Object>();
		List<MovieReviewDto> list = new ArrayList<MovieReviewDto>();
		int pageNo = Integer.parseInt(paramPage);
		logger.info("리뷰 검색 카테고리 페이지 = {}",pageNo);
		int size = service.keywordsize(CommandFactory.size(sel,word));
		list = service.search(CommandFactory.search(pageNo, sel, word));
		map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
		return map;
	}
	
	/* 영화 리뷰 상세보기 */
	@RequestMapping(value="/detail/{brdNo}")
	public @ResponseBody MovieReviewDto detail(
			@PathVariable("brdNo")String brdNo){
		mReview = service.detail(CommandFactory.detail("BRD_NO", brdNo, 1002));
		return mReview;
	}
	
	/* 영화 리뷰 삭제 */
	@RequestMapping(value="/del/{brdNo}")
	public @ResponseBody MovieReviewDto del(
			@PathVariable("brdNo")String brdNo){
		int ok = service.delete(mReview);
		return mReview;
	}
	
	/* 영화 리뷰 상세정보 업데이트 */
	@RequestMapping(value="/update/{brdNo}")
	public @ResponseBody MovieReviewDto update(
			@ModelAttribute MovieReviewDto mReview,
			@PathVariable("brdNo")String brdNo){
		
		logger.info("업데이트  글넘버={}",brdNo);
		logger.info("업데이트 제목=[{}] 글내용=[{}]", mReview.getBrdTitle(), mReview.getBrdContent());
		int ok = service.update(mReview);
		
		if (ok == 1) {
			mReview = service.detail(CommandFactory.detail("BRD_NO", brdNo, 1002));
		}
		return mReview;
	}
	
	//리뷰 입력
	@RequestMapping(value="/writeConfirm",method=RequestMethod.GET)
	public @ResponseBody MovieReviewDto result(@ModelAttribute MovieReviewDto mReview){
	
		logger.info("[컨트롤러] 결과 페이지 아이디={}",mReview.getUserId());
		logger.info("[컨트롤러] 결과 페이지 타입={}",mReview.getBrdType() );
		logger.info("[컨트롤러] 결과 페이지 장르={}",mReview.getGenre() );
		logger.info("[컨트롤러] 결과 페이지 게시판 제목={}",mReview.getBrdTitle() );
		logger.info("[컨트롤러] 결과 페이지 게시판 내용={}",mReview.getBrdContent() );
		logger.info("[컨트롤러] 결과 페이지 게시판 날자={}",mReview.getBrdDate() );
		logger.info("[컨트롤러] 결과 페이지 게시판No={}",mReview.getGenre() );
		logger.info("[컨트롤러] 결과 페이지 영화코드={}",mReview.getMovieCode() );
		
		int result = service.insert(mReview);
		int seq = service.getBrdSeq();
		mReview.setBrdNo(seq);
		
		int result2 = service.insert2(mReview);
		logger.info("[컨트롤러] 결과={}", result);
		logger.info("[컨트롤러] 결과2={}", result2);
		
		return mReview;
	}
	
	/* 리뷰 작성 확인*/
	@RequestMapping(value="/write/{movieCode}/{userId}")
	public @ResponseBody Map<String,Object> write(
			@PathVariable("movieCode")String movieCode,
			@PathVariable("userId")String userId){
		Map<String,Object>map = new HashMap<String,Object>();
		int count = service.count(CommandFactory.count(movieCode, userId));
		mReview = service.detail2(CommandFactory.detail("movie_code", movieCode));
		map.put("count", count);
		map.put("mReview", mReview);
		return map;
	}
}
