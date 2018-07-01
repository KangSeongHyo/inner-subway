package com.intern.isubway;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginViewController {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView loginform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/form");
		log.info("Result : request Ok, Return loginForm view page ");
		return mv;
	}

	@RequestMapping(value = "login/join", method = RequestMethod.GET)
	public ModelAndView join() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/join");
		log.info("Result : request Ok, Return join view page ");
		return mv;
	}

	@RequestMapping(value = "login/addrpopup")
	public ModelAndView addrpopup() {
		ModelAndView mv = new ModelAndView();
		log.info("Result : request Ok, Return addrpopup view page ");
		mv.setViewName("login/addrpopup");
		return mv;
	}

}
