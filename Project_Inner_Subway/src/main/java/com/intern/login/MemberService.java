package com.intern.login;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.intern.check.CheckValue;
import com.intern.dao.MemberDAO;

@Service
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/resources/mybatis/*.xml"})
public class MemberService implements Member {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	MemberDAO dao;

	@Autowired
	BCryptPasswordEncoder encoder;

	@Override
	public int memberRegister(MemberVO requestMember) {

		requestMember.setName(encoder.encode(requestMember.getName()));
		requestMember.setPw(encoder.encode(requestMember.getPw()));
		requestMember.setAddress(encoder.encode(requestMember.getAddress()));

		log.info("Processing : Member info security");
		int check = dao.memberRegister(requestMember);

		return check;
	}
    
	@Override
	public int idCheck(MemberVO requestMember) {

		int resultValue = dao.getIdCheck(requestMember);
		log.info("Processing : ID search");

		if (resultValue > 0) {

			log.info("Processing : ID not exist");
			return CheckValue.FAIL;

		} else {

			log.info("Processing : ID exist");
			return CheckValue.SUCCESS;
		}

	}

	@Override
	public int loginCheck(MemberVO requestMember) {

		MemberVO member = dao.getMemberOne(requestMember);
		log.info("Processing : get  Member info & check for login");

		if (member == null) {

			log.info("Processing : Member not exist");
			return CheckValue.FAIL;

		} else {

			if (encoder.matches(requestMember.getPw(), member.getPw())) {

				log.info("Processing : Member PW accordance");
				return CheckValue.SUCCESS;

			} else {

				log.info("Processing : Member PW Disaccordance");
				return CheckValue.DISCORDANCE;

			}

		}

	}

}
