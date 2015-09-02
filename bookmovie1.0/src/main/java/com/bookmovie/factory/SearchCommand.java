package com.bookmovie.factory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class SearchCommand extends Command {
	private static final Logger logger = LoggerFactory.getLogger(SearchCommand.class);
	
	@Override
	public void execute(int pageNo,String searchKey, String searchVal) {
		setPageNo(pageNo);
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		logger.info("서치 커맨드 검색 키={},검색값={}",getSearchKey(),getSearchVal());
	}
	
	@Override
	public void execute(int pageNo, String searchKey, String searchVal, int theme) {
		setPageNo(pageNo);
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		setTheme(theme);
		logger.info("서치 커맨드 검색 유형={},검색값={}",getTheme(),getSearchVal());
	}
	
	@Override
	public void execute(String searchKey, String searchVal) {
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		logger.info("서치 커맨드 검색 키={},검색값={}",getSearchKey(),getSearchVal());
	}
   //검색하기 위해서 필요한 메소드 석보 board에서
	@Override
	public void execute(String keyword, String searchKey, String searchVal) {
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		setKeyword(keyword);
		logger.info("서치 커맨드 검색하는기위한 아이디={},val={}", getKeyword(),getSearchVal());
		
	}
	//통계 파트 추가
	@Override
	public void execute(String searchKey, String searchVal, String searchKey2, String searchVal2) {
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		setSearchKey2(searchKey2);
		setSearchVal2(searchVal2);
		logger.info("서치 커맨드 검색 값={},검색 값2={}",getSearchVal(),getSearchVal2());
	}
	@Override
	public void execute(int pageNo, String searchKey, String searchVal, String searchKey2, String searchVal2) {
		setPageNo(pageNo);
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		setSearchKey2(searchKey2);
		setSearchVal2(searchVal2);
		logger.info("서치 커맨드 검색 값={},검색 값2={}",getSearchVal(),getSearchVal2());
	}
	//통계파트 끝
	
	
	
	
}
