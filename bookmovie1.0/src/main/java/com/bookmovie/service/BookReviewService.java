package com.bookmovie.service;

import java.util.List;


import com.bookmovie.domain.BookReviewDto;
import com.bookmovie.factory.Command;

public interface BookReviewService {
	/************************************
	  ==== executeUpdate ====
	  1. 삽입(insert)
	 ************************************/
	public int insert(BookReviewDto bReview);
	public int insert2(BookReviewDto bReview);
	public int insert3(BookReviewDto bReview);
	
	/************************************
	  2. 조회(update)
	 ************************************/
	public int update(BookReviewDto bReview);
	
	/************************************
	  3. 삭제(delete)
	 ************************************/
	public int delete(BookReviewDto bReview);
	
	/************************************
	  ==== executeQuery ====
	  4. 상세(detail)
	 ************************************/
	public BookReviewDto detail(Command command);	// 글 상세보기
	public BookReviewDto detail2(Command command);	// 글 정보 가져오기
	public BookReviewDto boardMeta(Command command);	// 보트메타 정보 가져오기
	public int getBrdSeq();
	
	/************************************
	  5. 조회(serch)
	 ************************************/
	public List<BookReviewDto> search(Command command); // 아이디 검색, 제목검색
	public List<BookReviewDto> searching(Command command); // 아이디 검색, 제목검색
	/************************************
	  6. 목록(list)
	 ************************************/
	public List<BookReviewDto> list(Command command);	// 글 목록

	/************************************
	  7. 사이즈(size)
	 ************************************/
	public int size(Command command);	
	public int keywordsize(Command command);	
	/************************************
	  8. 카운트(count)
	 ************************************/
	public int count(Command command);	
	
}
