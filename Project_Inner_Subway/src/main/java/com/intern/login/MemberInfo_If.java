package com.intern.login;

import java.util.List;
import java.util.Map;

public interface MemberInfo_If {
	public List<MemberInfoVO> getMemberList();
	public void insertMember(MemberInfoVO vo);
	public List<String> getIdList();

	
}
