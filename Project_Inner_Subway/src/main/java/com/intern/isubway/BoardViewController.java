package com.intern.isubway;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.intern.board.BoardVO;
import com.intern.board.BoardService;
import com.intern.station.StationService;
import com.intern.station.StationVO;

@Controller
@SessionAttributes({"sname", "scode", "line"})
@RequestMapping("/board")
public class BoardViewController {

	@Autowired
	BoardService boardService;
	@Autowired
	StationService stationService;

	Logger log = Logger.getLogger(this.getClass());

	//외부게시판 뷰
	@RequestMapping(value = "/external", method = RequestMethod.GET)
	public ModelAndView externalBoard(@RequestParam(value = "page", defaultValue = "1") int page,
		@ModelAttribute StationVO requestStation, Model model, HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if (session.getAttribute("id") == null) {

			RedirectView redirectView = new RedirectView();
			redirectView.setUrl("/isubway");
			redirectView.setExposeModelAttributes(false);

			mv.setView(redirectView);
			log.info("Result : request Fail, Return redirect login view page ");

		} else {

			requestStation.setId((String)session.getAttribute("id"));

			List<BoardVO> boardList = boardService.getBoardList(requestStation, page);

			boardList = boardService.removeHtml(boardList);

			List<StationVO> stationList = stationService
				.getStations(requestStation.getLine());

			mv.addObject("boardList", boardList);
			mv.addObject("stationList", stationList);

			mv.addObject("pageMap", boardService.getPage(page, requestStation));

			model.addAttribute("sname", requestStation.getSname());
			model.addAttribute("scode", requestStation.getScode());
			model.addAttribute("line", requestStation.getLine());

			log.info("Result : request Ok,Return external view page");

			mv.setViewName("board/external");
		}

		return mv;

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		session.invalidate();

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl("/isubway");
		redirectView.setExposeModelAttributes(false);

		mv.setView(redirectView);

		log.info("Result : logout Ok, session expired");
		return mv;
	}

}
