package com.bookmovie.factory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DetailCommand extends Command {
	private static final Logger logger = LoggerFactory.getLogger(DetailCommand.class);
	
	@Override
	public void execute(String searchKey, String searchVal) {
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		logger.info("디테일커맨드 검색 키={}, 검색 값={}",getSearchKey(),getSearchVal());
	}
	
	@Override
	public void execute(String searchKey, String searchVal, int theme) {
		setSearchKey(searchKey);
		setSearchVal(searchVal);
		setTheme(theme);
		logger.info("디테일커맨드 검색 키={}, 검색 값={}",getSearchKey(),getSearchVal());
	}
	//북에 추가된것
	@Override
	public void execute(String param1, int param2, int param3) {
		setSearchKey(param1);
		setSeq(param2);
		setTheme(param3);
		logger.info("디테일커맨드 theme={},번호={}", getTheme(),getSeq());
	}
	
	
}
