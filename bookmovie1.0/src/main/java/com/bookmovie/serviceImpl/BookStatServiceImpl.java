package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.BookStatDataDto;
import com.bookmovie.domain.BookStatMetaDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.BookStatMapper;
import com.bookmovie.service.BookStatService;


@Service
public class BookStatServiceImpl implements BookStatService{

	private static Logger logger = LoggerFactory.getLogger(BookStatServiceImpl.class);
	
	@Autowired private SqlSession sqlSession;
	
	/***************************************/
	/** executeUpdate **/
	/***************************************/
	
	
	@Override
	public int createUserBookReadCntStat(BookStatMetaDto dto) {
		logger.info("[서비스] createUserBookReadCntStat() - 사용자들의 월간 독서량 통계 생성 - 통계 타입[{}]", dto.getStatTypeCode());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		
		Integer lastStatId = mapper.getLastStatId(dto);
		if(lastStatId != null){
			mapper.removeBookReadCntStat(lastStatId);
			mapper.unregisterBookStat(lastStatId);
		}
		
		int sequence = mapper.getNewSequence();
		dto.setStatId(sequence);
		
		int nCreated = mapper.registerBookStat(dto);
		if(nCreated == 0)
			return -1;
		
		List<BookStatDataDto> list = mapper.extractBookReadCntStatById();
		
		if(list.size() == 0) 
			return 0;
		
		nCreated = 0;
		
		for(BookStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addBookReadCntStatById(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		list = mapper.extractBookReadCntStatByAll();
		
		if(list.size() == 0) 
			return 0;
		
		nCreated = 0;
		
		for(BookStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addBookReadCntStatByAll(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		logger.info("추출된 통계 데이터 건수 : {}", nCreated);
		
		return 1;
	}
	
	@Override
	public int createBookAvgGradeStat(BookStatMetaDto dto) {
		logger.info("[서비스] createBookAvgGradeStat() - 각 책의 대해 사용자들이 매긴 평점들을 평균으로 구하는 통계 생성 - 통계 타입[{}]", dto.getStatTypeCode());
		
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		
		Integer lastStatId = mapper.getLastStatId(dto);
		if(lastStatId != null){
			mapper.removeBookAvgGradeStat(lastStatId);
			mapper.unregisterBookStat(lastStatId);
		}
	
		int sequence = mapper.getNewSequence();
		dto.setStatId(sequence);
		
		int nCreated = mapper.registerBookStat(dto);
		if(nCreated == 0)
			return -1;
		
		List<BookStatDataDto> list = mapper.extractBookAvgGradeStat();  
		
		nCreated = 0;
		
		for(BookStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addBookAvgGradeStat(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		logger.info("추출된 통계 데이터 건수 : {}", nCreated);
		
		return 1;
	}

	
	/***************************************/
	/** executeQuery **/
	/***************************************/
	
	@Override
	public List<BookStatMetaDto> getStatTypes() {
		logger.info("[서비스] getStatTypes() - 도서 관련 통계 타입 리스트");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getStatTypes();
	}

	@Override
	public float getAvgGradeBook(Command command) {
		logger.info("[서비스] getAvgGradeBook() - 해당 책의 평균 평점 가져오기 - 북 코드 : {}", command.getSearchVal());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getAvgGradeBook(command);
	}

	@Override
	public List<BookStatDataDto> getUserFavoriteBookCategoriesStat(Command command) {
		logger.info("[서비스] getUserFavoriteBookCategoriesStat() - 해당 유저가 선호하는 도서 소분류 가져오기 - 유저 아이디 {}" + command.getSearchVal());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getUserFavoriteBookCategoriesStat(command);
	}

	@Override
	public List<BookStatDataDto> getUserBookReadCntStatByUser(Command command) {
		logger.info("[서비스] getUserBookReadCntStatByUser() - 해당 유저의 월간 독서량 가져오기 - 유저 아이디 {}" + command.getSearchVal());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getUserBookReadCntStatByUser(command);
	}
	
	@Override
	public List<BookStatDataDto> getUserBookReadCntStatByAll() {
		logger.info("[서비스] getUserBookReadCntStatByAll() - 해당 유저의 월간 독서량 가져오기");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getUserBookReadCntStatByAll();
	}


	@Override
	public List<BookStatDataDto> bookRankByCategory(Command command) {
		logger.info("[서비스] bookRankByCategory() - 유저의 특정 도서 분류에서 높은 평점 위주의 도서 목록 가져오기 - 유저 아이디 {}, 도서분류코드 {}", command.getSearchVal(), command.getSearchVal2());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.bookRankByCategory(command);
	}

	@Override
	public List<BookStatDataDto> bookRankByCategoryAndContentsByUser(Command command) {
		logger.info("[서비스] bookRankByCategoryByUser() - 유저의 특정 도서 분류에서 높은 평점 위주의 도서 목록 가져오기(리뷰 텍스트 포함) -도서분류코드 {}, 페이지 번호 {}", command.getSearchVal2(), command.getPageNo());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.bookRankByCategoryAndContentsByUser(command);
	}

	@Override
	public int getTotalCntFromBookRankByCategoryByUser(Command command) {
		logger.info("[서비스] getTotalCntFromBookRankByCategoryByUser() - 유저의 특정 도서 분류에서 높은 평점 위주의 도서 목록 가져오기(리뷰 텍스트 포함) -도서분류코드 {}, 페이지 번호 {}", command.getSearchVal2(), command.getPageNo());
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getTotalCntFromBookRankByCategoryByUser(command);
	}

	@Override
	public List<BookStatDataDto> bestSellerList() {
		logger.info("[서비스] 베스트 셀러 목록 가져오기 (평균 평점이 높은 도서 5위까지 리스트로 추출하기)");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		List<BookStatDataDto> list = mapper.bestSellerList();

		for(BookStatDataDto data : list){
			List<BookStatDataDto> brdTitles = mapper.getTop3BoardTitlesOfTheBook(data.getBookSerialNo());
			data.setReviewMsgOfParticipant1(brdTitles.get(0).getBoardTitle());
			data.setReviewMsgOfParticipant2(brdTitles.get(1).getBoardTitle());
			data.setReviewMsgOfParticipant3(brdTitles.get(2).getBoardTitle());
		}
		
		return list;
	}

	@Override
	public List<BookStatDataDto> favoriteBooks(Command command) {
		logger.info("[서비스] 사용자가 좋아하는 책 목록 가져오기");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.favoriteBooks(command);
	}

	@Override
	public List<BookStatDataDto> recentBooksInFavoriteCategories(BookStatDataDto category) {
		logger.info("[서비스] 사용자가 좋아하는 도서 카테고리 목록 중 하나를 전달받아 최근의 새로운 책 목록 가져오기");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.recentBooksInFavoriteCategories(category);
	}

	@Override
	public List<BookStatDataDto> getFavoriteTop3BookCategories(Command command) {
		logger.info("[서비스] 사용자가 좋아하는 도서 카테고리 3개 가져오기");
		BookStatMapper mapper = sqlSession.getMapper(BookStatMapper.class);
		return mapper.getFavoriteTop3BookCategories(command);
	}
	
}
