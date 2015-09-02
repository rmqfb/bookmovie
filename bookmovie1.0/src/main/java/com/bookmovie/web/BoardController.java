package com.bookmovie.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;


import com.bookmovie.domain.BoardDto;
import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.serviceImpl.BoardServiceImpl;





@Controller
@SessionAttributes("user")
@RequestMapping("/board")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired BoardServiceImpl boardServiceImpl;
	@Autowired BoardDto board;
	
	@RequestMapping("/main")
	public String main(@ModelAttribute("user") MemberDto user
	           ,Model model){
		  model.addAttribute("member", user);
       logger.info("보드 메인페이지 유저={}",user);
    
    return "board/boardMain.tiles";
    }    
	
	
	//jsp 페이지를 이동하기위한 메소드
	@RequestMapping("/path/{path}")
	public String path(@PathVariable("path")String path,
			@ModelAttribute("user")MemberDto user,
			Model model){
		logger.info("패스 경로로 들어온것={}",path);
		logger.info("write-reviewform이동,들어온유저={}", user);
		model.addAttribute("member",user);
		
		return "board/"+path+".jsp";
	}
	
	//유저아이디에 의한 게시판 목록 보이게하는것!
	@RequestMapping("/search/{boardtype}/{pageNo}")
	public @ResponseBody Map<String,Object> search(
			@PathVariable("boardtype")String strbtype,
			@PathVariable("pageNo")String no){
		 List<BoardDto> list = new ArrayList<BoardDto>();
		 Map<String,Object>map = new HashMap<String,Object>();
		 int boardtype = Integer.parseInt(strbtype);   
		 int pageNo = Integer.parseInt(no);
		 
		 logger.info("페이지 넘버={}", no);
		 logger.info("들어온타입={}", strbtype);
		 
		 int size = boardServiceImpl.size(CommandFactory.size());
		 //list = boardServiceImpl.search(CommandFactory.search(pageNo, "userId", userId, boardtype));
	     list = boardServiceImpl.list(CommandFactory.list(pageNo, boardtype));
		
	        map.put("currentPage", pageNo);
			map.put("size", size);
			map.put("list", list);
	     
	    return map;
	}
	//글쓰기
	@RequestMapping(value="/write/review",method=RequestMethod.GET)
	public @ResponseBody List<BoardDto> write(
			@RequestParam("userId")String userId,
			@RequestParam("boardtype")String boardtype,
		    @RequestParam("bcate")String bcate,
		    @RequestParam("title")String title,
			@RequestParam("content")String content
		    ){
		List<BoardDto> list = new ArrayList<BoardDto>();
		
		int boardType = Integer.parseInt(boardtype);
		logger.info("글쓴이 아이디={}", userId);
		logger.info(" 장르={}",bcate);
		logger.info("게시판 유형={}", boardtype);
		logger.info("게시판 제목={}", title);
		
		String moviecode = "";
		
		board.setUserId(userId);
		board.setTheme(boardType);
		board.setCategory(bcate);
		board.setTitle(title);
		board.setBoardContent(content);
		board.setMoviecode(moviecode);
		
		int check = boardServiceImpl.insert(board);
		if(check == 1){
			list = boardServiceImpl.search(CommandFactory.search(1, "userId", board.getUserId(),boardType));
		}else{
			logger.info("글쓰기 실패");
		}
		
		
		return list;
	}
	// 보드 상세내용
	@RequestMapping("/detail/{boardNum}")
	public @ResponseBody BoardDto boarddetail(
		    @PathVariable("boardNum")String boardNum,
		    Model model){
	
		//logger.info("[board상세내용detail]user={}", userid);
		logger.info("[board상세내용detail]넘버={}", boardNum);
		int bNum = Integer.parseInt(boardNum);
		
		board = boardServiceImpl.detail(CommandFactory.detail("BRD_NO", boardNum, 1003));
		
		
		return board;
	}
	//보드 업데이트 부분
	@RequestMapping(value="/update/{boardNum}",method=RequestMethod.GET)
	public @ResponseBody BoardDto update(
			@PathVariable("boardNum")String boardNum,
			@ModelAttribute BoardDto board,
			Model model){
		logger.info("board 업데이트 부분");
		logger.info("borad 업데이트 보드넘버={}", boardNum);
		logger.info("board 업데이트 보드종류={}", board.getTheme());
		logger.info("board 업데이트 title={}", board.getTitle());
		logger.info("업데이트 장르={}", board.getCategory());
		logger.info("board 업데이트 부분 content={}",board.getBoardContent());
		
		//int bnum = Integer.parseInt(boardNum);
		//board.setTheme(1003);
		//board.setBoardNum(bnum);
		
		int ok = boardServiceImpl.update(board);
		if(ok ==1){
			board = boardServiceImpl.detail(CommandFactory.detail("BRD_NO",boardNum,1003));
		}else{
			board = null;
		}
		return board;
	}
	//보드 삭제 부분
	@RequestMapping("/remove")
	public @ResponseBody List<BoardDto> boardremove(
			@ModelAttribute BoardDto board){
		List<BoardDto> list = new ArrayList<BoardDto>();
		int ok = boardServiceImpl.delete(board);
		
		
		logger.info("보드 삭제 상황={}", ok);
       if(ok==1){
    	   //board = boardServiceImpl.search(CommandFactory.search(1, "userId", board.getUserId(),board.getBoardType()));
           list = boardServiceImpl.search(CommandFactory.search(1, "userId", board.getUserId(),1003));
       }else{
    	   list = null;
       }
	 //return "redirect:/board/search/"+board.getUserId()+"/1";		
	  return list;
	}
	// 보드 검색부분
	//'{root}/board/bsearch/'+ seletedOption + '/'+ word,
	@RequestMapping(value="/bsearch/{sel}/{word}/{pageNo}",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object>bsearch(
			   @PathVariable("sel")String sel,
			   @PathVariable("word")String word,
			   @PathVariable("pageNo")String pageNo){
		List<BoardDto> list = new ArrayList<BoardDto>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		String searchKey = sel;
		String searchVal = word;
		//String keyword = pageNo;
		int bpageNo = Integer.parseInt(pageNo);
	 logger.info("[자유게시판] 통합검색={},서치val={}", searchKey,searchVal);
	 logger.info("[자유게시판] 페이지넘={}", bpageNo);	
		//list = boardServiceImpl.boardsearch(CommandFactory.search(searchKey, searchVal));
	    list = boardServiceImpl.boardsearch(CommandFactory.search(bpageNo, searchKey, searchVal));
	    int size = boardServiceImpl.size(CommandFactory.size(sel, word));
	    map.put("currentPage", pageNo);
		map.put("size", size);
		map.put("list", list);
	    
	 
		return map;
	}
	
	
	
	
}
