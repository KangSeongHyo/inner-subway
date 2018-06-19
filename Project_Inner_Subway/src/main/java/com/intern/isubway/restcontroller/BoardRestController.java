package com.intern.isubway.restcontroller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.intern.board.BoardService;
import com.intern.board.BoardVO;
import com.intern.station.StationVO;

@RestController
@RequestMapping("/board")
public class BoardRestController {

	@Autowired
	BoardService boardService;

	///////게시물삭제
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseEntity<Integer> removeBoard(@RequestBody BoardVO requestBoard, HttpSession session) {
		ResponseEntity<Integer> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<Integer>(
				boardService.romoveBoard(requestBoard, (String)session.getAttribute("id")), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	///////////게시물 불러오기 + id check
	@RequestMapping(value = "/{scode}/{entryNum}/{writer}", method = RequestMethod.GET)
	public ResponseEntity<BoardVO> getBoardOne(@ModelAttribute BoardVO requestBoard, HttpSession session) {

		ResponseEntity<BoardVO> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<BoardVO>(
				boardService.getBoardOne(requestBoard, (String)session.getAttribute("id")), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<BoardVO>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	///////////게시물 불러오기(상세보기)
	@RequestMapping(value = "/{scode}/{entryNum}", method = RequestMethod.GET)
	public ResponseEntity<BoardVO> getBoardOne(@ModelAttribute BoardVO requestBoard) {

		ResponseEntity<BoardVO> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<BoardVO>(
				boardService.getBoardOne(requestBoard, "load"), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<BoardVO>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	/////////게시물 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerBoard(@ModelAttribute BoardVO requestBoard,
		MultipartFile file) {

		ResponseEntity<Integer> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<Integer>(boardService.boardRegister(requestBoard, file), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	///////////게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ResponseEntity<Integer> modifyBoard(@ModelAttribute BoardVO requestBoard,
		MultipartFile file) {

		ResponseEntity<Integer> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<Integer>(
				boardService.modifyBoard(requestBoard, file), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return responseEntity;
	}

	///////////검색 게시물 불러오기
	@RequestMapping(value = "/search/{scode}/{search}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchBoard(@ModelAttribute StationVO requestStation,
		@PathVariable("search") String search, @PathVariable("page") int page) {

		ResponseEntity<Map<String, Object>> responseEntity = null;
		Map<String, Object> searchBoardList = boardService.getSearchBoard(requestStation, search, page);

		try {
			if (searchBoardList == null) {
				responseEntity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);

			} else {
				responseEntity = new ResponseEntity<Map<String, Object>>(searchBoardList, HttpStatus.OK);

			}

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}
}
