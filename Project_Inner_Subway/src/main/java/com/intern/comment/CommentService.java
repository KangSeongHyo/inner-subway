package com.intern.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.CommentDAO;
import com.intern.globalexceptionhandler.NoAuthException;

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
	public int removeComment(CommentVO requestComment, String id) throws NoAuthException {

		int resultValue;

		if (requestComment.getWriter().equals(id)) {
			resultValue = dao.removeComment(requestComment);
		} else {
			throw new NoAuthException("Error occurred : Discordance writer");
		}

		return resultValue;
	}

	@Override
	public CommentVO getCommentOne(CommentVO requestComment, String id) throws NoAuthException {

		CommentVO cvo = new CommentVO();

		if (requestComment.getWriter().equals(id)) {

			cvo = dao.getCommentOne(requestComment);

		} else {

			throw new NoAuthException("Error occurred : Discordance writer");

		}

		return cvo;
	}

	@Override
	public int modifyComment(CommentVO requestComment) {

		return dao.modifyComment(requestComment);
	}

}
