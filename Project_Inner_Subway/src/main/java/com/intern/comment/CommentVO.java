package com.intern.comment;

import java.sql.Date;

public class CommentVO {

	String scode;
	int entry_num;
	int comment_seq;
	String content;
	String writer;
	Date registration_date;
	
	public CommentVO() {
		super();
	}

	public CommentVO(String scode, int entry_num, int comment_seq, String content, String writer,
		Date registration_date) {
		super();
		this.scode = scode;
		this.entry_num = entry_num;
		this.comment_seq = comment_seq;
		this.content = content;
		this.writer = writer;
		this.registration_date = registration_date;
	}

	public String getScode() {
		return scode;
	}

	public void setScode(String scode) {
		this.scode = scode;
	}

	public int getEntry_num() {
		return entry_num;
	}

	public void setEntry_num(int entry_num) {
		this.entry_num = entry_num;
	}

	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegistration_date() {
		return registration_date;
	}

	public void setRegistration_date(Date registration_date) {
		this.registration_date = registration_date;
	}
	
	
}
