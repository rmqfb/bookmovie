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

import com.bookmovie.domain.MemberDto;
import com.bookmovie.domain.ThRsvDto;
import com.bookmovie.domain.TheaterDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.serviceImpl.ThRsvServiceImpl;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/thRsv")
public class ThRsvController {
	private static final Logger logger = LoggerFactory.getLogger(ThRsvController.class);
	@Autowired private ThRsvServiceImpl service;
	@Autowired ThRsvDto dto;

	// no execute
	@RequestMapping("/main")
	public String main(@ModelAttribute("user")MemberDto user,
			Model model){
		logger.info("[컨트롤러] 예약 메인페이지 ");
        model.addAttribute("member",user);
		return "threservation/thReservation.tiles";
	}

	// executeUpdate 
	@RequestMapping(value="/result/{thCode}/{thTime}", method=RequestMethod.POST)
	public String result(@ModelAttribute ThRsvDto dto,
			@ModelAttribute("user")MemberDto user,
			@PathVariable("thTime")String thTime,
			@RequestParam("data1")String data){
		logger.info("result 들어옴");
		dto.setId(user.getUserId());
		dto.setThCode(data);
		dto.setThTime(thTime);
		int result = service.thRsv(dto);
		logger.info("[컨트롤러] 결과={}", result);
		return "threservation/thReservation.tiles";
	}
	
	@RequestMapping(value="/del", method=RequestMethod.POST)
	public String del(
			@RequestParam("thRsvNo") int[] checkbox,
			@ModelAttribute("user")MemberDto user,
			Model model){
		logger.info("[컨트롤러] 체크된 개수 = {}", checkbox.length);
		
		List<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < checkbox.length; i++) {
			list.add(checkbox[i]);
		}
		logger.info("list 결과: {}", list);
		int result = service.delete(list);
		logger.info("[컨트롤러] 삭제 성공 개수 = {}", result);
	    model.addAttribute("member", user);
		
		return "threservation/thReservation.tiles";
	}

	// executeQuery
	@RequestMapping(value="/my-thrsv-list/{pageNo}")
	public @ResponseBody Map<String, Object> myThrsvList(@ModelAttribute ThRsvDto dto,
			@PathVariable("pageNo")int pageNo,
			@ModelAttribute("user") MemberDto user){
		
		logger.info("[컨트롤러] 결과 페이지 아이디={}", user.getUserId());
		Map<String,Object>map =  new HashMap<String,Object>();
		List<ThRsvDto> list = new ArrayList<ThRsvDto>();
		int size = service.size(CommandFactory.size(user.getUserId()));
		logger.info("리스트 pageNo: "+pageNo);
		logger.info("리스트 size: "+size);
		list = service.list(CommandFactory.list(pageNo, user.getUserId()));
		
		map.put("list", list);
		map.put("currentPage", pageNo);
		map.put("size", size);

		return map;
	}
	
	@RequestMapping(value="/my-get-thrsv-list")
	public @ResponseBody List<ThRsvDto> myGetThRsvList(@ModelAttribute("user") MemberDto user){
		
		logger.info("[컨트롤러] 결과 페이지 아이디={}", user.getUserId());

		String searchKey = "user_id";
		String searchVal = user.getUserId();
		logger.info("리스트 값 :"+service.list(CommandFactory.search(searchKey, searchVal)).toString());
		return service.list(CommandFactory.search(searchKey, searchVal));
	}

}