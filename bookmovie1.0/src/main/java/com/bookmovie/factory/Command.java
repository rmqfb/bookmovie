package com.bookmovie.factory;

public class Command implements Orderable{
	public final int PAGESIZE = 5;
	private int pageNo, start, end ;
	private int theme, seq; // theme 는 게시판 시퀀스 번호
	private String command, searchKey, searchVal,searchKey2, searchVal2;
	//searchKey2, searchVal2 는 통계파트 추가
	private String directory, action, keyword, keyField, view, date; //극장에 관련된 변수들
	
	
	
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	
	public int getTheme() {
		return theme;
	}

	public void setTheme(int theme) {
		this.theme = theme;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public String getSearchVal() {
		return searchVal;
	}

	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}

	public int getPageNo() {
		return pageNo;
	}


	public int getStart() {
		return start;
	}


	public int getEnd() {
		return end;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		this.start = (pageNo-1)*PAGESIZE+1;
		this.end = pageNo*PAGESIZE;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public void setEnd(int end) {
		this.end = end;
	}
	
	


	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyField() {
		return keyField;
	}

	public void setKeyField(String keyField) {
		this.keyField = keyField;
	}

	public String getView() {
		return view;
	}

	public void setView(String view) {
		this.view = view;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	public String getSearchKey2() {
		return searchKey2;
	}

	public void setSearchKey2(String searchKey2) {
		this.searchKey2 = searchKey2;
	}

	public String getSearchVal2() {
		return searchVal2;
	}

	public void setSearchVal2(String searchVal2) {
		this.searchVal2 = searchVal2;
	}

	@Override
	public void execute() {
		
	}

	@Override
	public void execute(String param1, String param2) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1, String param2, int param3) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1, String param2, String param3) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1, String param2, String param3, int param4) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1, int param2) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1, int param2) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1, String param2, String param3) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1, int param2, int param3) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1, String param2) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(String param1, String param2, String param3, String param4) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void execute(int param1, String param2, String param3, String param4, String param5) {
		// TODO Auto-generated method stub
		
	}

	

}
