package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.BookDto;
import com.bookmovie.factory.Command;

public interface BookService {
	/************************************
	  ==== executeUpdate ====
	  1. 삽입(insert)
	 ************************************/
	public int insert(BookDto book);
	
	/************************************
	  2. 조회(update)
	 ************************************/
	public int update(BookDto book);
	
	/************************************
	  3. 삭제(delete)
	 ************************************/
	public int delete(BookDto book);
	
	/************************************
	  ==== executeQuery ====
	  4. 상세(detail)
	 ************************************/
	public BookDto detail(Command command);	// 글 상세보기
	
	
	/************************************
	  5. 조회(serch)
	 ************************************/
	public List<BookDto> search(Command command); // 아이디 검색, 제목검색
	public List<BookDto> searching(Command command); // 아이디 검색, 제목검색
	/************************************
	  6. 목록(list)
	 ************************************/
	public List<BookDto> list(Command command);	// 글 목록
	public List<BookDto> smallCat(Command command);	// 대분류
	public List<BookDto> mediumCat(Command command);	// 중분류
	public List<BookDto> bigCat();	// 소분류
	
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
