package com.intern.isubway;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.intern.login.MemberVO;
import com.intern.login.MemberService;

@Controller
public class LoginViewController {

	@Autowired
	MemberService memberService;

	@Autowired
	BCryptPasswordEncoder encoder;

	@RequestMapping("/")
	public String loginform() {
		return "login/form";
	}

	@RequestMapping("login/join")
	public void join() {}

	@RequestMapping("login/addrpopup")
	public void addrpopup() {}
	/*
		@RequestMapping("login/test")
		public ModelAndView test() {
	
			ModelAndView mv = new ModelAndView();
			mv.addObject("list", memberService.getMemberList());
			return mv;
		}
	
		//////// 단방향 암호화처리
		@RequestMapping(value = "login/bcrypt", method = RequestMethod.POST)
		public String bcrypt(MemberVO vo) {
			vo.getId();
	
			String pw = encoder.encode(vo.getPw());
			String name = encoder.encode(vo.getName());
			String address = encoder.encode(vo.getName());
	
			memberService.insertMember(new MemberVO(vo.getId(), pw, name, vo.getGender(), address));
			return "redirect:/";
		}
	
		//////////// 로그인체크
		@RequestMapping(value = "login/loginck", method = RequestMethod.POST)
		public String loginCheck(String id, String pw, HttpSession session) {
			List<MemberVO> list = memberService.getMemberList();
			MemberVO m = new MemberVO();
			m.getId();
	
			for (MemberVO vo : list) {
				if (vo.getId().equals(id) && encoder.matches(pw, vo.getPw())) {
					session.setAttribute("id", vo.getId());
					return "redirect:/main/line";
				}
			}
			return "login/loginfail";
		}
	
		/////중복아이디체크
		@RequestMapping("/login/id_check")
		@ResponseBody
		public List<String> idCheck() {
			List<String> list = memberService.getIdList();
			return list;
		}
	*/
}
