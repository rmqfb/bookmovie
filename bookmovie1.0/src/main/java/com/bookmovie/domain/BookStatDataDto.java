package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("bookStatDataDto")
public class BookStatDataDto {

	private int statId;
	private String userId;
	private int rank;
	private String readCnt;
	private String statDate;
	private String bookBigCat;
	private String bookMediumCat;
	private String bookSmallCat;
	private int bookSerialNo;
	private int bookCntInCategory;
	private float bookAvgPoint;
	private String bookTitle;
	private int bookGradePoint;
	private String author;
	private String publisher;
	private String brdContent;
	private int numOfReviewParticipants;
	private String reviewMsgOfParticipant1;
	private String reviewMsgOfParticipant2;
	private String reviewMsgOfParticipant3;
	private String boardTitle;
	private String bookPressDay;
	private String bookImgAddr;
	
	
	public String getBookImgAddr() {
		return bookImgAddr;
	}
	public void setBookImgAddr(String bookImgAddr) {
		this.bookImgAddr = bookImgAddr;
	}
	public String getBookPressDay() {
		return bookPressDay;
	}
	public void setBookPressDay(String bookPressDay) {
		this.bookPressDay = bookPressDay;
	}
	public int getStatId() {
		return statId;
	}
	public void setStatId(int statId) {
		this.statId = statId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(String readCnt) {
		this.readCnt = readCnt;
	}
	public String getStatDate() {
		return statDate;
	}
	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}
	public String getBookBigCat() {
		return bookBigCat;
	}
	public void setBookBigCat(String bookBigCat) {
		this.bookBigCat = bookBigCat;
	}
	public String getBookMediumCat() {
		return bookMediumCat;
	}
	public void setBookMediumCat(String bookMediumCat) {
		this.bookMediumCat = bookMediumCat;
	}
	public String getBookSmallCat() {
		return bookSmallCat;
	}
	public void setBookSmallCat(String bookSmallCat) {
		this.bookSmallCat = bookSmallCat;
	}
	public int getBookSerialNo() {
		return bookSerialNo;
	}
	public void setBookSerialNo(int bookSerialNo) {
		this.bookSerialNo = bookSerialNo;
	}
	public int getBookCntInCategory() {
		return bookCntInCategory;
	}
	public void setBookCntInCategory(int bookCntInCategory) {
		this.bookCntInCategory = bookCntInCategory;
	}
	public float getBookAvgPoint() {
		return bookAvgPoint;
	}
	public void setBookAvgPoint(float bookAvgPoint) {
		this.bookAvgPoint = bookAvgPoint;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public int getBookGradePoint() {
		return bookGradePoint;
	}
	public void setBookGradePoint(int bookGradePoint) {
		this.bookGradePoint = bookGradePoint;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBrdContent() {
		return brdContent;
	}
	public void setBrdContent(String brdContent) {
		this.brdContent = brdContent;
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
}
