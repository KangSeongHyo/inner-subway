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

	public List<StationVO> getStations(StationVO vo) {
		return session.selectList("station.getStationInfo", vo);
	}

	public List<StationVO> getStationList(StationVO vo) {
		return session.selectList("station.getStationList", vo);
	}

	public String getStationName(StationVO vo) {
		return session.selectOne("station.getStationName", vo);
	}

}
