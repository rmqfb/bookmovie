package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.MovieDto;
import com.bookmovie.factory.Command;


public interface MovieService {
	/*************************************
	 === executeUpdate ===
	  1. 삽입(insert) 
	 *************************************/
	/*************************************
	  2. 수정(update) 
	 *************************************/

	/*************************************
	 === executeQuery ===
	  1. 상세(detail) 
	 *************************************/
	public MovieDto detail(Command command);

	
	/*************************************
	  2. 조회 (search)
	 *************************************/
	public int searchSeq();
	
	/*************************************
	  3. 목록 (list)
	 *************************************/
	public List<MovieDto> list(Command command);

	
	/*************************************
	  4. 카운팅 (count)
	 *************************************/
	public int count(Command command);
	public int size(Command command);
	
}
