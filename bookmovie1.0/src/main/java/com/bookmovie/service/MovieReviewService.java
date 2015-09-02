package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.MovieReviewDto;
import com.bookmovie.factory.Command;

public interface MovieReviewService {
	/************************************
	  ==== executeUpdate ====
	  1. 삽입(insert)
	 ************************************/
	public int insert(MovieReviewDto mReview);
	public int insert2(MovieReviewDto mReview);
	public int insert3(MovieReviewDto mReview);
	
	/************************************
	  2. 조회(update)
	 ************************************/
	public int update(MovieReviewDto mReview);
	
	/************************************
	  3. 삭제(delete)
	 ************************************/
	public int delete(MovieReviewDto mReview);
	
	/************************************
	  ==== executeQuery ====
	  4. 상세(detail)
	 ************************************/
	public MovieReviewDto detail(Command command);	// 글 상세보기
	public MovieReviewDto detail2(Command command);	// 글 정보 가져오기
	public MovieReviewDto boardMeta(Command command);	// 보트메타 정보 가져오기
	public int getBrdSeq();
	
	/************************************
	  5. 조회(serch)
	 ************************************/
	public List<MovieReviewDto> search(Command command); // 아이디 검색, 제목검색
	public List<MovieReviewDto> searching(Command command); // 아이디 검색, 제목검색
	/************************************
	  6. 목록(list)
	 ************************************/
	public List<MovieReviewDto> list(Command command);	// 글 목록

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
