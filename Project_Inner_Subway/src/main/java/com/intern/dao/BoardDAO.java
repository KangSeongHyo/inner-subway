package com.intern.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.board.BoardVO;
import com.intern.station.StationVO;
import com.mysql.cj.api.result.Row;

@Component
public class BoardDAO {

	@Autowired
	SqlSession session;

	public List<BoardVO> getBoardList(StationVO vo, int startBoard) {
		int limit = 4;
		RowBounds rowbound = new RowBounds(startBoard, limit);

		return session.selectList("board.getBoardList", vo, rowbound);
	}

	public int getEntryCount(StationVO vo) {
		return session.selectOne("board.getEntryCount", vo);
	}

	public int boardRegister(BoardVO vo) {
		return session.insert("board.insertBoard", vo);
	}

	public int removeBoard(BoardVO vo) {
		return session.delete("board.deleteBoard", vo);
	}

	public int modifyBoard(BoardVO vo) {
		return session.update("board.updateBoard", vo);
	}

	public BoardVO getBoardOne(BoardVO vo) {
		return session.selectOne("board.getBoardOne", vo);
	}

	public int increaseViewcount(BoardVO vo) {
		return session.update("board.updateViewcount", vo);
	}

	public List<BoardVO> getSearchBoard(Map<String, Object> map, int startBoard) {
		int limit = 4;
		RowBounds rowBounds = new RowBounds(startBoard, limit);
		return session.selectList("board.getSearchBoard", map, rowBounds);
	}

	public int getSearchBoardCount(Map<String, Object> map) {
		return session.selectOne("board.getSearchBoardCount", map);
	}

}
