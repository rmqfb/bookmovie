package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.TheaterDto;
import com.bookmovie.factory.Command;

public interface TheaterMapper {
	
	public int insert(TheaterDto theater); // 관리자가 등록할때 사용 (삽입)
	public int delete(TheaterDto theater); // 관리자가 잘못된 정보를 입력했을 경우 삭제
	
	public TheaterDto detail(Command command); // // 상영정보의 한튜플 정보 출력 (getThInfo)
	public List<TheaterDto> list(Command command);// 전체 목록 추출 
	public TheaterDto getElementById(Command command); 
	public List<TheaterDto> getElementsByName(Command command); // 같은 이름의 종류를 보여줌
	public int count(Command command); // 갯수
	public List<TheaterDto> search(Command command);  // 검색
}