package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("Reservation")
public class ReservationDto {
   
	private int resNo;    // 예약번호
    private String id;		// 아이디
    private String serialNo;	// 시리얼넘버
    private String imgAddr;		// 이미지
    private String bTitle;		// 책제목
    private String pressDay;	// 출판일
 	private String publisher;	// 출판사
 	private String author;		// 글쓴이
 	
 	
     
     public String getPressDay() {
		return pressDay;
	}
	public void setPressDay(String pressDay) {
		this.pressDay = pressDay;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSerialNo() {
 		return serialNo;
 	}
 	public void setSerialNo(String serialNo) {
 		this.serialNo = serialNo;
 	}
	public String getImgAddr() {
		return imgAddr;
	}
	public void setImgAddr(String imgAddr) {
		this.imgAddr = imgAddr;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public int getResNo() {
		return resNo;
	}
	public void setResNo(int resNo) {
		this.resNo = resNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}	
}
