package com.intern.isubway;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.intern.login.MemberInfoVO;
import com.intern.login.MemberInfo_Service;

@Controller
public class LoginController {

	@Autowired
	MemberInfo_Service mservice;
	@Autowired
	BCryptPasswordEncoder encoder;

	@RequestMapping("/")
	public String loginform() {
		return "login/loginform";
		}

	@RequestMapping("login/join")
	public void join() {}

	@RequestMapping("login/addrpopup")
	public void addrpopup() {

	}

	@RequestMapping("login/test")
	public ModelAndView test() {

		ModelAndView mv = new ModelAndView();
		mv.addObject("list", mservice.getMemberList());
		return mv;
	}
	
	@RequestMapping(value="login/bcrypt", method=RequestMethod.POST)
	public String bcrypt(MemberInfoVO vo) {
		String pw=encoder.encode(vo.getPw());
		String name=encoder.encode(vo.getName());
		String address=encoder.encode(vo.getName());
		
		mservice.insertMember(new MemberInfoVO(vo.getId(), pw, name,vo.getGender(), address));		
		return "redirect:/";
	}
	
	@RequestMapping(value="login/loginck", method=RequestMethod.POST)
	public String loginCheck(String id,String pw,HttpSession session) {
		List<MemberInfoVO> list=mservice.getMemberList();
		for(MemberInfoVO vo:list){
		 if(vo.getId().equals(id)&&encoder.matches(pw, vo.getPw())){
			 session.setAttribute("id", vo.getId());
			 return "redirect:/main/line"; 
		 }
		}
		return "login/loginfail";
	}
	
	
	

}
