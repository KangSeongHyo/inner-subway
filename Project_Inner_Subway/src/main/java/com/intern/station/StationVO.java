package com.intern.station;

public class StationVO {

	String scode;
	String sname;
	int line;
	int x;
	int y;

	public StationVO() {
		super();
	}

	public StationVO(String scode, String sname, int line, int x, int y) {
		super();
		this.scode = scode;
		this.sname = sname;
		this.line = line;
		this.x = x;
		this.y = y;
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
