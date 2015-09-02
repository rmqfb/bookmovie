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

import com.bookmovie.domain.BookStatDataDto;
import com.bookmovie.domain.BookStatMetaDto;
import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.BookStatService;

@Controller
@SessionAttributes("user")
@RequestMapping("/book/stat")
public class BookStatController {
	
	private static Logger logger = LoggerFactory.getLogger(BookStatController.class);

	@Autowired private BookStatService service;
	
	/***************************************/
	/** no execute **/
	/***************************************/
	
	/*
	 * 유저의 도서 관련 통계 페이지로 이동합니다.
	 */
	@RequestMapping(value="/mystat", method=RequestMethod.GET)
	public String mystat(@ModelAttribute("user") MemberDto user,
			Model model){
		logger.info("[컨트롤러] mystat() - 로그인한 유저의 도서 관련 통계 페이지 보기");
		model.addAttribute("member", user);
		return "bookStat/myStat.tiles";
	}
	
	/*
	 * 도서 관련 관리자 페이지로 이동합니다.
	 */
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String admin(){
		logger.info("[컨트롤러] admin() - 도서 관련 통계 페이지 보기");
		return "bookStat/admin.tiles";
	}
	
	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	/*
	 * 관리자 페이지에서 각종 통계를 생성하는 업무를 맡습니다. 
	 */
	@RequestMapping(value="/admin/create/user-stat", method=RequestMethod.POST)
	public @ResponseBody int createUserStat(@ModelAttribute BookStatMetaDto dto){
		// 리턴타입 1 : 통계 생성 성공 / 리턴타입 -1 : 통계  생성 메소드를 타지 아니하거나 익셉션 발생 / 리턴타입 0 : 추출된 통계 데이터가 없음 
		
		logger.info("[컨트롤러] createUserStat() - 도서 관련 통계 생성 - 통계 타입[{}]", dto.getStatTypeCode());
		int result = -1;
		
		switch(dto.getStatTypeCode()){
			case 1:
				result = service.createUserBookReadCntStat(dto);
				break;
			case 2:
				result = service.createBookAvgGradeStat(dto);
				break;
		}
		
		return result;
	}
	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	
	/*
	 * 관리자 페이지에서 조작할 수 있는 통계타입 리스트를 가져옵니다. 
	 */
	@RequestMapping(value="/admin/get-stat-types", method=RequestMethod.GET)
	public @ResponseBody List<BookStatMetaDto> getStatTypes(){
		logger.info("[컨트롤러] getStatTypes() - 도서 관련 통계 타입 리스트");
		return service.getStatTypes();
	}
	
