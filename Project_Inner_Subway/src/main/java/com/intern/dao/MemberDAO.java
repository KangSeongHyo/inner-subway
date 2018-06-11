package com.intern.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.intern.login.MemberVO;

@Component
public class MemberDAO {

	@Autowired
	SqlSession session;

	public List<MemberVO> getMemberList() {
		return session.selectList("member.getMemberList");
	}

	public int memberRegister(MemberVO vo) {
		return session.insert("member.insertMember", vo);
	}

	public List<String> getIdList() {
		return session.selectList("member.getIdList");
	}

}
