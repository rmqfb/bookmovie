package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.Command;


public interface MemberMapper {
		/*===== executeUpdate =====*/	
			/* 
			 * 추가 CREATE
			 * */
			public int insert(MemberDto member);
			/*
			 * 수정
			 * */
			public int update(MemberDto member);
			/*
			 * 삭제
			 * */
			public int delete(MemberDto member);
			
		/*===== executeQuery =====*/	
			/*
			 * 요소의 전체 갯수 
			 * */
			public int countAll();
			/*검색 결과로 나온 요소의 갯수*/
			public int countSome(Command command);
			/*
			 * ID 로 중복값 없이 추출
			 * */
			public MemberDto getElementById(Command command);
			/*
			 * Name 으로 중복값 허용하며 추출
			 * */
			public List<MemberDto> getElementsByName(Command command);
			/*
			 * 전체 목록 추출
			 * */
			public List<MemberDto> list(Command command);
			/* 로그인 */
			public MemberDto login (Command command);
			
}
