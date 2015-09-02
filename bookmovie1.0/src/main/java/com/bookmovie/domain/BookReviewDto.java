package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("bookReviewDto")
public class BookReviewDto {
	private int brdNo;
	private String userId;
	private String serialNo;
	private String bookCat;
	private String gradeSeq;
	private String bTitle;
	private String imgAddr;
	private String brdType;
	private String brdTitle;
	private String brdContent;
	private String brdDate;
	private int brdViews;
	private int gPoint;
	
	
	public int getgPoint() {
		return gPoint;
	}
	public void setgPoint(int gPoint) {
		this.gPoint = gPoint;
	}
	public String getBookCat() {
		return bookCat;
	}
	public void setBookCat(String bookCat) {
		this.bookCat = bookCat;
	}
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
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getGradeSeq() {
		return gradeSeq;
	}
	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getImgAddr() {
		return imgAddr;
	}
	public void setImgAddr(String imgAddr) {
		this.imgAddr = imgAddr;
	}
	public String getBrdType() {
		return brdType;
	}
	public void setBrdType(String brdType) {
		this.brdType = brdType;
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
	
	
	
}
