package com.intern.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.board.BoardVO;

@Component
public class BoardDAO {

	@Autowired
	SqlSession session;
	
	public List<BoardVO> getBoardList(Map<String, Object> map){
	  return session.selectList("board.getBoardList",map);
	}
	
	public int getEntryCount(){
		return session.selectOne("board.getEntryCount");
	}
	
	public void insertBoard(BoardVO vo){
		session.insert("board.insertBoard",vo);
	}
	
	public BoardVO getBoardOne(HashMap map){
		return session.selectOne("board.getBoardOne",map);
	}
	public void updateViewcount(Map map){
		session.update("board.updateViewcount",map);
	}
	
	public void deleteBoard(Map<String, Object> map){
		session.delete("board.deleteBoard",map);
	}
	
	public void updateBoard(BoardVO vo){
		session.update("board.updateBoard",vo);
	}
	
	public List<BoardVO> getSearchBoard(Map<String,Object> map){
		return session.selectList("board.getSearchBoard", map);
	}
}
