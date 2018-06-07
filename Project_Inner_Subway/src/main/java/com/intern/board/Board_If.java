package com.intern.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface Board_If {

	List<BoardVO> getBoardList(Map<String, Object> map);
	int getEntryCount();
	void insertBoard(BoardVO vo); 
	BoardVO getBoardOne(HashMap map);
	void updateViewcount(Map map);
	void deleteBoard(Map<String, Object> map);
	void updateBoard(BoardVO vo);
	List<BoardVO> getSearchBoard(Map<String,Object> map);
	
}
