package com.intern.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface Board_If {

	List<BoardVO> getBoardList(String scode);
	int getEntryCount();
	void insertBoard(BoardVO vo); 
	BoardVO getBoardOne(HashMap map);
	void updateViewcount(Map map);
	
}
