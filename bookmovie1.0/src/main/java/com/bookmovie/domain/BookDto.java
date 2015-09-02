package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("bookDto")
public class BookDto {
	private String bigCat;
	private String mediumCat;
	private String smallCat;
	private String serialNo;
	private String bTitle;
	private String author;
	private String imgAddr;
	private String pressDay;
	private String publisher;
	private String detail;
	
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getBigCat() {
		return bigCat;
	}
	public void setBigCat(String bigCat) {
		this.bigCat = bigCat;
	}
	public String getMediumCat() {
		return mediumCat;
	}
	public void setMediumCat(String mediumCat) {
		this.mediumCat = mediumCat;
	}
	public String getSmallCat() {
		return smallCat;
	}
	public void setSmallCat(String smallCat) {
		this.smallCat = smallCat;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getImgAddr() {
		return imgAddr;
	}
	public void setImgAddr(String imgAddr) {
		this.imgAddr = imgAddr;
	}
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
}
