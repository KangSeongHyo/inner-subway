package com.intern.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.comment.CommentVO;

@Component
public class CommentDAO {

	@Autowired
	SqlSession session;
	
	public List<CommentVO> getCommentList(Map map){
		return session.selectList("comment.getCommentList",map);
	}
	
	public void insertComment(CommentVO vo){
		session.insert("comment.insertComment",vo);
	}
	public void deleteComment(Map<String, Object> map){
		session.delete("comment.deleteComment", map);
	}
	
	
}
