package com.intern.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.intern.station.StationVO;

public interface Board {

	List<BoardVO> getBoardList(StationVO requestStation);

	int getEntryCount();

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
	 * @return 1(성공),0(오류),-1(작성자아님)
	 */
	int romoveBoard(BoardVO requestBoard, String id);

	/*BoardVO getBoardOne(HashMap map);

	void updateViewcount(Map map);


	void updateBoard(BoardVO vo);

	List<BoardVO> getSearchBoard(Map<String, Object> map);
*/
	List<BoardVO> removeHtml(List<BoardVO> boardList);

	Map<String, Integer> getPage(int page);
}
