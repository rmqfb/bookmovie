package com.bookmovie.factory;

public interface Orderable {
	// 메소드 오버로딩
	public void execute(String param1);
	public void execute(String param1,String param2,String param3);
	public void execute(String param1,int param2,int param3 ); // 북 추가사항
	
	/************************************
	  1. 상세(detail)
	 ************************************/
	public void execute(String param1, String param2);
	public void execute(String param1, String param2, int param3);
	
	/************************************
	  2. 조회(search)
	 ************************************/
	public void execute(int param1, String param2, String param3);
	public void execute(int param1, String param2, String param3, int param4);
	//통계파트 추가
	public void execute(String param1, String param2, String param3, String param4);
	public void execute(int param1, String param2, String param3, String param4, String param5);
	//---통계파트 
	/************************************
	  3. 목록(list)
	 ************************************/
	public void execute(int param1);
	public void execute(int param1, int param2);
	public void execute(int param1, String param2);    //예약 , 극장에 추가된 execute
	
	/************************************
	  4. 크기(size)
	 ************************************/
	public void execute();
	/*public void execute(int param1,); 목록에서 중복*/
	
	/************************************
	  5. 카운팅(count)
	 ************************************/
	public void execute(String param1, int param2);
	/*public void execute(String param1, String param2, int param3); 상세에서 중복*/
}
