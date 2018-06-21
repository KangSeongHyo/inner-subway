package com.intern.isubway;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class LoginViewController {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping("/")
	public ModelAndView loginform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/form");
		log.info("Result : request Ok, Return loginForm view page ");
		return mv;
	}

	@RequestMapping("login/join")
	public ModelAndView join() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/join");
		log.info("Result : request Ok, Return join view page ");
		return mv;
	}

	@RequestMapping("login/addrpopup")
	public ModelAndView addrpopup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/addrpopup");
		log.info("Result : request Ok, Return addrpopup view page ");
		return mv;

	}

}
