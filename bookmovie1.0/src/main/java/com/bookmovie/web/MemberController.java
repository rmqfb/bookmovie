package com.bookmovie.web;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.bookmovie.domain.MemberDto;
import com.bookmovie.factory.CommandFactory;
import com.bookmovie.serviceImpl.MemberServiceImpl;


@Controller
@SessionAttributes("user")
@RequestMapping(value="/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired MemberServiceImpl memberService;
	@Autowired MemberDto member;
		
	/**********************************************
	 * no execute
	 **********************************************/
	
	
	@RequestMapping(value="/agree")
	public String agree(){
		logger.info("회원 가입동의 창으로 이동..");
		return "homes/nulls/memberAgree.tiles";
	}
	
	@RequestMapping(value="/agree2")/*이건 머지?*/
	public String agree2(){
		logger.info("회원가입 창으로 이동..");
		return "homes/nulls/memberJoin.tiles";
	}
	
	@RequestMapping(value="/myMovie")
	public String myPage(@ModelAttribute("user") MemberDto user, Model model){
		logger.info("마이페이지로 이동..");
		model.addAttribute("member", user);
		return "member/myPage.tiles";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(@ModelAttribute("user") MemberDto user, Model model) {
		logger.info("========= 수정페이지 이동 ========");
		logger.info("회원성별={}", member.getGender());
		model.addAttribute("member", user);
		model.addAttribute("member", member);
		return "member/memberUpdate.tiles";
	}
	
	
	/**********************************************
	 * executeUpdate
	 **********************************************/
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute MemberDto member, ModelMap model) {
		logger.info("회원가입 아이디={}", member.getUserId());
		int joinOk = memberService.joinMember(member);
		logger.info("회원가입 성공여부={}", joinOk);
		return "homes/nulls/login.tiles";
	}
	
	@RequestMapping(value="/updateEnd", method=RequestMethod.POST)
	public String update(@ModelAttribute("user") MemberDto user, SessionStatus status, 
						@RequestParam(value="email", required=false) String email, 
						@RequestParam(value="userPw") String userPw,
						@RequestParam(value="birthday") String birthday,
						@RequestParam(value="birthdayRadio") String birthdayRadio,
						@RequestParam(value="phone") String phone,
						Model model) {
		user.setEmail(email);
		user.setUserPw(userPw);
		user.setBirthday(birthday);
		user.setBirthdayRadio(birthdayRadio);
		user.setPhone(phone);
		model.addAttribute("member", user);
		int result = memberService.updateMember(member);
		logger.info("수정 후 결과보기={}", result);
		model.addAttribute("user", member);	
		model.addAttribute("member", member);
		return "member/memberUpdate.tiles";
	}
	
	@RequestMapping(value="/del")
	public String delete(@ModelAttribute("user") MemberDto user, SessionStatus status, Model model) {
		logger.info("회원탈퇴아이디={}", member.getUserId());
		int delOk = memberService.deleteMember(member);
		model.addAttribute("user", member);	
		model.addAttribute("member", member);
		logger.info("회원탈퇴 성공여부={}", delOk);
		status.setComplete();
		return "homes/nulls/homeMain.tiles";
	}
	
	
	/**********************************************
	 * executeQuery
	 **********************************************/
		
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam("userId")String userid, 
			            @RequestParam("userPw")String userpw, Model model){
		logger.info("[로그인] : id = {}, pass = {} ", userid, userpw);
		String searchKey = "user_id", searchVal = userid;
		
		member = memberService.memberDetail(CommandFactory.search(searchKey, searchVal));
		if (member != null) {
			if (userpw.equals(member.getUserPw())) {
				logger.info("========= 로그인 성공 ========");
				logger.info("member - id = {}, name = {}", member.getUserId(), member.getName());
				model.addAttribute("user", member);
				model.addAttribute("member", member);
				return "home/homeMain.tiles";
			} else {
				logger.info("========= 비밀번호가 일치하지 않습니다. ========");
				model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
				return "homes/nulls/homeMain.tiles";
			}
		} else {
			logger.info("========= 아이디가 존재하지 않습니다. ========");
			model.addAttribute("msg", "아이디가 존재하지 않습니다.");
			return "homes/nulls/homeMain.tiles";
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(@ModelAttribute("user") MemberDto user, SessionStatus status) {
		logger.info("========= 로그아웃 처리 ========");
		status.setComplete(); // 세션을 비우고 로그아웃 처리
		return "homes/nulls/homeMain.tiles";
	}
	

}