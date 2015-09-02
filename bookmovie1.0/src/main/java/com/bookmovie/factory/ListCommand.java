package com.bookmovie.factory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ListCommand extends Command {
	private static final Logger logger = LoggerFactory.getLogger(ListCommand.class);
	
	@Override
	public void execute(int pageNo) {
		setPageNo(pageNo);
		logger.info("리스트 커맨드에서 시작={},끝={}", getStart(),getEnd());
	}
	@Override
	public void execute(int pageNo, int theme) {
		setPageNo(pageNo);
		setTheme(theme);
		logger.info("리스트 커맨드에서 시작={},끝={}", getStart(),getEnd());
	}
	@Override//극자에서 추가된 메소드
	public void execute(String date) {
		setDate(date);
		logger.info("ListCommand 에서 설정된 극장 날짜 넘버={}",getDate());
	}
   //예약에 추가된거
	@Override
	public void execute(int pageNo, String userid) {
		setPageNo(pageNo);
		setSearchVal(userid);
		logger.info("리스트 커맨드에서 페이지번호={}, 아이디={}", getPageNo(),getSearchVal());
	}
	

}
