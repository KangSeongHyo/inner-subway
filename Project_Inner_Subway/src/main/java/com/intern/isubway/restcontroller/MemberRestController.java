package com.intern.isubway.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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
	 * id 중복체크를 위한 id List 반환 
	 * 
	 * @return DB의 id List
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<String>> getIdList() {

		ResponseEntity<List<String>> responseEntity = null;
		log.debug("로그테스트");

		try {
			List<String> list = memberService.getIdList();
			responseEntity = new ResponseEntity<List<String>>(list, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
		}

		return responseEntity;
	}

	/**
	 * 회원 체크
	 * id가 있는지 없는지
	 * id와 비밀번호가 일치하는지 확인
	 * 
	 * @param vo 회원가입정보
	 * @return 1(로그인 OK),0(비밀번호가 일치하지 않음),-1(아이디가 존재하지 않음)
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<Integer> loginCheck(@RequestBody MemberVO requestMember, HttpSession session) {

		ResponseEntity<Integer> responseEntity = null;
		try {
			int check = memberService.loginCheck(requestMember);
			responseEntity = new ResponseEntity<Integer>(check, HttpStatus.OK);
			if (check == 1) {
				session.setAttribute("id", requestMember.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return responseEntity;
	}

	/**
	 * 회원가입
	 * 
	 * @param mvo 회원가입 정보 
	 * @return insert 성공실패(1,0)
	 */
	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<Integer> registerMember(@RequestBody MemberVO requestMember) {

		ResponseEntity<Integer> responseEntity = null;

		try {

			responseEntity = new ResponseEntity<Integer>(memberService.memberRegister(requestMember), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return responseEntity;
	}

}
