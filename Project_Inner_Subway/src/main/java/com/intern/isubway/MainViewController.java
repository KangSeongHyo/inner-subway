package com.intern.isubway;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.intern.station.StationService;
import com.intern.station.StationVO;

@Controller
public class MainViewController {

	@RequestMapping("/main")
	public ModelAndView main_page(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("id") == null) {
			mv.setViewName("redirect:/");
		} else {
			mv.setViewName("main");
		}
		return mv;
	}

}
