package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("BoardDto")
public class BoardDto {
	
	private int boardNum; //게시글 등록번호
	private String userId;   //회원id
	private String category;  //게시글 카테고리
	private String title;   // 게시글 제목
	private String boardContent;  //게시글 본문내용
	private String boardDate; //게시글 등록 날짜
	private int readcnt;		//조회수
	private int theme;	//게시판 종류
	private String name; //사용자 이름
	private String moviecode; //외래키 무비코드
	
	
	
	public int getTheme() {
		return theme;
	}
	public void setTheme(int theme) {
		this.theme = theme;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMoviecode() {
		return moviecode;
	}
	public void setMoviecode(String moviecode) {
		this.moviecode = moviecode;
	}
	
	

}
