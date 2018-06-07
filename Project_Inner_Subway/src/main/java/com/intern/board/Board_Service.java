package com.intern.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.BoardDAO;

@Service
public class Board_Service implements Board_If {

	@Autowired
	BoardDAO dao;

	@Override
	public List<BoardVO> getBoardList(Map<String, Object> map) {
		return dao.getBoardList(map);
	}

	@Override
	public int getEntryCount() {
		return dao.getEntryCount();
	}

	@Override
	public void insertBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}

	@Override
	public BoardVO getBoardOne(HashMap map) {
		return dao.getBoardOne(map);
	}

	@Override
	public void updateViewcount(Map map) {
		// TODO Auto-generated method stub
		dao.updateViewcount(map);
	}

	@Override
	public void deleteBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		dao.deleteBoard(map);
	}

	@Override
	public void updateBoard(BoardVO vo) {
		// TODO Auto-generated method stub
	     dao.updateBoard(vo);
	}

	@Override
	public List<BoardVO> getSearchBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.getSearchBoard(map);
	}

}
