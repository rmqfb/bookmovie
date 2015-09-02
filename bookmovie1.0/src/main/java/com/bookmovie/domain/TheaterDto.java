package com.bookmovie.domain;

import org.springframework.stereotype.Component;

/*
@ Date :2015-06-22
@ Author : JTJ
@ Story: 극장관련 Bean 

thCode // 상영코드
title // 영화타이틀
thDate // 상영날짜
thName // 상영관이름
firstTime // 1번째상영시간
secondTime // 2번쨰상영시간
thirdTime // 3번쨰상영시간
fourthTime // 4번째상영시간
fifthTime // 5번째상영시간
*/
@Component("TheaterDto")
public class TheaterDto {
	private String mpName; // 극장이름
	private String thCode; // 상영코드
	private String title; // 영화타이틀
	private String thDate; // 상영날짜
	private String thName; // 상영관이름
	private String thTime; // 상영시간
	
	private String firstTime; // 1번째상영시간
	private String secondTime; // 2번쨰상영시간
	private String thirdTime; // 3번쨰상영시간
	private String fourthTime; // 4번째상영시간
	private String fifthTime; // 5번째상영시간
	//private String closeTime; // 상영종료시간  (보류)
	
	public String getMpName() {
		return mpName;
	}
	public void setMpName(String mpName) {
		this.mpName = mpName;
	}
	public String getThCode() {
		return thCode;
	}
	public void setThCode(String thCode) {
		this.thCode = thCode;
	}
	public String getThDate() {
		return thDate;
	}
	public void setThDate(String thDate) {
		this.thDate = thDate;
	}
	public String getThName() {
		return thName;
	}
	public void setThName(String thName) {
		this.thName = thName;
	}
	public String getFirstTime() {
		return firstTime;
	}
	public void setFirstTime(String firstTime) {
		this.firstTime = firstTime;
	}
	public String getSecondTime() {
		return secondTime;
	}
	public void setSecondTime(String secondTime) {
		this.secondTime = secondTime;
	}
	public String getThirdTime() {
		return thirdTime;
	}
	public void setThirdTime(String thirdTime) {
		this.thirdTime = thirdTime;
	}
	public String getFourthTime() {
		return fourthTime;
	}
	public void setFourthTime(String fourthTime) {
		this.fourthTime = fourthTime;
	}
	public String getFifthTime() {
		return fifthTime;
	}
	public void setFifthTime(String fifthTime) {
		this.fifthTime = fifthTime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	/*public String getCloseTime() {
		return closeTime;
	}
	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}*/
	public String getThTime() {
		return thTime;
	}
	public void setThTime(String thTime) {
		this.thTime = thTime;
	}
	
	

}
