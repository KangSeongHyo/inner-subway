package com.intern.station;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.StationDAO;

@Service
public class StationService implements Station {

	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	StationDAO dao;

	@Override
	public List<StationVO> getStations(int line) {

		log.info("Processing : select station info from DB");
		return dao.getStations(line);
	}

	@Override
	public String getStationName(StationVO requestStation) {

		log.info("Processing : select station name from DB");
		return dao.getStationName(requestStation);
	}

}
