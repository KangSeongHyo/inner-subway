package com.intern.isubway;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.intern.login.MemberService;

@Controller
public class LoginViewController {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping("/")
	public ModelAndView loginform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/form");
		return mv;
	}

	@RequestMapping("login/join")
	public ModelAndView join() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/join");
		return mv;
	}

	@RequestMapping("login/addrpopup")
	public ModelAndView addrpopup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/addrpopup");
		return mv;

	}

}
