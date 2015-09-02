package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("MovieDto")
public class MovieDto  {
	private String movieCode;	//영화코드
	private String filmRate;	//관람가능 나이 정보 
	private String regDate;		//개봉일
	private String title;		//제목
	private String genre;		//장르
	private String viewTime;	//런링타임
	private String poster;		//포스터
	private String background;	//배경
	private String iFrame;		//아이프레임 주소
	private String movieInfo;	//영화 택스트
	private String pageNo;
	
	
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
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
