package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.BoardDto;
import com.bookmovie.factory.Command;

public interface BoardService {
	/*
	 * executeUpdate
	 * */
	public int insert(BoardDto board); //보드 값 입력
	public int update(BoardDto board); //보드 값 업데이트
	public int delete(BoardDto board); //보드 값 삭제
	
	/*
	 * executeQuery
	 * */
	
	public BoardDto detail(Command command);    //보드 하나의 값만 불러들일때
	public List<BoardDto> search(Command command); // 보드 리스트 불러올때 
	public List<BoardDto> list(Command command);  // 보드 리스트 불러올떄쓰이는데 아직쓰이지는않다.
	public List<BoardDto> boardsearch(Command command);//보드 제목으로 검색, 장르검색
	public int size(Command command);
	public int keywordsize(Command command);
	public int count(Command commnad);
	

}
