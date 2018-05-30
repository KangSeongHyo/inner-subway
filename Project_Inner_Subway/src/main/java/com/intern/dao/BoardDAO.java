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
	
	public int getEntryCount(){
		return session.selectOne("board.getEntryCount");
	}
	
	public void insertBoard(BoardVO vo){
		session.insert("insertBoard",vo);
	}
	
	public BoardVO getBoardOne(int entry_num){
		return session.selectOne("getBoardOne",entry_num);
	}
}
