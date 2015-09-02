package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("MovieReviewDto")
public class MovieReviewDto {
	private int brdNo; //게시글 등록번호
	 private String userId;   //회원id
	 private String category;  //게시글 카테고리
	 private String brdTitle;   // 게시글 제목
	 private String brdContent;  //게시글 본문내용
	 private String brdDate; //게시글 등록 날짜
	 private int brdViews;  //조회수
	 private int brdType; //게시판 종류
	 private int gPoint; //게시판 종류
	 private String name; //사용자 이름
		private String movieCode;	//영화코드
		private String filmRate;	//관람가능 나이 정보 
		private String regDate;		//개봉일
		private String title;		//제목
		private String genre;		//장르
		private String viewTime;	//런링타임
		private String poster;		//포스터
		private String background;	//배경
		private String iFrame;		//아이프레임 주소
		private String movieInfo;	//영화텍스트
		
		
		public int getBrdNo() {
			return brdNo;
		}
		public void setBrdNo(int brdNo) {
			this.brdNo = brdNo;
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
		public String getBrdTitle() {
			return brdTitle;
		}
		public void setBrdTitle(String brdTitle) {
			this.brdTitle = brdTitle;
		}
		public String getBrdContent() {
			return brdContent;
		}
		public void setBrdContent(String brdContent) {
			this.brdContent = brdContent;
		}
		public String getBrdDate() {
			return brdDate;
		}
		public void setBrdDate(String brdDate) {
			this.brdDate = brdDate;
		}
		
		public int getBrdViews() {
			return brdViews;
		}
		public void setBrdViews(int brdViews) {
			this.brdViews = brdViews;
		}
		public int getBrdType() {
			return brdType;
		}
		public void setBrdType(int brdType) {
			this.brdType = brdType;
		}
		public int getgPoint() {
			return gPoint;
		}
		public void setgPoint(int gPoint) {
			this.gPoint = gPoint;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getMovieCode() {
			return movieCode;
		}
		public void setMovieCode(String movieCode) {
			this.movieCode = movieCode;
		}
		public String getFilmRate() {
			return filmRate;
		}
		public void setFilmRate(String filmRate) {
			this.filmRate = filmRate;
		}
		public String getRegDate() {
			return regDate;
		}
		public void setRegDate(String regDate) {
			this.regDate = regDate;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getGenre() {
			return genre;
		}
		public void setGenre(String genre) {
			this.genre = genre;
		}
		public String getViewTime() {
			return viewTime;
		}
		public void setViewTime(String viewTime) {
			this.viewTime = viewTime;
		}
		public String getPoster() {
			return poster;
		}
		public void setPoster(String poster) {
			this.poster = poster;
		}
		public String getBackground() {
			return background;
		}
		public void setBackground(String background) {
			this.background = background;
		}
		public String getiFrame() {
			return iFrame;
		}
		public void setiFrame(String iFrame) {
			this.iFrame = iFrame;
		}
		public String getMovieInfo() {
			return movieInfo;
		}
		public void setMovieInfo(String movieInfo) {
			this.movieInfo = movieInfo;
		}
		
	
}
