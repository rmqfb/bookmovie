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
import com.bookmovie.domain.ReservationDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.serviceImpl.MemberServiceImpl;
import com.bookmovie.serviceImpl.ReservationServiceImpl;

@Controller
@SessionAttributes("user")
@RequestMapping(value="/res")
public class ReservationController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	@Autowired private ReservationServiceImpl service;
	@Autowired private MemberServiceImpl memberService;
	@Autowired ReservationDto dto;

	// no execute
	@RequestMapping("/main")
	public String main(@ModelAttribute("user")MemberDto user,
			Model model){
		logger.info("[컨트롤러] 예약 메인페이지 ");
        model.addAttribute("member", user);
		return "reservation/reservation.tiles";
	}

	// executeUpdate 
	@RequestMapping(value="/result", method=RequestMethod.POST)
	public void result(@ModelAttribute ReservationDto dto,
			@ModelAttribute("user")MemberDto user,
			@RequestParam("data1")String data){
		dto.setId(user.getUserId());
		dto.setSerialNo(data);

		int result = service.reserve(dto);
		logger.info("[컨트롤러] 결과={}", result);
		
	}
	
	@RequestMapping(value="/del", method=RequestMethod.POST)
	public String del(
			@RequestParam("resNo") int[] checkbox){
		logger.info("[컨트롤러] 체크된 개수 = {}", checkbox.length);
		
		List<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < checkbox.length; i++) {
			list.add(checkbox[i]);
		}
		int result = service.delete(list);
		logger.info("[컨트롤러] 삭제 성공 개수 = {}", result);
		
		return "reservation/reservation.tiles";
	}

	// executeQuery
		@RequestMapping("/my-res-list/{pageNo}")
		public @ResponseBody  Map<String,Object>  myResList(@ModelAttribute ReservationDto dto,
				@PathVariable("pageNo")int pageNo,
				@ModelAttribute("user") MemberDto user){
			
			logger.info("[컨트롤러] 결과 페이지 아이디={}", user.getUserId());
			Map<String,Object>map = new HashMap<String,Object>();
			List<ReservationDto> list = new ArrayList<ReservationDto>();
			int size = service.size(CommandFactory.size(user.getUserId()));
			
			/*logger.info("리스트 값 :={}",service.list(CommandFactory.list(pageNo)));
			logger.info("리스트 값 :={}",pageNo);
			logger.info("리스트 값 :={}",size);*/
			
			list = service.list(CommandFactory.list(pageNo, user.getUserId()));
			logger.info("리스트 값 아이디={} :",user.getUserId());
			
			/*return service.list(CommandFactory.search(searchKey, searchVal));*/
			map.put("list", list);
			map.put("currentPage", pageNo);
			map.put("size", size);
			
			
			
			return map;
		}
	
	@RequestMapping(value="/my-get-res-list")
	public @ResponseBody List<ReservationDto> myGetResList(@ModelAttribute("user") MemberDto user){
		
		logger.info("[컨트롤러] 결과 페이지 아이디={}", dto.getId());

		String searchKey = "user_id";
		String searchVal = user.getUserId();
		System.out.println("리스트 값 :"+service.list(CommandFactory.search(searchKey, searchVal)).toString());
		return service.list(CommandFactory.search(searchKey, searchVal));
	}
}