	/*
	 * 관리자 페이지에서 한 유저의 통계 데이터를 가져옵니다.
	 */
	@RequestMapping(value="/admin/user-stat/{userId}", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getUserStatAdmin(@PathVariable("userId") String userId){
		logger.info("[컨트롤러] getUserStatAdmin() - 관리자 페이지에서 유저의 도서 통계 가져오기 - 유저 아이디 {}", userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<BookStatDataDto> favoriteCategoryList = service.getUserFavoriteBookCategoriesStat(CommandFactory.search(1, null, userId));
		
		List<BookStatDataDto> bookReadCntByMonth = service.getUserBookReadCntStatByUser(CommandFactory.search(null, userId));
		
		map.put("favoriteCategoryList", favoriteCategoryList);
		map.put("bookReadCntByMonth", bookReadCntByMonth);
		
		return map;
	}
	
	/*
	 * 관리자 페이지의 한 도서 분류에서 한 유저가 즐겨찾는 도서 목록 순위를 가져옵니다.
	 */
	@RequestMapping(value="/admin/book-rank-by-category/{userId}/{bookSmallCat}", method=RequestMethod.GET)
	public @ResponseBody List<BookStatDataDto> bookRankByCategory(@PathVariable("userId") String userId, @PathVariable("bookSmallCat") String bookSmallCat){
		logger.info("[컨트롤러] booksByCategory() - 유저의 특정 도서 분류에서 평점순위의 도서 목록 가져오기 - 유저 아이디 {}, 도서분류코드 {}", userId, bookSmallCat);
		return service.bookRankByCategory(CommandFactory.search(1, null, userId, null, bookSmallCat));
	}
	
	/*
	 * 관리자 페이지에서 한 유저가 평점을 준 도서들의 도서 분류를 가져옵니다.  
	 */
	@RequestMapping(value="/favorite-book-categories/{pageNo}", method=RequestMethod.GET)
	public @ResponseBody List<BookStatDataDto> getFavoriteBookCategories(@ModelAttribute("user") MemberDto member, @PathVariable("pageNo") String pageNoParam){
		
		int pageNo = 1;
		try{
			pageNo = Integer.parseInt(pageNoParam);
		}catch(Exception e){
			pageNo = 1;
		}
		
		logger.info("[컨트롤러] getUserStat() - 유저의 인기 도서 소분류 가져오기 - 유저 아이디 {}, 페이지 번호 {}", member, pageNoParam);
		
		return service.getUserFavoriteBookCategoriesStat(CommandFactory.search(pageNo, null, member.getUserId()));
	}
	
	/*
	 * 유저의 월별 독서량을 가져옵니다. 
	 */
	@RequestMapping(value="/book-read-count", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getBookReadCount(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] getUserStat() - 유저의 월간 독서량 가져오기 - 유저 아이디 {}", member.getUserId());
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<BookStatDataDto> listByUser = service.getUserBookReadCntStatByUser(CommandFactory.search(null, member.getUserId()));
		List<BookStatDataDto> listByAll = service.getUserBookReadCntStatByAll();
		
		map.put("listByUser", listByUser);
		map.put("listByAll", listByAll);
		
		return map;
	}
	
	/*
	 * 한 도서 분류에서 한 유저가 평점을 높게 준 책 목록 순위를 가져옵니다.
	 */
	@RequestMapping(value="/book-rank-by-category/{bookSmallCat}/{pageNo}", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> bookRankByCategory(@ModelAttribute("user") MemberDto member, @PathVariable("bookSmallCat") String bookSmallCat, @PathVariable("pageNo") String pageNoParam){

		int pageNo = 1;
		try{
			pageNo = Integer.parseInt(pageNoParam);
		}catch(Exception e){
			pageNo = 1;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.info("[컨트롤러] booksByCategory() - 유저의 특정 도서 분류에서 평점 순위의 도서 목록 가져오기(리뷰 텍스트 포함) - 도서분류코드 {}, 페이지 번호 {}", bookSmallCat, pageNo);
		List<BookStatDataDto> listByUser = service.bookRankByCategoryAndContentsByUser(CommandFactory.search(pageNo, null, member.getUserId(), null, bookSmallCat));
		
		int totalCount = service.getTotalCntFromBookRankByCategoryByUser(CommandFactory.search(null, member.getUserId(), null, bookSmallCat));
		
		map.put("bookRankByCategoryListByUser", listByUser);
		map.put("size", totalCount);
		map.put("currentPage", pageNo);
		
		return map;
	}
	
	@RequestMapping(value="/best-seller-list", method=RequestMethod.GET)
	public @ResponseBody List<BookStatDataDto> bestSellerList(){
		logger.info("[컨트롤러] 베스트 셀러 목록 가져오기 (평균 평점이 높은 도서 5위까지 리스트로 추출하기)");
		return service.bestSellerList();
	}
	
	@RequestMapping(value="/favorite-books", method=RequestMethod.GET)
	public @ResponseBody List<BookStatDataDto> favoriteBooks(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] 사용자가 좋아하는 책 목록 가져오기");
		return service.favoriteBooks(CommandFactory.search(null, member.getUserId()));
	}
	
	@RequestMapping(value="/new-books-in-favorite-categories", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> newBooksInFavoriteCategories(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] 사용자가 좋아하는 도서 카테고리 3개에서 각각 3개 씩의 새로운 책 목록 가져오기");
		
		List<BookStatDataDto> categories = service.getFavoriteTop3BookCategories(CommandFactory.search(null, member.getUserId()));
		
		List<BookStatDataDto> bookList = new ArrayList<BookStatDataDto>();
		
		for(BookStatDataDto category : categories){
			List<BookStatDataDto> bookListByCat = service.recentBooksInFavoriteCategories(category);
			bookList.addAll(bookListByCat);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("categories", categories);
		map.put("bookList", bookList);
		
		return map;
	}
}
