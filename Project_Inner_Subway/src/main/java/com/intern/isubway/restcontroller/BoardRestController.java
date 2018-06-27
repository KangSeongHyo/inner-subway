package com.intern.isubway.restcontroller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.intern.board.BoardService;
import com.intern.board.BoardVO;
import com.intern.check.CheckValue;
import com.intern.globalexceptionhandler.NoAuthException;
import com.intern.station.StationVO;

@RestController
@RequestMapping("/board")
public class BoardRestController {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	BoardService boardService;

	/**
	 * 수정할 게시물 내용 불러오기
	 * @param requestBoard 요청 게시물
	 * @param session
	 * @return 게시물 정보
	 * @throws Exception(DB 오류,400) NoAuthException(작성자가 아닐경우,401 권한없음) 
	 */
	@RequestMapping(value = "/{scode}/{entryNum}/{writer}", method = RequestMethod.GET)
	public ResponseEntity<BoardVO> getBoardOne(@ModelAttribute BoardVO requestBoard, HttpSession session)
		throws Exception {

		ResponseEntity<BoardVO> responseEntity = null;

		BoardVO resultBoard = boardService.getBoardOne(requestBoard, (String)session.getAttribute("id"));

		if (resultBoard != null) {

			responseEntity = new ResponseEntity<BoardVO>(resultBoard, HttpStatus.OK);
			log.info("Result : board request OK, Retrun board");

		} else {

			throw new Exception("Error occurred : database select");

		}

		return responseEntity;
	}

	/**
	 * 상세보기를 위한 게시물 정보 불러오기
	 * @param requestBoard 요청 게시물정보
	 * @return 요청 게시물
	 * @throws Exception 
	 */
	@RequestMapping(value = "/{scode}/{entryNum}", method = RequestMethod.GET)
	public ResponseEntity<BoardVO> getBoardOne(@ModelAttribute BoardVO requestBoard) throws NoAuthException, Exception {

		ResponseEntity<BoardVO> responseEntity = null;

		BoardVO resultBoard = boardService.getBoardOne(requestBoard, "load");

		if (resultBoard != null) {

			responseEntity = new ResponseEntity<BoardVO>(resultBoard, HttpStatus.OK);
			log.info("Result : board request OK, Retrun board");

		} else {

			throw new Exception("Error occurred : database select");

		}

		return responseEntity;
	}

	/**
	 * 게시물 등록
	 * @param requestBoard 등록 게시물 정보
	 * @param file 사진
	 * @return SUCCESS
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerBoard(@ModelAttribute BoardVO requestBoard,
		MultipartFile file) throws IllegalStateException, IOException, Exception {

		ResponseEntity<Integer> responseEntity = null;

		int resultValue = boardService.boardRegister(requestBoard, file);

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : board register OK, Retrun SUCCESS");
		} else {

			throw new Exception("Error occurred : updating database");
		}
		return responseEntity;
	}

	/**
	 * 게시물 삭제
	 * @param requestBoard 삭제 요청게시물 정보
	 * @param session
	 * @return SUCCESS
	 * @throws NoAuthException 
	 */
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseEntity<Integer> removeBoard(@RequestBody BoardVO requestBoard, HttpSession session)
		throws NoAuthException, Exception {

		ResponseEntity<Integer> responseEntity = null;
		int resultValue = boardService.romoveBoard(requestBoard, (String)session.getAttribute("id"));

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : board delete OK, Retrun SUCCESS");

		} else {

			throw new Exception("Error occurred : database delete");

		}

