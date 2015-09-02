package com.bookmovie.service;
/*
@ Date : 2015.06
@ Author : ITB-1
@ Story : 회원관리 인터페이스
*/
import java.util.List;

import com.bookmovie.domain.TheaterDto;
import com.bookmovie.factory.Command;


public interface TheaterService {
	/*************************************
	 === executeUpdate ===
	  1. 삽입(insert) 
	 *************************************/
	public int insert(TheaterDto theater);
		
	/*************************************
	  2. 삭제(delete) 
	 *************************************/
	public int delete(TheaterDto theater);
	

	/*************************************
	 === executeQuery ===
	  1. 상세(detail) 
	 *************************************/
	public TheaterDto detail(Command command);
	
	/*************************************
	  2. 목록 (list)
	 *************************************/
	public List<TheaterDto> list(Command command);

   
}
