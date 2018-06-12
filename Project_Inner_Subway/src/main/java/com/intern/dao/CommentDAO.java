package com.intern.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import com.intern.comment.CommentVO;

@Component
public class CommentDAO {

	@Autowired
	SqlSession session;

	public List<CommentVO> getCommentList(CommentVO vo) {
		return session.selectList("comment.getCommentList", vo);
	}

	public int registerComment(CommentVO vo) {
		return session.insert("comment.insertComment", vo);
	}

	public int removeComment(CommentVO vo) {
		return session.delete("comment.deleteComment", vo);
	}

}
