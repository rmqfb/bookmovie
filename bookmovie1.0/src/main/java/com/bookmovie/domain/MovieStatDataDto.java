package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("movieStatData")
public class MovieStatDataDto {

	private int statId;
	private String userId;
	private int viewCnt;
	private String statDate;
	private String movieCode;
	private String movieTitle;
	private int movieGradePoint;
	private float movieAvgPoint;
	private String brdContent;
	private int rank;
	private String movieGenre;
	private String movieViewTime;
	private int numOfReviewParticipants;
	private String reviewMsgOfParticipant1;
	private String reviewMsgOfParticipant2;
	private String reviewMsgOfParticipant3;
	private String boardTitle;
	private String moviePoster;
	
	
	

	public String getMoviePoster() {
		return moviePoster;
	}

	public void setMoviePoster(String moviePoster) {
		this.moviePoster = moviePoster;
	}

	public String getMovieGenre() {
		return movieGenre;
	}

	public void setMovieGenre(String movieGenre) {
		this.movieGenre = movieGenre;
	}

	public String getMovieViewTime() {
		return movieViewTime;
	}

	public void setMovieViewTime(String movieViewTime) {
		this.movieViewTime = movieViewTime;
	}

	public int getNumOfReviewParticipants() {
		return numOfReviewParticipants;
	}

	public void setNumOfReviewParticipants(int numOfReviewParticipants) {
		this.numOfReviewParticipants = numOfReviewParticipants;
	}

	public String getReviewMsgOfParticipant1() {
		return reviewMsgOfParticipant1;
	}

	public void setReviewMsgOfParticipant1(String reviewMsgOfParticipant1) {
		this.reviewMsgOfParticipant1 = reviewMsgOfParticipant1;
	}

	public String getReviewMsgOfParticipant2() {
		return reviewMsgOfParticipant2;
	}

	public void setReviewMsgOfParticipant2(String reviewMsgOfParticipant2) {
		this.reviewMsgOfParticipant2 = reviewMsgOfParticipant2;
	}

	public String getReviewMsgOfParticipant3() {
		return reviewMsgOfParticipant3;
	}

	public void setReviewMsgOfParticipant3(String reviewMsgOfParticipant3) {
		this.reviewMsgOfParticipant3 = reviewMsgOfParticipant3;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public String getStatDate() {
		return statDate;
	}

	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}

	public String getMovieCode() {
		return movieCode;
	}

	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}

	public String getMovieTitle() {
		return movieTitle;
	}

	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}

	public int getMovieGradePoint() {
		return movieGradePoint;
	}

	public void setMovieGradePoint(int movieGradePoint) {
		this.movieGradePoint = movieGradePoint;
	}

	public float getMovieAvgPoint() {
		return movieAvgPoint;
	}

	public void setMovieAvgPoint(float movieAvgPoint) {
		this.movieAvgPoint = movieAvgPoint;
	}

	public String getBrdContent() {
		return brdContent;
	}

	public void setBrdContent(String brdContent) {
		this.brdContent = brdContent;
	}

	public int getStatId() {
		return statId;
	}

	public void setStatId(int statId) {
		this.statId = statId;
	}
	
	
	
}
