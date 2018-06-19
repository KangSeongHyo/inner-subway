package com.intern.isubway.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.NotFoundException;
import org.apache.log4j.Logger;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.intern.check.Check;
import com.intern.dao.MemberDAO;
import com.intern.login.MemberService;
import com.intern.login.MemberVO;

/*@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:com.intern.mybatis.**")*/

@RestController
@RequestMapping("/member")
public class MemberRestController {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	MemberService memberService;

	/**
	 * 모든 회원들의  ID List 반환 
	 * @return id List
	 * @throws Exception 
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<String>> getIdList() throws Exception {

		ResponseEntity<List<String>> responseEntity = null;

		List<String> list = memberService.getIdList();

		if (list != null) {
			responseEntity = new ResponseEntity<List<String>>(list, HttpStatus.OK);
			log.info(" ID List return ");

		} else {

			throw new Exception();
		}

		return responseEntity;
	}

	/**
	 * 회원가입
	 * @param mvo 회원가입 정보 
	 * @return success(1),fail(0)
	 */
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<Integer> registerMember(@RequestBody MemberVO requestMember) {

		ResponseEntity<Integer> responseEntity = null;

		try {

			int check = memberService.memberRegister(requestMember);

			if (check == Check.SUCCESS) {
				responseEntity = new ResponseEntity<Integer>(check, HttpStatus.OK);
				log.info("회원가입 OK");

			} else {

				responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
				log.warn("회원가입 FAIL");

			}

		} catch (Exception e) {

			e.printStackTrace();
			log.error(e.getMessage());
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return responseEntity;
	}

	/**
	 * 회원 체크
	 * id가 있는지 없는지
	 * id와 비밀번호가 일치하는지 확인
	 * @param vo 회원가입정보
	 * @return success(로그인 OK), fail(비밀번호가 일치하지 않음), NOAUTH(아이디가 존재하지 않음)
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<Integer> loginCheck(@RequestBody MemberVO requestMember, HttpSession session) {

		ResponseEntity<Integer> responseEntity = null;

		try {
			int check = memberService.loginCheck(requestMember);

			responseEntity = new ResponseEntity<Integer>(check, HttpStatus.OK);

			if (check == Check.SUCCESS) {
				session.setAttribute("id", requestMember.getId());
			}

		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

		return responseEntity;
	}

}
