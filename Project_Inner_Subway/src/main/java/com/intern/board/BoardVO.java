package com.intern.board;

import java.sql.Date;

public class BoardVO {

	String scode;
	int entryNum;
	String title;
	String writer;
	Date registrationDate;
	int viewCount;
	String content;
	String imgPath;
	
	
	
	public BoardVO() {
		super();
	}



	public BoardVO(String scode, int entryNum, String title, String writer, Date registrationDate, int viewCount,
		String content, String imgPath) {
		super();
		this.scode = scode;
		this.entryNum = entryNum;
		this.title = title;
		this.writer = writer;
		this.registrationDate = registrationDate;
		this.viewCount = viewCount;
		this.content = content;
		this.imgPath = imgPath;
	}



	public String getScode() {
		return scode;
	}



	public void setScode(String scode) {
		this.scode = scode;
	}



	public int getEntryNum() {
		return entryNum;
	}



	public void setEntryNum(int entryNum) {
		this.entryNum = entryNum;
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



	public Date getRegistrationDate() {
		return registrationDate;
	}



	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}



	public int getViewCount() {
		return viewCount;
	}



	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getImgPath() {
		return imgPath;
	}



	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
	

	
}
