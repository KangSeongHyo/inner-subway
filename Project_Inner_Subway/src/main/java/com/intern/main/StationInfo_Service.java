package com.intern.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.dao.StationInfoDAO;

@Service
public class StationInfo_Service implements StationInfo_If{

	@Autowired
	StationInfoDAO dao;

	@Override
	public List<StationInfoVO> getStationInfo(int line_number) {
		// TODO Auto-generated method stub
		return dao.getStationInfo(line_number);
	}

	@Override
	public String getStationName(String scode) {
		// TODO Auto-generated method stub
		return dao.getStationName(scode);
	}

}
