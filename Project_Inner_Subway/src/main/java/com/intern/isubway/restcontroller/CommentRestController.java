package com.intern.isubway.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intern.comment.CommentService;
import com.intern.comment.CommentVO;

@RestController
@RequestMapping("/comment")
public class CommentRestController {

	@Autowired
	CommentService commentService;

	@RequestMapping(value = "/{scode}/{entryNum}", method = RequestMethod.GET)
	public ResponseEntity<List<CommentVO>> getCommentList(@ModelAttribute CommentVO requestComment) {

		ResponseEntity<List<CommentVO>> responseEntity = null;
		try {
			responseEntity = new ResponseEntity<List<CommentVO>>(commentService.getCommentList(requestComment),
				HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<List<CommentVO>>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	@RequestMapping(value = "/{scode}/{entryNum}/{commentSeq}/{writer}", method = RequestMethod.GET)
	public ResponseEntity<CommentVO> getCommentOne(@ModelAttribute CommentVO requestComment, HttpSession session) {

		ResponseEntity<CommentVO> responseEntity = null;
		CommentVO result = commentService.getCommentOne(requestComment, (String)session.getAttribute("id"));

		try {
			if (result != null) {
				if (result.getWriter() == "NOAUTH") {

					responseEntity = new ResponseEntity<CommentVO>(HttpStatus.UNAUTHORIZED);
				} else {
					responseEntity = new ResponseEntity<CommentVO>(result, HttpStatus.OK);
				}

			} else {

				responseEntity = new ResponseEntity<CommentVO>(result, HttpStatus.OK);

			}

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<CommentVO>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerComment(@RequestBody CommentVO requestComment, HttpSession session) {

		ResponseEntity<Integer> responseEntity = null;
		try {
			requestComment.setWriter((String)session.getAttribute("id"));
			responseEntity = new ResponseEntity<Integer>(commentService.registerComment(requestComment), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseEntity<Integer> removeComment(@RequestBody CommentVO requestComment, HttpSession session) {

		ResponseEntity<Integer> responseEntity = null;

		try {
			responseEntity = new ResponseEntity<Integer>(
				commentService.removeComment(requestComment, (String)session.getAttribute("id")), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

	@RequestMapping(value = "", method = RequestMethod.PUT)
	public ResponseEntity<Integer> modifyComment(@RequestBody CommentVO requestComment) {

		ResponseEntity<Integer> responseEntity = null;

		try {
			responseEntity = new ResponseEntity<Integer>(
				commentService.modifyComment(requestComment), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return responseEntity;
	}

}
