package com.intern.comment;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.CommentDAO;
import com.intern.globalexceptionhandler.NoAuthException;

@Service
public class CommentService implements Comment {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	CommentDAO dao;

	@Override
	public List<CommentVO> getCommentList(CommentVO requestComment) {
		log.info("Processing : select comment from DB");
		return dao.getCommentList(requestComment);
	}

	@Override
	public int registerComment(CommentVO requestComment) {

		String content = requestComment.getContent();
		String replaceContent = content.replaceAll("\n", "<br>");
		requestComment.setContent(replaceContent);

		log.info("Processing : insert comment in DB");

		return dao.registerComment(requestComment);
	}

	@Override
	public int removeComment(CommentVO requestComment, String id) throws NoAuthException {

		int resultValue;

		if (requestComment.getWriter().equals(id)) {
			log.info("Processing : writer accordance");
			log.info("Processing : delete comment in DB");

			resultValue = dao.removeComment(requestComment);
		} else {
			throw new NoAuthException("Error occurred : Discordance writer(CommentService.java:43)");
		}

		return resultValue;
	}

	@Override
	public CommentVO getCommentOne(CommentVO requestComment, String id) throws NoAuthException {

		CommentVO cvo = new CommentVO();

		if (requestComment.getWriter().equals(id)) {
			log.info("Processing : writer accordance");
			log.info("Processing : select comment from DB");
			cvo = dao.getCommentOne(requestComment);

		} else {

			throw new NoAuthException("Error occurred : Discordance writer(CommentService.java:61)");

		}

		return cvo;
	}

	@Override
	public int modifyComment(CommentVO requestComment) {

		log.info("Processing : update comment in DB");
		return dao.modifyComment(requestComment);
	}

}
