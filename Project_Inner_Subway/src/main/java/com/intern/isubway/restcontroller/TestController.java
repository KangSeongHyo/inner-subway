package com.intern.isubway.restcontroller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intern.board.BoardVO;
import com.intern.login.MemberVO;
import com.mysql.cj.core.exceptions.RSAException;

@RestController
public class TestController {

	/*@RequestMapping("/errorcode") //에러처리
	public ResponseEntity<Void> errCode() {
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}

	@RequestMapping("/errorlist")
	public ResponseEntity<List<String>> err() {
		List<String> list = new LinkedList<>();
		list.add("테");
		list.add("스");
		list.add("트");

		return new ResponseEntity<List<String>>(list, HttpStatus.BAD_REQUEST);
	}

	@RequestMapping(value = "/memberss", method = RequestMethod.POST)
	public ResponseEntity<String> input(@RequestBody MemberVO vo) {

		ResponseEntity<String> rEntity;
		try {
			//////// 처리(간단하게) 로직은 서비스에서 
			System.out.println(vo.getId());
			rEntity = new ResponseEntity<String>("sucess", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			rEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);

		}

		return rEntity;

	}

	////////GET 
	@RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
	public ResponseEntity<List<MemberVO>> list(@PathVariable("id") int id) {

		ResponseEntity<List<MemberVO>> responseEntity;

		try {
			responseEntity = new ResponseEntity<List<MemberVO>>(new LinkedList<>(), HttpStatus.OK);
			/// //안에는 getBoard 이란거 

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<List<MemberVO>>();

		}
		return responseEntity;
	}

	@RequestMapping(value = "/get/{pw}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> re(@PathVariable("pw") int k, @RequestBody MemberVO vo) {}

	$.ajax({
	 * type : 'post',
	 * url : '/replies',
	 * headers:{ "Content-Type" : "application/json"
	 *           "X-HTTP-Method-Override" : "POST" -> 처리못하는게있음},
	 * dataType : 'text',
	 * data : JSON.stringify({id:id,pw:pw})
	 * 
	 * })
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
*/
}
