package com.intern.login;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.MemberDAO;

@Service
public class MemberInfo_Service implements MemberInfo_If {
 

	@Autowired
	MemberDAO dao;
	
	@Override
	public List<MemberInfoVO> getMemberList() {
		return dao.getMemberList();
	}
	
	@Override
	public void insertMember(MemberInfoVO vo){
		dao.insertMember(vo);
	}

	@Override
	public List<String> getIdList() {
		return dao.getIdList();
	}
}