		return responseEntity;
	}

	/**
	 * 게시물 수정
	 * @param requestBoard 요청 수정게시물 정보
	 * @param file
	 * @return SUCCESS
	 * @throws IllegalStateException
	 * @throws IOException
	 * @throws Exception (DB 오류)
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ResponseEntity<Integer> modifyBoard(@ModelAttribute BoardVO requestBoard,
		MultipartFile file) throws IllegalStateException, IOException, Exception {

		ResponseEntity<Integer> responseEntity = null;

		int resultValue = boardService.modifyBoard(requestBoard, file);

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : board modify OK, Retrun SUCCESS");

		} else {

			throw new Exception("Error occurred : database update");

		}

		return responseEntity;
	}

	/**
	 * 게시물 검색하기
	 * @param requestStation 검색 요청 정보
	 * @param search 검색 내용
	 * @param page 페이지수
	 * @return 페이징처리 Value + 검색 게시물리스트
	 * @throws Exception
	 */
	@RequestMapping(value = "/search/{scode}/{search}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchBoard(@ModelAttribute StationVO requestStation,
		@PathVariable("search") String search, @PathVariable("page") int page, HttpSession session) throws Exception {

		ResponseEntity<Map<String, Object>> responseEntity = null;

		Map<String, Object> searchBoardList = boardService.getSearchBoard(requestStation, search,
			(String)session.getAttribute("id"), page);

		if (searchBoardList != null) {

			responseEntity = new ResponseEntity<Map<String, Object>>(searchBoardList, HttpStatus.OK);
			log.info("Result : board search request OK, Retrun search board List & paging values ");

		} else {

			throw new Exception("Error occurred : database select");
		}

		return responseEntity;
	}

	/**
	 * 게시물 추천
	 * @param requestBoard 요청 게시물정보
	 * @return 요청 게시물
	 * @throws Exception 
	 */
	@RequestMapping(value = "/recommend", method = RequestMethod.PUT)
	public ResponseEntity<Integer> recommend(@RequestBody BoardVO requestBoard) throws Exception {
		ResponseEntity<Integer> responseEntity = null;

		int resultValue = boardService.recommendBoard(requestBoard);

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : board recommend request OK, Retrun SUCCESS");

		} else {

			log.error("Result : board recommend request Fail, Retrun Bad_request");
			throw new Exception("Error occurred : database update(BoardRestController.java:225)");

		}

		return responseEntity;
	}

	/**
	 * 게시물 정렬
	 * @param requestBoard target(정렬할 부분)
	 * @param page
	 * @param session
	 * @return 정렬된 게시물 List
	 * @throws Exception
	 */
	@RequestMapping(value = "/sort/{scode}/{target}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> sortBoard(@ModelAttribute BoardVO requestBoard,
		@PathVariable("page") int page, HttpSession session)
		throws Exception {

		ResponseEntity<Map<String, Object>> responseEntity = null;

		String id = (String)session.getAttribute("id");

		if (id != null) {

			requestBoard.setId(id);

			Map<String, Object> resultMap = boardService.getSortBoardList(requestBoard, page);

			if (resultMap != null) {
				responseEntity = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
				log.info(
					"Result : board sort[target : " + requestBoard.getTarget() + "] request OK, Retrun boardSortList");

			} else {
				log.error("Result : board sort request Fail, Retrun Bad_request");
				throw new Exception("Error occurred : database update(BoardRestController.java:225)");
			}

		} else {
			log.info("Result : request Fail, Return Invalid request ");
			throw new Exception("Error occurred : Invalid request (BoardRestController.java:262)");
		}
		return responseEntity;

	}

	/**
	 * 검색 게시물 정렬
	 * @param requestBoard target(정렬할 부분)
	 * @param page
	 * @param session
	 * @return 정렬된 게시물 List
	 * @throws Exception
	 */
	@RequestMapping(value = "/sort/{scode}/{target}/{page}/{search}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchSortBoard(@ModelAttribute BoardVO requestBoard,
		@PathVariable("page") int page, HttpSession session)
		throws Exception {

		ResponseEntity<Map<String, Object>> responseEntity = null;

		String id = (String)session.getAttribute("id");

		if (id != null) {

			requestBoard.setId(id);

			Map<String, Object> resultMap = boardService.getSortBoardList(requestBoard, page);

			if (resultMap != null) {
				responseEntity = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
				log.info(
					"Result : board sort[target : " + requestBoard.getTarget() + "search : " + requestBoard.getSearch()
						+ "] request OK, Retrun boardSortList");

			} else {
				log.error("Result : board sort request Fail, Retrun Bad_request");
				throw new Exception("Error occurred : database update(BoardRestController.java:225)");
			}

		} else {
			log.info("Result : request Fail, Return Invalid request ");
			throw new Exception("Error occurred : Invalid request (BoardRestController.java:262)");
		}
		return responseEntity;

	}

}
