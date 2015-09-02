package com.bookmovie.domain;


import org.springframework.stereotype.Component;

/*
 * DATE : 2015.06.22
 * AUTHOR : 허성조
 * STORY : 멤버빈
 * */

	/*
	name : 회원 이름
	birthday : 생일
	birthdayRadio : 생일 양력/음력
	gender : 성별 남성/여성 
	userId : 유저 아이디
	userPw : 유저 비밀번호
	email : 이메일
	phone : 전화번호
	adminId : 관리자 아이디 
	adminPw : 관리자 비밀번호
	 * */

@Component("memberDto")
public class MemberDto {

	private String name;
	private String birthday;
	private String birthdayRadio;
	private String gender; 
	private String userId;
	private String userPw;
	private String email;
	private String phone;
	
	private String adminId; 
	private String adminPw;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	
	public String getBirthdayRadio() {
		return birthdayRadio;
	}
	public void setBirthdayRadio(String birthdayRadio) {
		this.birthdayRadio = birthdayRadio;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	
	

}