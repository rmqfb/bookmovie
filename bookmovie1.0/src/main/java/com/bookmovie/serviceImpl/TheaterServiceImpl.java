package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.TheaterDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.TheaterMapper;
import com.bookmovie.service.TheaterService;

@Service
public class TheaterServiceImpl implements TheaterService{
	private static final Logger logger = LoggerFactory.getLogger(TheaterServiceImpl.class);
	@Autowired SqlSession sqlSession;
	
	/*=== executeUpdate ===*/
	@Override
	public int insert(TheaterDto theater) {
		logger.info("[서비스] 삽입");
		TheaterMapper mapper = sqlSession.getMapper(TheaterMapper.class);
		return mapper.insert(theater);
	}

	@Override
	public int delete(TheaterDto theater) {
		logger.info("[서비스] 삭제");
		TheaterMapper mapper = sqlSession.getMapper(TheaterMapper.class);
		return mapper.delete(theater);
	}
	
	
	/*===== executeQuery =====*/
	@Override
	public TheaterDto detail(Command command) {
		logger.info("[서비스] 상세정보={}",command.getSearchVal());
		TheaterMapper mapper = sqlSession.getMapper(TheaterMapper.class);
		return mapper.detail(command);
	}

	@Override
	public List<TheaterDto> list(Command command) {
		logger.info("[서비스] 상세정보={}",command.getDate());
		TheaterMapper mapper = sqlSession.getMapper(TheaterMapper.class);
		return mapper.list(command);
	}
}
