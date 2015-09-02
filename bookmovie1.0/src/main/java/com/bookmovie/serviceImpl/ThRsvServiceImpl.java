package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.ThRsvDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.ThRsvMapper;
import com.bookmovie.service.ThRsvService;

@Service
public class ThRsvServiceImpl implements ThRsvService{
	private static final Logger logger = LoggerFactory.getLogger(ThRsvServiceImpl.class);
	@Autowired private SqlSession sqlSession;
	
	@Override
	public int thRsv(ThRsvDto dto){
		logger.info("[서비스] 결과 아이디={}", dto.getId());
		ThRsvMapper mapper = sqlSession.getMapper(ThRsvMapper.class);
		return mapper.insert(dto);
	}

	@Override
	public int delete(List<Integer> checkbox) {
		logger.info("[서비스] 삭제 페이지 자리번호={}", checkbox);
		ThRsvMapper mapper = sqlSession.getMapper(ThRsvMapper.class);
		logger.info("[서비스] mapper: {}" ,mapper);
		return mapper.delete(checkbox);
	}


	@Override
	public List<ThRsvDto> list(Command command) {
		logger.info("[서비스] 리스트");
		logger.info("searchVal={}",command.getSearchVal());
		ThRsvMapper mapper = sqlSession.getMapper(ThRsvMapper.class);
		List<ThRsvDto> list = mapper.list(command);
		
		return list;
	}
	
	@Override
	public int size(Command command) {
		logger.info("[서비스] 사이즈");
		ThRsvMapper mapper = sqlSession.getMapper(ThRsvMapper.class);
		return mapper.size(command);
	}
	
}
