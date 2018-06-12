package com.intern.comment;

import java.util.List;
import java.util.Map;

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
	 * @return 1(성공),0(실패)
	 */
	public int registerComment(CommentVO requestComment);
	public void deleteComment(Map map);
}
