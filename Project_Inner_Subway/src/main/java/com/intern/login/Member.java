package com.intern.login;

import java.util.List;
import java.util.Map;

public interface Member {

	
	/**
	 * ID 중복체크
	 * @return ID값 리스트 
	 */
	public List<String> getIdList();
	/**
	 * 멤버등록 (회원가입)
	 * @param 유저정보
	 * @return 1(성공),0(실패)
	 */
	public int memberRegister(MemberVO vo);
	
	/**
	 * ID 중복체크
	 * @return ID값 리스트 
	 */
	public int loginCheck(MemberVO vo);
	
	
}
