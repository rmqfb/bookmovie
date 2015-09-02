package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.BoardDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.BoardMapper;

import com.bookmovie.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService{
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
    BoardDto board = new BoardDto();
	
	@Autowired private SqlSession sqlSession;
    
	
	@Override
	public int insert(BoardDto board) {
		logger.info("[서비스 구역]들어온 보드type={},장르={}", board.getTheme(),board.getCategory());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.insert(board);
	}

	@Override
	public int update(BoardDto board) {
		logger.info("[서비스 구역]들어온 보드type={},장르={}", board.getTheme(),board.getCategory());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.update(board);
	}

	@Override
	public int delete(BoardDto board) {
		logger.info("[서비스 구역]들어온 보드type={},장르={}", board.getTheme(),board.getCategory());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.delete(board);
	}

	@Override
	public BoardDto detail(Command command) {
		logger.info("[서비스 구역]들어온 보드val={}", command.getTheme());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.detail(command);
	}

	@Override
	public List<BoardDto> search(Command command) {
		logger.info("board서비스 유형={},val={}",command.getTheme(),command.getSearchVal());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.search(command);
	}

	@Override
	public List<BoardDto> list(Command command) {
		logger.info("board서비스 유형={}", command.getTheme());
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.list(command);
	}
	@Override
	public List<BoardDto> boardsearch(Command command) {
		logger.info("board서비스 검색부분 검색 페이지넘={},검색 val={}", command.getPageNo(),command.getSearchVal());
		
		BoardMapper boardmapper = sqlSession.getMapper(BoardMapper.class);
		return boardmapper.boardsearch(command);
	}

	@Override
	public int size(Command command) {
		logger.info("board서비스 사이즈={}", command.getPageNo());
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.size(command);
	}
	@Override
	public int keywordsize(Command command) {
	 logger.info("board서비스 검색사이즈", command.getSearchKey());
	  BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);	
	 return boardMapper.keywordsize(command);
	}

	@Override
	public int count(Command commnad) {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
