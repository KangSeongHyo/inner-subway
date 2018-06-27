package com.intern.board;

import java.sql.Date;

public class BoardVO {

	private String scode;
	private int entryNum;
	private String title;
	private String writer;
	private Date registrationDate;
	private int viewCount;
	private String content;
	private String imgPath;
	private int recommend;
	private String id;
	private boolean recommendCheck;
	private String target;

	public BoardVO() {
		super();
	}

	public BoardVO(String scode, int entryNum, String title, String writer, Date registrationDate, int viewCount,
		String content, String imgPath, int recommend, String id, boolean recommendCheck, String target) {
		super();
		this.scode = scode;
		this.entryNum = entryNum;
		this.title = title;
		this.writer = writer;
		this.registrationDate = registrationDate;
		this.viewCount = viewCount;
		this.content = content;
		this.imgPath = imgPath;
		this.recommend = recommend;
		this.id = id;
		this.recommendCheck = recommendCheck;
		this.target = target;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public boolean isRecommendCheck() {
		return recommendCheck;
	}

	public void setRecommendCheck(boolean recommendCheck) {
		this.recommendCheck = recommendCheck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
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
