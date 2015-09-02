package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.MovieStatDataDto;
import com.bookmovie.domain.MovieStatMetaDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.MovieStatMapper;
import com.bookmovie.service.MovieStatService;

@Service
public class MovieStatServiceImpl implements MovieStatService{

	private static Logger logger = LoggerFactory.getLogger(MovieStatServiceImpl.class);
	
	@Autowired private SqlSession sqlSession;

	@Override
	public int createUserMovieReadCntStat(MovieStatMetaDto dto) {
		logger.info("[서비스] 유저의 영화를 상영한 횟수 통계 생성 ");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);

		List<Integer> statIds = mapper.getMovieReadCntStatIds();
		logger.info("삭제할 stat 번호 갯수 : {}", statIds.size());
	
		if(statIds.size() > 0){
			for(Integer i : statIds){
				mapper.removeMovieReadCntStat(i);
				mapper.unregisterMovieStat(i);
			}
		}
		
		int sequence = mapper.getNewSequence();
		dto.setStatId(sequence);
		logger.info("생성된 시퀀스 번호 : {}", sequence);
		
		int nCreated = mapper.registerMovieStat(dto);
		logger.info("통계 등록 완료 : {}", nCreated);
		if(nCreated == 0)
			return -1;
		
		List<MovieStatDataDto> list = mapper.extractMovieReadCntStatByUser();
		logger.info("추출된 통계 자료 갯수 : {}", list.size());
		if(list.size() == 0) 
			return 0;
		
		nCreated = 0;
		
		for(MovieStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addMovieReadCntStatByUser(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		list = mapper.extractMovieReadCntStatByAll();
		logger.info("추출된 통계 자료 갯수 : {}", list.size());
		if(list.size() == 0) 
			return 0;
		
		nCreated = 0;
		
		for(MovieStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addMovieReadCntStatByAll(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		logger.info("추출된 통계 데이터 건수 : {}", nCreated);
		
		return 1;
	}

	@Override
	public int createMovieAvgGradeStat(MovieStatMetaDto dto) {
		logger.info("[서비스] 유저가 매긴 영화의 평점을 토대로 순위를 매기는 통계 생성 ");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);

		List<Integer> statIds = mapper.getMovieAvgGradeStatIds();
		for(Integer i : statIds){
			mapper.removeMovieAvgGradeStat(i);
			mapper.unregisterMovieStat(i);
		};
		
		int sequence = mapper.getNewSequence();
		dto.setStatId(sequence);
		
		int nCreated = mapper.registerMovieStat(dto);
		if(nCreated == 0)
			return -1;
		
		List<MovieStatDataDto> list = mapper.extractMovieAvgGradeStat();  
		
		nCreated = 0;
		
		for(MovieStatDataDto item : list){
			item.setStatId(sequence);
			nCreated += mapper.addMovieAvgGradeStat(item);
		}
		
		if(nCreated == 0)
			return -1;
		
		logger.info("추출된 통계 데이터 건수 : {}", nCreated);
		
		return 1;
	}

	@Override
	public List<MovieStatMetaDto> getStatTypes() {
		logger.info("[서비스] 영화 통계 타입 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getStatTypes();
	}

	@Override
	public float getAvgGradeMovie(Command command) {
		logger.info("[서비스] 해당 영화의 평균 영화 평점 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getAvgGradeMovie(command);
	}

	@Override
	public List<MovieStatDataDto> getUserFavoriteMovieCategoriesStat(Command command) {
		logger.info("[서비스] 유저가 매긴 영화 평점을 토대로 가장 재미있는 영화순위를 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getUserFavoriteMovieCategoriesStat(command);
	}

	@Override
	public List<MovieStatDataDto> getUserMovieReadCntStatByUser(Command command) {
		logger.info("[서비스] 유저의 영화를 상영한 횟수 통계 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getUserMovieReadCntStatByUser(command);
	}

	@Override
	public List<MovieStatDataDto> getUserMovieReadCntStatByAll() {
		logger.info("[서비스] 유저의 영화를 상영한 횟수 통계 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getUserMovieReadCntStatByAll();
	}
	
	@Override
	public List<MovieStatDataDto> movieRankByCategory(Command command) {
		logger.info("[서비스] 해당 영화 카테고리 내에서 유저가 매긴 영화 평점을 토대로 가장 재미있는 영화순위를 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.movieRankByCategory(command);
	}

	@Override
	public List<MovieStatDataDto> movieRankByCategoryAndContentsByUser(Command command) {
		logger.info("[서비스] 해당 영화 카테고리 내에서 유저가 매긴 영화 평점을 토대로 가장 재미있는 영화순위를 가져오기 [영화 리뷰 포함]");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.movieRankByCategoryAndContentsByUser(command);
	}

	@Override
	public int getTotalCntFromMovieRankByCategory(Command command) {
		logger.info("[서비스] 해당 영화 카테고리 내에서 유저가 평점을 매긴 영화들의 갯수를 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getTotalCntFromMovieRankByCategory(command);
	}

	@Override
	public List<MovieStatDataDto> popularMovieList() {
		logger.info("[서비스] 모든 회원들이 좋아하는 영화 목록 가져오기 (평균 평점이 높은 영화 5위까지 리스트로 추출하기)");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		List<MovieStatDataDto> list = mapper.popularMovieList();

		for(MovieStatDataDto data : list){
			System.out.println("movie code : " + data.getMovieCode());
			List<MovieStatDataDto> brdTitles = mapper.getTop3BoardTitlesOfTheMovie(data.getMovieCode());
			data.setReviewMsgOfParticipant1(brdTitles.get(0).getBoardTitle());
			data.setReviewMsgOfParticipant2(brdTitles.get(1).getBoardTitle());
			data.setReviewMsgOfParticipant3(brdTitles.get(2).getBoardTitle());
		}
		
		return list;
	}

	@Override
	public List<MovieStatDataDto> favoriteMovies(Command command) {
		logger.info("[서비스] 사용자가 좋아하는 영화 목록 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.favoriteMovies(command);
	}

	@Override
	public List<MovieStatDataDto> recentMoviesInFavoriteGenres(MovieStatDataDto genre) {
		logger.info("[서비스] 사용자가 좋아하는 영화 장르 3개에서 각각 3개 씩의 새로운 영화 목록 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getRecentMoviesInGenre(genre);
		
	}

	@Override
	public List<MovieStatDataDto> getFavoriteTop3MovieGenres(Command command) {
		logger.info("[서비스] 사용자가 좋아하는 영화 장르 3개 가져오기");
		MovieStatMapper mapper = sqlSession.getMapper(MovieStatMapper.class);
		return mapper.getFavoriteTop3MovieGenres(command);
	}
}
