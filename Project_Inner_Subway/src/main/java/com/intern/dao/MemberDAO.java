package com.intern.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.login.MemberVO;

@Component
public class MemberDAO {

	@Autowired
	SqlSession session;

	public MemberVO getMemberOne(MemberVO vo) {
		return session.selectOne("member.getMemberOne", vo);
	}

	public int memberRegister(MemberVO vo) {
		return session.insert("member.insertMember", vo);
	}

	public int getIdCheck(MemberVO vo) {
		return session.selectOne("member.getIdCheck", vo);
	}

}
