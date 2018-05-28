package com.intern.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.login.MemberInfoVO;

@Component
public class MemberDAO {

	@Autowired
	SqlSession session;

	public List<MemberInfoVO> getMemberList() {
		return session.selectList("member.getMemberList");}
	
	public void insertMember(MemberInfoVO vo){
	    session.insert("member.insertMember",vo);
	}

}
