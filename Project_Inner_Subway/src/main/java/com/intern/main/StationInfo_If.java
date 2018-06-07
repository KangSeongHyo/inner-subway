package com.intern.main;

import java.util.List;

public interface StationInfo_If {
	
	public List<StationInfoVO> getStationInfo(int line_number);
	public String getStationName(String scode);
}
