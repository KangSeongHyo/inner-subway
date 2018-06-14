package com.intern.comment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.check.Check;
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
	public int removeComment(CommentVO requestComment, String id) {

		int check;

		if (requestComment.getWriter().equals(id)) {
			check = dao.removeComment(requestComment);
		} else {
			check = Check.NOAUTH;
		}

		return check;
	}

	@Override
	public CommentVO getCommentOne(CommentVO requestComment, String id) {

		CommentVO cvo = new CommentVO();

		if (requestComment.getWriter().equals(id)) {
			cvo = dao.getCommentOne(requestComment);
		} else {
			cvo.setWriter("NOAUTH");
		}

		return cvo;
	}

	@Override
	public int modifyComment(CommentVO requestComment) {

		return dao.modifyComment(requestComment);
	}

}
