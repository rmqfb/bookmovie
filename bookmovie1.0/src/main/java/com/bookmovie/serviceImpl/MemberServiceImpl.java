package com.bookmovie.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.Command;
import com.bookmovie.mapper.MemberMapper;
import com.bookmovie.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	/*===== Field =====*/	
	@Autowired private SqlSession sqlSession;
    
/*===== executeUpdate =====*/
    @Override
    public int joinMember(MemberDto member) {
    	logger.info("[서비스]회원가입 이름 = {}",member.getName());
    	logger.info("[서비스]회원가입아이디={}",member.getUserId());
    	logger.info("[서비스]회원가입비번={}",member.getUserPw());
    	logger.info("[서비스]회원가입성별={}",member.getGender());
    	logger.info("[서비스]회원가입생일={}",member.getBirthday());
    	logger.info("[서비스]회원가입양력음력={}",member.getBirthdayRadio());
    	logger.info("[서비스]회원가입이메일={}",member.getEmail());
    	logger.info("[서비스]회원가입전화번호={}",member.getPhone());
    	MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
        return memberMapper.insert(member);
    }
    @Override
	public int updateMember(MemberDto member) {
    	logger.info("[서비스]회원수정 이름 = {}",member.getName());
    	MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.update(member);
	}
	@Override
	public int deleteMember(MemberDto member) {
		logger.info("[서비스]회원탈퇴 이름 = {}",member.getName());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.delete(member);
	}
   
/*===== executeQuery =====*/	
	@Override
	public MemberDto memberDetail(Command command) {
		logger.info("[서비스]회원검색 아이디 = {}",command.getSearchVal());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.getElementById(command);
	}
	@Override
	public List<MemberDto> searchByKeyword(Command command) {
		logger.info("[서비스]회원검색 키워드 = {}",command.getSearchVal());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.getElementsByName(command);
	}
	
	@Override
	public MemberDto login(Command command) {
		logger.info("[서비스]로그인 아이디 = {}",command.getSearchKey());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.login(command);
	}
    @Override
    public List<MemberDto> memberList(Command command) {
    	logger.info("[서비스]회원 목록 페이지 번호 = {}",command.getPageNo());
    	MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
        return  memberMapper.list(command);
    }
	@Override
	public int memberCountAll() {
		logger.info("[서비스]전체 회원수 지나는 중...");
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.countAll();
	}
	
	@Override
	public int memberCountSome(Command command) {
		logger.info("[서비스]특정 회원수 = {}",command.getSearchVal());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.countSome(command);
	}
}
