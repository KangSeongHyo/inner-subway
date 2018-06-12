package com.intern.comment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.intern.dao.CommentDAO;

@Service
public class CommentService implements Comment {

	@Autowired
	CommentDAO dao;

	@Override
	public List<CommentVO> getCommentList(CommentVO requestComment) {

		return dao.getCommentList(requestComment);
	}

	@Override
	public int registerComment(CommentVO requestComment) {

		return dao.registerComment(requestComment);
	}

	@Override
	public void deleteComment(Map map) {
		// TODO Auto-generated method stub
		dao.deleteComment(map);
	}

}
