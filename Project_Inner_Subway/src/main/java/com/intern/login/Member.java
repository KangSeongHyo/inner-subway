package com.intern.login;

import java.util.List;
import java.util.Map;

public interface Member {

	/**
	 * ID 중복체크
	 * @return Success(1) Fail(0) 
	 */
	public int idCheck(MemberVO requestMember);

	/**
	 * 멤버등록 (회원가입)
	 * @param 유저정보
	 * @return 1(성공),0(실패)
	 */
	public int memberRegister(MemberVO requestMember);

	/**
	 * 로그인 체크
	 * @return login 확인 
	 */
	public int loginCheck(MemberVO requestMember);

}
