package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("ThRsvDto")
public class ThRsvDto {
   
	private int thRsvNo;    // 영화예매번호
    private String id;		// 아이디
    private String rsvDate; // 예매날짜/시간
    private String thCode;	// 상영코드
    private String movieCode;	// 상영코드
    private String poster;	// 영화포스터
    private String mpName;	// 극장지역
    private String mTitle;	// 영화제목
 	private String thDate;	// 상영날짜
    private String thName;	// 상영관
 	private String thTime;	// 상영시간
 	
 	private String firstTime; // 1번째상영시간
	private String secondTime; // 2번쨰상영시간
	private String thirdTime; // 3번쨰상영시간
	private String fourthTime; // 4번째상영시간
	private String fifthTime; // 5번째상영시간
 	
	
	
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
	public String getRsvDate() {
		return rsvDate;
	}
	public void setRsvDate(String rsvDate) {
		this.rsvDate = rsvDate;
	}
	public int getThRsvNo() {
		return thRsvNo;
	}
	public void setThRsvNo(int thRsvNo) {
		this.thRsvNo = thRsvNo;
	}
	public String getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}
	public int getThResNo() {
		return thRsvNo;
	}
	public void setThResNo(int thResNo) {
		this.thRsvNo = thResNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getThCode() {
		return thCode;
	}
	public void setThCode(String thCode) {
		this.thCode = thCode;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getMpName() {
		return mpName;
	}
	public void setMpName(String mpName) {
		this.mpName = mpName;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
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
	public String getThTime() {
		return thTime;
	}
	public void setThTime(String thTime) {
		this.thTime = thTime;
	}
 	
 	
}
