package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.ReservationDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.ReservationMapper;
import com.bookmovie.service.ReservationService;
import com.bookmovie.web.ReservationController;

@Service
public class ReservationServiceImpl implements ReservationService{
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	@Autowired private SqlSession sqlSession;
	
	@Override
	public int reserve(ReservationDto dto){
		logger.info("[서비스] 결과 아이디={}", dto.getId());
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		return mapper.insert(dto);
	}

	@Override
	public int delete(List<Integer> checkbox) {
		logger.info("[서비스] 삭제 페이지 자리번호={}", checkbox);
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		return mapper.delete(checkbox);
	}


	@Override
	public List<ReservationDto> list(Command command) {
		logger.info("[서비스] 리스트의 아이디={}", command.getSearchVal());
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		List<ReservationDto> list = mapper.list(command);
		
		return list;
	}
	
	@Override
	public int size(Command command) {
		logger.info("[서비스] 사이즈");
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		return mapper.size(command);
	}
}
