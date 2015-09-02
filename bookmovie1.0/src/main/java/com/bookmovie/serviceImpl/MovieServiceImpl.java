package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.MovieDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.MovieMapper;
import com.bookmovie.service.MovieService;



@Service
public class MovieServiceImpl implements MovieService {
	private static final Logger logger = LoggerFactory.getLogger(MovieServiceImpl.class);
	
	/*===== Field =====*/	
	/*ArticleDto member = new ArticleDto();*/
	@Autowired private SqlSession sqlSession;

		
	
	/*===== executeQuery =====*/	
	@Override
	public MovieDto detail(Command command) {
		logger.info("[서비스]상세={}",command.getSearchVal());
		MovieMapper mapper = sqlSession.getMapper(MovieMapper.class);
		return mapper.detail(command);
	}
	



	@Override
	public List<MovieDto> list(Command command) {
		logger.info("[서비스]게시글 목록={}",command.getPageNo());
		MovieMapper mapper = sqlSession.getMapper(MovieMapper.class);
		return mapper.list(command);
	}



	@Override
	public int count(Command command) {
		logger.info("[서비스] 카운트={}",command.getSearchVal());
		MovieMapper mapper = sqlSession.getMapper(MovieMapper.class);
		return mapper.count(command);
	
	}


	@Override
	public int searchSeq() {
		logger.info("최근 시퀀스");
		MovieMapper mapper = sqlSession.getMapper(MovieMapper.class);
		return mapper.searchSeq();
	}

	@Override
	public int size(Command command) {
		logger.info("사이즈 리턴");
		MovieMapper mapper = sqlSession.getMapper(MovieMapper.class);
		return mapper.size(command);
	}

	
	
}
