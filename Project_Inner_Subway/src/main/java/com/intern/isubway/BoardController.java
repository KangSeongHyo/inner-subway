package com.intern.isubway;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.intern.board.BoardVO;
import com.intern.board.Board_Service;

@Controller
public class BoardController {

	@Autowired
	Board_Service service;

	@RequestMapping("/board/external")
	public ModelAndView externalBoard(String scode, HttpSession session) {

		List<BoardVO> list = service.getBoardList(scode);
		session.setAttribute("scode", scode);
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("board/external_board");
		return mv;
	}

	@RequestMapping("/board/write")
	public void write() {}

	@RequestMapping("/board/write_result")
	public String write_result(MultipartFile file, HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		 // file 업로드
		 String real_name=file.getOriginalFilename();
	     String ext=real_name.substring(real_name.lastIndexOf("."));// 확장자 추출
	     String uuid=UUID.randomUUID().toString().replaceAll("-", "");//-제거  
	     String unique_name=uuid+ext; //유니크한 이름 생성 
	     String img_path="C:/new/"+unique_name;
         File newfile=new File(img_path);
		 file.transferTo(newfile);
		 
		 String writer=(String)session.getAttribute("id");
		 String scode=(String)session.getAttribute("scode");
		 
		 String head=request.getParameter("head");
		 String title=request.getParameter("title");
		 String content=request.getParameter("content");
		 int entry_num=service.getEntryCount()+1;
		 
		BoardVO vo=new BoardVO(scode, entry_num, head, title, writer, new Date(0), 0, content, img_path);
		service.insertBoard(vo);
		
		return "redirect:/board/external?scode="+scode;
	}
	
	@RequestMapping("/board/inner_board")
	public ModelAndView inner_board(int entry_num){
         BoardVO vo=service.getBoardOne(entry_num);
         
		ModelAndView mv=new ModelAndView();
		mv.addObject("vo",vo);
		return mv;
	}
	
	
}
