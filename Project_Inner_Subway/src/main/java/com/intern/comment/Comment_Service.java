package com.intern.comment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.intern.dao.CommentDAO;


@Service
public class Comment_Service implements Comment_If{

	@Autowired
	 CommentDAO dao;
	
	
	@Override
	public List<CommentVO> getCommentList(Map map) {
		// TODO Auto-generated method stub
		return dao.getCommentList(map);
	}

	@Override
	public void insertComment(CommentVO vo) {
		// TODO Auto-generated method stub
	     dao.insertComment(vo);
	}

	@Override
	public void deleteComment(Map map) {
		// TODO Auto-generated method stub
		dao.deleteComment(map);
	}

	
	
}
