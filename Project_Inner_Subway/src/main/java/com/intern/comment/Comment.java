package com.intern.comment;

import java.util.List;

import com.intern.globalexceptionhandler.NoAuthException;

public interface Comment {

	/**
	 * 게시물 댓글 리스트
	 * @param requestComment 요청 게시글 정보
	 * @return 댓글 리스트
	 */
	public List<CommentVO> getCommentList(CommentVO requestComment);

	/**
	 * 댓글 등록
	 * @param requestComment 요청댓글정보
	 * @return SUCCESS,FAIL
	 */
	public int registerComment(CommentVO requestComment);

	/**
	 * 댓글 삭제(+작성자 체크)
	 * @param requestComment 요청댓글정보
	 * @param id 로그인 된 아이디
	 * @return SUCCESS,FAIL
	 * @throws NoAuthException(작성자가 아님)
	 */
	public int removeComment(CommentVO requestComment, String id) throws NoAuthException;

	/**
	 * 수정(해당 댓글 불러오기)
	 * @param requestComment 요청댓글정보
	 * @param id 로그인 된 아이디
	 * @return 해당댓글정보
	 */
	public CommentVO getCommentOne(CommentVO requestComment, String id) throws NoAuthException;

	/**
	 * 수정
	 * @param requestComment 요청댓글정보
	 * @return SUCCESS,FAIL
	 */
	public int modifyComment(CommentVO requestComment);

}
