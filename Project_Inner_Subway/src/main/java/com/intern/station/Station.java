package com.intern.station;

import java.util.List;

public interface Station {

	public List<StationVO> getStations(int line);

	public String getStationName(StationVO vo);
}
