package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.BookStatDataDto;
import com.bookmovie.domain.BookStatMetaDto;
import com.bookmovie.factory.Command;



public interface BookStatMapper {

	
	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	/*
	 * 기본적인 통계 데이터를 등록합니다. (통계 생성날짜, 시퀀스, 통계 타입 등...)
	 */
	Integer registerBookStat(BookStatMetaDto dto);
	
	/*
	 * 추출된 월별 독서량 통계 데이터를 저장합니다.
	 */
	Integer addBookReadCntStatById(BookStatDataDto dto);
	
	Integer addBookReadCntStatByAll(BookStatDataDto item);
	
	/*
	 * 추출된 각 도서의 평균 평점을 저장합니다.
	 */
	Integer addBookAvgGradeStat(BookStatDataDto item);
	
	/*
	 * 기본적인 통계 정보가 들어간 데이터를 삭제합니다.
	 */
	Integer unregisterBookStat(Integer i);
	
	/*
	 * 월별 독서량 통계 데이터를 제거합니다.
	 */
	Integer removeBookReadCntStat(Integer i);
	
	/*
	 * 도서의 평균 평점 통계 데이터를 제거합니다.
	 */
	Integer removeBookAvgGradeStat(Integer i);
	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	
	/*
	 * 통계 파트 DB의 새로운 시퀀스 번호를 가져옵니다.
	 */
	Integer getNewSequence();
	
	/*
	 * 관리자 페이지에서 조작할 수 있는 통계 타입들을 가져옵니다.
	 */
	List<BookStatMetaDto> getStatTypes();
	
	/*
	 * 월별 독서량 통계 데이터를 추출합니다.
	 */
	List<BookStatDataDto> extractBookReadCntStatById();
	
	List<BookStatDataDto> extractBookReadCntStatByAll();
	
	/*
	 * 각 도서의 평균 평점 통계 데이터를 추출합니다.
	 */
	List<BookStatDataDto> extractBookAvgGradeStat();
	
	/*
	 * 주어진 도서번호의 해당하는 평균 평점을 반환합니다.
	 */
	Float getAvgGradeBook(Command command);
	
	/*
	 * 유저가 평점을 높게 준 도서들의 정보를 가져옵니다.
	 */
	List<BookStatDataDto> getUserFavoriteBookCategoriesStat(Command command);
	
	/*
	 * 유저의 월별 독서량 통계를 가져옵니다.
	 */
	List<BookStatDataDto> getUserBookReadCntStatByUser(Command command);
	
	List<BookStatDataDto> getUserBookReadCntStatByAll();
	
	/*
	 * 해당 도서 카테고리 내에서 유저가 평점을 높게 준 책 정보 순위를 가져옵니다.
	 */
	List<BookStatDataDto> bookRankByCategory(Command command);
	
	/*
	 * 해당 도서 카테고리 내에서 유저가 평점을 높게 준 책 정보 순위를 가져옵니다. (리뷰 메시지 포함)
	 */
	List<BookStatDataDto> bookRankByCategoryAndContentsByUser(Command command);
	
	
	Integer getLastStatId(BookStatMetaDto dto);
	
	Integer getLastWeekStatId(BookStatMetaDto dto);
	
	/*
	 * 도서 카테고리 내에서 유저가 리뷰를 남긴 모든 책의 권 수를 반환합니다.
	 */
	Integer getTotalCntFromBookRankByCategoryByUser(Command command);

	Integer getTotalCntFromBookRankByCategoryByAll(Command command);

	List<BookStatDataDto> bestSellerList();

	List<BookStatDataDto> getTop3BoardTitlesOfTheBook(Integer bookSerialNo);

	List<BookStatDataDto> favoriteBooks(Command command);

	List<BookStatDataDto> getFavoriteTop3BookCategories(Command command);

	List<BookStatDataDto> recentBooksInFavoriteCategories(BookStatDataDto category);

	

	

	

	

	
	
	
	
	
	
	
	
	

	
	

	

	
	
}
