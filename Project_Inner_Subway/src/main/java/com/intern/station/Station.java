package com.intern.station;

import java.util.List;

public interface Station {

	/**
	 * 요청 호선의 지하철역들 정보
	 *
	 * @param line 요청 호선
	 * @return 요청 호선 지하철역 List
	 */
	public List<StationVO> getStations(int line);

	/**
	 * 요청 지하철역 코드로 역 이름 반환
	 * @param requestStation 요청 지하철역 정보
	 * @return 지하철역 이름
	 */
	public String getStationName(StationVO requestStation);
}
