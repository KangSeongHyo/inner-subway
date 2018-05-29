package com.intern.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.board.BoardVO;

@Component
public class BoardDAO {

	@Autowired
	SqlSession session;
	
	public List<BoardVO> getBoardList(String scode){
	  return session.selectList("board.getBoardList",scode);
	}

	
	
}
