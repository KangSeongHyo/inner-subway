package com.intern.board;

public class RecommendVO {

	String scode;
	int entryNum;
	String id;
	boolean recommendCheck;

	public RecommendVO(String scode, int entryNum, String id, boolean recommendCheck) {
		super();
		this.scode = scode;
		this.entryNum = entryNum;
		this.id = id;
		this.recommendCheck = recommendCheck;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public boolean isRecommendCheck() {
		return recommendCheck;
	}

	public void setRecommendCheck(boolean recommendCheck) {
		this.recommendCheck = recommendCheck;
	}

	

}
