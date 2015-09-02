package com.bookmovie.mapper;


import java.util.List;

import com.bookmovie.domain.MovieStatDataDto;
import com.bookmovie.domain.MovieStatMetaDto;
import com.bookmovie.factory.Command;

public interface MovieStatMapper {



	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	/*
	 * 기본적인 통계 데이터를 등록합니다. (통계 생성날짜, 시퀀스, 통계 타입 등...)
	 */
	int registerMovieStat(MovieStatMetaDto dto);
	
	/*
	 * 추출된 월별 영화 상영 횟수 통계 데이터를 저장합니다.
	 */
	int addMovieReadCntStatByUser(MovieStatDataDto dto);
	
	int addMovieReadCntStatByAll(MovieStatDataDto item);
	
	/*
	 * 추출된 각 영화의 평균 평점을 저장합니다.
	 */
	int addMovieAvgGradeStat(MovieStatDataDto item);
	
	/*
	 * 기본적인 통계 정보가 들어간 데이터를 삭제합니다.
	 */
	int unregisterMovieStat(int i);
	
	/*
	 * 월별 영화 상영 횟수 통계 데이터를 제거합니다.
	 */
	int removeMovieReadCntStat(int i);
	
	/*
	 * 영화의 평균 평점 통계 데이터를 제거합니다.
	 */
	int removeMovieAvgGradeStat(Integer i);
	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	
	/*
	 * 통계 파트 DB의 새로운 시퀀스 번호를 가져옵니다.
	 */
	int getNewSequence();
	
	/*
	 * 관리자 페이지에서 조작할 수 있는 통계 타입들을 가져옵니다.
	 */
	List<MovieStatMetaDto> getStatTypes();
	
	/*
	 * 월별 영화 상영 횟수 통계 데이터를 추출합니다.
	 */
	List<MovieStatDataDto> extractMovieReadCntStatByUser();
	
	List<MovieStatDataDto> extractMovieReadCntStatByAll();
	
	/*
	 * 각 영화의 평균 평점 통계 데이터를 추출합니다.
	 */
	List<MovieStatDataDto> extractMovieAvgGradeStat();
	
	/*
	 * 주어진 영화코드의 해당하는 평균 평점을 반환합니다.
	 */
	float getAvgGradeMovie(Command command);
	
	/*
	 * 유저가 평점을 높게 준 영화들의 정보를 가져옵니다.
	 */
	List<MovieStatDataDto> getUserFavoriteMovieCategoriesStat(Command command);
	
	/*
	 * 유저의 월별 영화 상영 횟수 통계를 가져옵니다.
	 */
	List<MovieStatDataDto> getUserMovieReadCntStatByUser(Command command);
	
	List<MovieStatDataDto> getUserMovieReadCntStatByAll();
	
	/*
	 * 월별 영화 상영 횟수 통계의 통계 식별 번호를 가져옵니다.
	 */
	List<Integer> getMovieReadCntStatIds();
	
	/*
	 * 영화 평균 평점 통계의 통계 식별 번호를 가져옵니다.
	 */
	List<Integer> getMovieAvgGradeStatIds();
	
	/*
	 * 영화 장르 내에서 유저가 리뷰를 남긴 모든 영화 수를 반환합니다.
	 */
	int getTotalCntFromMovieRankByCategory(Command command);
	List<MovieStatDataDto> movieRankByCategory(Command command);
	List<MovieStatDataDto> movieRankByCategoryAndContentsByUser(Command command);
	List<MovieStatDataDto> popularMovieList();
	List<MovieStatDataDto> getTop3BoardTitlesOfTheMovie(String movieCode);

	List<MovieStatDataDto> favoriteMovies(Command command);
	List<MovieStatDataDto> getFavoriteTop3MovieGenres(Command command);
	List<MovieStatDataDto> getRecentMoviesInGenre(MovieStatDataDto genre);


	

	

	
	
	
}
