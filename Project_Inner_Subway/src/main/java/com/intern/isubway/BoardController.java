package com.intern.isubway;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.intern.board.BoardVO;
import com.intern.board.Board_Service;

@Controller
public class BoardController {

	@Autowired
	Board_Service service;
	
	@RequestMapping("/board/external")
	public ModelAndView externalBoard(String scode){
		
		List<BoardVO> list=service.getBoardList(scode);
		ModelAndView mv =new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("board/external_board");
		return mv;
	}
	
}
