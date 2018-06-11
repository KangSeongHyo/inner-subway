package com.intern.comment;

import java.util.List;
import java.util.Map;

public interface Comment_If {
	public List<CommentVO> getCommentList(Map map);
	public void insertComment(CommentVO vo);
	public void deleteComment(Map map);
}
