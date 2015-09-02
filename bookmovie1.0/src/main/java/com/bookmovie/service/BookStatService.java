package com.bookmovie.service;




import java.util.List;

import com.bookmovie.domain.BookStatDataDto;
import com.bookmovie.domain.BookStatMetaDto;
import com.bookmovie.factory.Command;


public interface BookStatService {

	
	/***************************************/
	/** executeUpdate **/
	/***************************************/
	/*
	 * 유저의 월별 독서량 통계를 생성합니다.
	 */
	int createUserBookReadCntStat(BookStatMetaDto dto);
	
	/*
	 * 모든 도서의 평균 평점의 대한 통계를 생성합니다.
	 */
	int createBookAvgGradeStat(BookStatMetaDto dto);
	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	/*
	 * 관리자 페이지에서 조작할 수 있는 통계 타입들을 가져옵니다.
	 */
	List<BookStatMetaDto> getStatTypes();
	
	/*
	 * 도서 번호를 입력하면 그 도서의 평균 평점을 반환해줍니다.
	 */
	float getAvgGradeBook(Command command);
	
	/*
	 * 유저가 평점을 준 책들의 도서 카테고리 리스트를 가져옵니다.
	 */
	List<BookStatDataDto> getUserFavoriteBookCategoriesStat(Command command);
	
	/*
	 * 유저의 월별 독서량을 가져옵니다.
	 */
	List<BookStatDataDto> getUserBookReadCntStatByUser(Command command);
	
	List<BookStatDataDto> getUserBookReadCntStatByAll();
	
	/*
	 * 해당 카테고리에서 유저가 높게 평점을 준 책들의 순위를 가져옵니다.
	 */
	List<BookStatDataDto> bookRankByCategory(Command command);
	
	/*
	 * 해당 카테고리에서 유저가 높게 평점을 준 책들의 순위를 가져옵니다. (리뷰 평 포함)
	 */
	List<BookStatDataDto> bookRankByCategoryAndContentsByUser(Command command);
	
	
	/*
	 * 해당 카테고리에서 유저가 평점을 준 책들의 권 수를 가져옵니다.
	 */
	int getTotalCntFromBookRankByCategoryByUser(Command command);

	List<BookStatDataDto> bestSellerList();

	List<BookStatDataDto> favoriteBooks(Command command);

	List<BookStatDataDto> recentBooksInFavoriteCategories(BookStatDataDto category);

	List<BookStatDataDto> getFavoriteTop3BookCategories(Command search);

	

	
}
