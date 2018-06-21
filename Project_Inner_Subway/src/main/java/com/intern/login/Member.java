package com.intern.login;


public interface Member {

	/**
	 * ID 중복체크
	 * @return SUCCESS FAIL 
	 */
	public int idCheck(MemberVO requestMember);

	/**
	 * 멤버등록 (회원가입)
	 * @param 유저정보
	 * @return SUCCESS FAIL
	 */
	public int memberRegister(MemberVO requestMember);

	/**
	 * 회원 체크
	 * id가 있는지 없는지
	 * id와 비밀번호가 일치하는지 확인
	 * 
	 * @param vo 회원정보
	 * @return SUCCESS(로그인 OK),DISCORDANCE(비밀번호가 일치하지 않음),FAIL(아이디가 존재하지 않음)
	 * @throws Exception 
	 */
	public int loginCheck(MemberVO requestMember);

}
