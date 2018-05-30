package com.intern.board;

import java.util.List;

public interface Board_If {

	List<BoardVO> getBoardList(String scode);
	int getEntryCount();
	void insertBoard(BoardVO vo); 
	BoardVO getBoardOne(int entry_num);
	
}
