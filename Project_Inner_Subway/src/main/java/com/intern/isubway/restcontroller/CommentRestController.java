package com.intern.isubway.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intern.check.CheckValue;
import com.intern.comment.CommentService;
import com.intern.comment.CommentVO;
import com.intern.globalexceptionhandler.NoAuthException;

@RestController
@RequestMapping("/comment")
public class CommentRestController {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	CommentService commentService;

	/**
	 * 댓글 리스트 불러오기 (상세보기)
	 * @param requestComment 요청 댓글 정보
	 * @return 댓글 List
	 * @throws Exception
	 */
	@RequestMapping(value = "/{scode}/{entryNum}", method = RequestMethod.GET)
	public ResponseEntity<List<CommentVO>> getCommentList(@ModelAttribute CommentVO requestComment) throws Exception {

		ResponseEntity<List<CommentVO>> responseEntity = null;

		List<CommentVO> resultList = commentService.getCommentList(requestComment);

		if (resultList != null) {

			responseEntity = new ResponseEntity<List<CommentVO>>(resultList, HttpStatus.OK);
			log.info("Result : request commentList OK, Retrun commentList");

		} else {
			throw new Exception("Error occurred : database select");
		}

		return responseEntity;
	}

	/**
	 * 수정할 댓글 불러오기
	 * @param requestComment 요청 댓글 정보
	 * @param session
	 * @return 댓글정보
	 * @throws NoAuthException(작성자가 아닐경우)
	 */
	@RequestMapping(value = "/{scode}/{entryNum}/{commentSeq}/{writer}", method = RequestMethod.GET)
	public ResponseEntity<CommentVO> getCommentOne(@ModelAttribute CommentVO requestComment, HttpSession session)
		throws NoAuthException, Exception {

		ResponseEntity<CommentVO> responseEntity = null;
		CommentVO resultObject = commentService.getCommentOne(requestComment, (String)session.getAttribute("id"));

		if (resultObject != null) {

			responseEntity = new ResponseEntity<CommentVO>(resultObject, HttpStatus.OK);
			log.info("Result : request comment OK, Retrun commentInfo");

		} else {

			throw new Exception("Error occurred : database select");
		}

		return responseEntity;
	}

	/**
	 * 댓글 작성
	 * @param requestComment 요청 댓글 정보
	 * @param session
	 * @return SUCCESS
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerComment(@RequestBody CommentVO requestComment, HttpSession session)
		throws Exception {

		ResponseEntity<Integer> responseEntity = null;

		String writer = (String)session.getAttribute("id");
		int resultValue;

		if (writer == null) {

			throw new Exception("Error occurred : do not exist id in session");

		} else {

			requestComment.setWriter(writer);
			resultValue = commentService.registerComment(requestComment);

			if (resultValue == CheckValue.SUCCESS) {
				responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
				log.info("Result : request comment register OK, Retrun SUCCESS");

			} else {
				throw new Exception("Error occurred : database update");

			}

		}

		return responseEntity;
	}

	/**
	 * 댓글 삭제
	 * @param requestComment 요청댓글정보
	 * @param session
	 * @return SUCCESS
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseEntity<Integer> removeComment(@RequestBody CommentVO requestComment, HttpSession session)
		throws Exception {

		ResponseEntity<Integer> responseEntity = null;
		String writer = (String)session.getAttribute("id");
		int resultValue = commentService.removeComment(requestComment, writer);

		if (writer == null) {

			throw new Exception("Error occurred : do not exist id in session");

		} else {

			if (resultValue == CheckValue.SUCCESS) {
				responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
				log.info("Result : request comment delete OK, Retrun SUCCESS");

			} else {

				throw new Exception("Error occurred : database delete");
			}
		}

		return responseEntity;
	}

	/**
	 * 댓글 수정
	 * @param requestComment 요청 댓글 정보
	 * @return SUCCESS
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public ResponseEntity<Integer> modifyComment(@RequestBody CommentVO requestComment, HttpSession session)
		throws Exception {

		ResponseEntity<Integer> responseEntity = null;
		String writer = (String)session.getAttribute("id");
		int resultValue = commentService.modifyComment(requestComment);

		if (writer == null) {

			throw new Exception("Error occurred : do not exist id in session");

		} else {

			if (resultValue == CheckValue.SUCCESS) {

				responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
				log.info("Result : request comment modify OK, Retrun SUCCESS");

			} else {

				throw new Exception("Error occurred : database update");
			}

		}

		return responseEntity;
	}

}
