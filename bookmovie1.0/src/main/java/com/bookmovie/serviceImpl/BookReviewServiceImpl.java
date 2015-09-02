package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookmovie.domain.BookReviewDto;
import com.bookmovie.factory.Command;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.mapper.BookReviewMapper;
import com.bookmovie.service.BookReviewService;
@Transactional
@Service
public class BookReviewServiceImpl implements BookReviewService{
	private static final Logger logger = LoggerFactory.getLogger(BookReviewServiceImpl.class);
	
	@Autowired private SqlSession sqlSession;
	
	
	@Override
	public int insert(BookReviewDto bReview) {
		logger.info("리뷰 작성={}",bReview.getSerialNo());
		logger.info("리뷰 평점={}",bReview.getgPoint());
		logger.info("리뷰 리뷰제목={}",bReview.getBrdTitle());
		logger.info("리뷰 리뷰내용={}",bReview.getBrdContent());
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		bookReviewMapper.insert(bReview);
		return bookReviewMapper.insert(bReview);
	}
	
	@Override
	public BookReviewDto boardMeta(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.boardMeta(command);
	}
	
	
	@Override
	public int insert2(BookReviewDto bReview) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.insert2(bReview);
	}
	@Override
	public int insert3(BookReviewDto bReview) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.insert3(bReview);
	}

	@Override
	public int update(BookReviewDto bReview) {
		logger.info("[책리뷰] 삽입 값={}",bReview.getBrdContent());
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.update(bReview);
	}

	@Override
	public int delete(BookReviewDto bReview) {
		logger.info("[책리뷰] 삭제 값={}",bReview.getBrdNo());
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.delete(bReview);
	}
	@Override
	public List<BookReviewDto> list(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.list(command);
	}
	
	@Override
	public List<BookReviewDto> search(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.search(command);
	}
	
	@Override
	public List<BookReviewDto> searching(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.searching(command);
	}

	@Override
	public BookReviewDto detail(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.detail(command);
	}

	@Override
	public int size(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.size(command);
	}

	@Override
	public int keywordsize(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.keywordsize(command);
	}

	@Override
	public int count(Command command) {
		logger.info("[책리뷰] 삽입 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.count(command);
	}

	@Override
	public BookReviewDto detail2(Command command) {
		logger.info("[책리뷰] 디테일 값={}", command.getSearchVal());
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.detail2(command);
	}

	@Override
	public int getBrdSeq() {
		logger.info("리뷰 시퀀스 값={}");
		BookReviewMapper bookReviewMapper = sqlSession.getMapper(BookReviewMapper.class);
		return bookReviewMapper.getBrdSeq();
	}

	

}
