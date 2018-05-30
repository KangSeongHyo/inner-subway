package com.intern.board;

import java.sql.Date;

public class BoardVO {

	String scode;
	int entry_num;
	String head;
	String title;
	String writer;
	Date registration_date;
	int viewcount;
	String content;
	String img_path;
	
	public BoardVO() {
		super();
	}
	@Override
	public String toString() {
		return "BoardVO [scode=" + scode + ", entry_num=" + entry_num + ", head=" + head + ", title=" + title
			+ ", writer=" + writer + ", registration_date=" + registration_date + ", viewcount=" + viewcount
			+ ", content=" + content + ", img_path=" + img_path + "]";
	}
	public BoardVO(String scode, int entry_num, String head, String title, String writer, Date registration_date,
		int viewcount, String content, String img_path) {
		super();
		this.scode = scode;
		this.entry_num = entry_num;
		this.head = head;
		this.title = title;
		this.writer = writer;
		this.registration_date = registration_date;
		this.viewcount = viewcount;
		this.content = content;
		this.img_path = img_path;
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
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getViewcount() {
		return viewcount;
	}
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	

	
	
}
