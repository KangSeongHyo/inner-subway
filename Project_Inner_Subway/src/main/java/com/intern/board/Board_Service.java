package com.intern.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.BoardDAO;

@Service
public class Board_Service implements Board_If {

	@Autowired
	BoardDAO dao;

	@Override
	public List<BoardVO> getBoardList(String scode) {
		// TODO Auto-generated method stub
		return dao.getBoardList(scode);
	}

}
