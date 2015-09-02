package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.BoardDto;
import com.bookmovie.factory.Command;

public interface BoardMapper {
	
	/*executeUpdate*/
	public int update(BoardDto board);
	public int insert(BoardDto board);
	public int delete(BoardDto board);
	
	
  /*
   * 1. 아이디로 (detail)
   */
  public BoardDto detail (Command command);
  /*
   * 2. 이름으로 검색(목록)board에서 쓰인 리스트  (search)
   * */
  public List<BoardDto> search(Command command);
  /*
   * 3. 리스트전체(목록)검색 그냥 있는거  (list)
   * */
   public List<BoardDto> list(Command command);
   
   public int size(Command command);
   public int keywordsize(Command command);
   public int count(Command command);
   public List<BoardDto> boardsearch(Command command);
   
  

}
