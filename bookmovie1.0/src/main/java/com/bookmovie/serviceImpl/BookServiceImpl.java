package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.BookDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.BookMapper;
import com.bookmovie.service.BookService;

@Service
public class BookServiceImpl implements BookService{
	private static final Logger logger = LoggerFactory.getLogger(BookServiceImpl.class);
	
	@Autowired private SqlSession sqlSession;
	
	
	@Override
	public int insert(BookDto book) {
		logger.info("[북서비스] 삽입 값={}",book.getbTitle());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.insert(book);
	}

	@Override
	public int update(BookDto book) {
		logger.info("[북서비스] 수정 값={}",book.getbTitle());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.update(book);
	}

	@Override
	public int delete(BookDto book) {
		logger.info("[북서비스] 지우기 값={}",book.getbTitle());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.delete(book);
	}
	@Override
	public List<BookDto> list(Command command) {
		logger.info("[북서비스] 리스트 값={}",command.getPageNo());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.list(command);
	}
	

	@Override
	public List<BookDto> smallCat(Command command) {
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.smallCat(command);
	}

	@Override
	public List<BookDto> mediumCat(Command command) {
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.mediumCat(command);
	}

	@Override
	public List<BookDto> bigCat() {
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.bigCat();
	}

	@Override
	public List<BookDto> search(Command command) {
		logger.info("[북서비스] 서치 키={}, 값={}",command.getSearchKey(),command.getSearchVal());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.search(command);
	}
	
	@Override
	public List<BookDto> searching(Command command) {
		logger.info("[북서비스] 서치 키={}, 값={}",command.getSearchKey(),command.getSearchVal());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.searching(command);
	}

	@Override
	public BookDto detail(Command command) {
		logger.info("[북서비스] 상세 값={}",command.getSearchKey());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.detail(command);
	}

	@Override
	public int size(Command command) {
		logger.info("[북서비스] 사이즈 테마값={}",command.getSearchVal());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.size(command);
	}

	@Override
	public int keywordsize(Command command) {
		logger.info("[북서비스] 사이즈 테마값={}",command.getSearchVal());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.keywordsize(command);
	}

	@Override
	public int count(Command command) {
		logger.info("[북서비스] 카운트 키={},값={}",command.getSearchKey(),command.getSearchVal());
		BookMapper bookMapper = sqlSession.getMapper(BookMapper.class);
		return bookMapper.size(command);
	}

}
