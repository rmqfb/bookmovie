package com.bookmovie.factory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class CommandFactory {
	private static final Logger logger = LoggerFactory.getLogger(CommandFactory.class);
	private static Command instance;
	private CommandFactory(){}
	
	/************************************
	  1. 상세(detail)
	 ************************************/
	public static Command detail(String searchKey, String searchVal){
		instance = new DetailCommand();
		instance.execute(searchKey, searchVal);
		logger.info("[팩토리] 디테일 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	public static Command detail(String searchKey, String searchVal, int theme){
		instance = new DetailCommand();
		instance.execute(searchKey, searchVal, theme);
		logger.info("[팩토리] 디테일 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	//북 추가사항
	public static Command detail(String searchKey, int param1, int param2){
		instance = new DetailCommand();
		instance.execute(param1, param2);
		logger.info("[팩토리] 디테일 시퀀스={}, 테마={}",instance.getSeq(),instance.getTheme());
		return instance;
	}
	
	/************************************
	  2. 조회(search)
	 ************************************/
	public static Command search(String searchKey, String searchVal){
		instance = new SearchCommand();
		instance.execute(searchKey, searchVal);
		logger.info("[팩토리] 조회 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	public static Command search(int pageNo,String searchKey, String searchVal){
		instance = new SearchCommand();
		instance.execute(pageNo, searchKey, searchVal);
		logger.info("[팩토리] 조회 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	public static Command search(int pageNo,String searchKey, String searchVal,int theme){
		instance = new SearchCommand();
		instance.execute(pageNo, searchKey, searchVal, theme);
		logger.info("[팩토리] 조회 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	// 자유게시판 검색하기위해서 필요한 부분
	public static Command search(String keyword,String searchKey,String searchVal){
	  instance = new SearchCommand();
	  instance.execute(keyword, searchKey, searchVal);
	  logger.info("[팩토리] 검색 하는곳  들어온아이디={},검색값{}", instance.getKeyword(),instance.getSearchVal());
		
	  return instance;
	}
	//통계에서 추가된 내용
	public static Command search(String searchKey, String searchVal, String searchKey2, String searchVal2){
		instance = new SearchCommand();
		instance.execute(searchKey, searchVal, searchKey2, searchVal2);
		logger.info("[팩토리] 조회 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	public static Command search(int pageNo,String searchKey, String searchVal, String searchKey2, String searchVal2){
		instance = new SearchCommand();
		instance.execute(pageNo, searchKey, searchVal, searchKey2, searchVal2);
		logger.info("[팩토리] 조회 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	
	//통계내용끝
	
	
	/************************************
	  3. 목록(list)
	 ************************************/
	public static Command list(String date){ //극장에 쓰인 리스트
        instance = new ListCommand();
        instance.execute(date);
        return instance;
     }
	public static Command list(int pageNo){
		instance = new ListCommand();
		instance.execute(pageNo);
		logger.info("[팩토리] 목록(list) 시작값={}, 끝값={}",instance.getStart(),instance.getEnd());
		return instance;
	}
	public static Command list(int pageNo,int theme){
		instance = new ListCommand();
		instance.execute(pageNo,theme);
		logger.info("[팩토리] 목록(list) 시작값={}, 끝값={}",instance.getStart(),instance.getEnd());
		return instance;
	}
	//예약에 쓰인 리스트
	public static Command list(int pageNo,String userid){
		instance = new ListCommand();
		instance.execute(pageNo,userid);
		logger.info("[팩토리] 목록(list) 페이지번호={}, 아이디={}",instance.getPageNo(),instance.getSearchVal());
		return instance;
	}
	
	
	/************************************
	  4. 크기(size)
	 ************************************/
	public static Command size(){
		instance = new SizeCommand();
		instance.execute();
		logger.info("[팩토리] 전체 목록 수 구하기");
		return instance;
	}
	public static Command size(int theme){
		instance = new SizeCommand();
		instance.execute(theme);
		logger.info("[팩토리] 전체 목록 수 구하기");
		return instance;
	}
	/*예약 으로 인해서 추가된것*/
	public static Command size(String searchVal){
		instance = new SizeCommand(); //userid -> searchVal
		instance.execute(searchVal);
		logger.info("[팩토리] 전체 목록 수 구하기");
		return instance;

	}
	//북 에 추가된 사항
	public static Command size(String searchKey, String searchVal){
		instance = new SizeCommand();
		instance.execute(searchKey, searchVal);
		logger.info("[팩토리] 전체 목록 수 구하기 스트링={} 겟={}",searchVal,instance.getSearchVal());
		return instance;
	}

	
	
	/************************************
	  5. 카운팅(count)
	 ************************************/
	public static Command count(String searchKey, String searchVal){
		instance = new CountCommand();
		instance.execute(searchKey, searchVal);
		logger.info("[팩토리] 카운트 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	public static Command countSome(String searchKey, String searchVal,int theme){
		instance = new CountCommand();
		instance.execute(searchKey, searchVal,theme);
		logger.info("[팩토리] 카운트 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	/************************************
	  6. 수정(update)
	 ************************************/
	//movie 쪽에서 영화리뷰 수정 에서 추가된거
	public static Command update(String searchKey, String searchVal,int brdNo){
		instance = new CountCommand();
		instance.execute(searchKey, searchVal,brdNo);
		logger.info("[팩토리] 카운트 검색키={},검색값={}",instance.getSearchKey(),instance.getSearchVal());
		return instance;
	}
	
	
}
