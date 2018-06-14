package com.intern.board;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.intern.station.StationVO;

public interface Board {

	List<BoardVO> getBoardList(StationVO requestStation,int page);

	Map<String, Integer> getPage(int page, StationVO requestStation);

	int getEntryCount(StationVO requestStation);

	/**
	 * 게시물 등록
	 * @param vo 등록할 게시물 정보
	 * @param file 첨부파일(사진)
	 * @return 1(성공),0(오류)
	 */
	int boardRegister(BoardVO requestBoard, MultipartFile file);

	/**
	 * 게시물 삭제
	 * @param requestBoard 삭제할 게시물 정보
	 * @param id 로그인 된 아이디
	 * @return 1(성공),0(오류),-1(작성자아님)
	 */
	int romoveBoard(BoardVO requestBoard, String id);

	/**
	 * 게시물 수정
	 * @param requestBoard 수정 게시물 정보
	 * @param file 변경파일
	 * @param id 로그인 된 아이디
	 * @return 1(성공),0(오류),-1(작성자아님)
	 */

	int modifyBoard(BoardVO requestBoard, MultipartFile file);

	/**
	 * 해당 게시물 정보 불러오기 
	 * @param requestBoard 요청 board
	 * @param 로그인 된 아이디
	 * @return 요청 게시물 정보
	 */
	BoardVO getBoardOne(BoardVO requestBoard, String id);

	List<BoardVO> removeHtml(List<BoardVO> boardList);

	/*
	
	void updateViewcount(Map map);
	
	
	void updateBoard(BoardVO vo);
	
	List<BoardVO> getSearchBoard(Map<String, Object> map);
	 */

}
