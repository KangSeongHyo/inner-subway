package com.intern.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.station.StationVO;

@Component
public class StationDAO {

	@Autowired
	SqlSession session;

	public List<StationVO> getStations(int line) {
		return session.selectList("station.getStationInfo", line);
	}

	public String getStationName(StationVO requestStation) {
		return session.selectOne("station.getStationName", requestStation);
	}

}
