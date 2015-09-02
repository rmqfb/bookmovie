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
import com.bookmovie.domain.MovieStatDataDto;
import com.bookmovie.domain.MovieStatMetaDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.service.MovieStatService;

@Controller
@SessionAttributes("user")
@RequestMapping("/movie/stat")
public class MovieStatController {

	private static Logger logger = LoggerFactory.getLogger(MovieStatController.class);
	
	@Autowired private MovieStatService service;
	
	
	/***************************************/
	/** no execute **/
	/***************************************/
	
	/*
	 * 유저의 영화 관련 통계 페이지로 이동합니다.
	 */
	@RequestMapping(value="/mystat", method=RequestMethod.GET)
	public String mystat(@ModelAttribute("user") MemberDto user,
			Model model){
		logger.info("[컨트롤러] mystat() - 로그인한 유저의 영화 관련 통계 페이지 보기");
         model.addAttribute("member", user);
		return "movieStat/myStat.tiles";
	}
	
	/*
	 * 영화 관련 관리자 페이지로 이동합니다.
	 */
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String admin(){
		logger.info("[컨트롤러] admin() - 영화 관련 통계 페이지 보기");
		return "movieStat/admin.tiles";
	}
	
	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	/*
	 * 관리자 페이지에서 각종 통계를 생성하는 업무를 맡습니다. 
	 */
	@RequestMapping(value="/admin/create/user-stat", method=RequestMethod.POST)
	public @ResponseBody int createUserStat(@ModelAttribute MovieStatMetaDto dto){
		logger.info("[컨트롤러] createUserStat() - 영화 관련 통계 생성 - 통계 타입[{}]", dto.getStatTypeCode());
		int result = -1;
		
		switch(dto.getStatTypeCode()){
			case 3:
				result = service.createUserMovieReadCntStat(dto);
				break;
			case 4:
				result = service.createMovieAvgGradeStat(dto);
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
	public @ResponseBody List<MovieStatMetaDto> getStatTypes(){
		logger.info("[컨트롤러] getStatTypes() - 영화 관련 통계 타입 리스트");
		return service.getStatTypes();
	}
	 
	/*
	 * 관리자 페이지에서 한 유저의 통계 데이터를 가져옵니다.
	 */
	@RequestMapping(value="/admin/user-stat/{userId}", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getUserStatAdmin(@PathVariable("userId") String userId){
		logger.info("[컨트롤러] getUserStatAdmin() - 관리자 페이지에서 유저의 영화 통계 가져오기 - 유저 아이디 {}", userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MovieStatDataDto> favoriteCategoryList = service.getUserFavoriteMovieCategoriesStat(CommandFactory.search(1, null, userId));
		
		List<MovieStatDataDto> movieReadCntByMonth = service.getUserMovieReadCntStatByUser(CommandFactory.search(null, userId));
		
		map.put("favoriteCategoryList", favoriteCategoryList);
		map.put("movieReadCntByMonth", movieReadCntByMonth);
		
		return map;
	}
	
	/*
	 * 관리자 페이지에서 영화 장르 중 한 유저가 높게 평점을 준 영화들 순위를 가져옵니다.
	 */
	@RequestMapping(value="/admin/movie-rank-by-category/{userId}/{genre}", method=RequestMethod.GET)
	public @ResponseBody List<MovieStatDataDto> movieRankByCategory(@PathVariable("userId") String userId, @PathVariable("genre") String genre){
		logger.info("[컨트롤러] moviesByCategory() - 유저의 특정 영화 분류에서 평점순위의 영화 목록 가져오기 - 유저 아이디 {}, 영화 장르 {}", userId, genre);
		return service.movieRankByCategory(CommandFactory.search(1, null, userId, null, genre));
	}
	
	/*
	 * 관리자 페이지에서 한 유저가 평점을 준 영화들의 장르를 가져옵니다.  
	 */
	@RequestMapping(value="/favorite-movie-categories/{pageNo}", method=RequestMethod.GET)
	public @ResponseBody List<MovieStatDataDto> getFavoriteMovieCategories(@ModelAttribute("user") MemberDto member, @PathVariable("pageNo") String pageNoParam){
		
		int pageNo = 1;
		try{
			pageNo = Integer.parseInt(pageNoParam);
		}catch(Exception e){
			pageNo = 1;
		}
		
		logger.info("[컨트롤러] getUserStat() - 유저의 인기 영화 소분류 가져오기 - 유저 아이디 {}, 페이지 번호 {}", member, pageNoParam);
		
		return service.getUserFavoriteMovieCategoriesStat(CommandFactory.search(pageNo, null, member.getUserId()));
	}
	
	/*
	 * 유저의 월별 영화 상영 횟수를 가져옵니다. 
	 */
	@RequestMapping(value="/movie-view-count", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> getMovieViewCount(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] getUserStat() - 유저의 월간 독서량 가져오기 - 유저 아이디 {}", member.getUserId());
		List<MovieStatDataDto> listByUser = service.getUserMovieReadCntStatByUser(CommandFactory.search(null, member.getUserId()));
		List<MovieStatDataDto> listByAll = service.getUserMovieReadCntStatByAll();
		
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("listByUser", listByUser);
		map.put("listByAll", listByAll);
		
		return map;
	}
	
	/*
	 * 한 영화 분류에서 한 유저가 평점을 높게 준 영화 목록 순위를 가져옵니다.
	 */
	@RequestMapping(value="/movie-rank-by-category/{genre}/{pageNo}", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> movieRankByCategory(@ModelAttribute("user") MemberDto member, @PathVariable("genre") String genre, @PathVariable("pageNo") String pageNoParam){

		int pageNo = 1;
		try{
			pageNo = Integer.parseInt(pageNoParam);
		}catch(Exception e){
			pageNo = 1;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.info("[컨트롤러] movieRankByCategory() - 유저의 특정 영화 분류에서 평점 순위의 영화 목록 가져오기(리뷰 텍스트 포함) - 영화 장르 {}, 페이지 번호 {}", genre, pageNo);
		List<MovieStatDataDto> listByUser = service.movieRankByCategoryAndContentsByUser(CommandFactory.search(pageNo, null, member.getUserId(), null, genre));
		
		int totalCount = service.getTotalCntFromMovieRankByCategory(CommandFactory.search(null, member.getUserId(), null, genre));
		
		map.put("movieRankByCategoryListByUser", listByUser);
		map.put("size", totalCount);
		map.put("currentPage", pageNo);
		
		return map;
	}
	
	@RequestMapping("/popular-movie-list")
	public @ResponseBody List<MovieStatDataDto> popularMovieList(){
		logger.info("[컨트롤러] 모든 회원들이 좋아하는 영화 목록 가져오기 (평균 평점이 높은 영화 5위까지 리스트로 추출하기)");
		return service.popularMovieList();
	}
	
	@RequestMapping(value="/favorite-movies", method=RequestMethod.GET)
	public @ResponseBody List<MovieStatDataDto> favoriteMovies(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] 사용자가 좋아하는 영화 목록 가져오기");
		return service.favoriteMovies(CommandFactory.search(null, member.getUserId()));
	}
	
	@RequestMapping(value="/new-movies-in-favorite-genres", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> newMoviesInFavoriteGenres(@ModelAttribute("user") MemberDto member){
		logger.info("[컨트롤러] 사용자가 좋아하는 영화 장르 3개에서 각각 3개 씩의 새로운 영화 목록 가져오기");
		
		List<MovieStatDataDto> genres = service.getFavoriteTop3MovieGenres(CommandFactory.search(null, member.getUserId()));
		List<MovieStatDataDto> movieList = new ArrayList<MovieStatDataDto>();
		
		for(MovieStatDataDto genre : genres){
			List<MovieStatDataDto> movieListByGenre = service.recentMoviesInFavoriteGenres(genre);
			movieList.addAll(movieListByGenre);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("genres", genres);
		map.put("movieList", movieList);
		
		return map;
	}
}
