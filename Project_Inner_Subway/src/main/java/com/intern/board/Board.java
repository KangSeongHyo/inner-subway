package com.intern.board;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.intern.globalexceptionhandler.NoAuthException;
import com.intern.station.StationVO;

public interface Board {

	/**
	 * 총 게시물 개수 
	 * @param requestStation 요청 게시판
	 * @return 총 게시물 개수 
	 */
	int getEntryCount(StationVO requestStation);

	/**
	 * 페이징 처리 
	 * @param page
	 * @param requestStation 요청게시판
	 * @return 페이징 정보
	 */
	Map<String, Integer> getPage(int page, StationVO requestStation);

	/**
	 * 게시물 리스트
	 * @param requestStation 요청게시판
	 * @param page 
	 * @return 게시물 리스트
	 */
	List<BoardVO> getBoardList(StationVO requestStation, int page);

	/**
	 * 게시물 등록
	 * @param vo 등록할 게시물 정보
	 * @param file 첨부파일(사진)
	 * @return 1(성공),0(오류)
	 */
	int boardRegister(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException;

	/**
	 * 게시물 삭제
	 * @param requestBoard 삭제할 게시물 정보
	 * @param id 로그인 된 아이디
	 * @return 1(성공),0(오류),-1(작성자아님)
	 */
	int romoveBoard(BoardVO requestBoard, String id) throws NoAuthException;

	/**
	 * 게시물 수정
	 * @param requestBoard 수정 게시물 정보
	 * @param file 변경파일
	 * @param id 로그인 된 아이디
	 * @return 1(성공),0(오류),-1(작성자아님)
	 */

	int modifyBoard(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException;

	/**
	 * 해당 게시물 정보 불러오기 
	 * @param requestBoard 요청 board
	 * @param 로그인 된 아이디
	 * @return 요청 게시물 정보
	 * @throws Exception 
	 */
	BoardVO getBoardOne(BoardVO requestBoard, String id) throws NoAuthException, Exception;

	/**
	 * Html 제거
	 * @param boardList
	 * @return Html 제거(미리보기) 
	 */
	List<BoardVO> removeHtml(List<BoardVO> boardList);

	Map<String, Object> getSearchBoard(StationVO requestStation, String search, String id, int page)
		throws Exception;

	/**
	 * 게시물 추천
	 * @param requestBoard 추천된 게시물 정보
	 * @return 
	 * @throws Exception
	 */
	int recommendBoard(BoardVO requestBoard) throws Exception;

	/**
	 * 게시물 정렬
	 * @param requestStation
	 * @param target 정렬 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getSortBoardList(BoardVO requestStation, int page) throws Exception;
}
