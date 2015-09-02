package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookmovie.domain.BookReviewDto;
import com.bookmovie.domain.MovieReviewDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.MovieReviewMapper;
import com.bookmovie.service.MovieReviewService;
@Transactional
@Service
public class MovieReviewServiceImpl implements MovieReviewService{
	private static final Logger logger = LoggerFactory.getLogger(MovieReviewServiceImpl.class);
	
	@Autowired private SqlSession sqlSession;
	
	
	@Override
	public int insert(MovieReviewDto mReview) {
		logger.info("리뷰 평점={}",mReview.getgPoint());
		logger.info("리뷰 리뷰제목={}",mReview.getBrdTitle());
		logger.info("리뷰 리뷰내용={}",mReview.getBrdContent());
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		movieReviewMapper.insert(mReview);
		return movieReviewMapper.insert(mReview);
	}
	
	@Override
	public MovieReviewDto boardMeta(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.boardMeta(command);
	}
	
	
	@Override
	public int insert2(MovieReviewDto mReview) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.insert2(mReview);
	}
	@Override
	public int insert3(MovieReviewDto mReview) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.insert3(mReview);
	}

	@Override
	public int update(MovieReviewDto mReview) {
		logger.info("[영화리뷰] 삽입 값={}",mReview.getBrdContent());
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.update(mReview);
	}

	@Override
	public int delete(MovieReviewDto mReview) {
		logger.info("[영화리뷰] 삭제 값={}",mReview.getBrdNo());
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.delete(mReview);
	}
	@Override
	public List<MovieReviewDto> list(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.list(command);
	}
	
	@Override
	public List<MovieReviewDto> search(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.search(command);
	}
	
	@Override
	public List<MovieReviewDto> searching(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.searching(command);
	}

	@Override
	public MovieReviewDto detail(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.detail(command);
	}

	@Override
	public int size(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.size(command);
	}

	@Override
	public int keywordsize(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.keywordsize(command);
	}

	@Override
	public int count(Command command) {
		logger.info("[영화리뷰] 삽입 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.count(command);
	}

	@Override
	public MovieReviewDto detail2(Command command) {
		logger.info("[영화리뷰] 디테일 값={}", command.getSearchVal());
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.detail2(command);
	}

	@Override
	public int getBrdSeq() {
		logger.info("리뷰 시퀀스 값={}");
		MovieReviewMapper movieReviewMapper = sqlSession.getMapper(MovieReviewMapper.class);
		return movieReviewMapper.getBrdSeq();
	}

	

}
