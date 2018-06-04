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
	public List<BoardVO> getBoardList(String scode) {
		return dao.getBoardList(scode);
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

}
