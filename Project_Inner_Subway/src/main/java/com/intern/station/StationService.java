package com.intern.station;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.StationDAO;

@Service
public class StationService implements Station{

	@Autowired
	StationDAO dao;

	@Override
	public List<StationVO> getStations(int line) {
		// TODO Auto-generated method stub
		return dao.getStations(line);
	}

	@Override
	public String getStationName(StationVO requestStation) {
		// TODO Auto-generated method stub
		return dao.getStationName(requestStation);
	}

}
