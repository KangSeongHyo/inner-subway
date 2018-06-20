package com.intern.login;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.intern.check.Check;
import com.intern.dao.MemberDAO;

@Service
public class MemberService implements Member {

	@Autowired
	MemberDAO dao;

	@Autowired
	BCryptPasswordEncoder encoder;

	@Override
	public int memberRegister(MemberVO requestMember) {

		requestMember.setName(encoder.encode(requestMember.getName()));
		requestMember.setPw(encoder.encode(requestMember.getPw()));
		requestMember.setAddress(encoder.encode(requestMember.getAddress()));

		int check = dao.memberRegister(requestMember);
		return check;
	}

	@Override
	public int idCheck(MemberVO requestMember) {

		return dao.getIdCheck(requestMember);
	}

	/**
	 * 회원 체크
	 * id가 있는지 없는지
	 * id와 비밀번호가 일치하는지 확인
	 * 
	 * @param vo 회원가입정보
	 * @return 1(로그인 OK),0(비밀번호가 일치하지 않음),-1(아이디가 존재하지 않음)
	 */
	@Override
	public int loginCheck(MemberVO requestMember) {

		List<MemberVO> memberList = dao.getMemberList();
		String pw = "";
		boolean idCheck = false;

		for (MemberVO mvo : memberList) {

			if (requestMember.getId().equals(mvo.getId())) {
				idCheck = true;
				pw = mvo.getPw();
			}

		}

		if (idCheck == false) {

			return Check.NOAUTH;

		} else {

			if (encoder.matches(requestMember.getPw(), pw)) {

				return Check.SUCCESS;
			}
		}
		return Check.FAIL;

	}

}
