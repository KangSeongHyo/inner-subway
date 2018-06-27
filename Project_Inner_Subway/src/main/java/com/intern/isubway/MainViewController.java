package com.intern.isubway;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

@Controller
public class MainViewController {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value="/main",method=RequestMethod.GET)
	public ModelAndView main_page(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("id") == null) {
			RedirectView redirectView = new RedirectView();
			redirectView.setUrl("/isubway");
			redirectView.setExposeModelAttributes(false);
			
			mv.setViewName("redirect:/");
			log.info("Result : request Fail, Return redirect login view page ");
		} else {
			mv.setViewName("main");
			log.info("Result : request Ok, Return main view page ");
		}
		return mv;
	}

}
