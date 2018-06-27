package com.intern.station;

public class StationVO {

	private String scode;
	private String sname;
	private int line;
	private int x;
	private int y;
	private String id;
	private int boardCount;

	public StationVO() {
		super();
	}

	public StationVO(String scode, String sname, int line, int x, int y, String id, int boardCount) {
		super();
		this.scode = scode;
		this.sname = sname;
		this.line = line;
		this.x = x;
		this.y = y;
		this.id = id;
		this.boardCount = boardCount;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getScode() {
		return scode;
	}

	public void setScode(String scode) {
		this.scode = scode;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public int getLine() {
		return line;
	}

	public void setLine(int line) {
		this.line = line;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

}
