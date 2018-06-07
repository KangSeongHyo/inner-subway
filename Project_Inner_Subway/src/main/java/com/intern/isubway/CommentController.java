package com.intern.isubway;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.intern.comment.CommentVO;
import com.intern.comment.Comment_Service;

@Controller
public class CommentController {
	
	@Autowired
	Comment_Service service;
	
	
	//////댓글 등록
	@RequestMapping("/comment/insert")
	@ResponseBody
	public List<CommentVO> insertComment(String scode,int entry_num,String content,HttpSession session){

		String writer=(String)session.getAttribute("id");
		CommentVO vo=new CommentVO(scode,entry_num,0,content, writer, new Date(0));
		service.insertComment(vo);
		
		 Map map=new HashMap();
	      map.put("scode", vo.getScode());
	      map.put("entry_num",vo.getEntry_num());
		
		return service.getCommentList(map);
		
	}
	
	////////////댓글삭제
	@RequestMapping("/comment/del")
	@ResponseBody
	public List<CommentVO> deleteComment(String scode,int entry_num, int comment_seq,String writer,HttpSession session){
	
		String id=(String)session.getAttribute("id");
		if(!id.equals(writer)){
			return null;
		}
		
		Map map=new HashMap();
		map.put("scode", scode);
		map.put("entry_num", entry_num);
		map.put("comment_seq", comment_seq);
		
		service.deleteComment(map);
		return service.getCommentList(map);
	}
}
