package com.intern.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.board.BoardVO;
import com.intern.station.StationVO;

@Component
public class BoardDAO {

	@Autowired
	SqlSession session;

	public List<BoardVO> getBoardList(StationVO requestStation) {
		return session.selectList("board.getBoardList", requestStation);
	}

	public int getEntryCount() {
		return session.selectOne("board.getEntryCount");
	}

	public int boardRegister(BoardVO vo) {
		return session.insert("board.insertBoard", vo);
	}
	
	public int removeBoard(BoardVO vo) {
		return session.delete("board.deleteBoard", vo);
	}


	/*public BoardVO getBoardOne(HashMap map) {
		return session.selectOne("board.getBoardOne", map);
	}

	public void updateViewcount(Map map) {
		session.update("board.updateViewcount", map);
	}

	
	public void updateBoard(BoardVO vo) {
		session.update("board.updateBoard", vo);
	}

	public List<BoardVO> getSearchBoard(Map<String, Object> map) {
		return session.selectList("board.getSearchBoard", map);
	}*/
}
