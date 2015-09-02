package com.bookmovie.service;


import java.util.List;

import com.bookmovie.domain.MovieStatDataDto;
import com.bookmovie.domain.MovieStatMetaDto;
import com.bookmovie.factory.Command;

public interface MovieStatService {

	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	/*
	 * 유저의 월별 독서량 통계를 생성합니다.
	 */
	int createUserMovieReadCntStat(MovieStatMetaDto dto);
	
	/*
	 * 모든 도서의 평균 평점의 대한 통계를 생성합니다.
	 */
	int createMovieAvgGradeStat(MovieStatMetaDto dto);
	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	
	/*
	 * 관리자 페이지에서 조작할 수 있는 통계 타입들을 가져옵니다.
	 */
	List<MovieStatMetaDto> getStatTypes();
	
	/*
	 * 영화 코드를 입력하면 그 영화의 평균 평점을 반환해줍니다.
	 */
	float getAvgGradeMovie(Command command);
	
	/*
	 * 유저가 평점을 준 책들의 도서 카테고리 리스트를 가져옵니다.
	 */
	List<MovieStatDataDto> getUserFavoriteMovieCategoriesStat(Command command);
	
	/*
	 * 유저의 월별 영화 상영 횟수를 가져옵니다.
	 */
	List<MovieStatDataDto> getUserMovieReadCntStatByUser(Command command);
	
	List<MovieStatDataDto> getUserMovieReadCntStatByAll();
	
	/*
	 * 해당 카테고리에서 유저가 높게 평점을 준 영화들의 순위를 가져옵니다.
	 */
	List<MovieStatDataDto> movieRankByCategory(Command command);
	
	/*
	 * 해당 카테고리에서 유저가 높게 평점을 준 영화들의 순위를 가져옵니다. (리뷰 평 포함)
	 */
	List<MovieStatDataDto> movieRankByCategoryAndContentsByUser(Command command);
	
	
	/*
	 * 해당 카테고리에서 유저가 평점을 준 영화들의 수를 가져옵니다.
	 */
	int getTotalCntFromMovieRankByCategory(Command command);

	List<MovieStatDataDto> popularMovieList();

	List<MovieStatDataDto> favoriteMovies(Command command);

	List<MovieStatDataDto> recentMoviesInFavoriteGenres(MovieStatDataDto genre);

	List<MovieStatDataDto> getFavoriteTop3MovieGenres(Command command);

	

	
	
	
}