package com.intern.main;


public class StationInfoVO {

	String scode;
	String sname;
	int line;
	
	public StationInfoVO() {
		super();
	}
	
	public StationInfoVO(String scode, String sname, int line) {
		super();
		this.scode = scode;
		this.sname = sname;
		this.line = line;
	}
	
	@Override
	public String toString() {
		return "StationInfoVO [scode=" + scode + ", sname=" + sname + ", line=" + line + "]";
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
}
