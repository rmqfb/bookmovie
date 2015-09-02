package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.Command;

public interface MemberService {
/*===== executeUpdate =====*/	
	
	/*insert : 회원가입*/
    public int joinMember(MemberDto bean);
    /*update : 회원정보 수정*/
    public int updateMember(MemberDto bean);
    /*delete : 회원탈퇴*/
    public int deleteMember(MemberDto bean);
    
/*===== executeQuery =====*/    
    
    /*getElementsByName : 검색어로 회원 검색*/
    public List<MemberDto> searchByKeyword(Command command);
    /*list : 회원전체 목록*/
    public List<MemberDto> memberList(Command command);
    /*login : 로그인*/
    public MemberDto login(Command command);
    /*count : 회원수*/
    public int memberCountAll();
    /*count : 특정 회원수*/
    public int memberCountSome(Command command);
    /*getElementById : 회원상세정보*/
    public MemberDto memberDetail(Command command);
}
