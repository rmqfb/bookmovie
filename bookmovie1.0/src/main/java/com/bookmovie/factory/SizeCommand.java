package com.bookmovie.factory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SizeCommand extends Command {
	private static final Logger logger = LoggerFactory.getLogger(SizeCommand.class);
	
	@Override
	public void execute() {
		logger.info("[전체목록] 사이즈커맨드 지나는중");
	}
	
	/*예약에 필요한 것 , 북에 추가된것*/
	@Override
	public void execute(String userid) {
		setSearchVal(userid);
		logger.info("[전체목록] 사이즈커맨드 지나는중 사용자아이디={}", getSearchVal());
	}

	@Override//극장및 보드 에서 추가된것
	public void execute(int theme) {
		setTheme(theme);
		logger.info("[테마목록] 사이즈커맨드 지나는중 테마={}",getTheme());
	}
	//북에 추가된것!!
	@Override
	public void execute(String param1, String param2) {
		setSearchKey(param1);
		setSearchVal(param2);
		logger.info("사이즈커맨드 지나는중 테마값={}, 검색값={}",getSearchKey(),getSearchVal());
	}
	@Override //극장에서의 예매 파트 메소드
	public void execute(int pageNo, String userid) {
		setPageNo(pageNo);
		setSearchVal(userid);
		logger.info("[전체목록] 사이즈커맨드 지나는중 사용자아이디={}",getSearchVal());
	}
	
	
}
