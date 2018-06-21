package com.intern.isubway.restcontroller;

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
import com.intern.login.MemberService;
import com.intern.login.MemberVO;

@RestController
@RequestMapping("/member")
public class MemberRestController {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	MemberService memberService;

	/**
	 * id 중복 체크 결과 반환 
	 * @return SUCCESS FAIL(id 중복)
	 * @throws Exception(DB 오류)
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Integer> getIdList(@ModelAttribute MemberVO requestMember) throws Exception {

		ResponseEntity<Integer> responseEntity = null;

		int result = memberService.idCheck(requestMember);

		if ((Integer)result != null) {
			responseEntity = new ResponseEntity<Integer>(result, HttpStatus.OK);

			log.info("Result : id duplicate check OK, Retrun CheckValue");

		} else {

			throw new Exception("Error occurred : database select");
		}

		return responseEntity;
	}

	/**
	 * 회원가입
	 * @param requestMember 회원가입 정보 
	 * @return SUCCESS
	 * @throws Exception(insert 오류)
	 */
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerMember(@RequestBody MemberVO requestMember) throws Exception {

		ResponseEntity<Integer> responseEntity = null;

		int resultValue = memberService.memberRegister(requestMember);

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : join OK, Retrun SUCCESS");

		} else {

			log.info("Result : Join Fail");
			throw new Exception("Error occurred : updating database");

		}

		return responseEntity;
	}

	/**
	 * 회원 체크
	 * id가 있는지 없는지
	 * id와 비밀번호가 일치하는지 확인
	 * @param vo 회원가입정보
	 * @return SUCCESS(로그인 OK), FAIL(비밀번호가 일치하지 않음), NOAUTH(아이디가 존재하지 않음)
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<Integer> loginCheck(@RequestBody MemberVO requestMember, HttpSession session) {

		ResponseEntity<Integer> responseEntity = null;

		int resultValue = memberService.loginCheck(requestMember);

		if (resultValue == CheckValue.SUCCESS) {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			session.setAttribute("id", requestMember.getId());

			log.info("Result : login OK & store request id in session , Retrun SUCCESS");

		} else {

			responseEntity = new ResponseEntity<Integer>(resultValue, HttpStatus.OK);
			log.info("Result : login Error , Retrun CheckValue ");

		}

		return responseEntity;
	}
}
