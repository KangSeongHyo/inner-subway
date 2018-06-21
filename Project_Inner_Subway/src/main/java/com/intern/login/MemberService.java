package com.intern.login;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.intern.check.CheckValue;
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

		int resultValue = dao.getIdCheck(requestMember);

		if (resultValue > 0) {

			return CheckValue.FAIL;

		} else {

			return CheckValue.SUCCESS;
		}

	}

	@Override
	public int loginCheck(MemberVO requestMember) {

		MemberVO member = dao.getMemberOne(requestMember);

		if (member == null) {

			return CheckValue.FAIL;

		} else {

			if (encoder.matches(requestMember.getPw(), member.getPw())) {

				return CheckValue.SUCCESS;

			} else {

				return CheckValue.DISCORDANCE;

			}

		}

	}

}
