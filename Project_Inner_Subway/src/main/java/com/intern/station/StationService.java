package com.intern.station;

import java.util.List;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.StationDAO;

@Service
public class StationService implements Station {

	@Autowired
	StationDAO dao;

	@Override
	public List<StationVO> getStations(int line) {
		return dao.getStations(line);
	}

	@Override
	public String getStationName(StationVO requestStation) {
		return dao.getStationName(requestStation);
	}

}
